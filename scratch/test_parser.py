import sys
sys.path.append('backend')
import os
from dotenv import load_dotenv
load_dotenv(dotenv_path='backend/.env')

from app.utils.resume_parser import parse_resume_with_deepseek

key = os.getenv("DEEPSEEK_API_KEY")
print("Using API Key:", key)

pdf_path = "backend/uploads/resumes/resume_data_analyst.pdf"
print("Parsing file:", pdf_path)

res = parse_resume_with_deepseek(pdf_path, "resume_data_analyst.pdf", key)
print("Parser Result:", res)
