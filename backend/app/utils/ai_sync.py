import json
import logging
from typing import Optional, Dict, Any, List
from sqlalchemy.orm import Session
from app.models.applicant import Applicant
from app.models.job import Job
from app.models.organisation import Organisation
from app.models.ai_integration import Company, Candidate, JobRole, Question, InterviewSession, ProctoringLog, RoleType, SessionStatus, Severity

logger = logging.getLogger(__name__)

def slugify(text: str) -> str:
    import re
    text = text.lower()
    text = re.sub(r'[^a-z0-9]+', '-', text)
    return text.strip('-')

def sync_applicant_to_ai(db: Session, applicant: Applicant) -> Optional[InterviewSession]:
    try:
        # Load relationships if not fully loaded
        job = db.query(Job).filter(Job.id == applicant.job_id).first()
        if not job:
            logger.warning(f"No job found for applicant {applicant.id}")
            return None
            
        organisation = None
        if job.organisation_id:
            organisation = db.query(Organisation).filter(Organisation.id == job.organisation_id).first()
            
        if not organisation:
            # Fallback or create dummy organisation if missing
            org_id = job.organisation_id or applicant.id # use a fallback
            logger.warning(f"No organisation found for job {job.id}, using fallback.")
            organisation = db.query(Organisation).first()
            if not organisation:
                return None

        # 1. Sync Company
        company_id = str(organisation.id)
        company = db.query(Company).filter(Company.id == company_id).first()
        if not company:
            company = Company(
                id=company_id,
                name=organisation.org_name,
                slug=organisation.domain or slugify(organisation.org_name),
                description=organisation.description or "No description provided",
                logoUrl=organisation.logo_url,
                primaryColor="#0f766e",
                settings={},
                webhooks={},
                reportEmail=organisation.contact_email or "hr@example.com"
            )
            db.add(company)
            db.commit()
            db.refresh(company)

        # 2. Sync JobRole
        role_id = str(job.id)
        job_role = db.query(JobRole).filter(JobRole.id == role_id).first()
        
        # Parse screening/functional criteria or use defaults
        primary_criteria = ["coding proficiency", "problem solving"]
        secondary_criteria = ["communication", "system design"]
        
        if job.functional_parameters:
            try:
                params = json.loads(job.functional_parameters)
                if isinstance(params, list):
                    primary_criteria = [str(p) for p in params][:4]
                elif isinstance(params, dict):
                    primary_criteria = [str(k) for k in params.keys()][:4]
            except Exception:
                pass
                
        if not job_role:
            job_role = JobRole(
                id=role_id,
                companyId=company_id,
                title=job.role_name or job.title,
                roleType=RoleType.GENERAL,
                description=job.description or "No description provided",
                requirements=job.description or "No requirements specified",
                primaryCriteria=primary_criteria,
                secondaryCriteria=secondary_criteria,
                atsScoringWeights={
                    "primary": 0.4,
                    "secondary": 0.3,
                    "education": 0.1,
                    "experience": 0.1,
                    "communication": 0.1
                },
                evaluationCriteria={
                    "modelAnswerAlignment": 1,
                    "correctness": 1,
                    "reasoning": 1,
                    "communication": 1,
                    "confidence": 1
                }
            )
            db.add(job_role)
            db.commit()
            db.refresh(job_role)
        else:
            # Update criteria
            job_role.title = job.role_name or job.title
            job_role.description = job.description or "No description provided"
            job_role.primaryCriteria = primary_criteria
            db.commit()

        # 3. Sync Candidate
        candidate_id = str(applicant.id)
        candidate = db.query(Candidate).filter(Candidate.id == candidate_id).first()
        if not candidate:
            candidate = Candidate(
                id=candidate_id,
                companyId=company_id,
                fullName=applicant.name,
                email=applicant.email,
                phone=applicant.phone,
                resumeText="",
                parsedResume={},
                atsScore=0.0,
                atsBreakdown={}
            )
            db.add(candidate)
            db.commit()
            db.refresh(candidate)
        else:
            candidate.fullName = applicant.name
            candidate.email = applicant.email
            candidate.phone = applicant.phone
            db.commit()

        # 4. Sync InterviewSession
        session_id = str(applicant.id) # Use candidate ID as Session ID directly
        session = db.query(InterviewSession).filter(InterviewSession.id == session_id).first()
        if not session:
            session = InterviewSession(
                id=session_id,
                companyId=company_id,
                candidateId=candidate_id,
                jobRoleId=role_id,
                status=SessionStatus.SCHEDULED,
                avatarProvider="ue5_pixel_streaming",
                transcript=[]
            )
            db.add(session)
            db.commit()
            db.refresh(session)
            
        return session
    except Exception as e:
        logger.exception(f"Error syncing applicant {applicant.id} to AI models: {e}")
        db.rollback()
        return None

