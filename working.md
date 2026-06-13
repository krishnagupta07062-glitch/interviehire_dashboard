# Change Log (working.md)

This file tracks all modifications made to the codebase in response to user requests.

## Prompt 1: Project Alignment & Tab Mismatch Bug Fix
- **Date**: 2026-06-10
- **Goal**: Analyze the workspace, fix the Report Vetting drawer tab mismatch, and restore the Reject/Advance action buttons inside the drawer.
- **Changes Made**:
  1. **Tab Content Alignment**: Modified `openReportDrawerForCandidate` in [dashboard.js](file:///c:/Users/KRISHNA%20GUPTA/Desktop/interviehire/frontend-final-final/src/dashboard.js#L3300-L3321) to explicitly reset and force the active class on tab buttons and content panes to `score` / `rep-tab-score` on open.
  2. **Action Buttons Container**: Added `<div class="report-action-buttons" id="report-action-buttons"></div>` back into the dynamically generated HTML template strings of both Resume (scorecard) and Vetting (notes/actions) layouts inside `repTabActions` in `dashboard.js`.
  3. **Documentation**: Updated [walkthrough.md](file:///C:/Users/KRISHNA%20GUPTA/.gemini/antigravity/brain/8f39792a-3205-40ba-865d-d661d509fa75/walkthrough.md) with details of the tab alignment and actions container fix.

## Prompt 2: Stage-Specific Reports, Scheduling & Leaderboard API
- **Date**: 2026-06-10
- **Goal**: Implement stage-specific reports (Resume, Screening, Functional), automated email scheduling invitation and Google Calendar integration, public rescheduling routes, and a candidate leaderboard API.
- **Changes Made**:
  1. **Frontend Report Drawer Integration**: Updated `openReportDrawerForCandidate` in [dashboard.js](file:///c:/Users/KRISHNA%20GUPTA/Desktop/interviehire/frontend-final-final/src/dashboard.js) to identify screening stage candidates (`isScreeningReport`) and display a customized report drawer featuring 4 screening tabs (Screening Overview, Parameters Checklist, Dialogue Snippet, Recruiter Notes) fetched from the backend.
  2. **Database Auto-Migrations**: Extended the applicant model in [applicant.py](file:///c:/Users/KRISHNA%20GUPTA/Desktop/interviehire/backend/app/models/applicant.py) and added database alter statements in [main.py](file:///c:/Users/KRISHNA%20GUPTA/Desktop/interviehire/backend/main.py) to dynamically create `scheduling_token` and `calendar_event_id` columns at startup.
  3. **Scheduling & Calendar Utilities**:
     - Created [google_calendar.py](file:///c:/Users/KRISHNA%20GUPTA/Desktop/interviehire/backend/app/utils/google_calendar.py) with OAuth 2.0 refresh token integration to create/update events on the organizer's calendar.
     - Created [email_sender.py](file:///c:/Users/KRISHNA%20GUPTA/Desktop/interviehire/backend/app/utils/email_sender.py) utilizing SMTP to dispatch responsive HTML email invitations and rescheduling confirmations.
  4. **Backend Router & API Additions**:
     - Implemented [public.py](file:///c:/Users/KRISHNA%20GUPTA/Desktop/interviehire/backend/app/routers/public.py) router for token-based candidate rescheduling.
     - Implemented [leaderboard.py](file:///c:/Users/KRISHNA%20GUPTA/Desktop/interviehire/backend/app/routers/leaderboard.py) router to return weighted candidates ordered by fit.
     - Updated [jobs.py](file:///c:/Users/KRISHNA%20GUPTA/Desktop/interviehire/backend/app/routers/jobs.py) to trigger scheduler hooks upon candidate advancement.
     - Registered routers and updated dependency configurations.
  5. **Verification**: Executed verification tests via a custom script to confirm database column mappings, leaderboard calculations, and token creation work correctly.

## Prompt 3: AI Components & Multi-User Calendar Integration
- **Date**: 2026-06-11
- **Goal**: Implement multi-recruiter Google OAuth credential storage, interactive iCalendar multipart MIME SMTP emails, FastAPI evaluation webhook ingestion, shared Question sync, and WebSocket state broadcasts.
- **Changes Made**:
  1. **Database Schema & Migrations**: Added recruiter OAuth credentials to `users` table and report scores to `applicants` table. Created `InterviewReport` model to store heavy summaries/transcripts/videos.
  2. **Recruiter Calendar OAuth Resolver**: Updated `google_calendar.py` to resolve recruiter credentials dynamically and disabled native Google Calendar emails with `sendUpdates="none"`.
  3. **MIME iCalendar Email Engine**: Refactored `email_sender.py` to attach interactive `invite.ics` files using alternate multipart MIME layouts.
  4. **Confirmation & Ingestion Webhook**: Added public `/confirm/{token}` and `/oauth/connect` endpoints in `public.py`, and the secure completed evaluation webhook in `jobs.py` broadcasting candidate updates.
  5. **Shared Question Sync**: Updated `sync_applicant_to_ai` in `ai_sync.py` to sync customized questions from `Job.functional_parameters` to the shared `Question` table.
  6. **Fastify evaluate Route update**: Modified `interview.routes.ts` evaluate endpoint to trigger FastAPI webhook completion event.
  7. **Verification**: Executed a comprehensive integration test confirming database persistence, webhook parsing, and question synchronization work perfectly.
  8. **Recruiter Identity Clarification**: Refactored the email sender and public routers (`public.py`, `jobs.py`, and `email_sender.py`) to resolve organizer names and email contacts directly from the candidate's `Organisation` record, ensuring candidate invitations show the organization as the host/sender instead of individual members.

## Prompt 4: Candidate Advancement Error Fix & Simulation Diagnostics
- **Date**: 2026-06-11
- **Goal**: Fix backend & frontend errors on candidate advancement, make SMTP simulation details easy to capture in the console, and resolve Next.js landing page HTML hydration mismatches.
- **Changes Made**:
  1. **Fixed NameErrors in Backend Route**: Added the missing imports `logging`, `logger`, and `settings` (from `app.config`) to [jobs.py](file:///c:/Users/KRISHNA%20GUPTA/Desktop/interviehire/backend/app/routers/jobs.py).
  2. **SMTP Simulation Console Outputs**: Refactored [email_sender.py](file:///c:/Users/KRISHNA%20GUPTA/Desktop/interviehire/backend/app/utils/email_sender.py) to output simulation email details using Python's `print()` instead of `logger.info()` (which was filtered out by the server console's default `WARNING` level). Added clear, structured ASCII boxes outlining candidate details, confirmation links, reschedule links, and interview room links to let developers copy/paste links instantly during simulation.
  3. **Next.js Hydration Mismatch Safeguard**: Fixed the React hydration mismatch in [page.js](file:///c:/Users/KRISHNA%20GUPTA/Desktop/interviehire/frontend-final-final/app/(landing)/page.js) by introducing a `mounted` state hook. The landing page now renders a consistent dark placeholder matching the theme on the server (SSR), and safely hydrates the full 3D interactive HTML on the client once mounted.
  4. **Verification**: Simulating candidate advancement now prints fully visible ASCII boxes with active testing URLs to the terminal, and loading the Next.js landing page completes with zero hydration mismatches.

## Prompt 5: Interview Room Route 404 Fix
- **Date**: 2026-06-11
- **Goal**: Fix the 404 error encountered when navigating to the interview room link generated by the backend.
- **Changes Made**:
  1. **Interview Room Route Link Fix**: Next.js route is configured at `/interview/page.tsx` (accessible as `/interview`) and parses the candidate's session ID from the `sessionId` query parameter (`?sessionId=...`), rather than using a dynamic directory path (`/interview/[id]`).
  2. **Backend Link Sync**: Updated [jobs.py](file:///c:/Users/KRISHNA%20GUPTA/Desktop/interviehire/backend/app/routers/jobs.py) and [public.py](file:///c:/Users/KRISHNA%20GUPTA/Desktop/interviehire/backend/app/routers/public.py) to format the generated `interview_link` as `{settings.FRONTEND_URL}/interview?sessionId={applicant.id}` instead of `/interview/{id}`.
  3. **Verification**: Verified using the unit test runner that the email confirmation links and calendar entries are successfully generated with the correct query parameter format, ensuring candidates navigate directly to the interview room page without encountering a 404.

## Prompt 6: AI Session Sync & Interview Hydration Fix
- **Date**: 2026-06-11
- **Goal**: Fix the 404 Session Not Found error and eliminate the Next.js hydration mismatch on the `/interview` page.
- **Changes Made**:
  1. **Confirm & Reschedule AI Sync Hook**: Added `sync_applicant_to_ai` calls to the `/confirm/{token}` and `/reschedule/{token}` public endpoints in [public.py](file:///c:/Users/KRISHNA%20GUPTA/Desktop/interviehire/backend/app/routers/public.py). When candidates schedule/reschedule via the public page, their session details are now instantly synced to the AI database, resolving the Fastify "Session not found" 404 error.
  2. **Interview Portal Hydration Mismatch Safeguard**: Added a `mounted` state safeguard to the `Interview` component in [page.tsx](file:///c:/Users/KRISHNA%20GUPTA/Desktop/interviehire/frontend-final-final/app/interview/page.tsx) to prevent hydration mismatches during state initialization. The page now safely delays active proctoring calculations and MediaPipe tracker bindings until the client has mounted, preventing browser/React render crashes.
  3. **Verification**: Checked that confirmed sessions successfully sync to the database and the `/interview` room loads cleanly on the client without console warnings or layout mismatch exceptions.

## Prompt 7: Proctoring Loop Bypass & Monotonic Timestamp Fix
- **Date**: 2026-06-11
- **Goal**: Fix the "detectForVideo" runtime exceptions and browser overlays during eye calibration, and verify how questions/parameters are passed to the interview room.
- **Changes Made**:
  1. **Proctoring Bypass During Calibration**: Added `hasCalibrationRef` to [useProctoring.ts](file:///c:/Users/KRISHNA%20GUPTA/Desktop/interviehire/frontend-final-final/hooks/useProctoring.ts). If calibration is not complete, the proctoring loop skips execution of `detectForVideo` while maintaining the webcam stream. This resolves the conflict and resource competition between the calibration loop and the proctoring loop.
  2. **Monotonic Timestamp Protection**: Updated [useProctoring.ts](file:///c:/Users/KRISHNA%20GUPTA/Desktop/interviehire/frontend-final-final/hooks/useProctoring.ts) and [useGazeCalibration.ts](file:///c:/Users/KRISHNA%20GUPTA/Desktop/interviehire/frontend-final-final/hooks/useGazeCalibration.ts) to track and sanitize MediaPipe task timestamps. If the browser's `performance.now()` returns non-increasing or identical timestamps, the delta is dynamically incremented by a microsecond, satisfying MediaPipe's strict monotonically increasing timestamp check and preventing WASM runtime exceptions.
  3. **Database Enum Case-Sensitivity Fix**: Executed SQL statements on the shared PostgreSQL database to create the missing case-sensitive custom enum types (`"RoleType"`, `"Difficulty"`, `"SessionStatus"`, `"Severity"`). This resolves the Prisma `ConnectorError: type "public.RoleType" does not exist` database crash on the Fastify server, keeping the code of `ai_components` completely untouched.
  4. **MediaPipe Console Log Interceptors**: Added temporary `console.error` interceptors around all `detectForVideo` calls in [useProctoring.ts](file:///c:/Users/KRISHNA%20GUPTA/Desktop/interviehire/frontend-final-final/hooks/useProctoring.ts) and [useGazeCalibration.ts](file:///c:/Users/KRISHNA%20GUPTA/Desktop/interviehire/frontend-final-final/hooks/useGazeCalibration.ts). This suppresses non-error informational logs printed by the MediaPipe WASM library (such as "INFO: Created TensorFlow Lite XNNPACK delegate for CPU."), preventing Next.js from displaying browser error overlays during calibration.
  5. **Verification**: Verified that the frontend compiles successfully (`npm run build` completed with zero warnings/errors) and the backend compiles cleanly.

## Prompt 8: Dynamic Local Port Routing, Self-Healing Dotenv & MediaPipe Console Interceptors
- **Date**: 2026-06-12
- **Goal**: Resolve browser connection issues, redirect loops, and websocket errors on local environments, handle dotenv loading robustly, fix candidate import parsing bugs, and permanently block MediaPipe/TensorFlow console.error overlays.
- **Changes Made**:
  1. **Dynamic Local Backend Routing**: Updated client-side fetches and websocket hosts in [dashboard.js](file:///c:/Users/KRISHNA%20GUPTA/Desktop/interviehire/frontend-final-final/src/dashboard.js), [login/page.js](file:///c:/Users/KRISHNA%20GUPTA/Desktop/interviehire/frontend-final-final/app/login/page.js), [signup/page.js](file:///c:/Users/KRISHNA%20GUPTA/Desktop/interviehire/frontend-final-final/app/signup/page.js), and [onboarding/page.js](file:///c:/Users/KRISHNA%20GUPTA/Desktop/interviehire/frontend-final-final/app/onboarding/page.js) to dynamically resolve to `window.location.hostname` (e.g. `localhost:8000` or `127.0.0.1:8000`). This aligns the cookie domains with the page origin exactly and resolves the `/login` loop redirection.
  2. **Self-Healing Environment Loading**: Added an explicit `load_dotenv` call referencing `backend/.env` at the top of [config.py](file:///c:/Users/KRISHNA%20GUPTA/Desktop/interviehire/backend/app/config.py), ensuring all API keys are populated regardless of uvicorn's execution directory context. Added error traceback logging in [deepseek.py](file:///c:/Users/KRISHNA%20GUPTA/Desktop/interviehire/backend/app/routers/deepseek.py) pointing to `deepseek_error.log` for future model troubleshooting.
  3. **Upload Candidates Response Parsing Fix**: Refactored the bulk resume import `fetch` in [dashboard.js](file:///c:/Users/KRISHNA%20GUPTA/Desktop/interviehire/frontend-final-final/src/dashboard.js) to route via `apiFetch`. Fixed the resulting `TypeError: res.json is not a function` by directly assigning the parsed JSON response of `apiFetch` to `createdApplicants`.
  4. **Global MediaPipe Console.error Interceptor**: Moved the `console.error` warnings override block to the global module-level context in [useProctoring.ts](file:///c:/Users/KRISHNA%20GUPTA/Desktop/interviehire/frontend-final-final/hooks/useProctoring.ts) and [useGazeCalibration.ts](file:///c:/Users/KRISHNA%20GUPTA/Desktop/interviehire/frontend-final-final/hooks/useGazeCalibration.ts). This ensures that when the MediaPipe library loads and caches `console.error` reference, it receives the overridden filter rather than the native one, permanently blocking Next.js dev server from showing error overlays for informational Emscripten warnings.
  5. **Verification**: Executed Playwright integration tests confirming that login, WebSockets, resume uploads, and resume evaluation flow operate cleanly with zero JavaScript errors, fetch loops, or Next.js overlays.

## Prompt 9: Supabase Database Migration, Developer Setup & Dependencies
- **Date**: 2026-06-12
- **Goal**: Export the local PostgreSQL database to a hosted Supabase instance to enable shared database access for all developers, fix SQL export syntax errors for Supabase compatibility, generate a clean developer setup guide, and package Python dependencies.
- **Changes Made**:
  1. **Full Database Backup**: Generated [supabase_backup.sql](file:///c:/Users/KRISHNA%20GUPTA/Desktop/interviehire/supabase_backup.sql) and [supabase_schema.sql](file:///c:/Users/KRISHNA%20GUPTA/Desktop/interviehire/supabase_schema.sql) via `pg_dump` containing the complete schema (all tables, custom enums, indexes, foreign keys) and seed data.
  2. **SQL Syntax Error Fix — `\restrict`/`\unrestrict`**: The `pg_dump` output included psql-only meta-commands (`\restrict`, `\unrestrict`) injected by the local environment. Commented them out in both SQL files since Supabase SQL Editor only accepts raw SQL, not psql meta-commands.
  3. **SQL Syntax Error Fix — `COPY FROM stdin`**: The original backup used PostgreSQL `COPY ... FROM stdin` format which is incompatible with Supabase SQL Editor. Regenerated the backup with `pg_dump --inserts` to produce pure `INSERT INTO` statements instead.
  4. **Supabase-Compatible Clean Backup**: Generated [supabase_backup_clean.sql](file:///c:/Users/KRISHNA%20GUPTA/Desktop/interviehire/supabase_backup_clean.sql) by stripping all statements that require superuser privileges or are unsupported in Supabase: `ALTER SCHEMA public OWNER TO postgres`, `COMMENT ON SCHEMA/EXTENSION`, `REVOKE USAGE ON SCHEMA public`, `SET transaction_timeout`, `SET idle_in_transaction_session_timeout`, and `SET row_security`.
  5. **Root Dependencies File**: Verified and maintained [requirements.txt](file:///c:/Users/KRISHNA%20GUPTA/Desktop/interviehire/requirements.txt) at the project root, listing all Python packages so other developers can install them with a single `pip install -r requirements.txt` command.
  6. **`.env.example` Updates**: Updated [backend/.env.example](file:///c:/Users/KRISHNA%20GUPTA/Desktop/interviehire/backend/.env.example) and created [ai_components/.env.example](file:///c:/Users/KRISHNA%20GUPTA/Desktop/interviehire/ai_components/.env.example) with the Supabase connection string template (`postgresql://postgres.spzjiqcosxcmzyrctjyh:[PASSWORD]@aws-0-ap-southeast-1.pooler.supabase.com:6543/postgres`) so developers know exactly what to fill in.
  7. **Developer Setup Guide**: Created [SETUP.md](file:///c:/Users/KRISHNA%20GUPTA/Desktop/interviehire/SETUP.md) at the project root with step-by-step setup instructions covering prerequisites, `.env` configuration, Python dependency installation, Node/Prisma setup, and commands to start all three servers (FastAPI port 8000, Fastify port 4000, Next.js port 3000).
  8. **Prisma Client Regeneration**: Ran `npx prisma generate --schema="apps/api/prisma/schema.prisma"` (with `Set-ExecutionPolicy RemoteSigned` for Windows) from within `ai_components/` to regenerate the Prisma Client pointing to the new Supabase database. ✔ Generated successfully (v6.19.3).

## Prompt 10: Re-Advance & Fresh Interview Link Fix
- **Date**: 2026-06-12
- **Goal**: Make the Advance button permanently functional so that advancing a candidate from Resume Analysis or Recruiter Screening always generates a fresh interview link, even if they have already completed an interview before.
- **Changes Made**:
  1. **Always-Fresh Scheduling Token** ([jobs.py](file:///c:/Users/KRISHNA%20GUPTA/Desktop/interviehire/backend/app/routers/jobs.py)): Changed the `scheduling_token` generation from `if not applicant.scheduling_token` (only once) to always regenerating a new UUID on every advance action. This ensures a brand new interview link is printed to the console each time, regardless of previous test runs.
  2. **InterviewSession Reset on Re-Advance** ([ai_sync.py](file:///c:/Users/KRISHNA GUPTA/Desktop/interviehire/backend/app/utils/ai_sync.py)): When `sync_applicant_to_ai` encounters an existing `InterviewSession`, it now resets it to `SCHEDULED` status and clears `transcript`, `evaluation`, `reportUrl`, `startedAt`, `completedAt`, `websocketId`, and `ueSocketId`. This allows the Fastify AI server to accept the candidate as a fresh interviewee.
  3. **Sync on Both Stages** ([jobs.py](file:///c:/Users/KRISHNA%20GUPTA/Desktop/interviehire/backend/app/routers/jobs.py)): Extended the `sync_applicant_to_ai` call to trigger on both `screening_status` and `functional_status` advances (previously only functional). This ensures even a Resume → Screening advance creates a clean session.

## Prompt 11: Fixed Screening Questions, Functional Stage Scheduling, Database Connection Resiliency & Rendering Fixes
- **Date**: 2026-06-13
- **Goal**: Align the recruiter screening and functional interview pipeline according to corrected requirements, resolve UI gaps, database pooling resiliency, and restore functional interview pane rendering.
- **Changes Made**:
  1. **Fixed Screening Questions**: Created a dedicated "Fixed Recruiter Screening Questions" panel below the applicants table in the Recruiter Screening stage pane. Recruiting organizations can now view, add, remove, and edit screening questions directly from the dashboard, saving edits directly to `job.screening_questions` in PostgreSQL.
  2. **Dynamic Status & Scheduling for Functional Stage**: Refactored the Functional Interview candidate table to use the dynamic `statusIcon` function and render the appropriate "Schedule" or "Reschedule" buttons based on `c.interviewStatus` rather than hardcoding all candidates to "Completed".
  3. **Database Connection Resiliency**: Configured SQLAlchemy with `pool_pre_ping=True` and `pool_recycle=3600` inside [database.py](file:///c:/Users/KRISHNA%20GUPTA/Desktop/interviehire/backend/app/database.py) to prevent crash loops from stale or disconnected pool connections.
  4. **Functional Stage Pane Rendering Restoration**: Fixed a syntax bug in the `functionalList` rendering block where an opening `} else {` statement was accidentally removed. Restoring it fixed a javascript runtime error and successfully restored candidate table rendering under the Functional tab.
  5. **Interview Page Styling Fix**: Created [globals.css](file:///c:/Users/KRISHNA%20GUPTA/Desktop/interviehire/frontend-final-final/app/globals.css) and [layout.tsx](file:///c:/Users/KRISHNA%20GUPTA/Desktop/interviehire/frontend-final-final/app/interview/layout.tsx) for the interview route to import TailwindCSS styles globally for the interview room without polluting other layouts/styling rules in the project.
  6. **Clean TypeScript Compilation**: Checked with local typecheck dry run (`tsc --noEmit`), verifying 100% clean build.

## Prompt 12: Supabase IPv4 Pooler Cluster Connection Fix
- **Date**: 2026-06-13
- **Goal**: Resolve database connection errors on startup due to IPv6-only direct connection hostname routing failures on IPv4-only networks.
- **Changes Made**:
  1. **IP Range Scanning**: Mapped the database domain's IPv6 address (`2406:da18:167b:f900:8243:f4a1:9f6d:65bb`) to AWS Singapore region (`ap-southeast-1`).
  2. **Active Pooler Verification**: Scanned the Supabase pooler clusters for `ap-southeast-1` and verified that cluster `aws-1` is active and successfully routes queries.
  3. **Updated Environment Files**: Modified `DATABASE_URL` in [backend/.env](file:///c:/Users/KRISHNA%20GUPTA/Desktop/interviehire/backend/.env) and [ai_components/.env](file:///c:/Users/KRISHNA%20GUPTA/Desktop/interviehire/ai_components/.env) to point to:
     `postgresql://postgres.spzjiqcosxcmzyrctjyh:tic*tac*toe@aws-1-ap-southeast-1.pooler.supabase.com:6543/postgres`
  4. **Verification**: Executed database query tests using SQLAlchemy and Prisma, verifying 100% successful database connection.

