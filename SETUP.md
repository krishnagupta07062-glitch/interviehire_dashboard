# InterviewHire — Local Developer Setup Guide

> **Shared Database**: All developers connect to the same hosted Supabase PostgreSQL database. No local PostgreSQL installation needed.

---

## Prerequisites

Install these tools before starting:

| Tool | Download |
|------|----------|
| Python 3.10+ | https://python.org |
| Node.js 18+ | https://nodejs.org |
| Git | https://git-scm.com |

---

## Step 1 — Clone the Repository

```bash
git clone <repo-url>
cd interviehire
```

---

## Step 2 — Configure Environment Variables

You need two `.env` files. Copy the examples and fill in the values (ask the project owner for the database password and API keys):

### Backend (`backend/.env`)
```bash
cp backend/.env.example backend/.env
```
Then open `backend/.env` and replace `[PASSWORD]` with the real Supabase password.

### AI Components (`ai_components/.env`)
```bash
cp ai_components/.env.example ai_components/.env
```
Then open `ai_components/.env` and replace `[PASSWORD]` with the real Supabase password.

> **Ask the project owner for:**
> - Supabase database password
> - `DEEPSEEK_API_KEY`

---

## Step 3 — Install Python Dependencies

From the **project root**:

```bash
pip install -r requirements.txt
```

---

## Step 4 — Install Node Dependencies & Generate Prisma Client

```bash
cd ai_components
npm install

# Windows (PowerShell)
Set-ExecutionPolicy -Scope Process -ExecutionPolicy RemoteSigned
npx prisma generate --schema="apps/api/prisma/schema.prisma"

# macOS / Linux
npx prisma generate --schema="apps/api/prisma/schema.prisma"
```

---

## Step 5 — Install Frontend Dependencies

```bash
cd frontend-final-final
npm install
```

---

## Step 6 — Run All Three Servers

Open **3 separate terminal windows**:

### Terminal 1 — FastAPI Backend (Port 8000)
```bash
cd backend

# Windows
python -m venv venv
venv\Scripts\activate
uvicorn main:app --reload --port 8000

# macOS / Linux
python3 -m venv venv
source venv/bin/activate
uvicorn main:app --reload --port 8000
```

### Terminal 2 — Fastify AI Server (Port 4000)
```bash
cd ai_components
npm run dev -w apps/api
```

### Terminal 3 — Next.js Frontend (Port 3000)
```bash
cd frontend-final-final
npm run dev
```

---

## Step 7 — Open the App

Visit: **http://localhost:3000**

Default login credentials (seeded in shared database):
| Role | Email | Password |
|------|-------|----------|
| Org Admin | devasri@zeko.ai | orgpassword |
| Member | aditya@zeko.ai | memberpassword |
| Super Admin | admin@interviehire.com | adminpassword |

---

## Architecture Overview

```
localhost:3000  →  Next.js Frontend
localhost:8000  →  FastAPI Backend  (Python / SQLAlchemy)
localhost:4000  →  Fastify Server   (Node.js / Prisma)
                       ↓
         Supabase PostgreSQL (shared, hosted)
```

---

## Troubleshooting

| Error | Fix |
|-------|-----|
| `npx : scripts disabled` | Run `Set-ExecutionPolicy -Scope Process -ExecutionPolicy RemoteSigned` first |
| `Could not find Prisma Schema` | Run prisma generate from inside `ai_components/`, not `ai_components/apps/api/` |
| `Connection refused` on port 8000 | Make sure the FastAPI backend is running |
| `MODULE_NOT_FOUND` | Run `npm install` inside the respective folder |
| Database errors on startup | Verify `DATABASE_URL` in `.env` has the correct Supabase password |