def get_applicant_vetting(db: Session, applicant_id: str) -> Dict[str, Any]:
    # Query InterviewSession
    session = db.query(InterviewSession).filter(InterviewSession.id == applicant_id).first()
    if not session:
        # Return mock / default state
        return {
            "summary": "No functional interview has been scheduled or attempted yet for this candidate.",
            "caveats": [{"type": "info", "text": "Interview pending candidate action."}],
            "pros": [],
            "cons": [],
            "rubrics": [],
            "transcript": []
        }

    # Query ProctoringLogs
    logs = db.query(ProctoringLog).filter(ProctoringLog.sessionId == applicant_id).all()
    
    # Parse evaluation json
    eval_data = session.evaluation or {}
    
    # Extract summary
    summary = eval_data.get("summary") or "The functional interview session is registered. Awaiting candidate submission."
    if session.status == SessionStatus.IN_PROGRESS:
        summary = "Candidate is currently attempting the functional interview in real-time."
    elif session.status == SessionStatus.COMPLETED:
        summary = "Functional interview completed. Vetting reports are being generated."

    # Extract pros and cons
    pros = eval_data.get("strengths") or []
    cons = eval_data.get("weaknesses") or []

    # Map rubrics
    rubrics = []
    # If we have dimensionScores
    dimension_scores = eval_data.get("dimensionScores") or {}
    for key, dim in dimension_scores.items():
        if isinstance(dim, dict) and "score" in dim:
            label = key.replace("_", " ").title()
            rubrics.append({
                "label": label,
                "score": float(dim["score"]) / 10.0 # Map from 100-scale to 10-scale for frontend
            })
            
    # Fallback to general scorecard if empty
    if not rubrics and session.status in [SessionStatus.EVALUATED, SessionStatus.COMPLETED]:
        # Generate some rubrics based on overall score if missing
        overall = eval_data.get("overallScore") or 0.0
        rubrics = [
            {"label": "Technical Fit", "score": round(overall / 10.0, 1)},
            {"label": "Communication", "score": round(overall / 10.0, 1)},
            {"label": "Problem Solving", "score": round(overall / 10.0, 1)},
            {"label": "Clarity & Structure", "score": round(overall / 10.0, 1)}
        ]

    # Map caveats based on proctoring logs
    caveats = []
    critical_violations = [l for l in logs if l.severity in [Severity.CRITICAL, Severity.HIGH]]
    if critical_violations:
        caveats.append({
            "type": "warning",
            "text": f"Critical proctoring warning: {len(critical_violations)} high-severity integrity violations flagged (e.g. face gaze drift, smartphone usage)."
        })
        
    for l in logs:
        # Add basic proctoring warning events
        text = f"{l.eventType} detected ({l.severity.value})"
        # avoid duplicating warnings
        if not any(c["text"] == text for c in caveats):
            caveats.append({
                "type": "warning" if l.severity in [Severity.CRITICAL, Severity.HIGH] else "info",
                "text": text
            })
            
    if not caveats:
        if session.status in [SessionStatus.EVALUATED, SessionStatus.COMPLETED]:
            caveats.append({
                "type": "info",
                "text": "Interview completed with no critical proctoring violations detected."
            })
        else:
            caveats.append({
                "type": "info",
                "text": f"Session status: {session.status.value}"
            })

    # Map transcript
    # session.transcript holds a list of entries like: { speaker: 'ai', text: '...' }
    transcript = []
    raw_transcript = session.transcript
    if isinstance(raw_transcript, str):
        try:
            raw_transcript = json.loads(raw_transcript)
        except Exception:
            raw_transcript = []
            
    if isinstance(raw_transcript, list):
        for entry in raw_transcript:
            if isinstance(entry, dict):
                speaker = entry.get("speaker") or entry.get("type") or "Participant"
                text = entry.get("text") or ""
                # Map speaker names
                if speaker.lower() == 'ai':
                    speaker = "AI Interviewer"
                elif speaker.lower() in ['candidate', 'user']:
                    speaker = "Candidate"
                    
                if text:
                    transcript.append({
                        "speaker": speaker,
                        "text": text
                    })

    return {
        "summary": summary,
        "caveats": caveats,
        "pros": pros,
        "cons": cons,
        "rubrics": rubrics,
        "transcript": transcript,
        "reportUrl": session.reportUrl if session else None
    }
