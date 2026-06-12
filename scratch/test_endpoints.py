import sys
import os
from dotenv import load_dotenv
sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__), '..', 'backend')))
load_dotenv(os.path.abspath(os.path.join(os.path.dirname(__file__), '..', 'backend', '.env')))

from sqlalchemy.orm import Session
from app.database import SessionLocal
from app.models.job import Job
from app.models.applicant import Applicant, InterviewStatus
import uuid

def test_leaderboard():
    db = SessionLocal()
    try:
        job = db.query(Job).first()
        if not job:
            print("No jobs found in database to test leaderboard.")
            return
            
        print(f"Testing Leaderboard for Job: {job.title} ({job.id})")
        applicants = db.query(Applicant).filter(Applicant.job_id == job.id).all()
        print(f"Found {len(applicants)} applicants.")
        for app in applicants:
            resume_score = app.match_score or 0.0
            if resume_score <= 10.0:
                resume_score = resume_score * 10.0
            screening_score = app.screening_score or app.recruiter_screening_score or 0.0
            functional_score = app.functional_score or 0.0
            overall_score = round(resume_score * 0.2 + screening_score * 0.3 + functional_score * 0.5, 1)
            print(f"- {app.name}: Match: {app.match_score}, Screen: {screening_score}, Func: {functional_score} -> Overall Fit Score: {overall_score}")
            
    finally:
        db.close()

def test_scheduling_flow():
    db = SessionLocal()
    try:
        applicant = db.query(Applicant).first()
        if not applicant:
            print("No applicants found to test scheduling.")
            return
            
        print(f"Testing Scheduling Token for Applicant: {applicant.name}")
        if not applicant.scheduling_token:
            applicant.scheduling_token = str(uuid.uuid4())
            db.commit()
            print(f"Successfully generated token: {applicant.scheduling_token}")
        else:
            print(f"Existing token: {applicant.scheduling_token}")
            
    finally:
        db.close()

if __name__ == "__main__":
    test_leaderboard()
    test_scheduling_flow()
