 'use client';
 import { useEffect, useRef, useState } from 'react';
 import { WS_URL, API_URL, parseApiResponse } from '@/lib/api';
 import { GazeCalibration } from '@/hooks/GazeCalibration';
 import { useProctoring } from '@/hooks/useProctoring';
 import { useSpeechMetrics } from '@/hooks/useSpeechMetrics';
 import { BarChart3, Maximize2, Mic, MonitorUp, Send, ShieldCheck, Timer, Video } from 'lucide-react';
 import type { CalibrationResult } from '@/hooks/useGazeCalibration';

type SpeechRecognitionInstance = {
  continuous: boolean;
  interimResults: boolean;
  lang: string;
  onstart: (() => void) | null;
  onend: (() => void) | null;
  onerror: ((event: { error?: string }) => void) | null;
  onresult: ((event: {
    resultIndex: number;
    results: ArrayLike<{
      isFinal: boolean;
      0: { transcript: string };
    }>;
  }) => void) | null;
  start: () => void;
  stop: () => void;
};

type SpeechRecognitionConstructor = new () => SpeechRecognitionInstance;

function getSpeechRecognitionConstructor(): SpeechRecognitionConstructor | null {
  if (typeof window === 'undefined') return null;
  const speechWindow = window as Window & {
    SpeechRecognition?: SpeechRecognitionConstructor;
    webkitSpeechRecognition?: SpeechRecognitionConstructor;
  };

  return speechWindow.SpeechRecognition ?? speechWindow.webkitSpeechRecognition ?? null;
}

 export default function Interview(){
  const [sessionId,setSessionId]=useState('demo-session');
  const [mounted, setMounted] = useState(false);
  const [scheduleData, setScheduleData] = useState<{
    candidate_name: string;
    email: string;
    job_title: string;
    stage: string;
    scheduled_at: string | null;
  } | null>(null);
  const [isLocked, setIsLocked] = useState(false);
  const [timeLeft, setTimeLeft] = useState<{
    days: number;
    hours: number;
    minutes: number;
    seconds: number;
  } | null>(null);

  useEffect(() => {
    setMounted(true);
  }, []);

  useEffect(() => {
    if (typeof window !== 'undefined') {
      const params = new URLSearchParams(window.location.search);
      const queryId = params.get('sessionId') || params.get('session');
      if (queryId) {
        setSessionId(queryId);
      }
    }
  }, []);

  useEffect(() => {
    if (!sessionId || sessionId === 'demo-session') return;
    
    async function fetchSchedule() {
      try {
        const res = await fetch(`/api/public/interview-session/${sessionId}`);
        if (res.ok) {
          const data = await res.json();
          setScheduleData(data);
          
          if (data.scheduled_at) {
            const scheduledTime = new Date(data.scheduled_at).getTime();
            const checkLock = () => {
              const now = Date.now();
              const diff = scheduledTime - now;
              if (diff > 0) {
                setIsLocked(true);
                const days = Math.floor(diff / (1000 * 60 * 60 * 24));
                const hours = Math.floor((diff % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
                const minutes = Math.floor((diff % (1000 * 60 * 60)) / (1000 * 60));
                const seconds = Math.floor((diff % (1000 * 60)) / 1000);
                setTimeLeft({ days, hours, minutes, seconds });
              } else {
                setIsLocked(false);
                setTimeLeft(null);
              }
            };
            checkLock();
            const timer = setInterval(checkLock, 1000);
            return () => clearInterval(timer);
          }
        }
      } catch (e) {
        console.error("Failed to fetch scheduling details:", e);
      }
    }
    fetchSchedule();
  }, [sessionId]);

  const [calibration, setCalibration] = useState<CalibrationResult | null>(null);
  const [socket,setSocket]=useState<WebSocket|null>(null);
  const [messages,setMessages]=useState<any[]>([{speaker:'ai',text:'Welcome. I will ask a few structured questions. Please answer naturally with examples.'}]);
  const [text,setText]=useState('');
  const [duration, setDuration] = useState('');
  const {markAiFinished, analyze}=useSpeechMetrics();
  const wsRef=useRef<WebSocket|null>(null);

  useEffect(()=>{
    let alive = true;
    let bootstrapTimer: number | undefined;
    let bootstrapAttempts = 0;

    async function bootstrapDemoSession() {
      if (sessionId !== 'demo-session') return;
      try {
        const res = await fetch(`${API_URL}/api/interview/demo-session`);
        const json = await parseApiResponse<{ sessionId?: string }>(res);
        if (alive && json?.sessionId) {
          setSessionId(json.sessionId);
        }
      } catch (error) {
        console.error('demo-session bootstrap failed', error);
        bootstrapAttempts += 1;
        if (alive && bootstrapAttempts < 3) {
          bootstrapTimer = window.setTimeout(bootstrapDemoSession, 5000);
        }
      }
    }
    bootstrapDemoSession();
    const ws=new WebSocket(WS_URL);
    wsRef.current=ws;
    ws.onopen=()=>ws.send(JSON.stringify({type:'register',role:'candidate',sessionId}));
    ws.onmessage=(e)=>{const msg=JSON.parse(e.data); if(msg.type==='ai_response'){setMessages(m=>[...m,{speaker:'ai',text:msg.text}]); markAiFinished();}};
    setSocket(ws);
    return()=>{
      alive = false;
      if (bootstrapTimer !== undefined) window.clearTimeout(bootstrapTimer);
      ws.close();
    };
  },[sessionId]);

  const { videoRef, events, state, requestRequiredPermissions } = useProctoring(sessionId, socket, calibration);
  const videoElement = (
    <video
      ref={videoRef}
      muted
      playsInline
      className="absolute bottom-5 right-5 h-36 w-52 rounded-2xl border border-white/20 object-cover shadow-2xl"
      style={{ display: calibration ? undefined : 'none' }}
    />
  );
  const [isRecording, setIsRecording] = useState(false);
  const [recordingStatus, setRecordingStatus] = useState('Idle');
  const [speechSupported, setSpeechSupported] = useState(false);
  const [speechStatus, setSpeechStatus] = useState('Speech-to-text idle');
  const [isListening, setIsListening] = useState(false);
  const [isTranscribingAnswer, setIsTranscribingAnswer] = useState(false);
  const [interimTranscript, setInterimTranscript] = useState('');
  const mediaRecorderRef = useRef<MediaRecorder|null>(null);
  const recordedChunksRef = useRef<BlobPart[]>([]);
  const answerRecorderRef = useRef<MediaRecorder | null>(null);
  const answerChunksRef = useRef<BlobPart[]>([]);
  const extraAudioStreamRef = useRef<MediaStream|null>(null);
  const speechRecognitionRef = useRef<SpeechRecognitionInstance | null>(null);
  const [sessionData, setSessionData] = useState<any|null>(null);
  const [evaluationReport, setEvaluationReport] = useState<any|null>(null);
  const [isEvaluating, setIsEvaluating] = useState(false);
  const [isSubmittingAnswer, setIsSubmittingAnswer] = useState(false);
  const [answerStatus, setAnswerStatus] = useState('Type your answer, then submit it for processing.');

  useEffect(() => {
    const supported = Boolean(getSpeechRecognitionConstructor());
    setSpeechSupported(supported);
    if (!supported) {
      setSpeechStatus('Browser live captions unavailable. Record spoken answers for transcription.');
    }
    return () => {
      speechRecognitionRef.current?.stop();
      speechRecognitionRef.current = null;
    };
  }, []);

  useEffect(()=>{
    let mounted = true;
    async function load(){
      try{
        const res = await fetch(`${API_URL}/api/interview/sessions/${sessionId}`);
        if(!res.ok) return;
        const json = await parseApiResponse<any>(res);
        if(mounted) {
          setSessionData(json);
          if (json?.evaluation) setEvaluationReport(json.evaluation);
        }
      }catch(e){/*ignore*/}
    }
    load();
    const t = setInterval(load, 5000);
    return ()=>{ mounted = false; clearInterval(t); };
  },[sessionId]);

  async function startRecording(){
    try{
      if(!videoRef.current) return;
      const original = videoRef.current.srcObject as MediaStream | null;
      let recorderStream: MediaStream | null = null;
      setRecordingStatus('Preparing recording...');

      if (original) {
        // Only record the already-active proctoring stream. Do not request new permissions here.
        recorderStream = original;
        setRecordingStatus((original.getAudioTracks() || []).length ? 'Recording video + audio' : 'Recording video only');
      } else {
        setRecordingStatus('Grant camera access first');
        return;
      }

      // Create MediaRecorder
      const mr = new MediaRecorder(recorderStream as MediaStream, { mimeType: 'video/webm' });
      recordedChunksRef.current = [];
      mr.ondataavailable = (ev:any)=>{ if(ev.data && ev.data.size>0) recordedChunksRef.current.push(ev.data); };
      mr.onstop = async ()=>{
        const blob = new Blob(recordedChunksRef.current, { type: 'video/webm' });
        const form = new FormData();
        form.append('file', blob, `recording-${Date.now()}.webm`);
        setRecordingStatus('Uploading recording...');
        try{
          const res = await fetch(`${API_URL}/api/interview/sessions/${sessionId}/recording`, { method: 'POST', body: form });
          const json = await parseApiResponse<any>(res);
          console.log('upload result', json);
          setRecordingStatus('Recording uploaded');
        }catch(err){
          console.error('Upload failed', err);
          setRecordingStatus('Recording upload failed');
        }
        // do not stop the main camera stream used by proctoring
        try{
          if (extraAudioStreamRef.current) {
            extraAudioStreamRef.current.getTracks().forEach(t=>t.stop());
            extraAudioStreamRef.current = null;
          }
        }catch(e){ console.error('Error stopping recorder tracks', e); }
      };
      mediaRecorderRef.current = mr;
      mr.start();
      setIsRecording(true);
    }catch(err){
      console.error('startRecording error', err);
      setRecordingStatus(`Recording failed: ${err instanceof Error ? err.message : 'unknown error'}`);
    }
  }

  function stopRecording(){
    try{ mediaRecorderRef.current?.stop(); setIsRecording(false); setRecordingStatus('Stopping...'); }catch(e){console.error(e);}
  }

  function startSpeechToText(){
    if (speechRecognitionRef.current) return;

    const Recognition = getSpeechRecognitionConstructor();
    if (!Recognition) {
      setSpeechSupported(false);
      setSpeechStatus('Browser live captions unavailable. Record spoken answers for transcription.');
      return;
    }

    const recognition = new Recognition();
    recognition.continuous = true;
    recognition.interimResults = true;
    recognition.lang = 'en-US';
    recognition.onstart = () => {
      setSpeechSupported(true);
      setIsListening(true);
      setSpeechStatus('Listening for spoken answers');
    };
    recognition.onresult = (event) => {
      let finalText = '';
      let interimText = '';

      for (let index = event.resultIndex; index < event.results.length; index += 1) {
        const transcript = event.results[index][0]?.transcript ?? '';
        if (event.results[index].isFinal) {
          finalText += transcript;
        } else {
          interimText += transcript;
        }
      }

      if (finalText.trim()) {
        setText((current) => `${current} ${finalText}`.trim());
      }
      setInterimTranscript(interimText.trim());
    };
    recognition.onerror = (event) => {
      setSpeechStatus(event.error ? `Speech-to-text error: ${event.error}` : 'Speech-to-text error');
      setIsListening(false);
    };
    recognition.onend = () => {
      setIsListening(false);
      speechRecognitionRef.current = null;
      setInterimTranscript('');
      setSpeechStatus('Speech-to-text idle');
    };

    speechRecognitionRef.current = recognition;
    recognition.start();
  }

  async function uploadAnswerAudio(blob: Blob) {
    const form = new FormData();
    form.append('file', blob, `answer-${Date.now()}.webm`);
    setIsTranscribingAnswer(true);
    setSpeechStatus('Transcribing spoken answer...');

    try {
      const res = await fetch(`${API_URL}/api/interview/sessions/${sessionId}/answer-transcription`, {
        method: 'POST',
        body: form,
      });
      const json = await parseApiResponse<any>(res);

      const transcript = String(json?.text || '').trim();
      if (transcript && transcript !== 'Transcript unavailable.') {
        setText((current) => `${current} ${transcript}`.trim());
        setSpeechStatus('Spoken answer transcribed');
      } else {
        setSpeechStatus('Transcription returned no usable text');
      }
    } catch (error) {
      setSpeechStatus(error instanceof Error ? error.message : 'Answer transcription failed');
    } finally {
      setIsTranscribingAnswer(false);
    }
  }

  function startAnswerRecording(){
    if (answerRecorderRef.current || isTranscribingAnswer) return;

    const stream = videoRef.current?.srcObject as MediaStream | null;
    if (!stream?.getAudioTracks().length) {
      setSpeechStatus('Microphone stream is not ready');
      return;
    }

    try {
      const audioStream = new MediaStream(stream.getAudioTracks());
      const recorder = new MediaRecorder(audioStream, { mimeType: 'audio/webm' });
      answerChunksRef.current = [];
      recorder.ondataavailable = (event) => {
        if (event.data && event.data.size > 0) answerChunksRef.current.push(event.data);
      };
      recorder.onstop = () => {
        const blob = new Blob(answerChunksRef.current, { type: 'audio/webm' });
        answerChunksRef.current = [];
        answerRecorderRef.current = null;
        setIsListening(false);
        if (blob.size > 0) {
          void uploadAnswerAudio(blob);
        } else {
          setSpeechStatus('No spoken audio captured');
        }
      };
      answerRecorderRef.current = recorder;
      recorder.start();
      setIsListening(true);
      setSpeechStatus('Recording spoken answer');
    } catch (error) {
      answerRecorderRef.current = null;
      setIsListening(false);
      setSpeechStatus(error instanceof Error ? error.message : 'Could not start answer recording');
    }
  }

  function stopAnswerRecording(){
    const recorder = answerRecorderRef.current;
    if (!recorder || recorder.state === 'inactive') return;
    recorder.stop();
    setSpeechStatus('Preparing spoken answer for transcription...');
  }

  function stopSpeechToText(){
    speechRecognitionRef.current?.stop();
    speechRecognitionRef.current = null;
    setIsListening(false);
    setInterimTranscript('');
    setSpeechStatus(speechSupported ? 'Speech-to-text idle' : 'Browser live captions unavailable. Record spoken answers for transcription.');
  }

  function toggleSpeechToText(){
    if (isListening) {
      if (speechRecognitionRef.current) {
        stopSpeechToText();
      } else {
        stopAnswerRecording();
      }
      return;
    }

    if (speechSupported) {
      startSpeechToText();
    } else {
      startAnswerRecording();
    }
  }

  async function startSession(){
    try{
      setRecordingStatus('Starting session...');
      const res = await fetch(`${API_URL}/api/interview/sessions/${sessionId}/start`, { method: 'POST' });
      const json = await parseApiResponse<any>(res);
      if (json?.initialQuestion) {
        setMessages([{speaker:'ai', text: json.initialQuestion}]);
        markAiFinished();
      }
      // begin recording automatically
      await startRecording();
    }catch(err){ console.error('startSession failed', err); }
  }

  async function completeSession(){
    try{
      setIsEvaluating(true);
      // stop recording and complete session
      stopSpeechToText();
      stopAnswerRecording();
      stopRecording();
      await fetch(`${API_URL}/api/interview/sessions/${sessionId}/complete`, { method: 'POST' });
      const evalRes = await fetch(`${API_URL}/api/interview/sessions/${sessionId}/evaluate`, { method: 'POST' });
      const evalJson = await parseApiResponse<any>(evalRes);
      if (evalJson?.evaluation) setEvaluationReport(evalJson.evaluation);
      const sessionRes = await fetch(`${API_URL}/api/interview/sessions/${sessionId}`);
      if (sessionRes.ok) setSessionData(await parseApiResponse<any>(sessionRes));
      setRecordingStatus('Session completed and evaluated');
    }catch(err){ console.error('completeSession failed', err); }
    finally { setIsEvaluating(false); }
  }

  async function send(){
    const answerText = text.trim();
    if(!answerText || isSubmittingAnswer) return;

    const metrics=analyze(answerText);
    setIsSubmittingAnswer(true);
    setAnswerStatus('Processing typed answer...');

    try {
      const response = await fetch(`${API_URL}/api/interview/sessions/${sessionId}/answers`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ text: answerText, metrics }),
      });
      const json = await parseApiResponse<any>(response);

      setMessages((current) => [
        ...current,
        { speaker: 'candidate', text: answerText, metrics },
        ...(json?.ai?.text ? [{ speaker: 'ai', text: json.ai.text }] : []),
      ]);
      setText('');
      setInterimTranscript('');
      markAiFinished();
      setAnswerStatus('Typed answer processed and saved for evaluation.');
    } catch (error) {
      setAnswerStatus(error instanceof Error ? error.message : 'Could not process the typed answer');
    } finally {
      setIsSubmittingAnswer(false);
    }
  }

  useEffect(()=>{ setDuration(new Date().toLocaleTimeString([], {hour:'numeric', minute:'2-digit', second:'2-digit'})); },[]);

  const cameraReady = state.cameraActive && !state.permissionDenied;
  const screenShareReady = !state.screenShareSupported || state.screenShareReadyBeforeInterview;
  const fullscreenReady = !state.fullscreenSupported || state.fullscreenReadyBeforeInterview || state.fullscreenActive;
  const permissionsReadyForCalibration = cameraReady && screenShareReady && fullscreenReady;

  async function requestAccessBeforeCalibration(){
    await requestRequiredPermissions();
  }

  const systemChecks = [
    { label: 'Camera stream', ok: state.cameraActive, detail: state.cameraActive ? 'Active' : 'Inactive' },
    { label: 'Typed answer input', ok: true, detail: 'Answers are submitted directly for evaluation' },
    { label: 'Face detector', ok: state.faceDetectorActive, detail: state.faceDetectorActive ? `Tracking ${state.faceCount} face${state.faceCount === 1 ? '' : 's'}` : 'Starting' },
    { label: 'Object detector', ok: state.objectDetectorActive, detail: state.phoneDetected ? 'Phone flagged' : 'Scanning for phone-like objects' },
    { label: 'Gaze monitor', ok: !state.gazeAwayDetected, detail: state.gazeAwayDetected ? `Looking ${state.gazeDirection}` : 'Centered on camera' },
    { label: 'WebSocket loop', ok: socket?.readyState === WebSocket.OPEN, detail: socket?.readyState === WebSocket.OPEN ? 'Connected' : 'Connecting' },
    { label: 'Backend logging', ok: events.length >= 0, detail: 'Proctoring events persist to the API' },
  ];

  const isInterviewFinished = messages.some(m => m.speaker === 'ai' && (m.text.includes('completes the structured interview') || m.text.includes('click Complete session')));

  if (!mounted) {
    return (
      <main className="min-h-screen bg-gradient-to-br from-[#0b0f19] via-[#0d1222] to-[#05070e] p-6 font-sans text-slate-100 flex items-center justify-center">
        <div className="text-center">
          <p className="text-xs uppercase tracking-[0.35em] text-[#d4af37]">Loading interview room</p>
          <div className="mt-4 h-8 w-8 animate-spin rounded-full border-4 border-[#d4af37] border-t-transparent mx-auto"></div>
        </div>
      </main>
    );
  }

  if (isLocked && timeLeft) {
    return (
      <main className="min-h-screen bg-gradient-to-br from-[#0b0f19] via-[#0d1222] to-[#05070e] p-6 font-sans text-slate-100 flex flex-col items-center justify-center relative overflow-hidden">
        {/* Glow Effects */}
        <div className="absolute top-1/4 left-1/4 w-[400px] h-[400px] rounded-full bg-cyan-500/10 blur-[100px] pointer-events-none" />
        <div className="absolute bottom-1/4 right-1/4 w-[400px] h-[400px] rounded-full bg-amber-500/5 blur-[100px] pointer-events-none" />

        <div className="w-full max-w-2xl text-center relative z-10">
          <div className="mb-6 flex flex-col items-center">
            <span className="text-xs uppercase tracking-[0.4em] text-[#d4af37] font-semibold">IntervieHire</span>
            <div className="h-[2px] w-12 bg-gradient-to-r from-transparent via-[#d4af37] to-transparent mt-2" />
          </div>

          <div className="rounded-3xl border border-white/10 bg-slate-900/40 backdrop-blur-xl p-8 shadow-[0_20px_50px_rgba(0,0,0,0.5)]">
            <div className="mb-8">
              <span className="inline-flex items-center gap-2 rounded-full bg-amber-500/10 border border-amber-500/20 px-4 py-1.5 text-xs font-semibold text-amber-300 uppercase tracking-wider animate-pulse">
                <span className="h-2 w-2 rounded-full bg-amber-400" />
                Interview Room Locked
              </span>
              
              <h1 className="mt-6 text-3xl font-extrabold text-white tracking-tight">
                {scheduleData?.job_title || "General Position"}
              </h1>
              <p className="mt-2 text-[#d4af37] font-medium tracking-wide">
                {scheduleData?.stage || "Interview Session"}
              </p>
              <p className="mt-4 text-sm text-slate-400 max-w-md mx-auto">
                Hello, <span className="text-white font-semibold">{scheduleData?.candidate_name || "Candidate"}</span>. Your interview has been scheduled. The room will unlock automatically when the interview begins.
              </p>
            </div>

            <div className="grid grid-cols-4 gap-4 max-w-md mx-auto mb-8">
              {[
                { label: 'Days', value: timeLeft.days },
                { label: 'Hours', value: timeLeft.hours },
                { label: 'Minutes', value: timeLeft.minutes },
                { label: 'Seconds', value: timeLeft.seconds }
              ].map(({ label, value }) => (
                <div key={label} className="flex flex-col items-center p-4 rounded-2xl bg-white/5 border border-white/5 shadow-inner">
                  <span className="text-3xl font-black text-white tracking-tight tabular-nums">
                    {String(value).padStart(2, '0')}
                  </span>
                  <span className="text-[10px] uppercase tracking-wider text-slate-500 font-semibold mt-1">
                    {label}
                  </span>
                </div>
              ))}
            </div>

            <div className="text-xs text-slate-500 border-t border-white/5 pt-6 flex items-center justify-center gap-2">
              <Timer size={14} className="text-[#d4af37]" />
              <span>Scheduled for: <span className="text-slate-300 font-medium">{scheduleData?.scheduled_at ? new Date(scheduleData.scheduled_at).toLocaleString() : 'N/A'}</span></span>
            </div>
          </div>
        </div>
      </main>
    );
  }

   return (
    <main className="min-h-screen bg-gradient-to-br from-[#0b0f19] via-[#0d1222] to-[#05070e] p-6 font-sans text-slate-100">
      {!calibration && !permissionsReadyForCalibration && (
        <div className="fixed inset-0 z-[9999] flex items-center justify-center bg-[#090d16] px-6 text-slate-100">
          <div className="w-full max-w-xl rounded-3xl border border-white/10 bg-slate-900/40 backdrop-blur-xl p-8 shadow-2xl">
            <div className="mb-8 text-center">
              <p className="text-xs uppercase tracking-[0.35em] text-[#d4af37]">Pre-interview access</p>
              <h1 className="mt-4 text-3xl font-black text-white">Grant Access Before Gaze Calibration</h1>
              <p className="mt-3 text-sm leading-6 text-slate-400">
                Camera, screen sharing, and fullscreen modes are verified before calibration begins. 
              </p>
            </div>

            <div className="space-y-3 rounded-2xl border border-white/5 bg-white/5 p-4">
              {[
                { label: 'Camera', ok: cameraReady, detail: state.permissionDenied ? 'Permission denied' : state.cameraActive ? 'Ready' : 'Waiting for browser permission', icon: Video },
                { label: 'Screen share', ok: screenShareReady, detail: !state.screenShareSupported ? 'Unavailable in this browser' : state.screenShareReadyBeforeInterview ? 'Ready' : 'Required before calibration', icon: MonitorUp },
                { label: 'Fullscreen', ok: fullscreenReady, detail: !state.fullscreenSupported ? 'Unavailable in this browser' : fullscreenReady ? 'Ready' : 'Required before calibration', icon: Maximize2 },
              ].map(({ label, ok, detail, icon: Icon }) => (
                <div key={label} className="flex items-center justify-between gap-4 rounded-xl bg-slate-950/70 border border-white/5 px-4 py-3">
                  <div className="flex items-center gap-3">
                    <Icon size={18} className={ok ? 'text-emerald-400' : 'text-[#d4af37]'} />
                    <div>
                      <p className="text-sm font-semibold">{label}</p>
                      <p className="text-xs text-slate-400">{detail}</p>
                    </div>
                  </div>
                  <span className={`h-2.5 w-2.5 rounded-full ${ok ? 'bg-emerald-400 shadow-[0_0_10px_#34d399]' : 'bg-amber-400 shadow-[0_0_10px_#fbbf24]'}`} />
                </div>
              ))}
            </div>

            <button
              onClick={requestAccessBeforeCalibration}
              className="mt-6 flex w-full items-center justify-center gap-2 rounded-xl bg-[#d4af37] hover:bg-[#c29d2f] px-5 py-3.5 text-sm font-black text-slate-950 transition-all shadow-[0_0_30px_rgba(212,175,55,0.25)]"
            >
              <ShieldCheck size={18} />
              Grant Required Access
            </button>
            {state.permissionDenied && (
              <p className="mt-4 text-center text-sm text-rose-300">
                Camera access was denied. Please allow it in your browser settings and refresh the page.
              </p>
            )}
          </div>
        </div>
      )}
      {!calibration && permissionsReadyForCalibration && (
        <GazeCalibration
          videoRef={videoRef}
          onComplete={setCalibration}
          onSkip={() => setCalibration({
            thresholdX: 0.18,
            thresholdY: 0.22,
            neutralX: 0,
            neutralY: 0,
            pointData: [],
            qualityScore: 0,
          })}
        />
      )}
      <div className="mx-auto grid max-w-7xl gap-6 lg:grid-cols-[1fr_420px]">
        <section className="rounded-3xl border border-white/10 bg-slate-900/40 backdrop-blur-md p-6 shadow-2xl">
          <div className="mb-6 flex flex-wrap items-center justify-between gap-4">
            <div>
              <p className="text-xs uppercase tracking-wider text-[#d4af37]">{scheduleData?.stage || 'Candidate Vetting Portal'}</p>
              <h1 className="text-2xl font-black text-white">{sessionData?.jobRole?.title || 'Functional Technical Interview'}</h1>
            </div>
            <div className="flex flex-wrap gap-2 text-xs">
              <button onClick={startSession} className="rounded-full bg-emerald-500/10 border border-emerald-500/30 text-emerald-300 px-4 py-2 hover:bg-emerald-500/20 transition-all font-semibold">Start Session</button>
              <button onClick={completeSession} disabled={isEvaluating || isSubmittingAnswer} className="rounded-full bg-rose-500/10 border border-rose-500/30 text-rose-300 px-4 py-2 hover:bg-rose-500/20 transition-all font-semibold disabled:opacity-40 disabled:cursor-not-allowed">{isEvaluating ? 'Evaluating...' : 'Complete Session'}</button>
              <span className="rounded-full bg-white/5 border border-white/10 px-4 py-2 flex items-center gap-1.5"><Timer size={14} className="text-[#d4af37]"/>{duration}</span>
              <span className={`rounded-full px-4 py-2 border flex items-center gap-1.5 ${state.permissionDenied ? 'bg-rose-500/10 border-rose-500/30 text-rose-300' : state.initialized ? 'bg-emerald-500/10 border-emerald-500/30 text-emerald-300' : 'bg-amber-500/10 border-amber-500/30 text-amber-300'}`}><ShieldCheck size={14}/>{state.status}</span>
            </div>
          </div>

          <div className="relative aspect-video overflow-hidden rounded-2xl border border-white/10 bg-gradient-to-br from-[#121c38] via-[#091024] to-[#04060d] shadow-inner">
            <div className="absolute inset-0 grid place-items-center">
              <div className="text-center">
                <div className="mx-auto mb-5 flex h-36 w-36 items-center justify-center rounded-full bg-white/5 border border-white/10 shadow-[0_0_50px_rgba(212,175,55,0.1)] ring-8 ring-white/5">
                  <img
                    src="/avatar-placeholder.svg"
                    alt="AI interviewer avatar"
                    className="h-28 w-28 rounded-full object-cover opacity-80"
                  />
                </div>
                <h2 className="text-xl font-bold text-white">AI Interviewer</h2>
                <p className="text-xs text-slate-400 mt-1">Interviewer bridge ready: UE5 / WebRTC / Convai Lip-Sync</p>
              </div>
            </div>
            {videoElement}
          </div>

          <div className="mt-6 rounded-2xl border border-white/10 bg-slate-900/60 p-5 text-white">
            <div className="max-h-72 space-y-4 overflow-y-auto pr-2 scrollbar-thin scrollbar-thumb-white/10">
              {messages.map((m,i)=>(
                <div key={i} className={`flex flex-col rounded-2xl p-4 max-w-[85%] shadow-md ${m.speaker==='ai' ? 'bg-white/5 border border-white/5 text-slate-200 rounded-tl-none self-start' : 'bg-[#d4af37]/10 border border-[#d4af37]/20 text-slate-200 rounded-tr-none ml-auto'}`}>
                  <b className={`text-[10px] uppercase tracking-wider font-bold mb-1 ${m.speaker==='ai' ? 'text-cyan-400' : 'text-amber-400'}`}>
                    {m.speaker === 'ai' ? 'AI Interviewer' : 'Candidate'}
                  </b>
                  <p className="text-sm leading-6">{m.text}</p>
                  {m.metrics && (
                    <p className="mt-2 text-[10px] text-slate-500 font-mono">
                      WPM: {m.metrics.wpm} | Latency: {m.metrics.latencyMs}ms
                    </p>
                  )}
                </div>
              ))}
            </div>
            <div className="mt-5 flex gap-3">
              <input
                value={text}
                onChange={e=>setText(e.target.value)}
                onKeyDown={e=>{ if(e.key==='Enter'){ e.preventDefault(); void send(); } }}
                disabled={isSubmittingAnswer || isInterviewFinished}
                className="flex-1 rounded-xl bg-white/5 border border-white/10 px-4 py-3 outline-none text-white placeholder-slate-400 focus:border-[#d4af37] focus:ring-1 focus:ring-[#d4af37] transition-all text-sm disabled:opacity-50"
                placeholder={isInterviewFinished ? "Interview completed. Click 'Complete Session' above." : "Type your answer here..."}
              />
              <button
                onClick={()=>void send()}
                disabled={!text.trim() || isSubmittingAnswer || isInterviewFinished}
                className="rounded-xl bg-[#d4af37] hover:bg-[#c29d2f] text-slate-950 px-5 font-black disabled:cursor-not-allowed disabled:opacity-50 transition-all flex items-center justify-center shadow-[0_0_15px_rgba(212,175,55,0.15)]"
                title="Submit typed answer"
              >
                <Send size={16}/>
              </button>
            </div>
            <div className="mt-3 flex flex-wrap items-center justify-between gap-2 text-[11px] text-slate-500">
              <span>{isInterviewFinished ? "Interview completed! Please click the 'Complete Session' button above." : answerStatus}</span>
            </div>
          </div>
        </section>

        <aside className="space-y-6">
          {evaluationReport && (
            <div className="rounded-3xl border border-white/10 bg-slate-900/40 backdrop-blur-md p-6 text-slate-200 shadow-2xl">
              <h2 className="font-bold text-white flex items-center gap-2"><BarChart3 className="text-[#d4af37]"/>Final Evaluation Report</h2>
              <div className="mt-4 grid grid-cols-2 gap-3">
                <div className="rounded-2xl border border-white/5 bg-white/5 p-4">
                  <p className="text-[10px] uppercase tracking-wider text-slate-400">Overall Score</p>
                  <p className="text-3xl font-black text-white mt-1">{evaluationReport.overallScore ?? '-'}<span className="text-xs text-slate-500 font-normal">/100</span></p>
                </div>
                <div className="rounded-2xl border border-white/5 bg-white/5 p-4">
                  <p className="text-[10px] uppercase tracking-wider text-slate-400">Recommendation</p>
                  <p className="mt-2 text-sm font-black text-emerald-400 capitalize">{String(evaluationReport.recommendation ?? '-').replaceAll('_', ' ')}</p>
                  <p className="text-[10px] text-slate-500 mt-1 font-mono">Confidence: {evaluationReport.recommendationConfidence ?? '-'}</p>
                </div>
              </div>
              <p className="mt-4 text-xs leading-6 text-slate-300 border-t border-white/5 pt-4">{evaluationReport.summary}</p>
              {evaluationReport.candidateConfidence && (
                <div className="mt-4 rounded-2xl border border-cyan-500/10 bg-cyan-500/5 p-4">
                  <h3 className="text-xs font-bold text-cyan-300">Expressed Confidence</h3>
                  <p className="mt-1 text-2xl font-black text-white">
                    {evaluationReport.candidateConfidence.score}<span className="text-xs text-slate-500 font-normal">/100</span>
                  </p>
                  <p className="text-[10px] capitalize text-slate-400 mt-1">
                    {evaluationReport.candidateConfidence.level} confidence | {evaluationReport.candidateConfidence.reliability} reliability
                  </p>
                  <p className="mt-2 text-xs leading-5 text-slate-300">{evaluationReport.candidateConfidence.summary}</p>
                </div>
              )}

              <div className="mt-5 border-t border-white/5 pt-4">
                <h3 className="text-xs font-bold text-[#d4af37] uppercase tracking-wider">Demonstrated Strengths</h3>
                <ul className="mt-2 space-y-2 text-xs text-slate-300">
                  {(evaluationReport.strengths ?? []).map((item:string, index:number)=>(
                    <li key={index} className="rounded-xl border border-emerald-500/10 bg-emerald-500/5 px-3 py-2.5 text-emerald-300">✓ {item}</li>
                  ))}
                </ul>
              </div>

              <div className="mt-5">
                <h3 className="text-xs font-bold text-rose-400 uppercase tracking-wider">Development Areas</h3>
                <ul className="mt-2 space-y-2 text-xs text-slate-300">
                  {(evaluationReport.weaknesses ?? []).map((item:string, index:number)=>(
                    <li key={index} className="rounded-xl border border-rose-500/10 bg-rose-500/5 px-3 py-2.5 text-rose-300">✗ {item}</li>
                  ))}
                </ul>
              </div>

              <div className="mt-5">
                <h3 className="text-xs font-bold text-white uppercase tracking-wider">Question Breakdown</h3>
                <div className="mt-2 space-y-3">
                  {(evaluationReport.questionBreakdown ?? []).map((item:any, index:number)=>(
                    <details key={item.answerId ?? index} className="rounded-xl border border-white/5 bg-white/5 p-3 text-xs">
                      <summary className="cursor-pointer font-semibold text-slate-200 hover:text-white transition-colors">
                        Q{index + 1}: {item.questionText ?? item.question ?? 'Asked question'} ({item.overallScore}/100)
                      </summary>
                      <p className="mt-2 text-slate-400 leading-5">{item.summary}</p>
                      {item.transcriptConfidence && (
                        <p className="mt-2 text-[10px] text-slate-500 font-mono">
                          Confidence: {item.transcriptConfidence.confidenceScore}/100 | Fillers: {item.transcriptConfidence.fillerCount} | Hedges: {item.transcriptConfidence.hedgeCount}
                        </p>
                      )}
                      {item.aiAuthorshipAssessment && (
                        <div className="mt-3 rounded-xl border border-violet-500/10 bg-violet-500/5 px-3 py-2">
                          <div className="flex flex-wrap items-center justify-between gap-2">
                            <span className="text-[10px] font-semibold text-violet-300">AI-Authorship Likelihood</span>
                            <span className="text-xs font-black text-violet-400">
                              {item.aiAuthorshipAssessment.probability}%
                            </span>
                          </div>
                          <details className="mt-1 text-[10px] text-violet-300">
                            <summary className="cursor-pointer font-medium hover:text-violet-200">
                              Assessment Details
                            </summary>
                            <ul className="mt-2 space-y-1 pl-2 list-disc list-inside">
                              {(item.aiAuthorshipAssessment.reasons ?? []).map((reason:string, reasonIndex:number)=>(
                                <li key={reasonIndex} className="text-slate-400">{reason}</li>
                              ))}
                            </ul>
                          </details>
                        </div>
                      )}
                    </details>
                  ))}
                </div>
              </div>
            </div>
          )}

          <div className="rounded-3xl border border-white/10 bg-slate-900/40 backdrop-blur-md p-6 text-slate-200 shadow-2xl">
            <h2 className="font-bold text-white flex items-center gap-2"><Video className="text-[#d4af37]"/>System Check</h2>
            <ul className="mt-4 space-y-2 text-xs text-slate-300">
              {systemChecks.map((check)=>(
                <li key={check.label} className="flex items-start justify-between gap-3 rounded-xl border border-white/5 bg-white/5 px-4 py-3">
                  <span className="flex items-center gap-2">
                    <span className={`h-2 w-2 rounded-full ${check.ok ? 'bg-emerald-400 shadow-[0_0_8px_#34d399]' : 'bg-rose-400 shadow-[0_0_8px_#f43f5e]'}`} />
                    {check.label}
                  </span>
                  <span className="text-right text-[11px] text-slate-400">{check.detail}</span>
                </li>
              ))}
            </ul>
            <p className="mt-4 text-[10px] text-slate-500 text-right font-mono">Last observed: {state.lastObservationAt ? new Date(state.lastObservationAt).toLocaleTimeString() : 'waiting for camera input'}</p>
          </div>

          <div className="rounded-3xl border border-white/10 bg-slate-900/40 backdrop-blur-md p-6 text-slate-200 shadow-2xl">
            <h2 className="font-bold text-white flex items-center gap-2"><Mic className="text-[#d4af37]"/>Live Integrity Events</h2>
            <div className="mt-4 space-y-3">
              {events.length ? events.map((e,i)=>(
                <div key={i} className="rounded-xl border border-white/5 bg-white/5 p-3 text-xs">
                  <b className={e.severity === 'HIGH' ? 'text-rose-400' : 'text-amber-400'}>{e.severity}</b>
                  <p className="mt-1 font-semibold text-slate-200">{e.eventType}</p>
                  <pre className="mt-2 whitespace-pre-wrap text-[10px] font-mono text-slate-400 border-t border-white/5 pt-2">{e.metadata ? JSON.stringify(e.metadata, null, 2) : ''}</pre>
                </div>
              )) : <p className="text-xs text-slate-400 text-center py-4">No events flagged yet.</p>}
            </div>
          </div>

          <div className="rounded-3xl border border-white/10 bg-slate-900/40 backdrop-blur-md p-6 text-slate-200 shadow-2xl">
            <h2 className="font-bold text-white">Recordings & Transcripts</h2>
            <p className="mt-2 text-xs text-slate-400 leading-5">Recorded candidate responses and automated transcriptions.</p>
            <p className="mt-3 text-[10px] text-slate-400 font-mono">Status: {recordingStatus}</p>
            <div className="mt-4 space-y-4">
              {sessionData?.transcript?.length ? sessionData.transcript.slice().reverse().map((entry:any, idx:number)=>(
                <div key={idx} className="rounded-xl border border-white/5 bg-white/5 p-3 text-xs">
                  <div className="text-[10px] text-[#d4af37] font-mono">{entry.type} • {entry.createdAt ? new Date(entry.createdAt).toLocaleString() : ''}</div>
                  {entry.type === 'recording' ? (
                    <video className="mt-2 w-full rounded-lg border border-white/10" controls src={`${API_URL}${entry.url}`} />
                  ) : null}
                  {entry.type === 'transcription' ? (
                    <pre className="mt-2 text-xs whitespace-pre-wrap leading-5 text-slate-300 font-sans">{entry.text}</pre>
                  ) : null}
                </div>
              )) : <div className="text-xs text-slate-400 text-center py-4">No recordings yet.</div>}

              {sessionData?.evaluation?.partialQuestionFit?.length ? (
                <div className="mt-4 border-t border-white/5 pt-4">
                  <h4 className="text-xs font-semibold text-white">Question-Fit Scoring</h4>
                  <ul className="mt-2 space-y-2">
                    {sessionData.evaluation.partialQuestionFit.map((q:any, i:number)=>(
                      <li key={i} className="rounded-xl border border-white/5 bg-white/5 p-3 text-xs">
                        <div className="font-semibold text-[#d4af37]">Score: {q.score}/5</div>
                        <div className="text-[11px] text-slate-400 mt-1 leading-4">{q.reasoning}</div>
                      </li>
                    ))}
                  </ul>
                </div>
              ) : null}
            </div>
          </div>

          <div className="rounded-3xl border border-[#d4af37]/20 bg-[#d4af37]/5 p-6 shadow-2xl">
            <h2 className="font-bold text-white">Active Session ID</h2>
            <input value={sessionId} onChange={e=>setSessionId(e.target.value)} className="mt-3 w-full rounded-xl bg-slate-950/70 border border-white/10 focus:border-[#d4af37] focus:ring-1 focus:ring-[#d4af37] transition-all px-4 py-3 text-xs text-white font-mono outline-none"/>
          </div>
        </aside>
      </div>
    </main>
  );
}
