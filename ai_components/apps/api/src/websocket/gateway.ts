import type { FastifyInstance } from 'fastify';
import { prisma } from '../lib/prisma.js';
import { handleCandidateTranscript } from '../services/interview-conversation.service.js';
import type { ClientToServerTranscript, ProctoringPayload, ServerToUESpeak } from '@interviehire/shared';

type Socket = any;
const candidates = new Map<string, Socket>();
const ueClients = new Map<string, Socket>();

function send(socket: Socket | undefined, payload: unknown) {
  if (socket && socket.readyState === 1) socket.send(JSON.stringify(payload));
}

export async function registerWebsocket(app: FastifyInstance) {
  app.get('/ws', { websocket: true }, (connection) => {
    const socket = connection;
    socket.on('message', async (raw: Buffer) => {
      try {
        const msg = JSON.parse(raw.toString());
        if (msg.type === 'register') {
          (msg.role === 'ue5' ? ueClients : candidates).set(msg.sessionId, socket);
          send(socket, {type:'registered', role: msg.role, sessionId: msg.sessionId});
          return;
        }
        if (msg.type === 'candidate_transcript') {
          const payload = msg as ClientToServerTranscript;
          const ai = await handleCandidateTranscript(payload.sessionId, payload.text, {latencyMs: payload.latencyMs, wpm: payload.wpm});
          const speak: ServerToUESpeak = {type:'avatar_speak', sessionId: payload.sessionId, ...ai};
          send(ueClients.get(payload.sessionId), speak);
          const { type: _t, ...speakNoType } = speak as any;
          send(candidates.get(payload.sessionId), {type:'ai_response', ...speakNoType});
          return;
        }
        if (msg.type === 'avatar_status') {
          send(candidates.get(msg.sessionId), msg);
          return;
        }
        if (msg.type === 'proctoring_event') {
          const event = msg as ProctoringPayload;
          await prisma.proctoringLog.create({data:{sessionId:event.sessionId,eventType:event.eventType,severity:event.severity as any,metadata:event.metadata as any,occurredAt:new Date(event.timestamp)}});
          send(candidates.get(event.sessionId), {type:'proctoring_ack', eventType:event.eventType});
        }
      } catch (error: any) {
        send(socket, {type:'error', message:error.message || 'WebSocket error'});
      }
    });
    socket.on('close', () => {
      let disconnectedSessionId: string | null = null;
      for (const [k,v] of candidates.entries()) {
        if (v === socket) {
          disconnectedSessionId = k;
          candidates.delete(k);
        }
      }
      for (const [k,v] of ueClients.entries()) if (v === socket) ueClients.delete(k);

      if (disconnectedSessionId) {
        const sessionId = disconnectedSessionId;
        // Wait 2 minutes before running auto-evaluation
        setTimeout(async () => {
          // If the candidate has reconnected in the meantime, do not auto-evaluate!
          if (candidates.has(sessionId)) {
            console.log(`Candidate reconnected for session ${sessionId}. Skipping auto-evaluation.`);
            return;
          }
          
          try {
            const session = await prisma.interviewSession.findUnique({
              where: { id: sessionId },
            });
            
            // Only auto-evaluate if the session is still IN_PROGRESS (not COMPLETED or EVALUATED)
            if (session && session.status === 'IN_PROGRESS') {
              console.log(`Candidate session ${sessionId} disconnected for >2 mins. Triggering auto-evaluation...`);
              
              const { evaluateInterview } = await import('../services/evaluation.service.js');
              await evaluateInterview(sessionId);
              
              // Trigger FastAPI webhook completion event
              const webhookUrl = `http://localhost:8000/api/jobs/webhooks/interview-completed`;
              const response = await fetch(webhookUrl, {
                method: 'POST',
                headers: {
                  'Content-Type': 'application/json',
                  'X-Webhook-Secret': process.env.WEBHOOK_SECRET || 'super-secret-webhook-key',
                },
                body: JSON.stringify({ sessionId }),
              });
              console.log(`Auto-evaluation webhook response for session ${sessionId}:`, response.status);
            }
          } catch (err) {
            console.error(`Error in auto-evaluation for session ${sessionId}:`, err);
          }
        }, 120000); // 2 minutes
      }
    });
  });
}
