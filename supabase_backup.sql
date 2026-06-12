--
-- PostgreSQL database dump
--

-- \restrict ngy2d4UswWZOi8A4hQGRzgb2qBrUBsYm1Gp1fPxNvhOaA8bCwJfRUgZgAPKgxNa

-- Dumped from database version 18.4
-- Dumped by pg_dump version 18.4

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

-- *not* creating schema, since initdb creates it


ALTER SCHEMA public OWNER TO postgres;

--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA public IS '';


--
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


--
-- Name: Difficulty; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."Difficulty" AS ENUM (
    'EASY',
    'MEDIUM',
    'HARD'
);


ALTER TYPE public."Difficulty" OWNER TO postgres;

--
-- Name: RoleType; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."RoleType" AS ENUM (
    'CONSULTING',
    'PRODUCT_MANAGEMENT',
    'BUSINESS_ANALYST',
    'FOUNDERS_OFFICE',
    'GENERAL'
);


ALTER TYPE public."RoleType" OWNER TO postgres;

--
-- Name: SessionStatus; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."SessionStatus" AS ENUM (
    'SCHEDULED',
    'IN_PROGRESS',
    'COMPLETED',
    'EVALUATED',
    'CANCELLED'
);


ALTER TYPE public."SessionStatus" OWNER TO postgres;

--
-- Name: Severity; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."Severity" AS ENUM (
    'LOW',
    'MEDIUM',
    'HIGH',
    'CRITICAL'
);


ALTER TYPE public."Severity" OWNER TO postgres;

--
-- Name: applicant_source; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.applicant_source AS ENUM (
    'career_page',
    'bulk_upload',
    'direct_link',
    'scheduled',
    'ats'
);


ALTER TYPE public.applicant_source OWNER TO postgres;

--
-- Name: applicantsource; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.applicantsource AS ENUM (
    'career_page',
    'bulk_upload',
    'direct_link',
    'scheduled',
    'ats'
);


ALTER TYPE public.applicantsource OWNER TO postgres;

--
-- Name: cheat_probability; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.cheat_probability AS ENUM (
    'low',
    'medium',
    'high'
);


ALTER TYPE public.cheat_probability OWNER TO postgres;

--
-- Name: cheatprobability; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.cheatprobability AS ENUM (
    'low',
    'medium',
    'high'
);


ALTER TYPE public.cheatprobability OWNER TO postgres;

--
-- Name: difficulty; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.difficulty AS ENUM (
    'EASY',
    'MEDIUM',
    'HARD'
);


ALTER TYPE public.difficulty OWNER TO postgres;

--
-- Name: interview_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.interview_status AS ENUM (
    'pending',
    'scheduled',
    'completed',
    'slot_missed',
    'incomplete'
);


ALTER TYPE public.interview_status OWNER TO postgres;

--
-- Name: interviewstatus; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.interviewstatus AS ENUM (
    'pending',
    'scheduled',
    'completed',
    'slot_missed',
    'incomplete'
);


ALTER TYPE public.interviewstatus OWNER TO postgres;

--
-- Name: job_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.job_status AS ENUM (
    'published',
    'draft',
    'archived'
);


ALTER TYPE public.job_status OWNER TO postgres;

--
-- Name: jobstatus; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.jobstatus AS ENUM (
    'published',
    'draft',
    'archived'
);


ALTER TYPE public.jobstatus OWNER TO postgres;

--
-- Name: roletype; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.roletype AS ENUM (
    'CONSULTING',
    'PRODUCT_MANAGEMENT',
    'BUSINESS_ANALYST',
    'FOUNDERS_OFFICE',
    'GENERAL'
);


ALTER TYPE public.roletype OWNER TO postgres;

--
-- Name: sessionstatus; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.sessionstatus AS ENUM (
    'SCHEDULED',
    'IN_PROGRESS',
    'COMPLETED',
    'EVALUATED',
    'CANCELLED'
);


ALTER TYPE public.sessionstatus OWNER TO postgres;

--
-- Name: severity; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.severity AS ENUM (
    'LOW',
    'MEDIUM',
    'HIGH',
    'CRITICAL'
);


ALTER TYPE public.severity OWNER TO postgres;

--
-- Name: user_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.user_status AS ENUM (
    'active',
    'invited',
    'inactive'
);


ALTER TYPE public.user_status OWNER TO postgres;

--
-- Name: user_type; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.user_type AS ENUM (
    'org_admin',
    'member'
);


ALTER TYPE public.user_type OWNER TO postgres;

--
-- Name: userstatus; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.userstatus AS ENUM (
    'active',
    'invited',
    'inactive'
);


ALTER TYPE public.userstatus OWNER TO postgres;

--
-- Name: usertype; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.usertype AS ENUM (
    'org_admin',
    'member',
    'super_admin'
);


ALTER TYPE public.usertype OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: Candidate; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Candidate" (
    id character varying NOT NULL,
    "companyId" character varying NOT NULL,
    "fullName" character varying NOT NULL,
    email character varying NOT NULL,
    phone character varying,
    "resumeText" text,
    "parsedResume" jsonb NOT NULL,
    "atsScore" double precision NOT NULL,
    "atsBreakdown" jsonb NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public."Candidate" OWNER TO postgres;

--
-- Name: Company; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Company" (
    id character varying NOT NULL,
    name character varying NOT NULL,
    slug character varying NOT NULL,
    description text,
    "logoUrl" character varying,
    "primaryColor" character varying NOT NULL,
    settings jsonb NOT NULL,
    webhooks jsonb NOT NULL,
    "reportEmail" character varying,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public."Company" OWNER TO postgres;

--
-- Name: InterviewSession; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."InterviewSession" (
    id character varying NOT NULL,
    "companyId" character varying NOT NULL,
    "candidateId" character varying NOT NULL,
    "jobRoleId" character varying NOT NULL,
    status public."SessionStatus" NOT NULL,
    "websocketId" character varying,
    "ueSocketId" character varying,
    "startedAt" timestamp with time zone,
    "completedAt" timestamp with time zone,
    "scheduledAt" timestamp with time zone,
    transcript jsonb NOT NULL,
    "avatarProvider" character varying NOT NULL,
    evaluation jsonb,
    "reportUrl" character varying,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public."InterviewSession" OWNER TO postgres;

--
-- Name: JobRole; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."JobRole" (
    id character varying NOT NULL,
    "companyId" character varying NOT NULL,
    title character varying NOT NULL,
    "roleType" public."RoleType" NOT NULL,
    description text NOT NULL,
    requirements text NOT NULL,
    "primaryCriteria" character varying[] NOT NULL,
    "secondaryCriteria" character varying[] NOT NULL,
    "atsScoringWeights" jsonb NOT NULL,
    "evaluationCriteria" jsonb NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public."JobRole" OWNER TO postgres;

--
-- Name: ProctoringLog; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."ProctoringLog" (
    id character varying NOT NULL,
    "sessionId" character varying NOT NULL,
    "eventType" character varying NOT NULL,
    severity public."Severity" NOT NULL,
    metadata jsonb NOT NULL,
    "occurredAt" timestamp with time zone DEFAULT now() NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public."ProctoringLog" OWNER TO postgres;

--
-- Name: Question; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Question" (
    id character varying NOT NULL,
    "companyId" character varying NOT NULL,
    "jobRoleId" character varying,
    text text NOT NULL,
    "roleApplicability" public."RoleType"[] NOT NULL,
    difficulty public."Difficulty" NOT NULL,
    "topicCategories" character varying[] NOT NULL,
    "estimatedMinutes" integer NOT NULL,
    "aiEvaluationGuidance" text NOT NULL,
    "effectivenessRating" double precision NOT NULL,
    version integer NOT NULL,
    "isActive" boolean NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public."Question" OWNER TO postgres;

--
-- Name: applicants; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.applicants (
    id uuid NOT NULL,
    name character varying NOT NULL,
    email character varying NOT NULL,
    phone character varying,
    source public.applicantsource,
    resume_url character varying,
    remarks text,
    job_id uuid NOT NULL,
    resume_analysed boolean,
    resume_shortlisted boolean,
    resume_waitlisted boolean,
    screening_status public.interviewstatus,
    screening_score double precision,
    screening_scheduled_at timestamp with time zone,
    functional_status public.interviewstatus,
    functional_score double precision,
    functional_scheduled_at timestamp with time zone,
    cheat_probability public.cheatprobability,
    report_url character varying,
    match_score double precision,
    resume_analysis_result json,
    screening_report json,
    functional_report json,
    created_at timestamp with time zone DEFAULT now(),
    recruiter_screening character varying,
    recruiter_screening_score double precision,
    attempted_at timestamp without time zone,
    resume_analysis_report text,
    scheduling_token character varying,
    calendar_event_id character varying,
    overall_interview_score double precision,
    proctoring_severity_flag character varying,
    calendar_sequence integer DEFAULT 0
);


ALTER TABLE public.applicants OWNER TO postgres;

--
-- Name: interview_reports; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.interview_reports (
    id uuid NOT NULL,
    applicant_id uuid NOT NULL,
    summary text,
    transcript text,
    video_url character varying,
    detailed_scores jsonb,
    created_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.interview_reports OWNER TO postgres;

--
-- Name: job_collaborators; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.job_collaborators (
    id uuid NOT NULL,
    job_id uuid NOT NULL,
    user_id uuid NOT NULL,
    added_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.job_collaborators OWNER TO postgres;

--
-- Name: jobs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.jobs (
    id uuid NOT NULL,
    custom_job_id character varying,
    title character varying NOT NULL,
    role_name character varying NOT NULL,
    status public.jobstatus,
    experience_band character varying,
    tags character varying,
    description text,
    location character varying,
    job_type character varying,
    is_job_listed boolean,
    resume_parameters text,
    screening_parameters text,
    functional_parameters text,
    questions text,
    resume_analysis_enabled boolean,
    recruiter_screening_enabled boolean,
    functional_interview_enabled boolean,
    created_by_id uuid,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone,
    organisation_id uuid
);


ALTER TABLE public.jobs OWNER TO postgres;

--
-- Name: organisations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.organisations (
    id uuid NOT NULL,
    org_name character varying NOT NULL,
    domain character varying,
    contact_email character varying,
    website_link character varying,
    location character varying,
    logo_url character varying,
    description text,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone
);


ALTER TABLE public.organisations OWNER TO postgres;

--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id uuid NOT NULL,
    name character varying NOT NULL,
    email character varying NOT NULL,
    designation character varying,
    user_type public.usertype,
    status public.userstatus,
    hashed_password character varying,
    registered_on timestamp with time zone DEFAULT now(),
    created_at timestamp with time zone DEFAULT now(),
    organisation_id uuid,
    google_refresh_token character varying,
    google_client_id character varying,
    google_client_secret character varying
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Data for Name: Candidate; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Candidate" VALUES ('1553de9e-a6ca-406e-a7f2-04221add377b', 'cbc684c2-63f6-4a66-ab4e-4f795fbe97a3', 'David Vance', 'david.vance.mktg@email.com', '+1 (555) 345-6789', '', '{}', 0, '{}', '2026-06-09 19:22:14.075667+05:30', '2026-06-09 19:22:14.075667+05:30');
INSERT INTO public."Candidate" VALUES ('1909adf6-507f-45a0-9268-72e5990938d0', 'cbc684c2-63f6-4a66-ab4e-4f795fbe97a3', 'Alex Mercer', 'alex.mercer@email.com', '+1 (555) 019-2834', '', '{}', 0, '{}', '2026-06-09 19:56:36.909795+05:30', '2026-06-09 19:56:36.909795+05:30');
INSERT INTO public."Candidate" VALUES ('202c2b46-ee23-4e75-9e67-f0e8a0ad4e96', 'cbc684c2-63f6-4a66-ab4e-4f795fbe97a3', 'Graduation May June', 'alex.mercer@email.com', '+1 (555) 019-2834', '', '{}', 0, '{}', '2026-06-09 22:07:01.008143+05:30', '2026-06-09 22:07:01.008143+05:30');
INSERT INTO public."Candidate" VALUES ('8cd1054d-4f6f-4e5c-9167-a83adc3992d3', 'cbc684c2-63f6-4a66-ab4e-4f795fbe97a3', 'Alex Mercer', 'alex.mercer@email.com', '+1 (555) 019-2834', '', '{}', 0, '{}', '2026-06-10 01:19:34.639246+05:30', '2026-06-10 01:19:34.639246+05:30');
INSERT INTO public."Candidate" VALUES ('1a9c6e86-69b3-452b-91ae-8fce963fcfb9', 'cbc684c2-63f6-4a66-ab4e-4f795fbe97a3', 'Alice Smith', 'alice@example.com', NULL, '', '{}', 0, '{}', '2026-06-11 12:45:06.904134+05:30', '2026-06-11 12:45:06.904134+05:30');
INSERT INTO public."Candidate" VALUES ('c4320a9c-bde7-46c1-bfab-57fd2bbda2df', 'cbc684c2-63f6-4a66-ab4e-4f795fbe97a3', 'Alice Smith', 'alice@example.com', NULL, '', '{}', 0, '{}', '2026-06-11 13:05:45.453269+05:30', '2026-06-11 13:05:45.453269+05:30');
INSERT INTO public."Candidate" VALUES ('73a9b85f-7526-4361-b5b8-6b6fec11a33c', 'cbc684c2-63f6-4a66-ab4e-4f795fbe97a3', 'Alice Smith', 'alice@example.com', NULL, '', '{}', 0, '{}', '2026-06-11 15:39:15.604095+05:30', '2026-06-11 15:39:15.604095+05:30');
INSERT INTO public."Candidate" VALUES ('e3e431a2-c53a-4bed-83dc-fe403c3bb35c', 'cbc684c2-63f6-4a66-ab4e-4f795fbe97a3', 'Alice Smith', 'alice@example.com', NULL, '', '{}', 0, '{}', '2026-06-11 16:47:10.435499+05:30', '2026-06-11 16:47:10.435499+05:30');
INSERT INTO public."Candidate" VALUES ('cmqakehms000cl7z0ona8lowj', 'cmq6p9edn0000l72wl889b8bq', 'Aarav Sharma', 'aarav@example.com', NULL, NULL, '{"skills": ["analytics", "presentation", "client communication", "problem-solving"], "yearsOfExperience": 2}', 82, '{"demo": true}', '2026-06-12 12:18:00.964+05:30', '2026-06-12 12:18:00.964+05:30');
INSERT INTO public."Candidate" VALUES ('c449fc1a-1642-42ef-abad-4852f787fea0', 'cbc684c2-63f6-4a66-ab4e-4f795fbe97a3', 'Marcus Thorne', 'marcus.thorne.pm@email.com', '+1 (555) 567-8901', '', '{}', 0, '{}', '2026-06-12 12:38:49.269+05:30', '2026-06-12 12:38:49.269+05:30');
INSERT INTO public."Candidate" VALUES ('f4f9aa8d-a33b-43dd-bf3f-5096589d05d1', 'cbc684c2-63f6-4a66-ab4e-4f795fbe97a3', 'Marcus Thorne', 'marcus.thorne.pm@email.com', '+1 (555) 567-8901', '', '{}', 0, '{}', '2026-06-12 12:44:11.571+05:30', '2026-06-12 12:44:11.571+05:30');
INSERT INTO public."Candidate" VALUES ('23da61af-62cc-4868-a02a-1333999b7a46', 'cbc684c2-63f6-4a66-ab4e-4f795fbe97a3', 'Elena Rostova', 'elena.rostova.hr@email.com', '+1 (555) 456-7890', '', '{}', 0, '{}', '2026-06-12 15:11:59.187+05:30', '2026-06-12 15:11:59.187+05:30');
INSERT INTO public."Candidate" VALUES ('a6c33c19-ea17-4d3e-85da-b4b8c7f1f63a', 'cbc684c2-63f6-4a66-ab4e-4f795fbe97a3', 'Rowan Baker', 'rowanbaker200017@example.com', '+1-555-1649', '', '{}', 0, '{}', '2026-06-12 15:18:09.927298+05:30', '2026-06-12 15:18:09.927298+05:30');


--
-- Data for Name: Company; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Company" VALUES ('cmq6p9edn0000l72wl889b8bq', 'IntervieHire Demo Engineering', 'demo-junior-sde', 'A demo engineering team hiring junior software development engineers.', NULL, '#0e7490', '{}', '{}', 'hr@example.com', '2026-06-09 19:22:56.803+05:30', '2026-06-12 15:18:42.26+05:30');
INSERT INTO public."Company" VALUES ('cbc684c2-63f6-4a66-ab4e-4f795fbe97a3', 'devasri-tech', 'devasri-tech.zeko.ai', 'Build the future of technology with us.', NULL, '#0f766e', '{}', '{}', 'devasri@zeko.ai', '2026-06-09 19:22:14.053662+05:30', '2026-06-12 15:11:59.172+05:30');


--
-- Data for Name: InterviewSession; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."InterviewSession" VALUES ('1553de9e-a6ca-406e-a7f2-04221add377b', 'cbc684c2-63f6-4a66-ab4e-4f795fbe97a3', '1553de9e-a6ca-406e-a7f2-04221add377b', '08ed817a-5e98-4083-a056-61ce569b48b5', 'SCHEDULED', NULL, NULL, NULL, NULL, NULL, '[]', 'ue5_pixel_streaming', NULL, NULL, '2026-06-09 19:22:14.082888+05:30', '2026-06-09 19:22:14.082888+05:30');
INSERT INTO public."InterviewSession" VALUES ('1909adf6-507f-45a0-9268-72e5990938d0', 'cbc684c2-63f6-4a66-ab4e-4f795fbe97a3', '1909adf6-507f-45a0-9268-72e5990938d0', '08ed817a-5e98-4083-a056-61ce569b48b5', 'SCHEDULED', NULL, NULL, NULL, NULL, NULL, '[]', 'ue5_pixel_streaming', NULL, NULL, '2026-06-09 19:56:36.927426+05:30', '2026-06-09 19:56:36.927426+05:30');
INSERT INTO public."InterviewSession" VALUES ('202c2b46-ee23-4e75-9e67-f0e8a0ad4e96', 'cbc684c2-63f6-4a66-ab4e-4f795fbe97a3', '202c2b46-ee23-4e75-9e67-f0e8a0ad4e96', '1f0cf586-72d3-4637-bd26-ec6dbd63a90f', 'SCHEDULED', NULL, NULL, NULL, NULL, NULL, '[]', 'ue5_pixel_streaming', NULL, NULL, '2026-06-09 22:07:01.037176+05:30', '2026-06-09 22:07:01.037176+05:30');
INSERT INTO public."InterviewSession" VALUES ('8cd1054d-4f6f-4e5c-9167-a83adc3992d3', 'cbc684c2-63f6-4a66-ab4e-4f795fbe97a3', '8cd1054d-4f6f-4e5c-9167-a83adc3992d3', 'd45bf0f9-8eea-4652-b7cc-f6d02848483c', 'SCHEDULED', NULL, NULL, NULL, NULL, NULL, '[]', 'ue5_pixel_streaming', NULL, NULL, '2026-06-10 01:19:34.650873+05:30', '2026-06-10 01:19:34.650873+05:30');
INSERT INTO public."InterviewSession" VALUES ('cmqakehn0000el7z0b641nyp5', 'cmq6p9edn0000l72wl889b8bq', 'cmqakehms000cl7z0ona8lowj', 'cmqakehlq0002l7z0igkdjf8y', 'SCHEDULED', NULL, NULL, NULL, NULL, '2026-06-12 12:18:00.971+05:30', '[]', 'ue5_pixel_streaming', NULL, NULL, '2026-06-12 12:18:00.972+05:30', '2026-06-12 12:18:00.972+05:30');
INSERT INTO public."InterviewSession" VALUES ('c449fc1a-1642-42ef-abad-4852f787fea0', 'cbc684c2-63f6-4a66-ab4e-4f795fbe97a3', 'c449fc1a-1642-42ef-abad-4852f787fea0', 'b52cd6ff-98b2-4d94-8dd1-f9ed36f7d656', 'SCHEDULED', NULL, NULL, NULL, NULL, NULL, '[]', 'ue5_pixel_streaming', NULL, NULL, '2026-06-12 12:38:49.272+05:30', '2026-06-12 12:38:49.272+05:30');
INSERT INTO public."InterviewSession" VALUES ('f4f9aa8d-a33b-43dd-bf3f-5096589d05d1', 'cbc684c2-63f6-4a66-ab4e-4f795fbe97a3', 'f4f9aa8d-a33b-43dd-bf3f-5096589d05d1', '06cdc83e-33fa-4c3e-a915-42108dd18b65', 'EVALUATED', NULL, NULL, '2026-06-12 12:45:26.815+05:30', '2026-06-12 12:47:43.814+05:30', NULL, '[{"text": "Describe a time you handled a difficult customer call. How did you resolve the issue?", "speaker": "ai", "timestamp": "2026-06-12T07:15:26.815Z", "questionIndex": 0}, {"text": "i dont remember", "metrics": {"wpm": 10, "words": 3, "latencyMs": 18230}, "speaker": "candidate", "timestamp": "2026-06-12T07:15:45.063Z", "questionIndex": 0}, {"text": "How do you prioritize and manage technical support tickets when multiple come in at once?", "speaker": "ai", "timestamp": "2026-06-12T07:15:45.063Z", "questionIndex": 1}, {"text": "i dont manage", "metrics": {"wpm": 25, "words": 3, "latencyMs": 7117}, "speaker": "candidate", "timestamp": "2026-06-12T07:15:52.197Z", "questionIndex": 1}, {"text": "Walk me through how you would troubleshoot a customer unable to log into a SaaS platform.", "speaker": "ai", "timestamp": "2026-06-12T07:15:52.197Z", "questionIndex": 2}, {"text": "troubleshoot?", "metrics": {"wpm": 7, "words": 1, "latencyMs": 8114}, "speaker": "candidate", "timestamp": "2026-06-12T07:16:00.344Z", "questionIndex": 2}, {"text": "What steps would you take to learn a new software product quickly to support customers?", "speaker": "ai", "timestamp": "2026-06-12T07:16:00.344Z", "questionIndex": 3}, {"text": "ai", "metrics": {"wpm": 5, "words": 1, "latencyMs": 11671}, "speaker": "candidate", "timestamp": "2026-06-12T07:16:12.051Z", "questionIndex": 3}, {"text": "Thanks. That completes the structured interview. You can click Complete session when you are ready to see the report.", "speaker": "ai", "timestamp": "2026-06-12T07:16:12.051Z", "questionIndex": null}, {"text": "thanks", "metrics": {"wpm": 9, "words": 1, "latencyMs": 6901}, "speaker": "candidate", "timestamp": "2026-06-12T07:16:18.988Z", "questionIndex": 3}, {"text": "Thanks. That completes the structured interview. You can click Complete session when you are ready to see the report.", "speaker": "ai", "timestamp": "2026-06-12T07:16:18.988Z", "questionIndex": null}]', 'ue5_pixel_streaming', '{"summary": "Candidate scored 0/100 with a hold recommendation and high confidence based on 5 answered questions.", "redFlags": [{"label": "Non-answer", "reason": "Candidate did not engage with the question, indicating lack of preparation or inability to answer.", "severity": "high"}, {"label": "Non-answer", "reason": "Candidate did not engage with the question, indicating lack of preparation or inability to answer.", "severity": "high"}, {"label": "Non-answer", "reason": "Candidate did not engage with the question, indicating lack of preparation or inability to answer.", "severity": "high"}, {"label": "Non-answer", "reason": "Candidate did not engage with the question, indicating lack of preparation or inability to answer.", "severity": "high"}, {"label": "Non-answer", "reason": "Candidate did not engage with the question, indicating lack of preparation or inability to answer.", "severity": "high"}], "roleTitle": "Tech Support Agent - Remote US", "strengths": ["Relative strength in answer relevance and expected-concept alignment: 0/100 across 5 responses, indicating the strongest demonstrated area in this interview.", "Relative strength in technical accuracy: 0/100 across 5 responses, indicating the strongest demonstrated area in this interview."], "weaknesses": ["Needs improvement in answer relevance and expected-concept alignment: 0/100 across 5 responses; substantial improvement is needed before this competency meets role expectations.", "Needs improvement in technical accuracy: 0/100 across 5 responses; substantial improvement is needed before this competency meets role expectations.", "Needs improvement in concept coverage: 0/100 across 5 responses; substantial improvement is needed before this competency meets role expectations.", "Needs improvement in reasoning and explanation: 0/100 across 5 responses; substantial improvement is needed before this competency meets role expectations."], "candidateId": "f4f9aa8d-a33b-43dd-bf3f-5096589d05d1", "interviewId": "f4f9aa8d-a33b-43dd-bf3f-5096589d05d1", "skillScores": [{"score": 0, "skill": "model_answer_alignment", "evidenceAnswerIds": ["f4f9aa8d-a33b-43dd-bf3f-5096589d05d1-question-1-answer-1", "f4f9aa8d-a33b-43dd-bf3f-5096589d05d1-question-2-answer-2", "f4f9aa8d-a33b-43dd-bf3f-5096589d05d1-question-3-answer-3", "f4f9aa8d-a33b-43dd-bf3f-5096589d05d1-question-4-answer-4", "f4f9aa8d-a33b-43dd-bf3f-5096589d05d1-question-4-answer-5"]}, {"score": 0, "skill": "factual_correctness", "evidenceAnswerIds": ["f4f9aa8d-a33b-43dd-bf3f-5096589d05d1-question-1-answer-1", "f4f9aa8d-a33b-43dd-bf3f-5096589d05d1-question-2-answer-2", "f4f9aa8d-a33b-43dd-bf3f-5096589d05d1-question-3-answer-3", "f4f9aa8d-a33b-43dd-bf3f-5096589d05d1-question-4-answer-4", "f4f9aa8d-a33b-43dd-bf3f-5096589d05d1-question-4-answer-5"]}, {"score": 0, "skill": "concept_coverage", "evidenceAnswerIds": ["f4f9aa8d-a33b-43dd-bf3f-5096589d05d1-question-1-answer-1", "f4f9aa8d-a33b-43dd-bf3f-5096589d05d1-question-2-answer-2", "f4f9aa8d-a33b-43dd-bf3f-5096589d05d1-question-3-answer-3", "f4f9aa8d-a33b-43dd-bf3f-5096589d05d1-question-4-answer-4", "f4f9aa8d-a33b-43dd-bf3f-5096589d05d1-question-4-answer-5"]}, {"score": 0, "skill": "reasoning_quality", "evidenceAnswerIds": ["f4f9aa8d-a33b-43dd-bf3f-5096589d05d1-question-1-answer-1", "f4f9aa8d-a33b-43dd-bf3f-5096589d05d1-question-2-answer-2", "f4f9aa8d-a33b-43dd-bf3f-5096589d05d1-question-3-answer-3", "f4f9aa8d-a33b-43dd-bf3f-5096589d05d1-question-4-answer-4", "f4f9aa8d-a33b-43dd-bf3f-5096589d05d1-question-4-answer-5"]}, {"score": 0, "skill": "technical_specificity", "evidenceAnswerIds": ["f4f9aa8d-a33b-43dd-bf3f-5096589d05d1-question-1-answer-1", "f4f9aa8d-a33b-43dd-bf3f-5096589d05d1-question-2-answer-2", "f4f9aa8d-a33b-43dd-bf3f-5096589d05d1-question-3-answer-3", "f4f9aa8d-a33b-43dd-bf3f-5096589d05d1-question-4-answer-4", "f4f9aa8d-a33b-43dd-bf3f-5096589d05d1-question-4-answer-5"]}, {"score": 0, "skill": "clarity_structure", "evidenceAnswerIds": ["f4f9aa8d-a33b-43dd-bf3f-5096589d05d1-question-1-answer-1", "f4f9aa8d-a33b-43dd-bf3f-5096589d05d1-question-2-answer-2", "f4f9aa8d-a33b-43dd-bf3f-5096589d05d1-question-3-answer-3", "f4f9aa8d-a33b-43dd-bf3f-5096589d05d1-question-4-answer-4", "f4f9aa8d-a33b-43dd-bf3f-5096589d05d1-question-4-answer-5"]}, {"score": 0, "skill": "communication_quality", "evidenceAnswerIds": ["f4f9aa8d-a33b-43dd-bf3f-5096589d05d1-question-1-answer-1", "f4f9aa8d-a33b-43dd-bf3f-5096589d05d1-question-2-answer-2", "f4f9aa8d-a33b-43dd-bf3f-5096589d05d1-question-3-answer-3", "f4f9aa8d-a33b-43dd-bf3f-5096589d05d1-question-4-answer-4", "f4f9aa8d-a33b-43dd-bf3f-5096589d05d1-question-4-answer-5"]}], "overallScore": 0, "interviewType": "technical", "recommendation": "hold", "transcriptOnly": true, "proctoringSummary": {"eventCount": 31, "criticalOrHighCount": 8}, "questionBreakdown": [{"summary": "Candidate did not answer the question; transcript only says ''i dont remember''.", "answerId": "f4f9aa8d-a33b-43dd-bf3f-5096589d05d1-question-1-answer-1", "redFlags": [{"label": "Non-answer", "reason": "Candidate did not engage with the question, indicating lack of preparation or inability to answer.", "severity": "high"}], "strengths": ["Some relevant concepts were attempted, but coverage was limited."], "questionId": "cmqalc5j40002l7tgnwifgps8", "weaknesses": ["No substantive response provided."], "overallScore": 0, "questionText": "Describe a time you handled a difficult customer call. How did you resolve the issue?", "evaluationMode": "model_answer_based", "questionOrigin": "predetermined", "transcriptOnly": true, "dimensionScores": {"concept_coverage": {"score": 0, "reason": "Required concepts were not covered.", "missing": ["All required concepts missing."], "evidence": ["i dont remember"]}, "clarity_structure": {"score": 0, "reason": "Response is unclear and not structured.", "missing": ["Lack of clear structure."], "evidence": ["i dont remember"]}, "reasoning_quality": {"score": 0, "reason": "No reasoning or explanation provided.", "missing": ["No reasoning or explanation."], "evidence": ["i dont remember"]}, "factual_correctness": {"score": 0, "reason": "No factual content to assess.", "missing": ["No accurate or correct content."], "evidence": ["i dont remember"]}, "communication_quality": {"score": 0, "reason": "Response is a non-answer; fails to communicate.", "missing": ["No communication of relevant content."], "evidence": ["i dont remember"]}, "technical_specificity": {"score": 0, "reason": "No technical details provided.", "missing": ["No technical details."], "evidence": ["i dont remember"]}, "model_answer_alignment": {"score": 0, "reason": "Candidate did not address the question or evaluate the topic.", "missing": ["No evaluation of the topic provided."], "evidence": ["i dont remember"]}}, "evaluationConfidence": "high", "transcriptConfidence": {"notes": ["No material textual hesitation or uncertainty markers were detected.", "Assessment reliability is low; transcript text cannot measure tone, pace, volume, or body language."], "fillerRate": 0, "hedgeCount": 0, "totalWords": 3, "fillerCount": 0, "reliability": "low", "confidenceLevel": "medium", "confidenceScore": 68, "confidencePenalty": 0, "repeatedWordCount": 0, "strongUncertaintyCount": 0}, "modelAnswerComparison": {"coverageScore": 0, "incorrectClaims": [], "requiredPointCoverage": [{"score": 0, "status": "missing", "weight": 100, "comment": "Candidate did not provide any response to evaluate the required topic.", "pointId": "model_answer_core", "evidence": ["i dont remember"], "description": "Evaluate response for topic: AI Generated Vetting Rubric"}], "secondaryPointCoverage": [], "excellentSignalCoverage": []}, "aiAuthorshipAssessment": {"reasons": ["Very short answer; insufficient text for analysis"], "provider": "deepseek", "confidence": "low", "disclaimer": "Text-only AI-authorship detection is probabilistic and cannot prove plagiarism.", "probability": 5}, "followUpRecommendations": ["Probe candidate for actual experience in handling difficult customer calls."]}, {"summary": "Candidate did not answer the question; transcript only says ''i dont manage''.", "answerId": "f4f9aa8d-a33b-43dd-bf3f-5096589d05d1-question-2-answer-2", "redFlags": [{"label": "Non-answer", "reason": "Candidate did not engage with the question, indicating lack of preparation or inability to answer.", "severity": "high"}], "strengths": ["Some relevant concepts were attempted, but coverage was limited."], "questionId": "cmqalc5j80004l7tg8hwcixsz", "weaknesses": ["No substantive response provided."], "overallScore": 0, "questionText": "How do you prioritize and manage technical support tickets when multiple come in at once?", "evaluationMode": "model_answer_based", "questionOrigin": "predetermined", "transcriptOnly": true, "dimensionScores": {"concept_coverage": {"score": 0, "reason": "Required concepts were not covered.", "missing": ["All required concepts missing."], "evidence": ["i dont manage"]}, "clarity_structure": {"score": 0, "reason": "Response is unclear and not structured.", "missing": ["Lack of clear structure."], "evidence": ["i dont manage"]}, "reasoning_quality": {"score": 0, "reason": "No reasoning or explanation provided.", "missing": ["No reasoning or explanation."], "evidence": ["i dont manage"]}, "factual_correctness": {"score": 0, "reason": "No factual content to assess.", "missing": ["No accurate or correct content."], "evidence": ["i dont manage"]}, "communication_quality": {"score": 0, "reason": "Response is a non-answer; fails to communicate.", "missing": ["No communication of relevant content."], "evidence": ["i dont manage"]}, "technical_specificity": {"score": 0, "reason": "No technical details provided.", "missing": ["No technical details."], "evidence": ["i dont manage"]}, "model_answer_alignment": {"score": 0, "reason": "Candidate did not address the question or evaluate the topic.", "missing": ["No evaluation of the topic provided."], "evidence": ["i dont manage"]}}, "evaluationConfidence": "high", "transcriptConfidence": {"notes": ["No material textual hesitation or uncertainty markers were detected.", "Assessment reliability is low; transcript text cannot measure tone, pace, volume, or body language."], "fillerRate": 0, "hedgeCount": 0, "totalWords": 3, "fillerCount": 0, "reliability": "low", "confidenceLevel": "medium", "confidenceScore": 68, "confidencePenalty": 0, "repeatedWordCount": 0, "strongUncertaintyCount": 0}, "modelAnswerComparison": {"coverageScore": 0, "incorrectClaims": [], "requiredPointCoverage": [{"score": 0, "status": "missing", "weight": 100, "comment": "Candidate did not provide any response to evaluate the required topic.", "pointId": "model_answer_core", "evidence": ["i dont manage"], "description": "Evaluate response for topic: AI Generated Vetting Rubric"}], "secondaryPointCoverage": [], "excellentSignalCoverage": []}, "aiAuthorshipAssessment": {"reasons": ["Extremely brief response; no AI indicators"], "provider": "deepseek", "confidence": "low", "disclaimer": "Text-only AI-authorship detection is probabilistic and cannot prove plagiarism.", "probability": 5}, "followUpRecommendations": ["Probe candidate for actual experience in ticket prioritization."]}, {"summary": "Candidate did not answer the question; transcript only says ''troubleshoot?''.", "answerId": "f4f9aa8d-a33b-43dd-bf3f-5096589d05d1-question-3-answer-3", "redFlags": [{"label": "Non-answer", "reason": "Candidate did not engage with the question, indicating lack of preparation or inability to answer.", "severity": "high"}], "strengths": ["Some relevant concepts were attempted, but coverage was limited."], "questionId": "cmqalc5jb0006l7tgcwkldqoy", "weaknesses": ["No substantive response provided."], "overallScore": 0, "questionText": "Walk me through how you would troubleshoot a customer unable to log into a SaaS platform.", "evaluationMode": "model_answer_based", "questionOrigin": "predetermined", "transcriptOnly": true, "dimensionScores": {"concept_coverage": {"score": 0, "reason": "Required concepts were not covered.", "missing": ["All required concepts missing."], "evidence": ["troubleshoot?"]}, "clarity_structure": {"score": 0, "reason": "Response is unclear and not structured.", "missing": ["Lack of clear structure."], "evidence": ["troubleshoot?"]}, "reasoning_quality": {"score": 0, "reason": "No reasoning or explanation provided.", "missing": ["No reasoning or explanation."], "evidence": ["troubleshoot?"]}, "factual_correctness": {"score": 0, "reason": "No factual content to assess.", "missing": ["No accurate or correct content."], "evidence": ["troubleshoot?"]}, "communication_quality": {"score": 0, "reason": "Response is a non-answer; fails to communicate.", "missing": ["No communication of relevant content."], "evidence": ["troubleshoot?"]}, "technical_specificity": {"score": 0, "reason": "No technical details provided.", "missing": ["No technical details."], "evidence": ["troubleshoot?"]}, "model_answer_alignment": {"score": 0, "reason": "Candidate did not address the question or evaluate the topic.", "missing": ["No evaluation of the topic provided."], "evidence": ["troubleshoot?"]}}, "evaluationConfidence": "high", "transcriptConfidence": {"notes": ["No material textual hesitation or uncertainty markers were detected.", "Assessment reliability is low; transcript text cannot measure tone, pace, volume, or body language."], "fillerRate": 0, "hedgeCount": 0, "totalWords": 1, "fillerCount": 0, "reliability": "low", "confidenceLevel": "medium", "confidenceScore": 68, "confidencePenalty": 0, "repeatedWordCount": 0, "strongUncertaintyCount": 0}, "modelAnswerComparison": {"coverageScore": 0, "incorrectClaims": [], "requiredPointCoverage": [{"score": 0, "status": "missing", "weight": 100, "comment": "Candidate only repeated a word from the question, no substantive response.", "pointId": "model_answer_core", "evidence": ["troubleshoot?"], "description": "Evaluate response for topic: AI Generated Vetting Rubric"}], "secondaryPointCoverage": [], "excellentSignalCoverage": []}, "aiAuthorshipAssessment": {"reasons": ["Single word with question; natural spoken fragment"], "provider": "deepseek", "confidence": "low", "disclaimer": "Text-only AI-authorship detection is probabilistic and cannot prove plagiarism.", "probability": 5}, "followUpRecommendations": ["Probe candidate for troubleshooting methodology."]}, {"summary": "Candidate did not answer the question; transcript only says ''ai''.", "answerId": "f4f9aa8d-a33b-43dd-bf3f-5096589d05d1-question-4-answer-4", "redFlags": [{"label": "Non-answer", "reason": "Candidate did not engage with the question, indicating lack of preparation or inability to answer.", "severity": "high"}], "strengths": ["Some relevant concepts were attempted, but coverage was limited."], "questionId": "cmqalc5je0008l7tg21bymdo3", "weaknesses": ["No substantive response provided."], "overallScore": 0, "questionText": "What steps would you take to learn a new software product quickly to support customers?", "evaluationMode": "model_answer_based", "questionOrigin": "predetermined", "transcriptOnly": true, "dimensionScores": {"concept_coverage": {"score": 0, "reason": "Required concepts were not covered.", "missing": ["All required concepts missing."], "evidence": ["ai"]}, "clarity_structure": {"score": 0, "reason": "Response is unclear and not structured.", "missing": ["Lack of clear structure."], "evidence": ["ai"]}, "reasoning_quality": {"score": 0, "reason": "No reasoning or explanation provided.", "missing": ["No reasoning or explanation."], "evidence": ["ai"]}, "factual_correctness": {"score": 0, "reason": "No factual content to assess.", "missing": ["No accurate or correct content."], "evidence": ["ai"]}, "communication_quality": {"score": 0, "reason": "Response is a non-answer; fails to communicate.", "missing": ["No communication of relevant content."], "evidence": ["ai"]}, "technical_specificity": {"score": 0, "reason": "No technical details provided.", "missing": ["No technical details."], "evidence": ["ai"]}, "model_answer_alignment": {"score": 0, "reason": "Candidate did not address the question or evaluate the topic.", "missing": ["No evaluation of the topic provided."], "evidence": ["ai"]}}, "evaluationConfidence": "high", "transcriptConfidence": {"notes": ["No material textual hesitation or uncertainty markers were detected.", "Assessment reliability is low; transcript text cannot measure tone, pace, volume, or body language."], "fillerRate": 0, "hedgeCount": 0, "totalWords": 1, "fillerCount": 0, "reliability": "low", "confidenceLevel": "medium", "confidenceScore": 68, "confidencePenalty": 0, "repeatedWordCount": 0, "strongUncertaintyCount": 0}, "modelAnswerComparison": {"coverageScore": 0, "incorrectClaims": [], "requiredPointCoverage": [{"score": 0, "status": "missing", "weight": 100, "comment": "Candidate only said ''ai'', which does not constitute a response to the question.", "pointId": "model_answer_core", "evidence": ["ai"], "description": "Evaluate response for topic: AI Generated Vetting Rubric"}], "secondaryPointCoverage": [], "excellentSignalCoverage": []}, "aiAuthorshipAssessment": {"reasons": ["One-word answer; cannot detect AI patterns"], "provider": "deepseek", "confidence": "low", "disclaimer": "Text-only AI-authorship detection is probabilistic and cannot prove plagiarism.", "probability": 5}, "followUpRecommendations": ["Probe candidate for learning strategies."]}, {"summary": "Candidate did not answer the question; transcript only says ''thanks''.", "answerId": "f4f9aa8d-a33b-43dd-bf3f-5096589d05d1-question-4-answer-5", "redFlags": [{"label": "Non-answer", "reason": "Candidate did not engage with the question, indicating lack of preparation or inability to answer.", "severity": "high"}], "strengths": ["Some relevant concepts were attempted, but coverage was limited."], "questionId": "cmqalc5je0008l7tg21bymdo3", "weaknesses": ["No substantive response provided."], "overallScore": 0, "questionText": "What steps would you take to learn a new software product quickly to support customers?", "evaluationMode": "model_answer_based", "questionOrigin": "predetermined", "transcriptOnly": true, "dimensionScores": {"concept_coverage": {"score": 0, "reason": "Required concepts were not covered.", "missing": ["All required concepts missing."], "evidence": ["thanks"]}, "clarity_structure": {"score": 0, "reason": "Response is unclear and not structured.", "missing": ["Lack of clear structure."], "evidence": ["thanks"]}, "reasoning_quality": {"score": 0, "reason": "No reasoning or explanation provided.", "missing": ["No reasoning or explanation."], "evidence": ["thanks"]}, "factual_correctness": {"score": 0, "reason": "No factual content to assess.", "missing": ["No accurate or correct content."], "evidence": ["thanks"]}, "communication_quality": {"score": 0, "reason": "Response is a non-answer; fails to communicate.", "missing": ["No communication of relevant content."], "evidence": ["thanks"]}, "technical_specificity": {"score": 0, "reason": "No technical details provided.", "missing": ["No technical details."], "evidence": ["thanks"]}, "model_answer_alignment": {"score": 0, "reason": "Candidate did not address the question or evaluate the topic.", "missing": ["No evaluation of the topic provided."], "evidence": ["thanks"]}}, "evaluationConfidence": "high", "transcriptConfidence": {"notes": ["No material textual hesitation or uncertainty markers were detected.", "Assessment reliability is low; transcript text cannot measure tone, pace, volume, or body language."], "fillerRate": 0, "hedgeCount": 0, "totalWords": 1, "fillerCount": 0, "reliability": "low", "confidenceLevel": "medium", "confidenceScore": 68, "confidencePenalty": 0, "repeatedWordCount": 0, "strongUncertaintyCount": 0}, "modelAnswerComparison": {"coverageScore": 0, "incorrectClaims": [], "requiredPointCoverage": [{"score": 0, "status": "missing", "weight": 100, "comment": "Candidate only said ''thanks'', which does not constitute a response to the question.", "pointId": "model_answer_core", "evidence": ["thanks"], "description": "Evaluate response for topic: AI Generated Vetting Rubric"}], "secondaryPointCoverage": [], "excellentSignalCoverage": []}, "aiAuthorshipAssessment": {"reasons": ["Minimal text; likely human simple response"], "provider": "deepseek", "confidence": "low", "disclaimer": "Text-only AI-authorship detection is probabilistic and cannot prove plagiarism.", "probability": 5}, "followUpRecommendations": ["Probe candidate for learning strategies."]}], "suggestedNextSteps": ["Probe candidate for actual experience in handling difficult customer calls.", "Probe candidate for actual experience in ticket prioritization.", "Probe candidate for troubleshooting methodology.", "Probe candidate for learning strategies."], "candidateConfidence": {"level": "medium", "score": 68, "summary": "Textual confidence was medium (68/100) with low reliability, based on explicit uncertainty, hedging, fillers, and repeated-word patterns. This does not assess vocal tone or body language.", "reliability": "low"}, "futureSignalPlaceholders": {"audioAnalysisEnabled": false, "videoAnalysisEnabled": false}, "recommendationConfidence": "high"}', NULL, '2026-06-12 12:44:11.575+05:30', '2026-06-12 12:47:43.818+05:30');
INSERT INTO public."InterviewSession" VALUES ('a6c33c19-ea17-4d3e-85da-b4b8c7f1f63a', 'cbc684c2-63f6-4a66-ab4e-4f795fbe97a3', 'a6c33c19-ea17-4d3e-85da-b4b8c7f1f63a', '06cdc83e-33fa-4c3e-a915-42108dd18b65', 'IN_PROGRESS', NULL, NULL, '2026-06-12 15:19:37.695+05:30', NULL, NULL, '[{"text": "Describe a time you handled a difficult customer call. How did you resolve the issue?", "speaker": "ai", "timestamp": "2026-06-12T09:49:37.695Z", "questionIndex": 0}, {"text": "no", "metrics": {"wpm": 10, "words": 1, "latencyMs": 6314}, "speaker": "candidate", "timestamp": "2026-06-12T09:49:47.221Z", "questionIndex": 0}, {"text": "How do you prioritize and manage technical support tickets when multiple come in at once?", "speaker": "ai", "timestamp": "2026-06-12T09:49:47.221Z", "questionIndex": 1}, {"text": "i dont", "metrics": {"wpm": 20, "words": 2, "latencyMs": 5662}, "speaker": "candidate", "timestamp": "2026-06-12T09:49:52.917Z", "questionIndex": 1}, {"text": "Walk me through how you would troubleshoot a customer unable to log into a SaaS platform.", "speaker": "ai", "timestamp": "2026-06-12T09:49:52.917Z", "questionIndex": 2}]', 'ue5_pixel_streaming', NULL, NULL, '2026-06-12 15:18:09.945513+05:30', '2026-06-12 15:19:52.919+05:30');
INSERT INTO public."InterviewSession" VALUES ('23da61af-62cc-4868-a02a-1333999b7a46', 'cbc684c2-63f6-4a66-ab4e-4f795fbe97a3', '23da61af-62cc-4868-a02a-1333999b7a46', '06cdc83e-33fa-4c3e-a915-42108dd18b65', 'EVALUATED', NULL, NULL, '2026-06-12 15:13:01.575+05:30', '2026-06-12 15:14:38.583+05:30', NULL, '[{"text": "Describe a time you handled a difficult customer call. How did you resolve the issue?", "speaker": "ai", "timestamp": "2026-06-12T09:43:01.575Z", "questionIndex": 0}, {"text": "cant remember", "metrics": {"wpm": 13, "words": 2, "latencyMs": 8991}, "speaker": "candidate", "timestamp": "2026-06-12T09:43:10.608Z", "questionIndex": 0}, {"text": "How do you prioritize and manage technical support tickets when multiple come in at once?", "speaker": "ai", "timestamp": "2026-06-12T09:43:10.608Z", "questionIndex": 1}, {"text": "i dont", "metrics": {"wpm": 13, "words": 2, "latencyMs": 8921}, "speaker": "candidate", "timestamp": "2026-06-12T09:43:19.548Z", "questionIndex": 1}, {"text": "Walk me through how you would troubleshoot a customer unable to log into a SaaS platform.", "speaker": "ai", "timestamp": "2026-06-12T09:43:19.548Z", "questionIndex": 2}, {"text": "no", "metrics": {"wpm": 10, "words": 1, "latencyMs": 4358}, "speaker": "candidate", "timestamp": "2026-06-12T09:43:23.940Z", "questionIndex": 2}, {"text": "What steps would you take to learn a new software product quickly to support customers?", "speaker": "ai", "timestamp": "2026-06-12T09:43:23.940Z", "questionIndex": 3}, {"text": "i wont learn", "metrics": {"wpm": 16, "words": 3, "latencyMs": 11051}, "speaker": "candidate", "timestamp": "2026-06-12T09:43:35.027Z", "questionIndex": 3}, {"text": "Thanks. That completes the structured interview. You can click Complete session when you are ready to see the report.", "speaker": "ai", "timestamp": "2026-06-12T09:43:35.027Z", "questionIndex": null}, {"url": "/uploads/1781257450881-recording-1781257450860.webm", "type": "recording", "filename": "1781257450881-recording-1781257450860.webm", "createdAt": "2026-06-12T09:44:11.039Z"}, {"text": "Transcript unavailable.", "type": "transcription", "filename": "1781257450881-recording-1781257450860.webm", "createdAt": "2026-06-12T09:44:11.045Z"}]', 'ue5_pixel_streaming', '{"summary": "Candidate scored 0/100 with a needs human review recommendation and high confidence based on 4 answered questions.", "redFlags": [{"label": "Non-answer", "reason": "Candidate did not provide any substantive response, indicating lack of engagement or preparation.", "severity": "high"}, {"label": "Non-answer", "reason": "Candidate gave an incomplete, non-responsive answer indicating possible lack of knowledge or effort.", "severity": "high"}, {"label": "Non-answer / Refusal", "reason": "Candidate answered with ''no'', which is a direct refusal to answer the question, indicating possible unpreparedness or disengagement.", "severity": "critical"}, {"label": "Negative attitude / Refusal", "reason": "Candidate stated they will not learn, which is a critical red flag for a support role that requires continuous learning.", "severity": "critical"}], "roleTitle": "Tech Support Agent - Remote US", "strengths": ["Relative strength in answer relevance and expected-concept alignment: 0/100 across 4 responses, indicating the strongest demonstrated area in this interview.", "Relative strength in technical accuracy: 0/100 across 4 responses, indicating the strongest demonstrated area in this interview."], "weaknesses": ["Needs improvement in answer relevance and expected-concept alignment: 0/100 across 4 responses; substantial improvement is needed before this competency meets role expectations.", "Needs improvement in technical accuracy: 0/100 across 4 responses; substantial improvement is needed before this competency meets role expectations.", "Needs improvement in concept coverage: 0/100 across 4 responses; substantial improvement is needed before this competency meets role expectations.", "Needs improvement in reasoning and explanation: 0/100 across 4 responses; substantial improvement is needed before this competency meets role expectations."], "candidateId": "23da61af-62cc-4868-a02a-1333999b7a46", "interviewId": "23da61af-62cc-4868-a02a-1333999b7a46", "skillScores": [{"score": 0, "skill": "model_answer_alignment", "evidenceAnswerIds": ["23da61af-62cc-4868-a02a-1333999b7a46-question-1-answer-1", "23da61af-62cc-4868-a02a-1333999b7a46-question-2-answer-2", "23da61af-62cc-4868-a02a-1333999b7a46-question-3-answer-3", "23da61af-62cc-4868-a02a-1333999b7a46-question-4-answer-4"]}, {"score": 0, "skill": "factual_correctness", "evidenceAnswerIds": ["23da61af-62cc-4868-a02a-1333999b7a46-question-1-answer-1", "23da61af-62cc-4868-a02a-1333999b7a46-question-2-answer-2", "23da61af-62cc-4868-a02a-1333999b7a46-question-3-answer-3", "23da61af-62cc-4868-a02a-1333999b7a46-question-4-answer-4"]}, {"score": 0, "skill": "concept_coverage", "evidenceAnswerIds": ["23da61af-62cc-4868-a02a-1333999b7a46-question-1-answer-1", "23da61af-62cc-4868-a02a-1333999b7a46-question-2-answer-2", "23da61af-62cc-4868-a02a-1333999b7a46-question-3-answer-3", "23da61af-62cc-4868-a02a-1333999b7a46-question-4-answer-4"]}, {"score": 0, "skill": "reasoning_quality", "evidenceAnswerIds": ["23da61af-62cc-4868-a02a-1333999b7a46-question-1-answer-1", "23da61af-62cc-4868-a02a-1333999b7a46-question-2-answer-2", "23da61af-62cc-4868-a02a-1333999b7a46-question-3-answer-3", "23da61af-62cc-4868-a02a-1333999b7a46-question-4-answer-4"]}, {"score": 0, "skill": "technical_specificity", "evidenceAnswerIds": ["23da61af-62cc-4868-a02a-1333999b7a46-question-1-answer-1", "23da61af-62cc-4868-a02a-1333999b7a46-question-2-answer-2", "23da61af-62cc-4868-a02a-1333999b7a46-question-3-answer-3", "23da61af-62cc-4868-a02a-1333999b7a46-question-4-answer-4"]}, {"score": 0, "skill": "clarity_structure", "evidenceAnswerIds": ["23da61af-62cc-4868-a02a-1333999b7a46-question-1-answer-1", "23da61af-62cc-4868-a02a-1333999b7a46-question-2-answer-2", "23da61af-62cc-4868-a02a-1333999b7a46-question-3-answer-3", "23da61af-62cc-4868-a02a-1333999b7a46-question-4-answer-4"]}, {"score": 0, "skill": "communication_quality", "evidenceAnswerIds": ["23da61af-62cc-4868-a02a-1333999b7a46-question-1-answer-1", "23da61af-62cc-4868-a02a-1333999b7a46-question-2-answer-2", "23da61af-62cc-4868-a02a-1333999b7a46-question-3-answer-3", "23da61af-62cc-4868-a02a-1333999b7a46-question-4-answer-4"]}], "overallScore": 0, "interviewType": "technical", "recommendation": "needs_human_review", "transcriptOnly": true, "proctoringSummary": {"eventCount": 28, "criticalOrHighCount": 6}, "questionBreakdown": [{"summary": "Candidate responded with ''cant remember'', which is a non-answer. No relevant content provided; score is 0.", "answerId": "23da61af-62cc-4868-a02a-1333999b7a46-question-1-answer-1", "redFlags": [{"label": "Non-answer", "reason": "Candidate did not provide any substantive response, indicating lack of engagement or preparation.", "severity": "high"}], "strengths": ["Some relevant concepts were attempted, but coverage was limited."], "questionId": "cmqalc5j40002l7tgnwifgps8", "weaknesses": ["No attempt to answer the question", "Transcript is a trivial non-answer"], "overallScore": 0, "questionText": "Describe a time you handled a difficult customer call. How did you resolve the issue?", "evaluationMode": "model_answer_based", "questionOrigin": "predetermined", "transcriptOnly": true, "dimensionScores": {"concept_coverage": {"score": 0, "reason": "Zero coverage of required concepts.", "missing": ["Core topic: handling difficult customer calls"], "evidence": ["cant remember"]}, "clarity_structure": {"score": 0, "reason": "Transcript is too short to assess structure; unclear response.", "missing": ["Clear and structured answer"], "evidence": ["cant remember"]}, "reasoning_quality": {"score": 0, "reason": "No reasoning provided.", "missing": ["Any reasoning or explanation"], "evidence": ["cant remember"]}, "factual_correctness": {"score": 0, "reason": "No factual claims made; answer is insufficient to evaluate correctness.", "missing": ["Factual content"], "evidence": ["cant remember"]}, "communication_quality": {"score": 0, "reason": "Transcript lacks meaningful communication; only a phrase indicating inability to answer.", "missing": ["Meaningful response"], "evidence": ["cant remember"]}, "technical_specificity": {"score": 0, "reason": "No technical detail provided.", "missing": ["Technical specifics"], "evidence": ["cant remember"]}, "model_answer_alignment": {"score": 0, "reason": "No alignment; answer does not address the question or model answer content.", "missing": ["Any description of a difficult customer call or resolution"], "evidence": ["cant remember"]}}, "evaluationConfidence": "high", "transcriptConfidence": {"notes": ["No material textual hesitation or uncertainty markers were detected.", "Assessment reliability is low; transcript text cannot measure tone, pace, volume, or body language."], "fillerRate": 0, "hedgeCount": 0, "totalWords": 2, "fillerCount": 0, "reliability": "low", "confidenceLevel": "medium", "confidenceScore": 68, "confidencePenalty": 0, "repeatedWordCount": 0, "strongUncertaintyCount": 0}, "modelAnswerComparison": {"coverageScore": 0, "incorrectClaims": [], "requiredPointCoverage": [{"score": 0, "status": "missing", "weight": 100, "comment": "Candidate did not provide any content addressing the question; transcript is a non-answer.", "pointId": "model_answer_core", "evidence": ["cant remember"], "description": "Evaluate response for topic: AI Generated Vetting Rubric"}], "secondaryPointCoverage": [], "excellentSignalCoverage": []}, "aiAuthorshipAssessment": {"reasons": ["Very short, natural fragment", "No generic structure"], "provider": "deepseek", "confidence": "high", "disclaimer": "Text-only AI-authorship detection is probabilistic and cannot prove plagiarism.", "probability": 0}, "followUpRecommendations": ["Probe candidate''s recall by asking if they can describe any customer interaction, even general steps."]}, {"summary": "Candidate responded with ''i dont'', which is a non-answer. No relevant content; score is 0.", "answerId": "23da61af-62cc-4868-a02a-1333999b7a46-question-2-answer-2", "redFlags": [{"label": "Non-answer", "reason": "Candidate gave an incomplete, non-responsive answer indicating possible lack of knowledge or effort.", "severity": "high"}], "strengths": ["Some relevant concepts were attempted, but coverage was limited."], "questionId": "cmqalc5j80004l7tg8hwcixsz", "weaknesses": ["No substantive content", "Response is incomplete and does not address the question"], "overallScore": 0, "questionText": "How do you prioritize and manage technical support tickets when multiple come in at once?", "evaluationMode": "model_answer_based", "questionOrigin": "predetermined", "transcriptOnly": true, "dimensionScores": {"concept_coverage": {"score": 0, "reason": "Zero coverage of ticket prioritization concepts.", "missing": ["Core topic: prioritizing and managing tickets"], "evidence": ["i dont"]}, "clarity_structure": {"score": 0, "reason": "Incomplete response; unclear.", "missing": ["Complete sentence or structure"], "evidence": ["i dont"]}, "reasoning_quality": {"score": 0, "reason": "No reasoning provided.", "missing": ["Reasoning"], "evidence": ["i dont"]}, "factual_correctness": {"score": 0, "reason": "No factual content to evaluate.", "missing": ["Factual claims"], "evidence": ["i dont"]}, "communication_quality": {"score": 0, "reason": "Minimal communication; appears to be a truncated or dismissive response.", "missing": ["Meaningful communication"], "evidence": ["i dont"]}, "technical_specificity": {"score": 0, "reason": "No technical detail.", "missing": ["Technical specifics"], "evidence": ["i dont"]}, "model_answer_alignment": {"score": 0, "reason": "No alignment; response does not answer the question.", "missing": ["Any prioritization strategy or management approach"], "evidence": ["i dont"]}}, "evaluationConfidence": "high", "transcriptConfidence": {"notes": ["No material textual hesitation or uncertainty markers were detected.", "Assessment reliability is low; transcript text cannot measure tone, pace, volume, or body language."], "fillerRate": 0, "hedgeCount": 0, "totalWords": 2, "fillerCount": 0, "reliability": "low", "confidenceLevel": "medium", "confidenceScore": 68, "confidencePenalty": 0, "repeatedWordCount": 0, "strongUncertaintyCount": 0}, "modelAnswerComparison": {"coverageScore": 0, "incorrectClaims": [], "requiredPointCoverage": [{"score": 0, "status": "missing", "weight": 100, "comment": "Candidate did not address the question; transcript is an incomplete phrase.", "pointId": "model_answer_core", "evidence": ["i dont"], "description": "Evaluate response for topic: AI Generated Vetting Rubric"}], "secondaryPointCoverage": [], "excellentSignalCoverage": []}, "aiAuthorshipAssessment": {"reasons": ["Minimal response, informal spelling", "Lacks any polished phrasing"], "provider": "deepseek", "confidence": "high", "disclaimer": "Text-only AI-authorship detection is probabilistic and cannot prove plagiarism.", "probability": 0}, "followUpRecommendations": ["Ask candidate to describe any experience with ticket queues or prioritization frameworks (e.g., severity, SLA)."]}, {"summary": "Candidate responded ''no'', a non-answer. Score is 0.", "answerId": "23da61af-62cc-4868-a02a-1333999b7a46-question-3-answer-3", "redFlags": [{"label": "Non-answer / Refusal", "reason": "Candidate answered with ''no'', which is a direct refusal to answer the question, indicating possible unpreparedness or disengagement.", "severity": "critical"}], "strengths": ["Some relevant concepts were attempted, but coverage was limited."], "questionId": "cmqalc5jb0006l7tgcwkldqoy", "weaknesses": ["Non-answer", "No attempt to demonstrate troubleshooting skills"], "overallScore": 0, "questionText": "Walk me through how you would troubleshoot a customer unable to log into a SaaS platform.", "evaluationMode": "model_answer_based", "questionOrigin": "predetermined", "transcriptOnly": true, "dimensionScores": {"concept_coverage": {"score": 0, "reason": "Zero coverage of troubleshooting concepts.", "missing": ["Core topic: login troubleshooting"], "evidence": ["no"]}, "clarity_structure": {"score": 0, "reason": "Minimal response, no structure.", "missing": ["Structured answer"], "evidence": ["no"]}, "reasoning_quality": {"score": 0, "reason": "No reasoning displayed.", "missing": ["Reasoning"], "evidence": ["no"]}, "factual_correctness": {"score": 0, "reason": "No factual information provided.", "missing": ["Correct factual content"], "evidence": ["no"]}, "communication_quality": {"score": 0, "reason": "Single word response; does not engage with the question.", "missing": ["Meaningful response"], "evidence": ["no"]}, "technical_specificity": {"score": 0, "reason": "No technical detail.", "missing": ["Technical specifics"], "evidence": ["no"]}, "model_answer_alignment": {"score": 0, "reason": "No alignment; response is a refusal or non-answer.", "missing": ["Troubleshooting steps or approach"], "evidence": ["no"]}}, "evaluationConfidence": "high", "transcriptConfidence": {"notes": ["No material textual hesitation or uncertainty markers were detected.", "Assessment reliability is low; transcript text cannot measure tone, pace, volume, or body language."], "fillerRate": 0, "hedgeCount": 0, "totalWords": 1, "fillerCount": 0, "reliability": "low", "confidenceLevel": "medium", "confidenceScore": 68, "confidencePenalty": 0, "repeatedWordCount": 0, "strongUncertaintyCount": 0}, "modelAnswerComparison": {"coverageScore": 0, "incorrectClaims": [], "requiredPointCoverage": [{"score": 0, "status": "missing", "weight": 100, "comment": "Candidate gave a one-word negative response, not addressing the question.", "pointId": "model_answer_core", "evidence": ["no"], "description": "Evaluate response for topic: AI Generated Vetting Rubric"}], "secondaryPointCoverage": [], "excellentSignalCoverage": []}, "aiAuthorshipAssessment": {"reasons": ["Single word refusal, natural", "No AI-typical completeness"], "provider": "deepseek", "confidence": "high", "disclaimer": "Text-only AI-authorship detection is probabilistic and cannot prove plagiarism.", "probability": 0}, "followUpRecommendations": ["If candidate resumes, ask them to attempt a basic troubleshooting sequence for login issues (e.g., check credentials, reset password, browser issues)."]}, {"summary": "Candidate responded ''i wont learn'', indicating refusal to engage with the question. Score is 0.", "answerId": "23da61af-62cc-4868-a02a-1333999b7a46-question-4-answer-4", "redFlags": [{"label": "Negative attitude / Refusal", "reason": "Candidate stated they will not learn, which is a critical red flag for a support role that requires continuous learning.", "severity": "critical"}], "strengths": ["Some relevant concepts were attempted, but coverage was limited."], "questionId": "cmqalc5je0008l7tg21bymdo3", "weaknesses": ["Non-answer / Refusal to learn", "Does not demonstrate any willingness to acquire product knowledge"], "overallScore": 0, "questionText": "What steps would you take to learn a new software product quickly to support customers?", "evaluationMode": "model_answer_based", "questionOrigin": "predetermined", "transcriptOnly": true, "dimensionScores": {"concept_coverage": {"score": 0, "reason": "Zero coverage; candidate rejects the concept of learning.", "missing": ["Core topic: strategies for learning a new software product"], "evidence": ["i wont learn"]}, "clarity_structure": {"score": 0, "reason": "Short statement, no structure.", "missing": ["Structured answer"], "evidence": ["i wont learn"]}, "reasoning_quality": {"score": 0, "reason": "No reasoning provided.", "missing": ["Reasoning or justification"], "evidence": ["i wont learn"]}, "factual_correctness": {"score": 0, "reason": "Statement ''i wont learn'' is not factual about learning process; it''s a refusal.", "missing": ["Correct factual content"], "evidence": ["i wont learn"]}, "communication_quality": {"score": 0, "reason": "Negative response; does not communicate learning approach.", "missing": ["Positive engagement with question"], "evidence": ["i wont learn"]}, "technical_specificity": {"score": 0, "reason": "No technical detail.", "missing": ["Technical specifics"], "evidence": ["i wont learn"]}, "model_answer_alignment": {"score": 0, "reason": "Response contradicts the question''s premise; no alignment.", "missing": ["Steps for learning a new product"], "evidence": ["i wont learn"]}}, "evaluationConfidence": "high", "transcriptConfidence": {"notes": ["No material textual hesitation or uncertainty markers were detected.", "Assessment reliability is low; transcript text cannot measure tone, pace, volume, or body language."], "fillerRate": 0, "hedgeCount": 0, "totalWords": 3, "fillerCount": 0, "reliability": "low", "confidenceLevel": "medium", "confidenceScore": 68, "confidencePenalty": 0, "repeatedWordCount": 0, "strongUncertaintyCount": 0}, "modelAnswerComparison": {"coverageScore": 0, "incorrectClaims": [], "requiredPointCoverage": [{"score": 0, "status": "missing", "weight": 100, "comment": "Candidate stated they will not learn, which is a rejection of the premise and does not answer.", "pointId": "model_answer_core", "evidence": ["i wont learn"], "description": "Evaluate response for topic: AI Generated Vetting Rubric"}], "secondaryPointCoverage": [], "excellentSignalCoverage": []}, "aiAuthorshipAssessment": {"reasons": ["Short, ungrammatical, human-like", "No attempts at structured answer"], "provider": "deepseek", "confidence": "high", "disclaimer": "Text-only AI-authorship detection is probabilistic and cannot prove plagiarism.", "probability": 0}, "followUpRecommendations": ["If interview continues, explore why candidate would not learn and assess adaptability."]}], "suggestedNextSteps": ["Probe candidate''s recall by asking if they can describe any customer interaction, even general steps.", "Ask candidate to describe any experience with ticket queues or prioritization frameworks (e.g., severity, SLA).", "If candidate resumes, ask them to attempt a basic troubleshooting sequence for login issues (e.g., check credentials, reset password, browser issues).", "If interview continues, explore why candidate would not learn and assess adaptability."], "candidateConfidence": {"level": "medium", "score": 68, "summary": "Textual confidence was medium (68/100) with low reliability, based on explicit uncertainty, hedging, fillers, and repeated-word patterns. This does not assess vocal tone or body language.", "reliability": "low"}, "futureSignalPlaceholders": {"audioAnalysisEnabled": false, "videoAnalysisEnabled": false}, "recommendationConfidence": "high"}', NULL, '2026-06-12 15:11:59.196+05:30', '2026-06-12 15:14:38.588+05:30');


--
-- Data for Name: JobRole; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."JobRole" VALUES ('08ed817a-5e98-4083-a056-61ce569b48b5', 'cbc684c2-63f6-4a66-ab4e-4f795fbe97a3', 'Director, Product Management Enterprise Platforms & Core Infrastructure', 'GENERAL', 'QUORUM FINANCIAL GROUP Director, Product Management Enterprise Platforms & Core Infrastructure · New York, NY · Hybrid (3 days onsite) Reports to SVP of Product · Full-time · Posted June 2026 ABOUT THE ROLE Quorum is looking for a Director of Product Management to own our core enterprise platform — the backbone that processes $4B+ in daily transaction volume for 600 institutional clients. You will set the product vision for a surface that engineers care deeply about and that clients never see, which means your impact is measured in uptime, throughput, and the absence of 3am incidents. This is not a role for someone who wants to launch consumer features on a six-week cycle. You will spend a lot of time reading architecture RFCs, sitting in on SRE postmortems, and arguing with a very opinionated VP of Engineering about whether we should rewrite the order matching engine in Rust. You should find that prospect exciting. WHAT YOU''LL OWN Multi-year roadmap for core settlement, custody, and reconciliation infrastructure across equities, fixed income, and FX Product strategy for our internal developer platform: shared APIs, SDKs, and the tooling layer used by 12 product teams Quarterly OKR cycles for your pod — setting targets, tracking them rigorously, and being honest when something isn''t working Client advisory relationships with 8–10 Tier 1 institutional accounts; you will occasionally present roadmap directly to their CTOs Hiring, coaching, and leveling the four PMs who report to you; two are senior and opinionated, which is the point Cross-functional alignment across Compliance, Risk, and Legal on anything that touches regulatory reporting or capital requirements WHAT WE NEED FROM YOU 8+ years in product management, at least 3 in a senior/staff role owning platform or infrastructure products — not just features Ability to read a database schema and have a meaningful conversation about query performance; you don''t need to write the SQL, but you need to understand why it matters Experience in a regulated environment: fintech, banking, insurance, or similar; compliance is not a blocker to you, it is a design constraint Track record of deprecating things — our platform has 14 years of legacy and someone needs to make the hard calls Strong written communication; our engineering culture is async-first: Slack is for jokes, Notion is for decisions Comfort with ambiguity at the strategic level and zero tolerance for ambiguity at the execution level PREFERRED BUT NOT REQUIRED Background in financial services: trade lifecycle, clearing & settlement, or custody operations Prior experience managing other PMs, not just individual contributors MBA or CFA — not because we value credentials, but because it usually means rigorous thinking about capital allocation You''ve worked at a firm that had a serious production incident and came out of it having changed something structural, not just added a runbook INTERVIEW PROCESS 30-min intro call with talent (scheduling, logistics, soft fit) 60-min product sense interview with SVP of Product — expect a case set in financial infrastructure, not consumer 90-min technical depth interview with VP of Engineering and a Staff Engineer — no coding, but heavy on systems thinking Half-day onsite in Midtown: leadership panel, take-home case debrief, and a 30-min informal lunch with the team you''d join Reference calls, offer, done — we move in under three weeks if you do Quorum Financial Group is an equal opportunity employer. We do not discriminate on the basis of race, religion, national origin, gender, sexual orientation, age, disability, or veteran status.', 'QUORUM FINANCIAL GROUP Director, Product Management Enterprise Platforms & Core Infrastructure · New York, NY · Hybrid (3 days onsite) Reports to SVP of Product · Full-time · Posted June 2026 ABOUT THE ROLE Quorum is looking for a Director of Product Management to own our core enterprise platform — the backbone that processes $4B+ in daily transaction volume for 600 institutional clients. You will set the product vision for a surface that engineers care deeply about and that clients never see, which means your impact is measured in uptime, throughput, and the absence of 3am incidents. This is not a role for someone who wants to launch consumer features on a six-week cycle. You will spend a lot of time reading architecture RFCs, sitting in on SRE postmortems, and arguing with a very opinionated VP of Engineering about whether we should rewrite the order matching engine in Rust. You should find that prospect exciting. WHAT YOU''LL OWN Multi-year roadmap for core settlement, custody, and reconciliation infrastructure across equities, fixed income, and FX Product strategy for our internal developer platform: shared APIs, SDKs, and the tooling layer used by 12 product teams Quarterly OKR cycles for your pod — setting targets, tracking them rigorously, and being honest when something isn''t working Client advisory relationships with 8–10 Tier 1 institutional accounts; you will occasionally present roadmap directly to their CTOs Hiring, coaching, and leveling the four PMs who report to you; two are senior and opinionated, which is the point Cross-functional alignment across Compliance, Risk, and Legal on anything that touches regulatory reporting or capital requirements WHAT WE NEED FROM YOU 8+ years in product management, at least 3 in a senior/staff role owning platform or infrastructure products — not just features Ability to read a database schema and have a meaningful conversation about query performance; you don''t need to write the SQL, but you need to understand why it matters Experience in a regulated environment: fintech, banking, insurance, or similar; compliance is not a blocker to you, it is a design constraint Track record of deprecating things — our platform has 14 years of legacy and someone needs to make the hard calls Strong written communication; our engineering culture is async-first: Slack is for jokes, Notion is for decisions Comfort with ambiguity at the strategic level and zero tolerance for ambiguity at the execution level PREFERRED BUT NOT REQUIRED Background in financial services: trade lifecycle, clearing & settlement, or custody operations Prior experience managing other PMs, not just individual contributors MBA or CFA — not because we value credentials, but because it usually means rigorous thinking about capital allocation You''ve worked at a firm that had a serious production incident and came out of it having changed something structural, not just added a runbook INTERVIEW PROCESS 30-min intro call with talent (scheduling, logistics, soft fit) 60-min product sense interview with SVP of Product — expect a case set in financial infrastructure, not consumer 90-min technical depth interview with VP of Engineering and a Staff Engineer — no coding, but heavy on systems thinking Half-day onsite in Midtown: leadership panel, take-home case debrief, and a 30-min informal lunch with the team you''d join Reference calls, offer, done — we move in under three weeks if you do Quorum Financial Group is an equal opportunity employer. We do not discriminate on the basis of race, religion, national origin, gender, sexual orientation, age, disability, or veteran status.', '{topics}', '{communication,"system design"}', '{"primary": 0.4, "education": 0.1, "secondary": 0.3, "experience": 0.1, "communication": 0.1}', '{"reasoning": 1, "confidence": 1, "correctness": 1, "communication": 1, "modelAnswerAlignment": 1}', '2026-06-09 19:22:14.064551+05:30', '2026-06-09 19:22:14.064551+05:30');
INSERT INTO public."JobRole" VALUES ('1f0cf586-72d3-4637-bd26-ec6dbd63a90f', 'cbc684c2-63f6-4a66-ab4e-4f795fbe97a3', 'Director, Product Management Enterprise Platforms & Core Infrastructure', 'GENERAL', 'QUORUM FINANCIAL GROUP Director, Product Management Enterprise Platforms & Core Infrastructure · New York, NY · Hybrid (3 days onsite) Reports to SVP of Product · Full-time · Posted June 2026 ABOUT THE ROLE Quorum is looking for a Director of Product Management to own our core enterprise platform — the backbone that processes $4B+ in daily transaction volume for 600 institutional clients. You will set the product vision for a surface that engineers care deeply about and that clients never see, which means your impact is measured in uptime, throughput, and the absence of 3am incidents. This is not a role for someone who wants to launch consumer features on a six-week cycle. You will spend a lot of time reading architecture RFCs, sitting in on SRE postmortems, and arguing with a very opinionated VP of Engineering about whether we should rewrite the order matching engine in Rust. You should find that prospect exciting. WHAT YOU''LL OWN Multi-year roadmap for core settlement, custody, and reconciliation infrastructure across equities, fixed income, and FX Product strategy for our internal developer platform: shared APIs, SDKs, and the tooling layer used by 12 product teams Quarterly OKR cycles for your pod — setting targets, tracking them rigorously, and being honest when something isn''t working Client advisory relationships with 8–10 Tier 1 institutional accounts; you will occasionally present roadmap directly to their CTOs Hiring, coaching, and leveling the four PMs who report to you; two are senior and opinionated, which is the point Cross-functional alignment across Compliance, Risk, and Legal on anything that touches regulatory reporting or capital requirements WHAT WE NEED FROM YOU 8+ years in product management, at least 3 in a senior/staff role owning platform or infrastructure products — not just features Ability to read a database schema and have a meaningful conversation about query performance; you don''t need to write the SQL, but you need to understand why it matters Experience in a regulated environment: fintech, banking, insurance, or similar; compliance is not a blocker to you, it is a design constraint Track record of deprecating things — our platform has 14 years of legacy and someone needs to make the hard calls Strong written communication; our engineering culture is async-first: Slack is for jokes, Notion is for decisions Comfort with ambiguity at the strategic level and zero tolerance for ambiguity at the execution level PREFERRED BUT NOT REQUIRED Background in financial services: trade lifecycle, clearing & settlement, or custody operations Prior experience managing other PMs, not just individual contributors MBA or CFA — not because we value credentials, but because it usually means rigorous thinking about capital allocation You''ve worked at a firm that had a serious production incident and came out of it having changed something structural, not just added a runbook INTERVIEW PROCESS 30-min intro call with talent (scheduling, logistics, soft fit) 60-min product sense interview with SVP of Product — expect a case set in financial infrastructure, not consumer 90-min technical depth interview with VP of Engineering and a Staff Engineer — no coding, but heavy on systems thinking Half-day onsite in Midtown: leadership panel, take-home case debrief, and a 30-min informal lunch with the team you''d join Reference calls, offer, done — we move in under three weeks if you do Quorum Financial Group is an equal opportunity employer. We do not discriminate on the basis of race, religion, national origin, gender, sexual orientation, age, disability, or veteran status.', 'QUORUM FINANCIAL GROUP Director, Product Management Enterprise Platforms & Core Infrastructure · New York, NY · Hybrid (3 days onsite) Reports to SVP of Product · Full-time · Posted June 2026 ABOUT THE ROLE Quorum is looking for a Director of Product Management to own our core enterprise platform — the backbone that processes $4B+ in daily transaction volume for 600 institutional clients. You will set the product vision for a surface that engineers care deeply about and that clients never see, which means your impact is measured in uptime, throughput, and the absence of 3am incidents. This is not a role for someone who wants to launch consumer features on a six-week cycle. You will spend a lot of time reading architecture RFCs, sitting in on SRE postmortems, and arguing with a very opinionated VP of Engineering about whether we should rewrite the order matching engine in Rust. You should find that prospect exciting. WHAT YOU''LL OWN Multi-year roadmap for core settlement, custody, and reconciliation infrastructure across equities, fixed income, and FX Product strategy for our internal developer platform: shared APIs, SDKs, and the tooling layer used by 12 product teams Quarterly OKR cycles for your pod — setting targets, tracking them rigorously, and being honest when something isn''t working Client advisory relationships with 8–10 Tier 1 institutional accounts; you will occasionally present roadmap directly to their CTOs Hiring, coaching, and leveling the four PMs who report to you; two are senior and opinionated, which is the point Cross-functional alignment across Compliance, Risk, and Legal on anything that touches regulatory reporting or capital requirements WHAT WE NEED FROM YOU 8+ years in product management, at least 3 in a senior/staff role owning platform or infrastructure products — not just features Ability to read a database schema and have a meaningful conversation about query performance; you don''t need to write the SQL, but you need to understand why it matters Experience in a regulated environment: fintech, banking, insurance, or similar; compliance is not a blocker to you, it is a design constraint Track record of deprecating things — our platform has 14 years of legacy and someone needs to make the hard calls Strong written communication; our engineering culture is async-first: Slack is for jokes, Notion is for decisions Comfort with ambiguity at the strategic level and zero tolerance for ambiguity at the execution level PREFERRED BUT NOT REQUIRED Background in financial services: trade lifecycle, clearing & settlement, or custody operations Prior experience managing other PMs, not just individual contributors MBA or CFA — not because we value credentials, but because it usually means rigorous thinking about capital allocation You''ve worked at a firm that had a serious production incident and came out of it having changed something structural, not just added a runbook INTERVIEW PROCESS 30-min intro call with talent (scheduling, logistics, soft fit) 60-min product sense interview with SVP of Product — expect a case set in financial infrastructure, not consumer 90-min technical depth interview with VP of Engineering and a Staff Engineer — no coding, but heavy on systems thinking Half-day onsite in Midtown: leadership panel, take-home case debrief, and a 30-min informal lunch with the team you''d join Reference calls, offer, done — we move in under three weeks if you do Quorum Financial Group is an equal opportunity employer. We do not discriminate on the basis of race, religion, national origin, gender, sexual orientation, age, disability, or veteran status.', '{topics}', '{communication,"system design"}', '{"primary": 0.4, "education": 0.1, "secondary": 0.3, "experience": 0.1, "communication": 0.1}', '{"reasoning": 1, "confidence": 1, "correctness": 1, "communication": 1, "modelAnswerAlignment": 1}', '2026-06-09 22:07:00.957079+05:30', '2026-06-09 22:07:00.957079+05:30');
INSERT INTO public."JobRole" VALUES ('d45bf0f9-8eea-4652-b7cc-f6d02848483c', 'cbc684c2-63f6-4a66-ab4e-4f795fbe97a3', 'Director, Product Management Enterprise Platforms & Core Infrastructure', 'GENERAL', 'Set product vision for Quorum''s core enterprise platform handling $4B+ daily transaction volume. Own multi-year roadmap for settlement, custody, and reconciliation infrastructure. Lead a team of 4 PMs and drive cross-functional alignment across engineering, compliance, and risk.

**Responsibilities:**
- Own multi-year roadmap for core settlement, custody, and reconciliation infrastructure across equities, fixed income, and FX.
- Define product strategy for internal developer platform (APIs, SDKs, tooling) used by 12 product teams.
- Lead quarterly OKR cycles for your pod with rigorous tracking.
- Manage client advisory relationships with 8–10 Tier 1 institutional accounts; present roadmap to their CTOs.
- Hire, coach, and level up 4 direct reports (2 senior PMs).
- Drive cross-functional alignment with Compliance, Risk, and Legal on regulatory reporting and capital requirements.

**Requirements:**
- 8+ years product management, 3+ in senior/staff role owning platform/infrastructure products.
- Ability to read database schemas and discuss query performance.
- Experience in regulated environment (fintech, banking, insurance, etc.).
- Track record of deprecating legacy systems.
- Strong async written communication; Slack for jokes, Notion for decisions.
- Comfort with strategic ambiguity, zero tolerance for execution ambiguity.

**Preferred:**
- Financial services background (trade lifecycle, clearing & settlement, custody).
- Prior PM management experience.
- MBA or CFA.
- Experience at a firm with serious production incident leading to structural change.', 'Set product vision for Quorum''s core enterprise platform handling $4B+ daily transaction volume. Own multi-year roadmap for settlement, custody, and reconciliation infrastructure. Lead a team of 4 PMs and drive cross-functional alignment across engineering, compliance, and risk.

**Responsibilities:**
- Own multi-year roadmap for core settlement, custody, and reconciliation infrastructure across equities, fixed income, and FX.
- Define product strategy for internal developer platform (APIs, SDKs, tooling) used by 12 product teams.
- Lead quarterly OKR cycles for your pod with rigorous tracking.
- Manage client advisory relationships with 8–10 Tier 1 institutional accounts; present roadmap to their CTOs.
- Hire, coach, and level up 4 direct reports (2 senior PMs).
- Drive cross-functional alignment with Compliance, Risk, and Legal on regulatory reporting and capital requirements.

**Requirements:**
- 8+ years product management, 3+ in senior/staff role owning platform/infrastructure products.
- Ability to read database schemas and discuss query performance.
- Experience in regulated environment (fintech, banking, insurance, etc.).
- Track record of deprecating legacy systems.
- Strong async written communication; Slack for jokes, Notion for decisions.
- Comfort with strategic ambiguity, zero tolerance for execution ambiguity.

**Preferred:**
- Financial services background (trade lifecycle, clearing & settlement, custody).
- Prior PM management experience.
- MBA or CFA.
- Experience at a firm with serious production incident leading to structural change.', '{topics}', '{communication,"system design"}', '{"primary": 0.4, "education": 0.1, "secondary": 0.3, "experience": 0.1, "communication": 0.1}', '{"reasoning": 1, "confidence": 1, "correctness": 1, "communication": 1, "modelAnswerAlignment": 1}', '2026-06-10 01:19:34.612956+05:30', '2026-06-10 01:19:34.612956+05:30');
INSERT INTO public."JobRole" VALUES ('d36d2d9d-0904-4083-b31f-4446be7edbed', 'cbc684c2-63f6-4a66-ab4e-4f795fbe97a3', 'Backend Developer', 'GENERAL', 'No description provided', 'No requirements specified', '{topics}', '{communication,"system design"}', '{"primary": 0.4, "education": 0.1, "secondary": 0.3, "experience": 0.1, "communication": 0.1}', '{"reasoning": 1, "confidence": 1, "correctness": 1, "communication": 1, "modelAnswerAlignment": 1}', '2026-06-11 12:45:06.88696+05:30', '2026-06-11 12:45:06.88696+05:30');
INSERT INTO public."JobRole" VALUES ('a46ed67b-e548-4648-8624-bec3df105317', 'cbc684c2-63f6-4a66-ab4e-4f795fbe97a3', 'Backend Developer', 'GENERAL', 'No description provided', 'No requirements specified', '{topics}', '{communication,"system design"}', '{"primary": 0.4, "education": 0.1, "secondary": 0.3, "experience": 0.1, "communication": 0.1}', '{"reasoning": 1, "confidence": 1, "correctness": 1, "communication": 1, "modelAnswerAlignment": 1}', '2026-06-11 13:05:45.443182+05:30', '2026-06-11 13:05:45.443182+05:30');
INSERT INTO public."JobRole" VALUES ('c7905743-07a6-42cf-b5de-0e89437a1400', 'cbc684c2-63f6-4a66-ab4e-4f795fbe97a3', 'Backend Developer', 'GENERAL', 'No description provided', 'No requirements specified', '{topics}', '{communication,"system design"}', '{"primary": 0.4, "education": 0.1, "secondary": 0.3, "experience": 0.1, "communication": 0.1}', '{"reasoning": 1, "confidence": 1, "correctness": 1, "communication": 1, "modelAnswerAlignment": 1}', '2026-06-11 15:39:15.592495+05:30', '2026-06-11 15:39:15.592495+05:30');
INSERT INTO public."JobRole" VALUES ('24e17bb0-ef87-46f1-ace2-bfe107a30d2b', 'cbc684c2-63f6-4a66-ab4e-4f795fbe97a3', 'Backend Developer', 'GENERAL', 'No description provided', 'No requirements specified', '{topics}', '{communication,"system design"}', '{"primary": 0.4, "education": 0.1, "secondary": 0.3, "experience": 0.1, "communication": 0.1}', '{"reasoning": 1, "confidence": 1, "correctness": 1, "communication": 1, "modelAnswerAlignment": 1}', '2026-06-11 16:47:10.425317+05:30', '2026-06-11 16:47:10.425317+05:30');
INSERT INTO public."JobRole" VALUES ('cmqakehlq0002l7z0igkdjf8y', 'cmq6p9edn0000l72wl889b8bq', 'Junior Software Development Engineer', 'GENERAL', 'Junior engineering role focused on fundamentals, debugging, backend basics, and clear technical communication.', 'Data structures, algorithms, debugging, APIs, databases, and basic system design.', '{"data structures",algorithms,debugging,"backend fundamentals"}', '{communication,"system design basics",testing}', '{"primary": 0.4, "education": 0.1, "secondary": 0.3, "experience": 0.1, "communication": 0.1}', '{"reasoning": 1, "confidence": 1, "correctness": 1, "communication": 1, "modelAnswerAlignment": 1}', '2026-06-12 12:18:00.926+05:30', '2026-06-12 12:18:00.926+05:30');
INSERT INTO public."JobRole" VALUES ('b52cd6ff-98b2-4d94-8dd1-f9ed36f7d656', 'cbc684c2-63f6-4a66-ab4e-4f795fbe97a3', 'Director, Product Management Enterprise Platforms & Core Infrastructure', 'GENERAL', 'Job overview
Quorum Financial Group seeks a Director of Product Management to own the core enterprise platform handling $4B+ daily transaction volume. Set product vision for internal developer platforms and client-facing infrastructure while leading a team of four PMs and driving cross-functional alignment.

Key responsibilities
- Own multi-year roadmap for core settlement, custody, and reconciliation infrastructure
- Define product strategy for internal developer platforms: shared APIs, SDKs, and tooling
- Drive quarterly OKR cycles for the product pod with rigorous tracking
- Manage relationships with 8–10 Tier 1 institutional clients, presenting roadmap to CTOs
- Hire, coach, and level four PMs, including senior and opinionated team members

Requirements
- 8+ years in product management, with at least 3 years owning platform/infrastructure products
- Ability to read a database schema and discuss query performance meaningfully
- Experience in a regulated environment (fintech, banking, insurance, etc.)
- Track record of deprecating legacy systems and making hard trade-offs
- Strong written communication skills for async-first engineering culture', 'Job overview
Quorum Financial Group seeks a Director of Product Management to own the core enterprise platform handling $4B+ daily transaction volume. Set product vision for internal developer platforms and client-facing infrastructure while leading a team of four PMs and driving cross-functional alignment.

Key responsibilities
- Own multi-year roadmap for core settlement, custody, and reconciliation infrastructure
- Define product strategy for internal developer platforms: shared APIs, SDKs, and tooling
- Drive quarterly OKR cycles for the product pod with rigorous tracking
- Manage relationships with 8–10 Tier 1 institutional clients, presenting roadmap to CTOs
- Hire, coach, and level four PMs, including senior and opinionated team members

Requirements
- 8+ years in product management, with at least 3 years owning platform/infrastructure products
- Ability to read a database schema and discuss query performance meaningfully
- Experience in a regulated environment (fintech, banking, insurance, etc.)
- Track record of deprecating legacy systems and making hard trade-offs
- Strong written communication skills for async-first engineering culture', '{topics}', '{communication,"system design"}', '{"primary": 0.4, "education": 0.1, "secondary": 0.3, "experience": 0.1, "communication": 0.1}', '{"reasoning": 1, "confidence": 1, "correctness": 1, "communication": 1, "modelAnswerAlignment": 1}', '2026-06-12 12:31:33.583519+05:30', '2026-06-12 12:38:49.265+05:30');
INSERT INTO public."JobRole" VALUES ('06cdc83e-33fa-4c3e-a915-42108dd18b65', 'cbc684c2-63f6-4a66-ab4e-4f795fbe97a3', 'Tech Support Agent - Remote US', 'GENERAL', 'Job overview
We are looking for a Technical Support Agent to handle inbound phone calls, chats, and emails, providing training and technical support to TitleTec customers within our SaaS platforms. This full-time remote role requires strong customer focus, basic troubleshooting skills, and prior telephone-based customer service experience.

Key responsibilities
- Handle inbound phone calls, chats, and emails to provide technical support and training.
- Work technical support tickets according to urgency in a triage manner.
- Engage in active listening, confirm information, and manage calls following state requirements.
- Meet call volume standards and other key performance indicators.
- Document and report activities in CRM system (Salesforce).

Requirements
- High school diploma or equivalent.
- Prior experience with telephone-based customer service.
- Basic troubleshooting skills and critical thinking abilities.
- Calm under pressure and able to think/react quickly.
- Dedication to learn products thoroughly; ability to work from home in a quiet designated workspace.', 'Job overview
We are looking for a Technical Support Agent to handle inbound phone calls, chats, and emails, providing training and technical support to TitleTec customers within our SaaS platforms. This full-time remote role requires strong customer focus, basic troubleshooting skills, and prior telephone-based customer service experience.

Key responsibilities
- Handle inbound phone calls, chats, and emails to provide technical support and training.
- Work technical support tickets according to urgency in a triage manner.
- Engage in active listening, confirm information, and manage calls following state requirements.
- Meet call volume standards and other key performance indicators.
- Document and report activities in CRM system (Salesforce).

Requirements
- High school diploma or equivalent.
- Prior experience with telephone-based customer service.
- Basic troubleshooting skills and critical thinking abilities.
- Calm under pressure and able to think/react quickly.
- Dedication to learn products thoroughly; ability to work from home in a quiet designated workspace.', '{topics}', '{communication,"system design"}', '{"primary": 0.4, "education": 0.1, "secondary": 0.3, "experience": 0.1, "communication": 0.1}', '{"reasoning": 1, "confidence": 1, "correctness": 1, "communication": 1, "modelAnswerAlignment": 1}', '2026-06-12 12:44:11.557+05:30', '2026-06-12 15:18:09.879108+05:30');


--
-- Data for Name: ProctoringLog; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."ProctoringLog" VALUES ('cmqalc5lq000al7tgajs9jgvo', 'f4f9aa8d-a33b-43dd-bf3f-5096589d05d1', 'TAB_RETURNED', 'MEDIUM', '{"reason": "document_hidden", "trigger": "visibilitychange", "hasFocus": true, "startedAt": 1781248451326, "durationMs": 350, "returnedAt": 1781248451676, "documentHidden": false, "durationSeconds": 0.4, "visibilityState": "visible"}', '2026-06-12 12:44:11.676+05:30', '2026-06-12 12:44:11.679+05:30');
INSERT INTO public."ProctoringLog" VALUES ('cmqalc6b3000cl7tglq28fu6c', 'f4f9aa8d-a33b-43dd-bf3f-5096589d05d1', 'TAB_SWITCH_DETECTED', 'HIGH', '{"reason": "document_hidden", "trigger": "visibilitychange", "hasFocus": true, "startedAt": 1781248452590, "documentHidden": true, "visibilityState": "hidden", "activeDurationMs": 0}', '2026-06-12 12:44:12.59+05:30', '2026-06-12 12:44:12.591+05:30');
INSERT INTO public."ProctoringLog" VALUES ('cmqalc92w000fl7tgvov49wh5', 'f4f9aa8d-a33b-43dd-bf3f-5096589d05d1', 'TAB_RETURNED', 'MEDIUM', '{"reason": "window_blur", "trigger": "focus", "hasFocus": true, "startedAt": 1781248453428, "durationMs": 2755, "returnedAt": 1781248456183, "documentHidden": false, "durationSeconds": 2.8, "visibilityState": "visible"}', '2026-06-12 12:44:16.183+05:30', '2026-06-12 12:44:16.185+05:30');
INSERT INTO public."ProctoringLog" VALUES ('cmqalc9q7000hl7tg8fn5w29v', 'f4f9aa8d-a33b-43dd-bf3f-5096589d05d1', 'FULLSCREEN_REQUEST_FAILED', 'MEDIUM', '{"message": "Permissions check failed", "trigger": "camera_started", "userGestureRequired": true}', '2026-06-12 12:44:17.022+05:30', '2026-06-12 12:44:17.023+05:30');
INSERT INTO public."ProctoringLog" VALUES ('cmqalccl3000jl7tgz4yrzbb9', 'f4f9aa8d-a33b-43dd-bf3f-5096589d05d1', 'TAB_SWITCH_DETECTED', 'HIGH', '{"reason": "window_blur", "trigger": "blur", "hasFocus": false, "startedAt": 1781248460726, "documentHidden": false, "visibilityState": "visible", "activeDurationMs": 0}', '2026-06-12 12:44:20.726+05:30', '2026-06-12 12:44:20.727+05:30');
INSERT INTO public."ProctoringLog" VALUES ('cmqalcfxl000ll7tgcjl0joxl', 'f4f9aa8d-a33b-43dd-bf3f-5096589d05d1', 'TAB_RETURNED', 'MEDIUM', '{"reason": "window_blur", "trigger": "focus", "hasFocus": true, "startedAt": 1781248460726, "durationMs": 4337, "returnedAt": 1781248465063, "documentHidden": false, "durationSeconds": 4.3, "visibilityState": "visible"}', '2026-06-12 12:44:25.063+05:30', '2026-06-12 12:44:25.065+05:30');
INSERT INTO public."ProctoringLog" VALUES ('cmqalcfys000nl7tgcedsl6jq', 'f4f9aa8d-a33b-43dd-bf3f-5096589d05d1', 'TAB_SWITCH_DETECTED', 'HIGH', '{"reason": "window_blur", "trigger": "blur", "hasFocus": false, "startedAt": 1781248465107, "documentHidden": false, "visibilityState": "visible", "activeDurationMs": 0}', '2026-06-12 12:44:25.107+05:30', '2026-06-12 12:44:25.109+05:30');
INSERT INTO public."ProctoringLog" VALUES ('cmqalcg4l000pl7tgp31y1mr9', 'f4f9aa8d-a33b-43dd-bf3f-5096589d05d1', 'PRE_INTERVIEW_SCREEN_SHARE_CONFIRMED', 'MEDIUM', '{"trigger": "user_interaction", "completedAt": 1781248465316, "requestedAt": 1781248458801, "screenShareRequired": true}', '2026-06-12 12:44:25.316+05:30', '2026-06-12 12:44:25.318+05:30');
INSERT INTO public."ProctoringLog" VALUES ('cmqalcg4p000rl7tgxatrkx1r', 'f4f9aa8d-a33b-43dd-bf3f-5096589d05d1', 'TAB_RETURNED', 'MEDIUM', '{"reason": "window_blur", "trigger": "focus", "hasFocus": true, "startedAt": 1781248465107, "durationMs": 213, "returnedAt": 1781248465320, "documentHidden": false, "durationSeconds": 0.2, "visibilityState": "visible"}', '2026-06-12 12:44:25.32+05:30', '2026-06-12 12:44:25.321+05:30');
INSERT INTO public."ProctoringLog" VALUES ('cmqalcg58000tl7tgauif8lie', 'f4f9aa8d-a33b-43dd-bf3f-5096589d05d1', 'PRE_INTERVIEW_FULLSCREEN_CONFIRMED', 'MEDIUM', '{"trigger": "user_interaction", "enteredAt": 1781248465339, "requestedAt": 1781248465316}', '2026-06-12 12:44:25.339+05:30', '2026-06-12 12:44:25.34+05:30');
INSERT INTO public."ProctoringLog" VALUES ('cmqalcg58000vl7tg8m1yurxm', 'f4f9aa8d-a33b-43dd-bf3f-5096589d05d1', 'FULLSCREEN_ENTERED', 'MEDIUM', '{"trigger": "fullscreenchange"}', '2026-06-12 12:44:25.34+05:30', '2026-06-12 12:44:25.341+05:30');
INSERT INTO public."ProctoringLog" VALUES ('cmqalda48000xl7tgirmzq5m2', 'f4f9aa8d-a33b-43dd-bf3f-5096589d05d1', 'MOBILE_PHONE_DETECTED', 'HIGH', '{"source": "ml_label", "proximity": "close", "confidence": 0.44171875, "detections": [{"label": "cell phone", "score": 0.44171875, "areaRatio": 0.26171875, "aspectRatio": 1.990049751243781}], "orientation": "landscape"}', '2026-06-12 12:45:04.183+05:30', '2026-06-12 12:45:04.184+05:30');
INSERT INTO public."ProctoringLog" VALUES ('cmqaldakg000zl7tgfcm6py18', 'f4f9aa8d-a33b-43dd-bf3f-5096589d05d1', 'GAZE_AWAY_DETECTED', 'MEDIUM', '{"source": "blendshape", "yawDelta": 0.5501371766123704, "direction": "down", "confidence": 0.1878242966061075, "pitchDelta": 0.9604291629556956, "thresholdX": 0.2107645884707436, "thresholdY": 0.1070841575191394, "compensatedX": 0.007311439960124549, "compensatedY": -0.1878242966061075, "uncompensatedX": 0.007311439960124549, "uncompensatedY": -0.1878242966061075, "calibrationReason": "Calibration sanitized: Missing required 8-dot calibration points: tl, tc, tr, ml, mr, bl, bc, br", "calibrationTrusted": false, "headPoseCompensated": false}', '2026-06-12 12:45:04.767+05:30', '2026-06-12 12:45:04.769+05:30');
INSERT INTO public."ProctoringLog" VALUES ('cmqaldgal0011l7tg0fj87o45', 'f4f9aa8d-a33b-43dd-bf3f-5096589d05d1', 'VIOLATION_SCREEN_RECORDING_READY', 'MEDIUM', '{"endedAt": "2026-06-12T07:15:12.187Z", "mimeType": "video/webm;codecs=vp9", "sizeBytes": 1247854, "startedAt": "2026-06-12T07:15:04.183Z", "durationMs": 8004, "eventCount": 2, "recordingId": "violation-recording-79ab1df6-24e9-4dd4-b31c-2b7085e46cf8", "violationTypes": ["MOBILE_PHONE", "GAZE_AWAY"]}', '2026-06-12 12:45:12.188+05:30', '2026-06-12 12:45:12.19+05:30');
INSERT INTO public."ProctoringLog" VALUES ('cmqaldmsj0013l7tg9x3trjt7', 'f4f9aa8d-a33b-43dd-bf3f-5096589d05d1', 'GAZE_AWAY_DETECTED', 'MEDIUM', '{"source": "geometry", "yawDelta": -1.003616069344627, "direction": "up", "confidence": 0.1253855765416823, "pitchDelta": 0.7371821554962636, "thresholdX": 0.2107645884707436, "thresholdY": 0.1070841575191394, "compensatedX": 0.1253855765416823, "compensatedY": -0.1175625707192944, "uncompensatedX": 0.1253855765416823, "uncompensatedY": -0.1175625707192944, "calibrationReason": "Calibration sanitized: Missing required 8-dot calibration points: tl, tc, tr, ml, mr, bl, bc, br", "calibrationTrusted": false, "headPoseCompensated": false}', '2026-06-12 12:45:20.61+05:30', '2026-06-12 12:45:20.611+05:30');
INSERT INTO public."ProctoringLog" VALUES ('cmqaldpp60015l7tgwnq5jndm', 'f4f9aa8d-a33b-43dd-bf3f-5096589d05d1', 'TAB_SWITCH_DETECTED', 'HIGH', '{"reason": "window_blur", "trigger": "blur", "hasFocus": false, "startedAt": 1781248524376, "documentHidden": false, "visibilityState": "visible", "activeDurationMs": 0}', '2026-06-12 12:45:24.376+05:30', '2026-06-12 12:45:24.378+05:30');
INSERT INTO public."ProctoringLog" VALUES ('cmqaldpxn0017l7tgc921t8co', 'f4f9aa8d-a33b-43dd-bf3f-5096589d05d1', 'TAB_RETURNED', 'MEDIUM', '{"reason": "window_blur", "trigger": "focus", "hasFocus": true, "startedAt": 1781248524376, "durationMs": 306, "returnedAt": 1781248524682, "documentHidden": false, "durationSeconds": 0.3, "visibilityState": "visible"}', '2026-06-12 12:45:24.682+05:30', '2026-06-12 12:45:24.684+05:30');
INSERT INTO public."ProctoringLog" VALUES ('cmqaldpxx0019l7tg2pkvew2p', 'f4f9aa8d-a33b-43dd-bf3f-5096589d05d1', 'VIOLATION_SCREEN_RECORDING_READY', 'MEDIUM', '{"endedAt": "2026-06-12T07:15:24.688Z", "mimeType": "video/webm;codecs=vp9", "sizeBytes": 607003, "startedAt": "2026-06-12T07:15:20.610Z", "durationMs": 4078, "eventCount": 2, "recordingId": "violation-recording-53736bbd-d969-4447-86d1-1106a5d814ce", "violationTypes": ["GAZE_AWAY", "TAB_SWITCH"]}', '2026-06-12 12:45:24.693+05:30', '2026-06-12 12:45:24.694+05:30');
INSERT INTO public."ProctoringLog" VALUES ('cmqaldyx2001bl7tgi03f85ql', 'f4f9aa8d-a33b-43dd-bf3f-5096589d05d1', 'GAZE_AWAY_DETECTED', 'MEDIUM', '{"source": "blendshape", "yawDelta": -3.120370702832739, "direction": "down", "confidence": 0.2163718275096785, "pitchDelta": 1.036023912917958, "thresholdX": 0.2107645884707436, "thresholdY": 0.1070841575191394, "compensatedX": 0.2163718275096785, "compensatedY": -0.1945219013473, "uncompensatedX": 0.2225755345380059, "uncompensatedY": -0.1945219013473, "calibrationReason": "Calibration sanitized: Missing required 8-dot calibration points: tl, tc, tr, ml, mr, bl, bc, br", "calibrationTrusted": false, "headPoseCompensated": true}', '2026-06-12 12:45:36.324+05:30', '2026-06-12 12:45:36.326+05:30');
INSERT INTO public."ProctoringLog" VALUES ('cmqale53g001dl7tgvbbb36t2', 'f4f9aa8d-a33b-43dd-bf3f-5096589d05d1', 'VIOLATION_SCREEN_RECORDING_READY', 'MEDIUM', '{"endedAt": "2026-06-12T07:15:44.329Z", "mimeType": "video/webm;codecs=vp9", "sizeBytes": 1205693, "startedAt": "2026-06-12T07:15:36.324Z", "durationMs": 8005, "eventCount": 1, "recordingId": "violation-recording-7f39e315-1c5d-4813-8237-4e987e337540", "violationTypes": ["GAZE_AWAY"]}', '2026-06-12 12:45:44.33+05:30', '2026-06-12 12:45:44.332+05:30');
INSERT INTO public."ProctoringLog" VALUES ('cmqalfo9a001fl7tg9pff1ifp', 'f4f9aa8d-a33b-43dd-bf3f-5096589d05d1', 'TAB_SWITCH_DETECTED', 'HIGH', '{"reason": "window_blur", "trigger": "blur", "hasFocus": false, "startedAt": 1781248615821, "documentHidden": false, "visibilityState": "visible", "activeDurationMs": 0}', '2026-06-12 12:46:55.821+05:30', '2026-06-12 12:46:55.822+05:30');
INSERT INTO public."ProctoringLog" VALUES ('cmqalfswf001hl7tg8zthfbts', 'f4f9aa8d-a33b-43dd-bf3f-5096589d05d1', 'TAB_RETURNED', 'MEDIUM', '{"reason": "window_blur", "trigger": "focus", "hasFocus": true, "startedAt": 1781248615821, "durationMs": 6017, "returnedAt": 1781248621838, "documentHidden": false, "durationSeconds": 6, "visibilityState": "visible"}', '2026-06-12 12:47:01.838+05:30', '2026-06-12 12:47:01.839+05:30');
INSERT INTO public."ProctoringLog" VALUES ('cmqalfswz001jl7tgms272dr7', 'f4f9aa8d-a33b-43dd-bf3f-5096589d05d1', 'VIOLATION_SCREEN_RECORDING_READY', 'MEDIUM', '{"endedAt": "2026-06-12T07:17:01.843Z", "mimeType": "video/webm;codecs=vp9", "sizeBytes": 228906, "startedAt": "2026-06-12T07:16:55.821Z", "durationMs": 6022, "eventCount": 1, "recordingId": "violation-recording-9c84c62c-1445-461a-938c-40d6ce9abe91", "violationTypes": ["TAB_SWITCH"]}', '2026-06-12 12:47:01.858+05:30', '2026-06-12 12:47:01.859+05:30');
INSERT INTO public."ProctoringLog" VALUES ('cmqalfufs001ll7tgl54syg0d', 'f4f9aa8d-a33b-43dd-bf3f-5096589d05d1', 'FULLSCREEN_EXITED_DETECTED', 'HIGH', '{"reason": "fullscreen_exited", "trigger": "fullscreenchange", "hasFocus": true, "documentHidden": false, "visibilityState": "visible", "fullscreenElementPresent": false}', '2026-06-12 12:47:03.831+05:30', '2026-06-12 12:47:03.833+05:30');
INSERT INTO public."ProctoringLog" VALUES ('cmqalfvcb001nl7tgt59df4tw', 'f4f9aa8d-a33b-43dd-bf3f-5096589d05d1', 'PRE_INTERVIEW_FULLSCREEN_CONFIRMED', 'MEDIUM', '{"trigger": "user_interaction", "enteredAt": 1781248625002, "requestedAt": 1781248624896}', '2026-06-12 12:47:05.002+05:30', '2026-06-12 12:47:05.004+05:30');
INSERT INTO public."ProctoringLog" VALUES ('cmqalg0bt001xl7tg4rukurau', 'f4f9aa8d-a33b-43dd-bf3f-5096589d05d1', 'FULLSCREEN_RESTORED', 'MEDIUM', '{"trigger": "fullscreenchange", "durationMs": 5271, "previousReason": "fullscreen_exited"}', '2026-06-12 12:47:11.464+05:30', '2026-06-12 12:47:11.465+05:30');
INSERT INTO public."ProctoringLog" VALUES ('cmqalg0r7001zl7tgot8nwz2s', 'f4f9aa8d-a33b-43dd-bf3f-5096589d05d1', 'GAZE_AWAY_DETECTED', 'MEDIUM', '{"source": "geometry", "yawDelta": -3.033851085321782, "direction": "left", "confidence": 0.2419499126820736, "pitchDelta": 20.61857654579782, "thresholdX": 0.2107645884707436, "thresholdY": 0.1070841575191394, "compensatedX": 0.2419499126820736, "compensatedY": 0.04157561594024692, "uncompensatedX": 0.2472884235352915, "uncompensatedY": -0.09342438405975309, "calibrationReason": "Calibration sanitized: Missing required 8-dot calibration points: tl, tc, tr, ml, mr, bl, bc, br", "calibrationTrusted": false, "headPoseCompensated": true}', '2026-06-12 12:47:12.018+05:30', '2026-06-12 12:47:12.02+05:30');
INSERT INTO public."ProctoringLog" VALUES ('cmqalg6xn0021l7tgz75zpbbc', 'f4f9aa8d-a33b-43dd-bf3f-5096589d05d1', 'VIOLATION_SCREEN_RECORDING_READY', 'MEDIUM', '{"endedAt": "2026-06-12T07:17:20.023Z", "mimeType": "video/webm;codecs=vp9", "sizeBytes": 1219069, "startedAt": "2026-06-12T07:17:12.018Z", "durationMs": 8005, "eventCount": 1, "recordingId": "violation-recording-5d13bd70-94d5-43b9-a959-b98982373a20", "violationTypes": ["GAZE_AWAY"]}', '2026-06-12 12:47:20.026+05:30', '2026-06-12 12:47:20.028+05:30');
INSERT INTO public."ProctoringLog" VALUES ('cmqalg9630023l7tg6b7chkw8', 'f4f9aa8d-a33b-43dd-bf3f-5096589d05d1', 'FULLSCREEN_EXITED_DETECTED', 'HIGH', '{"reason": "fullscreen_exited", "trigger": "fullscreenchange", "hasFocus": true, "documentHidden": false, "visibilityState": "visible", "fullscreenElementPresent": false}', '2026-06-12 12:47:22.922+05:30', '2026-06-12 12:47:22.923+05:30');
INSERT INTO public."ProctoringLog" VALUES ('cmqalgavh0025l7tgkqqnb4wp', 'f4f9aa8d-a33b-43dd-bf3f-5096589d05d1', 'PRE_INTERVIEW_FULLSCREEN_CONFIRMED', 'MEDIUM', '{"trigger": "user_interaction", "enteredAt": 1781248645132, "requestedAt": 1781248645084}', '2026-06-12 12:47:25.132+05:30', '2026-06-12 12:47:25.134+05:30');
INSERT INTO public."ProctoringLog" VALUES ('cmqalgnzc002fl7tg9gnjbmd1', 'f4f9aa8d-a33b-43dd-bf3f-5096589d05d1', 'FULLSCREEN_RESTORED', 'MEDIUM', '{"trigger": "fullscreenchange", "durationMs": 15489, "previousReason": "fullscreen_exited"}', '2026-06-12 12:47:42.12+05:30', '2026-06-12 12:47:42.12+05:30');
INSERT INTO public."ProctoringLog" VALUES ('cmqalgnzz002hl7tgmrr3gm0v', 'f4f9aa8d-a33b-43dd-bf3f-5096589d05d1', 'VIOLATION_SCREEN_RECORDING_READY', 'MEDIUM', '{"endedAt": "2026-06-12T07:17:42.133Z", "mimeType": "video/webm;codecs=vp9", "sizeBytes": 2320534, "startedAt": "2026-06-12T07:17:26.630Z", "durationMs": 15503, "eventCount": 1, "recordingId": "violation-recording-8450ca29-dc2a-4d7f-8c43-3b8b0ccaa8c5", "violationTypes": ["FULLSCREEN_EXIT"]}', '2026-06-12 12:47:42.142+05:30', '2026-06-12 12:47:42.143+05:30');
INSERT INTO public."ProctoringLog" VALUES ('cmqalgot4002jl7tgb9y8xi86', 'f4f9aa8d-a33b-43dd-bf3f-5096589d05d1', 'FULLSCREEN_EXITED_DETECTED', 'HIGH', '{"reason": "fullscreen_exited", "trigger": "fullscreenchange", "hasFocus": true, "documentHidden": false, "visibilityState": "visible", "fullscreenElementPresent": false}', '2026-06-12 12:47:43.191+05:30', '2026-06-12 12:47:43.192+05:30');
INSERT INTO public."ProctoringLog" VALUES ('cmqalgs1i002ll7tg4t9ipnoe', 'f4f9aa8d-a33b-43dd-bf3f-5096589d05d1', 'TAB_SWITCH_DETECTED', 'HIGH', '{"reason": "document_hidden", "trigger": "visibilitychange", "hasFocus": true, "startedAt": 1781248667381, "documentHidden": true, "visibilityState": "hidden", "activeDurationMs": 0}', '2026-06-12 12:47:47.381+05:30', '2026-06-12 12:47:47.383+05:30');
INSERT INTO public."ProctoringLog" VALUES ('cmqalfvcc001pl7tg04mcg63e', 'f4f9aa8d-a33b-43dd-bf3f-5096589d05d1', 'FULLSCREEN_RESTORED', 'MEDIUM', '{"trigger": "fullscreenchange", "durationMs": 1172, "previousReason": "fullscreen_exited"}', '2026-06-12 12:47:05.003+05:30', '2026-06-12 12:47:05.004+05:30');
INSERT INTO public."ProctoringLog" VALUES ('cmqalfw9e001rl7tg8wwjge1j', 'f4f9aa8d-a33b-43dd-bf3f-5096589d05d1', 'FULLSCREEN_EXITED_DETECTED', 'HIGH', '{"reason": "fullscreen_exited", "trigger": "fullscreenchange", "hasFocus": true, "documentHidden": false, "visibilityState": "visible", "fullscreenElementPresent": false}', '2026-06-12 12:47:06.193+05:30', '2026-06-12 12:47:06.194+05:30');
INSERT INTO public."ProctoringLog" VALUES ('cmqalfwrc001tl7tgxahbi0yn', 'f4f9aa8d-a33b-43dd-bf3f-5096589d05d1', 'VIOLATION_SCREEN_RECORDING_READY', 'MEDIUM', '{"endedAt": "2026-06-12T07:17:06.837Z", "mimeType": "video/webm;codecs=vp9", "sizeBytes": 397371, "startedAt": "2026-06-12T07:17:03.831Z", "durationMs": 3006, "eventCount": 2, "recordingId": "violation-recording-51603671-8f4c-4b70-b04d-3c108aa64c12", "violationTypes": ["FULLSCREEN_EXIT"]}', '2026-06-12 12:47:06.838+05:30', '2026-06-12 12:47:06.84+05:30');
INSERT INTO public."ProctoringLog" VALUES ('cmqalg0bs001vl7tgvns8lv6y', 'f4f9aa8d-a33b-43dd-bf3f-5096589d05d1', 'PRE_INTERVIEW_FULLSCREEN_CONFIRMED', 'MEDIUM', '{"trigger": "user_interaction", "enteredAt": 1781248631463, "requestedAt": 1781248631445}', '2026-06-12 12:47:11.463+05:30', '2026-06-12 12:47:11.465+05:30');
INSERT INTO public."ProctoringLog" VALUES ('cmqalgavj0027l7tgz1i053j0', 'f4f9aa8d-a33b-43dd-bf3f-5096589d05d1', 'FULLSCREEN_RESTORED', 'MEDIUM', '{"trigger": "fullscreenchange", "durationMs": 2211, "previousReason": "fullscreen_exited"}', '2026-06-12 12:47:25.133+05:30', '2026-06-12 12:47:25.134+05:30');
INSERT INTO public."ProctoringLog" VALUES ('cmqalgbhi0029l7tg0cuh0kze', 'f4f9aa8d-a33b-43dd-bf3f-5096589d05d1', 'VIOLATION_SCREEN_RECORDING_READY', 'MEDIUM', '{"endedAt": "2026-06-12T07:17:25.923Z", "mimeType": "video/webm;codecs=vp9", "sizeBytes": 376524, "startedAt": "2026-06-12T07:17:22.922Z", "durationMs": 3001, "eventCount": 1, "recordingId": "violation-recording-f0e3318d-9d17-4a45-b41a-6d40262c8a07", "violationTypes": ["FULLSCREEN_EXIT"]}', '2026-06-12 12:47:25.924+05:30', '2026-06-12 12:47:25.926+05:30');
INSERT INTO public."ProctoringLog" VALUES ('cmqalgc13002bl7tg06t9s3yh', 'f4f9aa8d-a33b-43dd-bf3f-5096589d05d1', 'FULLSCREEN_EXITED_DETECTED', 'HIGH', '{"reason": "fullscreen_exited", "trigger": "fullscreenchange", "hasFocus": true, "documentHidden": false, "visibilityState": "visible", "fullscreenElementPresent": false}', '2026-06-12 12:47:26.63+05:30', '2026-06-12 12:47:26.631+05:30');
INSERT INTO public."ProctoringLog" VALUES ('cmqalgnzc002dl7tg1gx7c7mn', 'f4f9aa8d-a33b-43dd-bf3f-5096589d05d1', 'PRE_INTERVIEW_FULLSCREEN_CONFIRMED', 'MEDIUM', '{"trigger": "user_interaction", "enteredAt": 1781248662119, "requestedAt": 1781248662090}', '2026-06-12 12:47:42.119+05:30', '2026-06-12 12:47:42.12+05:30');
INSERT INTO public."ProctoringLog" VALUES ('cmqaqm93y0002l7uoeirqrfo3', '23da61af-62cc-4868-a02a-1333999b7a46', 'TAB_RETURNED', 'MEDIUM', '{"reason": "window_not_focused", "trigger": "focus", "hasFocus": true, "startedAt": 1781257318730, "durationMs": 2130, "returnedAt": 1781257320860, "documentHidden": false, "durationSeconds": 2.1, "visibilityState": "visible"}', '2026-06-12 15:12:00.86+05:30', '2026-06-12 15:12:00.862+05:30');
INSERT INTO public."ProctoringLog" VALUES ('cmqaqmal50004l7uom66v2ssk', '23da61af-62cc-4868-a02a-1333999b7a46', 'TAB_SWITCH_DETECTED', 'HIGH', '{"reason": "window_blur", "trigger": "blur", "hasFocus": false, "startedAt": 1781257322776, "documentHidden": false, "visibilityState": "visible", "activeDurationMs": 0}', '2026-06-12 15:12:02.776+05:30', '2026-06-12 15:12:02.778+05:30');
INSERT INTO public."ProctoringLog" VALUES ('cmqaqmfvm0007l7uo7zssj4zv', '23da61af-62cc-4868-a02a-1333999b7a46', 'TAB_RETURNED', 'MEDIUM', '{"reason": "window_blur", "trigger": "focus", "hasFocus": true, "startedAt": 1781257323824, "durationMs": 5809, "returnedAt": 1781257329633, "documentHidden": false, "durationSeconds": 5.8, "visibilityState": "visible"}', '2026-06-12 15:12:09.633+05:30', '2026-06-12 15:12:09.635+05:30');
INSERT INTO public."ProctoringLog" VALUES ('cmqaqmgif0009l7uocpymogqo', '23da61af-62cc-4868-a02a-1333999b7a46', 'FULLSCREEN_REQUEST_FAILED', 'MEDIUM', '{"message": "Permissions check failed", "trigger": "camera_started", "userGestureRequired": true}', '2026-06-12 15:12:10.454+05:30', '2026-06-12 15:12:10.456+05:30');
INSERT INTO public."ProctoringLog" VALUES ('cmqaqmi3q000bl7uo5wwlfhhu', '23da61af-62cc-4868-a02a-1333999b7a46', 'TAB_SWITCH_DETECTED', 'HIGH', '{"reason": "window_blur", "trigger": "blur", "hasFocus": false, "startedAt": 1781257332517, "documentHidden": false, "visibilityState": "visible", "activeDurationMs": 0}', '2026-06-12 15:12:12.517+05:30', '2026-06-12 15:12:12.518+05:30');
INSERT INTO public."ProctoringLog" VALUES ('cmqaqmk03000dl7uov5l42asm', '23da61af-62cc-4868-a02a-1333999b7a46', 'TAB_RETURNED', 'MEDIUM', '{"reason": "window_blur", "trigger": "focus", "hasFocus": true, "startedAt": 1781257332517, "durationMs": 2460, "returnedAt": 1781257334977, "documentHidden": false, "durationSeconds": 2.5, "visibilityState": "visible"}', '2026-06-12 15:12:14.977+05:30', '2026-06-12 15:12:14.979+05:30');
INSERT INTO public."ProctoringLog" VALUES ('cmqaqmk1a000fl7uosifa9c92', '23da61af-62cc-4868-a02a-1333999b7a46', 'TAB_SWITCH_DETECTED', 'HIGH', '{"reason": "window_blur", "trigger": "blur", "hasFocus": false, "startedAt": 1781257335021, "documentHidden": false, "visibilityState": "visible", "activeDurationMs": 0}', '2026-06-12 15:12:15.021+05:30', '2026-06-12 15:12:15.022+05:30');
INSERT INTO public."ProctoringLog" VALUES ('cmqaqmk7e000hl7uo3twkbb6r', '23da61af-62cc-4868-a02a-1333999b7a46', 'PRE_INTERVIEW_SCREEN_SHARE_CONFIRMED', 'MEDIUM', '{"trigger": "user_interaction", "completedAt": 1781257335240, "requestedAt": 1781257331674, "screenShareRequired": true}', '2026-06-12 15:12:15.24+05:30', '2026-06-12 15:12:15.242+05:30');
INSERT INTO public."ProctoringLog" VALUES ('cmqaqmk7j000jl7uowy14hl2z', '23da61af-62cc-4868-a02a-1333999b7a46', 'TAB_RETURNED', 'MEDIUM', '{"reason": "window_blur", "trigger": "focus", "hasFocus": true, "startedAt": 1781257335021, "durationMs": 225, "returnedAt": 1781257335246, "documentHidden": false, "durationSeconds": 0.2, "visibilityState": "visible"}', '2026-06-12 15:12:15.246+05:30', '2026-06-12 15:12:15.247+05:30');
INSERT INTO public."ProctoringLog" VALUES ('cmqaqmk84000ll7uoypa307h9', '23da61af-62cc-4868-a02a-1333999b7a46', 'PRE_INTERVIEW_FULLSCREEN_CONFIRMED', 'MEDIUM', '{"trigger": "user_interaction", "enteredAt": 1781257335267, "requestedAt": 1781257335240}', '2026-06-12 15:12:15.267+05:30', '2026-06-12 15:12:15.269+05:30');
INSERT INTO public."ProctoringLog" VALUES ('cmqaqmk8o000nl7uopj4vr6hz', '23da61af-62cc-4868-a02a-1333999b7a46', 'FULLSCREEN_ENTERED', 'MEDIUM', '{"trigger": "fullscreenchange"}', '2026-06-12 15:12:15.286+05:30', '2026-06-12 15:12:15.288+05:30');
INSERT INTO public."ProctoringLog" VALUES ('cmqaqneph000pl7uo2szv92yn', '23da61af-62cc-4868-a02a-1333999b7a46', 'GAZE_AWAY_DETECTED', 'MEDIUM', '{"source": "geometry", "yawDelta": -9.795567835325084, "direction": "up", "confidence": 0.284972071582533, "pitchDelta": 7.012764200051123, "thresholdX": 0.1397101840482589, "thresholdY": 0.104896242852074, "compensatedX": 0, "compensatedY": -0.284972071582533, "uncompensatedX": -0.009243060042925529, "uncompensatedY": -0.3300997135830442, "calibrationReason": "Calibration sanitized: Missing required 8-dot calibration points: tl, tc, tr, ml, mr, bl, bc, br", "calibrationTrusted": false, "headPoseCompensated": true}', '2026-06-12 15:12:54.771+05:30', '2026-06-12 15:12:54.773+05:30');
INSERT INTO public."ProctoringLog" VALUES ('cmqaqnkw0000rl7uorepsaub7', '23da61af-62cc-4868-a02a-1333999b7a46', 'VIOLATION_SCREEN_RECORDING_READY', 'MEDIUM', '{"endedAt": "2026-06-12T09:43:02.780Z", "mimeType": "video/webm;codecs=vp9", "sizeBytes": 996988, "startedAt": "2026-06-12T09:42:54.771Z", "durationMs": 8008, "eventCount": 1, "recordingId": "violation-recording-ddb7fa79-6bb5-4af2-bb94-a83dfdce02b9", "violationTypes": ["GAZE_AWAY"]}', '2026-06-12 15:13:02.783+05:30', '2026-06-12 15:13:02.785+05:30');
INSERT INTO public."ProctoringLog" VALUES ('cmqaqnqsm000tl7uoznawjkep', '23da61af-62cc-4868-a02a-1333999b7a46', 'GAZE_AWAY_DETECTED', 'MEDIUM', '{"source": "geometry", "yawDelta": -0.08674047995759837, "direction": "up", "confidence": 0.3316183147189474, "pitchDelta": 3.560429996457341, "thresholdX": 0.1397101840482589, "thresholdY": 0.104896242852074, "compensatedX": 0.06868338255690745, "compensatedY": -0.3316183147189474, "uncompensatedX": 0.06868338255690745, "uncompensatedY": -0.3422226146835208, "calibrationReason": "Calibration sanitized: Missing required 8-dot calibration points: tl, tc, tr, ml, mr, bl, bc, br", "calibrationTrusted": false, "headPoseCompensated": true}', '2026-06-12 15:13:10.437+05:30', '2026-06-12 15:13:10.438+05:30');
INSERT INTO public."ProctoringLog" VALUES ('cmqaqwr0k0032l7uodighz646', 'a6c33c19-ea17-4d3e-85da-b4b8c7f1f63a', 'FULLSCREEN_EXITED_DETECTED', 'HIGH', '{"reason": "fullscreen_exited", "trigger": "fullscreenchange", "hasFocus": false, "documentHidden": false, "visibilityState": "visible", "fullscreenElementPresent": false}', '2026-06-12 15:20:10.627+05:30', '2026-06-12 15:20:10.629+05:30');
INSERT INTO public."ProctoringLog" VALUES ('cmqaqnwz3000vl7uo3pyyoluf', '23da61af-62cc-4868-a02a-1333999b7a46', 'VIOLATION_SCREEN_RECORDING_READY', 'MEDIUM', '{"endedAt": "2026-06-12T09:43:18.443Z", "mimeType": "video/webm;codecs=vp9", "sizeBytes": 1022965, "startedAt": "2026-06-12T09:43:10.437Z", "durationMs": 8006, "eventCount": 1, "recordingId": "violation-recording-0a689e8f-552a-40df-99e4-1f0172c94efe", "violationTypes": ["GAZE_AWAY"]}', '2026-06-12 15:13:18.445+05:30', '2026-06-12 15:13:18.447+05:30');
INSERT INTO public."ProctoringLog" VALUES ('cmqaqo2w4000xl7uooh85zd7y', '23da61af-62cc-4868-a02a-1333999b7a46', 'GAZE_AWAY_DETECTED', 'MEDIUM', '{"source": "geometry", "yawDelta": -7.955901275094613, "direction": "up", "confidence": 0.3294439742807859, "pitchDelta": 0.9659524865467084, "thresholdX": 0.1397101840482589, "thresholdY": 0.104896242852074, "compensatedX": 0.168300321391931, "compensatedY": -0.3294439742807859, "uncompensatedX": 0.2228593341428772, "uncompensatedY": -0.3294439742807859, "calibrationReason": "Calibration sanitized: Missing required 8-dot calibration points: tl, tc, tr, ml, mr, bl, bc, br", "calibrationTrusted": false, "headPoseCompensated": true}', '2026-06-12 15:13:26.115+05:30', '2026-06-12 15:13:26.116+05:30');
INSERT INTO public."ProctoringLog" VALUES ('cmqaqo92l000zl7uois3fuao0', '23da61af-62cc-4868-a02a-1333999b7a46', 'VIOLATION_SCREEN_RECORDING_READY', 'MEDIUM', '{"endedAt": "2026-06-12T09:43:34.122Z", "mimeType": "video/webm;codecs=vp9", "sizeBytes": 664281, "startedAt": "2026-06-12T09:43:26.115Z", "durationMs": 8007, "eventCount": 1, "recordingId": "violation-recording-a6ff3721-7748-4859-a1cf-2d01dccef8de", "violationTypes": ["GAZE_AWAY"]}', '2026-06-12 15:13:34.124+05:30', '2026-06-12 15:13:34.125+05:30');
INSERT INTO public."ProctoringLog" VALUES ('cmqaqof0b0011l7uo9z2l8u4e', '23da61af-62cc-4868-a02a-1333999b7a46', 'GAZE_AWAY_DETECTED', 'MEDIUM', '{"source": "geometry", "yawDelta": -5.566669358683995, "direction": "up", "confidence": 0.3383035315966266, "pitchDelta": -0.0421712009872941, "thresholdX": 0.1397101840482589, "thresholdY": 0.104896242852074, "compensatedX": 0.2098005974715908, "compensatedY": -0.3383035315966266, "uncompensatedX": 0.2404672910584308, "uncompensatedY": -0.3383035315966266, "calibrationReason": "Calibration sanitized: Missing required 8-dot calibration points: tl, tc, tr, ml, mr, bl, bc, br", "calibrationTrusted": false, "headPoseCompensated": true}', '2026-06-12 15:13:41.817+05:30', '2026-06-12 15:13:41.819+05:30');
INSERT INTO public."ProctoringLog" VALUES ('cmqaqokkx0013l7uoa6cljcql', '23da61af-62cc-4868-a02a-1333999b7a46', 'TAB_SWITCH_DETECTED', 'HIGH', '{"reason": "window_blur", "trigger": "blur", "hasFocus": false, "startedAt": 1781257429040, "documentHidden": false, "visibilityState": "visible", "activeDurationMs": 0}', '2026-06-12 15:13:49.04+05:30', '2026-06-12 15:13:49.041+05:30');
INSERT INTO public."ProctoringLog" VALUES ('cmqaqol6s0015l7uoj00e8m5l', '23da61af-62cc-4868-a02a-1333999b7a46', 'VIOLATION_SCREEN_RECORDING_READY', 'MEDIUM', '{"endedAt": "2026-06-12T09:43:49.827Z", "mimeType": "video/webm;codecs=vp9", "sizeBytes": 447767, "startedAt": "2026-06-12T09:43:41.817Z", "durationMs": 8010, "eventCount": 2, "recordingId": "violation-recording-c3e5a657-de60-4932-99ad-4aad523246d4", "violationTypes": ["GAZE_AWAY", "TAB_SWITCH"]}', '2026-06-12 15:13:49.827+05:30', '2026-06-12 15:13:49.829+05:30');
INSERT INTO public."ProctoringLog" VALUES ('cmqaqon7e0017l7uofbdtog1c', '23da61af-62cc-4868-a02a-1333999b7a46', 'TAB_RETURNED', 'MEDIUM', '{"reason": "window_blur", "trigger": "focus", "hasFocus": true, "startedAt": 1781257429040, "durationMs": 3400, "returnedAt": 1781257432440, "documentHidden": false, "durationSeconds": 3.4, "visibilityState": "visible"}', '2026-06-12 15:13:52.441+05:30', '2026-06-12 15:13:52.442+05:30');
INSERT INTO public."ProctoringLog" VALUES ('cmqaqopfy0019l7uoo7xfk06d', '23da61af-62cc-4868-a02a-1333999b7a46', 'TAB_SWITCH_DETECTED', 'HIGH', '{"reason": "window_blur", "trigger": "blur", "hasFocus": false, "startedAt": 1781257435341, "documentHidden": false, "visibilityState": "visible", "activeDurationMs": 0}', '2026-06-12 15:13:55.341+05:30', '2026-06-12 15:13:55.342+05:30');
INSERT INTO public."ProctoringLog" VALUES ('cmqaqor9s001bl7uoosvxyt8w', '23da61af-62cc-4868-a02a-1333999b7a46', 'TAB_RETURNED', 'MEDIUM', '{"reason": "window_blur", "trigger": "focus", "hasFocus": true, "startedAt": 1781257435341, "durationMs": 2370, "returnedAt": 1781257437711, "documentHidden": false, "durationSeconds": 2.4, "visibilityState": "visible"}', '2026-06-12 15:13:57.711+05:30', '2026-06-12 15:13:57.712+05:30');
INSERT INTO public."ProctoringLog" VALUES ('cmqaqorrc001dl7uovkjwp3vr', '23da61af-62cc-4868-a02a-1333999b7a46', 'VIOLATION_SCREEN_RECORDING_READY', 'MEDIUM', '{"endedAt": "2026-06-12T09:43:58.342Z", "mimeType": "video/webm;codecs=vp9", "sizeBytes": 250364, "startedAt": "2026-06-12T09:43:55.341Z", "durationMs": 3001, "eventCount": 1, "recordingId": "violation-recording-3bbca0da-3481-4d1a-b90e-c62240175739", "violationTypes": ["TAB_SWITCH"]}', '2026-06-12 15:13:58.343+05:30', '2026-06-12 15:13:58.345+05:30');
INSERT INTO public."ProctoringLog" VALUES ('cmqaqot0g001fl7uouc6chfv3', '23da61af-62cc-4868-a02a-1333999b7a46', 'TAB_SWITCH_DETECTED', 'HIGH', '{"reason": "window_blur", "trigger": "blur", "hasFocus": false, "startedAt": 1781257439967, "documentHidden": false, "visibilityState": "visible", "activeDurationMs": 0}', '2026-06-12 15:13:59.967+05:30', '2026-06-12 15:13:59.968+05:30');
INSERT INTO public."ProctoringLog" VALUES ('cmqaqouyj001hl7uojfu8n123', '23da61af-62cc-4868-a02a-1333999b7a46', 'TAB_RETURNED', 'MEDIUM', '{"reason": "window_blur", "trigger": "focus", "hasFocus": true, "startedAt": 1781257439967, "durationMs": 2523, "returnedAt": 1781257442490, "documentHidden": false, "durationSeconds": 2.5, "visibilityState": "visible"}', '2026-06-12 15:14:02.49+05:30', '2026-06-12 15:14:02.491+05:30');
INSERT INTO public."ProctoringLog" VALUES ('cmqaqovdr001jl7uoegjmqqdg', '23da61af-62cc-4868-a02a-1333999b7a46', 'VIOLATION_SCREEN_RECORDING_READY', 'MEDIUM', '{"endedAt": "2026-06-12T09:44:03.037Z", "mimeType": "video/webm;codecs=vp9", "sizeBytes": 287219, "startedAt": "2026-06-12T09:43:59.967Z", "durationMs": 3070, "eventCount": 1, "recordingId": "violation-recording-ec48268c-c121-49bc-9ecc-c29a659e98c3", "violationTypes": ["TAB_SWITCH"]}', '2026-06-12 15:14:03.038+05:30', '2026-06-12 15:14:03.039+05:30');
INSERT INTO public."ProctoringLog" VALUES ('cmqaqoxmi001ll7uobj64v7uo', '23da61af-62cc-4868-a02a-1333999b7a46', 'GAZE_AWAY_DETECTED', 'MEDIUM', '{"source": "geometry", "yawDelta": -8.912616492846878, "direction": "up", "confidence": 0.1586288045901019, "pitchDelta": 2.00068931474701, "thresholdX": 0.1397101840482589, "thresholdY": 0.104896242852074, "compensatedX": 0.09428993151405614, "compensatedY": -0.1586288045901019, "uncompensatedX": 0.1584160964425249, "uncompensatedY": -0.1586288045901019, "calibrationReason": "Calibration sanitized: Missing required 8-dot calibration points: tl, tc, tr, ml, mr, bl, bc, br", "calibrationTrusted": false, "headPoseCompensated": true}', '2026-06-12 15:14:05.944+05:30', '2026-06-12 15:14:05.946+05:30');
INSERT INTO public."ProctoringLog" VALUES ('cmqaqp3t0001nl7uo5sj6kftt', '23da61af-62cc-4868-a02a-1333999b7a46', 'VIOLATION_SCREEN_RECORDING_READY', 'MEDIUM', '{"endedAt": "2026-06-12T09:44:13.953Z", "mimeType": "video/webm;codecs=vp9", "sizeBytes": 678627, "startedAt": "2026-06-12T09:44:05.944Z", "durationMs": 8009, "eventCount": 1, "recordingId": "violation-recording-e19efdbe-8d97-43d4-b6ae-0fd6d389bbda", "violationTypes": ["GAZE_AWAY"]}', '2026-06-12 15:14:13.955+05:30', '2026-06-12 15:14:13.957+05:30');
INSERT INTO public."ProctoringLog" VALUES ('cmqaqp9qi001pl7uol16fnhc5', '23da61af-62cc-4868-a02a-1333999b7a46', 'GAZE_AWAY_DETECTED', 'MEDIUM', '{"source": "geometry", "yawDelta": -8.097728348719322, "direction": "left", "confidence": 0.2648428570589614, "pitchDelta": 4.67532337848267, "thresholdX": 0.1397101840482589, "thresholdY": 0.104896242852074, "compensatedX": 0.2648428570589614, "compensatedY": -0.220409141086496, "uncompensatedX": 0.3208201405461547, "uncompensatedY": -0.2421623748713227, "calibrationReason": "Calibration sanitized: Missing required 8-dot calibration points: tl, tc, tr, ml, mr, bl, bc, br", "calibrationTrusted": false, "headPoseCompensated": true}', '2026-06-12 15:14:21.641+05:30', '2026-06-12 15:14:21.643+05:30');
INSERT INTO public."ProctoringLog" VALUES ('cmqaqpfwt001rl7uolbus9d3r', '23da61af-62cc-4868-a02a-1333999b7a46', 'VIOLATION_SCREEN_RECORDING_READY', 'MEDIUM', '{"endedAt": "2026-06-12T09:44:29.642Z", "mimeType": "video/webm;codecs=vp9", "sizeBytes": 329462, "startedAt": "2026-06-12T09:44:21.641Z", "durationMs": 8001, "eventCount": 1, "recordingId": "violation-recording-78ef1cfa-ff75-43a2-92e7-6daf9596029e", "violationTypes": ["GAZE_AWAY"]}', '2026-06-12 15:14:29.643+05:30', '2026-06-12 15:14:29.645+05:30');
INSERT INTO public."ProctoringLog" VALUES ('cmqaqpluw001tl7uon86mc9w1', '23da61af-62cc-4868-a02a-1333999b7a46', 'GAZE_AWAY_DETECTED', 'MEDIUM', '{"source": "geometry", "yawDelta": -8.815336371392373, "direction": "up", "confidence": 0.2554155000186367, "pitchDelta": 5.223691081140348, "thresholdX": 0.1397101840482589, "thresholdY": 0.104896242852074, "compensatedX": 0.2018285302991225, "compensatedY": -0.2554155000186367, "uncompensatedX": 0.2649818940130462, "uncompensatedY": -0.2826524108300402, "calibrationReason": "Calibration sanitized: Missing required 8-dot calibration points: tl, tc, tr, ml, mr, bl, bc, br", "calibrationTrusted": false, "headPoseCompensated": true}', '2026-06-12 15:14:37.351+05:30', '2026-06-12 15:14:37.353+05:30');
INSERT INTO public."ProctoringLog" VALUES ('cmqaqps37001vl7uo3s80yz39', '23da61af-62cc-4868-a02a-1333999b7a46', 'VIOLATION_SCREEN_RECORDING_READY', 'MEDIUM', '{"endedAt": "2026-06-12T09:44:45.425Z", "mimeType": "video/webm;codecs=vp9", "sizeBytes": 778497, "startedAt": "2026-06-12T09:44:37.351Z", "durationMs": 8074, "eventCount": 1, "recordingId": "violation-recording-9d5997dc-b9d8-4aaf-a8c4-dd940bb7754d", "violationTypes": ["GAZE_AWAY"]}', '2026-06-12 15:14:45.426+05:30', '2026-06-12 15:14:45.427+05:30');
INSERT INTO public."ProctoringLog" VALUES ('cmqaqptcg001xl7uovcbdk8pn', '23da61af-62cc-4868-a02a-1333999b7a46', 'FULLSCREEN_EXITED_DETECTED', 'HIGH', '{"reason": "fullscreen_exited", "trigger": "fullscreenchange", "hasFocus": true, "documentHidden": false, "visibilityState": "visible", "fullscreenElementPresent": false}', '2026-06-12 15:14:47.054+05:30', '2026-06-12 15:14:47.056+05:30');
INSERT INTO public."ProctoringLog" VALUES ('cmqaquao7001zl7uowus22eim', 'a6c33c19-ea17-4d3e-85da-b4b8c7f1f63a', 'CAMERA_PERMISSION_DENIED', 'HIGH', '{"message": "Permission denied"}', '2026-06-12 15:18:16.134+05:30', '2026-06-12 15:18:16.135+05:30');
INSERT INTO public."ProctoringLog" VALUES ('cmqaquars0022l7uolzjqz4qo', 'a6c33c19-ea17-4d3e-85da-b4b8c7f1f63a', 'CAMERA_OFF_DETECTED', 'HIGH', '{"reason": "Permission denied", "permissionDenied": true}', '2026-06-12 15:18:16.134+05:30', '2026-06-12 15:18:16.136+05:30');
INSERT INTO public."ProctoringLog" VALUES ('cmqaqub8y0024l7uof3hy7d4a', 'a6c33c19-ea17-4d3e-85da-b4b8c7f1f63a', 'TAB_SWITCH_DETECTED', 'HIGH', '{"reason": "document_hidden", "trigger": "visibilitychange", "hasFocus": true, "startedAt": 1781257696881, "documentHidden": true, "visibilityState": "hidden", "activeDurationMs": 0}', '2026-06-12 15:18:16.881+05:30', '2026-06-12 15:18:16.882+05:30');
INSERT INTO public."ProctoringLog" VALUES ('cmqaqumiw0027l7uoceyglhc5', 'a6c33c19-ea17-4d3e-85da-b4b8c7f1f63a', 'TAB_SWITCH_DETECTED', 'HIGH', '{"reason": "window_blur", "trigger": "blur", "hasFocus": false, "startedAt": 1781257711493, "documentHidden": false, "visibilityState": "visible", "activeDurationMs": 0}', '2026-06-12 15:18:31.494+05:30', '2026-06-12 15:18:31.495+05:30');
INSERT INTO public."ProctoringLog" VALUES ('cmqaquv88002al7uotyq1ttsf', 'a6c33c19-ea17-4d3e-85da-b4b8c7f1f63a', 'FULLSCREEN_REQUEST_FAILED', 'MEDIUM', '{"message": "Permissions check failed", "trigger": "camera_started", "userGestureRequired": true}', '2026-06-12 15:18:42.775+05:30', '2026-06-12 15:18:42.777+05:30');
INSERT INTO public."ProctoringLog" VALUES ('cmqaqv24l002cl7uo9auqw596', 'a6c33c19-ea17-4d3e-85da-b4b8c7f1f63a', 'TAB_SWITCH_DETECTED', 'HIGH', '{"reason": "window_blur", "trigger": "blur", "hasFocus": false, "startedAt": 1781257731716, "documentHidden": false, "visibilityState": "visible", "activeDurationMs": 0}', '2026-06-12 15:18:51.717+05:30', '2026-06-12 15:18:51.718+05:30');
INSERT INTO public."ProctoringLog" VALUES ('cmqaqv3py002el7uokxotqd09', 'a6c33c19-ea17-4d3e-85da-b4b8c7f1f63a', 'TAB_RETURNED', 'MEDIUM', '{"reason": "window_blur", "trigger": "focus", "hasFocus": true, "startedAt": 1781257731716, "durationMs": 2065, "returnedAt": 1781257733781, "documentHidden": false, "durationSeconds": 2.1, "visibilityState": "visible"}', '2026-06-12 15:18:53.781+05:30', '2026-06-12 15:18:53.783+05:30');
INSERT INTO public."ProctoringLog" VALUES ('cmqaqv3qx002gl7uoe5togkkr', 'a6c33c19-ea17-4d3e-85da-b4b8c7f1f63a', 'TAB_SWITCH_DETECTED', 'HIGH', '{"reason": "window_blur", "trigger": "blur", "hasFocus": false, "startedAt": 1781257733816, "documentHidden": false, "visibilityState": "visible", "activeDurationMs": 0}', '2026-06-12 15:18:53.817+05:30', '2026-06-12 15:18:53.818+05:30');
INSERT INTO public."ProctoringLog" VALUES ('cmqaqv3wp002il7uoe0ig24ad', 'a6c33c19-ea17-4d3e-85da-b4b8c7f1f63a', 'PRE_INTERVIEW_SCREEN_SHARE_CONFIRMED', 'MEDIUM', '{"trigger": "user_interaction", "completedAt": 1781257734024, "requestedAt": 1781257729824, "screenShareRequired": true}', '2026-06-12 15:18:54.024+05:30', '2026-06-12 15:18:54.025+05:30');
INSERT INTO public."ProctoringLog" VALUES ('cmqaqv3ws002kl7uowg99x4rk', 'a6c33c19-ea17-4d3e-85da-b4b8c7f1f63a', 'TAB_RETURNED', 'MEDIUM', '{"reason": "window_blur", "trigger": "focus", "hasFocus": true, "startedAt": 1781257733816, "durationMs": 212, "returnedAt": 1781257734028, "documentHidden": false, "durationSeconds": 0.2, "visibilityState": "visible"}', '2026-06-12 15:18:54.028+05:30', '2026-06-12 15:18:54.029+05:30');
INSERT INTO public."ProctoringLog" VALUES ('cmqaqv3xe002ml7uo3zx2orwq', 'a6c33c19-ea17-4d3e-85da-b4b8c7f1f63a', 'PRE_INTERVIEW_FULLSCREEN_CONFIRMED', 'MEDIUM', '{"trigger": "user_interaction", "enteredAt": 1781257734049, "requestedAt": 1781257734024}', '2026-06-12 15:18:54.049+05:30', '2026-06-12 15:18:54.05+05:30');
INSERT INTO public."ProctoringLog" VALUES ('cmqaqv3xx002ol7uoa5b8m1w3', 'a6c33c19-ea17-4d3e-85da-b4b8c7f1f63a', 'FULLSCREEN_ENTERED', 'MEDIUM', '{"trigger": "fullscreenchange"}', '2026-06-12 15:18:54.068+05:30', '2026-06-12 15:18:54.069+05:30');
INSERT INTO public."ProctoringLog" VALUES ('cmqaqvxku002ql7uo5560zt8i', 'a6c33c19-ea17-4d3e-85da-b4b8c7f1f63a', 'GAZE_AWAY_DETECTED', 'MEDIUM', '{"source": "geometry", "yawDelta": 0.3251868975067023, "direction": "up", "confidence": 0.1208309656858239, "pitchDelta": -2.227549020600322, "thresholdX": 0.136116141105587, "thresholdY": 0.08, "compensatedX": 0.1018291171982106, "compensatedY": -0.1208309656858239, "uncompensatedX": 0.1018291171982106, "uncompensatedY": -0.1208309656858239, "calibrationReason": "Calibration sanitized: Missing required 8-dot calibration points: tl, tc, tr, ml, mr, bl, bc, br", "calibrationTrusted": false, "headPoseCompensated": false}', '2026-06-12 15:19:32.477+05:30', '2026-06-12 15:19:32.479+05:30');
INSERT INTO public."ProctoringLog" VALUES ('cmqaqw3rg002sl7uonppqb7ms', 'a6c33c19-ea17-4d3e-85da-b4b8c7f1f63a', 'VIOLATION_SCREEN_RECORDING_READY', 'MEDIUM', '{"endedAt": "2026-06-12T09:49:40.488Z", "mimeType": "video/webm;codecs=vp9", "sizeBytes": 985064, "startedAt": "2026-06-12T09:49:32.477Z", "durationMs": 8011, "eventCount": 1, "recordingId": "violation-recording-ca71f0c7-efb8-4b88-be56-455dddf8df90", "violationTypes": ["GAZE_AWAY"]}', '2026-06-12 15:19:40.49+05:30', '2026-06-12 15:19:40.492+05:30');
INSERT INTO public."ProctoringLog" VALUES ('cmqaqw9ow002ul7uoniqtq7wx', 'a6c33c19-ea17-4d3e-85da-b4b8c7f1f63a', 'GAZE_AWAY_DETECTED', 'MEDIUM', '{"source": "geometry", "yawDelta": 0.2892328820412722, "direction": "left", "confidence": 0.2760998429538927, "pitchDelta": -4.096369557016247, "thresholdX": 0.136116141105587, "thresholdY": 0.08, "compensatedX": 0.2760998429538927, "compensatedY": -0.09662915470721764, "uncompensatedX": 0.2760998429538927, "uncompensatedY": -0.1125928502773801, "calibrationReason": "Calibration sanitized: Missing required 8-dot calibration points: tl, tc, tr, ml, mr, bl, bc, br", "calibrationTrusted": false, "headPoseCompensated": true}', '2026-06-12 15:19:48.175+05:30', '2026-06-12 15:19:48.176+05:30');
INSERT INTO public."ProctoringLog" VALUES ('cmqaqwqzw002wl7uo00p4g6th', 'a6c33c19-ea17-4d3e-85da-b4b8c7f1f63a', 'GAZE_AWAY_DETECTED', 'MEDIUM', '{"source": "geometry", "yawDelta": 1.141020720494915, "direction": "left", "confidence": 0.2801625454382587, "pitchDelta": -5.756407150498365, "thresholdX": 0.136116141105587, "thresholdY": 0.08, "compensatedX": 0.2801625454382587, "compensatedY": -0.1109322654653121, "uncompensatedX": 0.2801625454382587, "uncompensatedY": -0.1434963369702958, "calibrationReason": "Calibration sanitized: Missing required 8-dot calibration points: tl, tc, tr, ml, mr, bl, bc, br", "calibrationTrusted": false, "headPoseCompensated": true}', '2026-06-12 15:20:10.602+05:30', '2026-06-12 15:20:10.604+05:30');
INSERT INTO public."ProctoringLog" VALUES ('cmqaqwr03002yl7uou933v97f', 'a6c33c19-ea17-4d3e-85da-b4b8c7f1f63a', 'TAB_SWITCH_DETECTED', 'HIGH', '{"reason": "window_blur", "trigger": "blur", "hasFocus": false, "startedAt": 1781257810610, "documentHidden": false, "visibilityState": "visible", "activeDurationMs": 0}', '2026-06-12 15:20:10.61+05:30', '2026-06-12 15:20:10.611+05:30');
INSERT INTO public."ProctoringLog" VALUES ('cmqaqwr060030l7uottoele83', 'a6c33c19-ea17-4d3e-85da-b4b8c7f1f63a', 'TAB_RETURNED', 'MEDIUM', '{"reason": "window_blur", "trigger": "focus", "hasFocus": true, "startedAt": 1781257810610, "durationMs": 3, "returnedAt": 1781257810613, "documentHidden": false, "durationSeconds": 0, "visibilityState": "visible"}', '2026-06-12 15:20:10.613+05:30', '2026-06-12 15:20:10.615+05:30');
INSERT INTO public."ProctoringLog" VALUES ('cmqaqwr0v0034l7uo03v95wvw', 'a6c33c19-ea17-4d3e-85da-b4b8c7f1f63a', 'VIOLATION_SCREEN_RECORDING_READY', 'MEDIUM', '{"endedAt": "2026-06-12T09:50:10.634Z", "mimeType": "video/webm;codecs=vp9,opus", "sizeBytes": 45014, "startedAt": "2026-06-12T09:50:10.627Z", "durationMs": 7, "eventCount": 1, "recordingId": "violation-recording-e5b868f4-2610-4c38-a066-ef103eff3db5", "violationTypes": ["FULLSCREEN_EXIT"]}', '2026-06-12 15:20:10.637+05:30', '2026-06-12 15:20:10.639+05:30');


--
-- Data for Name: Question; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Question" VALUES ('q-d376edb5-3256-4a61-9811-f7dc7aaf528c', 'cbc684c2-63f6-4a66-ab4e-4f795fbe97a3', 'b52cd6ff-98b2-4d94-8dd1-f9ed36f7d656', 'How would you prioritize between improving platform reliability vs. adding new features for clients?', '{GENERAL}', 'MEDIUM', '{"AI Generated Vetting Rubric"}', 4, 'Evaluate response for topic: AI Generated Vetting Rubric', 0, 1, true, '2026-06-12 12:36:43.799499+05:30', '2026-06-12 12:38:49.279+05:30');
INSERT INTO public."Question" VALUES ('q-05d96f62-7a42-4bb8-9640-c5b85eed6406', 'cbc684c2-63f6-4a66-ab4e-4f795fbe97a3', 'b52cd6ff-98b2-4d94-8dd1-f9ed36f7d656', 'Describe a case where you had to balance technical debt reduction with business demands.', '{GENERAL}', 'MEDIUM', '{"AI Generated Vetting Rubric"}', 4, 'Evaluate response for topic: AI Generated Vetting Rubric', 0, 1, true, '2026-06-12 12:36:43.799499+05:30', '2026-06-12 12:38:49.281+05:30');
INSERT INTO public."Question" VALUES ('q-dd2abca2-903f-418f-b131-bb5905908e50', 'cbc684c2-63f6-4a66-ab4e-4f795fbe97a3', 'b52cd6ff-98b2-4d94-8dd1-f9ed36f7d656', 'Walk through how you would design a real-time trade settlement system handling $4B/day.', '{GENERAL}', 'MEDIUM', '{"AI Generated Vetting Rubric"}', 4, 'Evaluate response for topic: AI Generated Vetting Rubric', 0, 1, true, '2026-06-12 12:36:43.799499+05:30', '2026-06-12 12:38:49.283+05:30');
INSERT INTO public."Question" VALUES ('q-1d7fd49b-fd83-4ea2-ad1c-46fdbdf6f3cd', 'cbc684c2-63f6-4a66-ab4e-4f795fbe97a3', 'b52cd6ff-98b2-4d94-8dd1-f9ed36f7d656', 'Explain how you would approach a postmortem for a production incident and what structural changes you would recommend.', '{GENERAL}', 'MEDIUM', '{"AI Generated Vetting Rubric"}', 4, 'Evaluate response for topic: AI Generated Vetting Rubric', 0, 1, true, '2026-06-12 12:36:43.799499+05:30', '2026-06-12 12:38:49.284+05:30');
INSERT INTO public."Question" VALUES ('cmqalc5j40002l7tgnwifgps8', 'cbc684c2-63f6-4a66-ab4e-4f795fbe97a3', '06cdc83e-33fa-4c3e-a915-42108dd18b65', 'Describe a time you handled a difficult customer call. How did you resolve the issue?', '{GENERAL}', 'MEDIUM', '{"AI Generated Vetting Rubric"}', 4, 'Evaluate response for topic: AI Generated Vetting Rubric', 0, 1, true, '2026-06-12 12:44:11.585+05:30', '2026-06-12 15:11:59.219+05:30');
INSERT INTO public."Question" VALUES ('cmqalc5j80004l7tg8hwcixsz', 'cbc684c2-63f6-4a66-ab4e-4f795fbe97a3', '06cdc83e-33fa-4c3e-a915-42108dd18b65', 'How do you prioritize and manage technical support tickets when multiple come in at once?', '{GENERAL}', 'MEDIUM', '{"AI Generated Vetting Rubric"}', 4, 'Evaluate response for topic: AI Generated Vetting Rubric', 0, 1, true, '2026-06-12 12:44:11.589+05:30', '2026-06-12 15:11:59.226+05:30');
INSERT INTO public."Question" VALUES ('cmqalc5jb0006l7tgcwkldqoy', 'cbc684c2-63f6-4a66-ab4e-4f795fbe97a3', '06cdc83e-33fa-4c3e-a915-42108dd18b65', 'Walk me through how you would troubleshoot a customer unable to log into a SaaS platform.', '{GENERAL}', 'MEDIUM', '{"AI Generated Vetting Rubric"}', 4, 'Evaluate response for topic: AI Generated Vetting Rubric', 0, 1, true, '2026-06-12 12:44:11.591+05:30', '2026-06-12 15:11:59.231+05:30');
INSERT INTO public."Question" VALUES ('cmqalc5je0008l7tg21bymdo3', 'cbc684c2-63f6-4a66-ab4e-4f795fbe97a3', '06cdc83e-33fa-4c3e-a915-42108dd18b65', 'What steps would you take to learn a new software product quickly to support customers?', '{GENERAL}', 'MEDIUM', '{"AI Generated Vetting Rubric"}', 4, 'Evaluate response for topic: AI Generated Vetting Rubric', 0, 1, true, '2026-06-12 12:44:11.594+05:30', '2026-06-12 15:11:59.235+05:30');
INSERT INTO public."Question" VALUES ('cmqakehmm000al7z0jah7fih5', 'cmq6p9edn0000l72wl889b8bq', 'cmqakehlq0002l7z0igkdjf8y', 'Describe how you would design a simple URL shortener.', '{GENERAL}', 'MEDIUM', '{"system design",backend}', 4, '{"questionType":"system_design","modelAnswer":"A simple URL shortener needs an API to create a short code for a long URL and another API to redirect from the code to the long URL. Store mappings in a database with fields like code, long URL, created time, and optional expiry. Generate unique codes using hashing, random IDs, or an incrementing ID encoded in base62, and handle collisions. Discuss redirects, validation, analytics, caching for popular links, and basic abuse prevention.","rubric":{"requiredPoints":[{"id":"core_apis","description":"Defines create-short-link and redirect APIs.","keywords":["api","create","redirect","short","long url"],"weight":25},{"id":"storage_mapping","description":"Stores short code to long URL mapping in a database.","keywords":["database","store","mapping","code","url"],"weight":25},{"id":"unique_code_generation","description":"Explains unique code generation and collision handling.","keywords":["unique","code","hash","base62","collision"],"weight":25}],"secondaryPoints":[{"id":"cache_analytics_expiry","description":"Mentions caching, analytics, expiry, or validation.","keywords":["cache","analytics","expiry","validation"],"weight":15}],"excellentAnswerSignals":[{"id":"abuse_and_scale","description":"Mentions abuse prevention or scaling popular redirects.","keywords":["abuse","rate limit","scale","popular"],"weight":10}],"redFlags":[{"id":"no_persistence","description":"Design has no persistence for URL mappings.","severity":"high"}]}}', 0, 1, true, '2026-06-12 12:18:00.958+05:30', '2026-06-12 15:18:42.275+05:30');
INSERT INTO public."Question" VALUES ('cmqakehm30004l7z0z912v6wa', 'cmq6p9edn0000l72wl889b8bq', 'cmqakehlq0002l7z0igkdjf8y', 'Explain the difference between an array and a linked list. When would you choose one over the other?', '{GENERAL}', 'EASY', '{"data structures",fundamentals}', 4, '{"questionType":"technical_theory","modelAnswer":"Arrays store elements contiguously and allow O(1) index access, but insertion or deletion in the middle can be O(n). Linked lists store nodes with references, so insertion or deletion can be O(1) when the node is known, but random access is O(n) and there is extra pointer memory overhead. Choose arrays for fast indexing and cache locality; choose linked lists when frequent insertions or deletions are needed and traversal is acceptable.","rubric":{"requiredPoints":[{"id":"array_contiguous_indexing","description":"Arrays use contiguous storage and support fast index-based access.","keywords":["contiguous","index","o(1)","random access"],"weight":30},{"id":"linked_list_nodes","description":"Linked lists use nodes and references/pointers rather than contiguous storage.","keywords":["node","pointer","reference","linked"],"weight":25},{"id":"operation_tradeoffs","description":"Explains insertion/deletion and access-time tradeoffs.","keywords":["insert","delete","o(n)","o(1)","access"],"weight":30}],"secondaryPoints":[{"id":"memory_cache_tradeoff","description":"Mentions memory overhead or cache locality.","keywords":["memory","cache","overhead","locality"],"weight":10}],"excellentAnswerSignals":[{"id":"use_case_choice","description":"Gives a clear rule for choosing one structure over the other.","keywords":["choose","when","frequent","indexing"],"weight":10}],"redFlags":[{"id":"claims_same_structure","description":"Claims arrays and linked lists are essentially the same structure.","severity":"high"}]}}', 0, 1, true, '2026-06-12 12:18:00.94+05:30', '2026-06-12 15:18:42.265+05:30');
INSERT INTO public."Question" VALUES ('cmqakehm80006l7z08ie58c54', 'cmq6p9edn0000l72wl889b8bq', 'cmqakehlq0002l7z0igkdjf8y', 'What is time complexity, and why does it matter when writing code?', '{GENERAL}', 'EASY', '{algorithms,complexity}', 4, '{"questionType":"technical_theory","modelAnswer":"Time complexity describes how an algorithm’s running time grows as input size grows, usually using Big O notation such as O(1), O(log n), O(n), or O(n squared). It matters because code that works on small inputs may become too slow on large inputs. Engineers use it to compare approaches, choose efficient algorithms, and understand scalability.","rubric":{"requiredPoints":[{"id":"growth_with_input","description":"Defines complexity as runtime growth relative to input size.","keywords":["input","size","grow","runtime","running time"],"weight":35},{"id":"big_o","description":"Mentions Big O or common complexity classes.","keywords":["big o","o(n)","o(1)","o(log","o(n^2)"],"weight":25},{"id":"scalability_reason","description":"Explains why complexity matters for larger inputs and scalability.","keywords":["large","slow","scale","scalability","efficient"],"weight":30}],"secondaryPoints":[{"id":"compare_approaches","description":"Uses complexity to compare possible implementations.","keywords":["compare","approach","algorithm","choose"],"weight":10}],"excellentAnswerSignals":[{"id":"concrete_example","description":"Gives a concrete example such as nested loops or binary search.","keywords":["example","nested","binary search","loop"],"weight":10}],"redFlags":[{"id":"only_actual_seconds","description":"Defines complexity only as exact seconds on one machine.","severity":"medium"}]}}', 0, 1, true, '2026-06-12 12:18:00.945+05:30', '2026-06-12 15:18:42.268+05:30');
INSERT INTO public."Question" VALUES ('cmqakehmf0008l7z0bwc530mp', 'cmq6p9edn0000l72wl889b8bq', 'cmqakehlq0002l7z0igkdjf8y', 'How would you debug an API endpoint that is returning a 500 error?', '{GENERAL}', 'MEDIUM', '{debugging,backend}', 4, '{"questionType":"technical_theory","modelAnswer":"Start by reproducing the request and checking logs, stack traces, and recent changes. Verify inputs, request body, authentication, database calls, environment variables, and downstream services. Add targeted logging or use a debugger, isolate the failing layer, write or update a test once the issue is understood, and return a safe error response without leaking internal details.","rubric":{"requiredPoints":[{"id":"reproduce_and_logs","description":"Reproduces the issue and checks logs or stack traces.","keywords":["reproduce","logs","stack trace","trace"],"weight":30},{"id":"check_inputs_dependencies","description":"Checks request inputs and dependencies such as database or downstream services.","keywords":["input","request","database","dependency","service"],"weight":30},{"id":"isolate_fix_verify","description":"Isolates the failing layer, fixes it, and verifies with testing.","keywords":["isolate","debugger","test","verify","fix"],"weight":25}],"secondaryPoints":[{"id":"safe_error_handling","description":"Mentions safe errors and avoiding leaked internals.","keywords":["safe","error","leak","internal"],"weight":10}],"excellentAnswerSignals":[{"id":"recent_changes_observability","description":"Mentions recent deploys, metrics, or observability.","keywords":["recent","deploy","metrics","observability"],"weight":10}],"redFlags":[{"id":"guess_without_logs","description":"Suggests changing random code without checking logs or reproducing.","severity":"medium"}]}}', 0, 1, true, '2026-06-12 12:18:00.95+05:30', '2026-06-12 15:18:42.272+05:30');


--
-- Data for Name: applicants; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.applicants VALUES ('0120f4e8-ed44-4482-a9a7-c1080a3fef2d', 'Ines Caetano', 'ines@design.io', NULL, 'scheduled', NULL, NULL, '79150b56-8b1a-4a35-8b81-79456bd50f07', false, false, false, 'scheduled', 87, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-05 23:07:25.867257+05:30', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO public.applicants VALUES ('47ab4017-a8a3-4f5d-9066-60c647db1045', 'Devasri Bali', 'devasri@company.com', NULL, 'direct_link', NULL, NULL, '79150b56-8b1a-4a35-8b81-79456bd50f07', false, false, false, NULL, NULL, NULL, 'completed', 96, NULL, 'low', '#', NULL, NULL, NULL, NULL, '2026-06-05 23:07:25.867257+05:30', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO public.applicants VALUES ('9b6b5afb-dfe9-4c34-85d5-057ddd90c98c', '2026 Global Markets Algo Strategies Internship Jd Bits Pilani', '2026.global.markets.algo.strategies.internship.jd.bits.pilani@candidate.io', '+1 555-0199', 'bulk_upload', 'uploads/resumes/2026 Global Markets - Algo Strategies Internship JD_BITS Pilani.pdf', NULL, 'ef10e239-f67c-49fe-9740-fc96605dad4a', false, false, false, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-08 23:09:49.392581+05:30', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO public.applicants VALUES ('c4beb110-f141-4b0f-8441-8bf3524a77d7', 'Aditya Rana', 'aditya@interviehire.com', NULL, 'direct_link', NULL, NULL, 'cc9d80a3-f778-44d2-863c-c0e809aaab56', false, false, false, NULL, NULL, NULL, 'completed', 94, NULL, 'low', '#', NULL, NULL, NULL, NULL, '2026-06-05 23:07:25.867257+05:30', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO public.applicants VALUES ('e2fcc0fa-62e6-4866-a587-5068f5d568aa', 'Software Engineer Mock V2', 'software.engineer.mock.v2@candidate.io', '+1 555-0199', 'scheduled', 'uploads/resumes/Software_Engineer_Mock_Resume-v2.pdf', NULL, 'ef10e239-f67c-49fe-9740-fc96605dad4a', false, false, false, 'scheduled', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-08 23:07:41.197047+05:30', NULL, NULL, '2026-06-10 10:00:00', NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO public.applicants VALUES ('ee9552c0-37f2-4c23-abd7-b58c8eac059e', 'Software Engineer Mock V2', 'software.engineer.mock.v2@candidate.io', '+1 555-0199', 'bulk_upload', 'uploads/resumes/Software_Engineer_Mock_Resume-v2.pdf', NULL, 'cc9d80a3-f778-44d2-863c-c0e809aaab56', false, false, false, 'pending', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-08 21:40:43.008512+05:30', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO public.applicants VALUES ('f20d9559-44ad-4086-889f-2c1b6f2d9c55', 'Ps Ii Sem I 26 27 At Intel Software, Bengaluru', 'ps.ii.sem.i.26.27.at.intel.software,.bengaluru@candidate.io', '+1 555-0199', 'scheduled', 'uploads/resumes/PS-II Sem I 26-27 at Intel Software, Bengaluru.pdf', 'Rejected', 'cc9d80a3-f778-44d2-863c-c0e809aaab56', false, false, false, 'pending', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-08 23:01:23.036058+05:30', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO public.applicants VALUES ('f28a3edf-edbc-419a-b05d-2317cdb94449', 'Ps Ii Sem I 26 27 At Intel Software, Bengaluru', 'ps.ii.sem.i.26.27.at.intel.software,.bengaluru@candidate.io', '+1 555-0199', 'scheduled', 'uploads/resumes/PS-II Sem I 26-27 at Intel Software, Bengaluru.pdf', NULL, 'ef10e239-f67c-49fe-9740-fc96605dad4a', false, false, false, 'pending', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-08 23:09:33.443996+05:30', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO public.applicants VALUES ('f2ffd671-1e94-4c7f-9be4-a58b5ba323f3', 'Emily Watson', 'emily@design.io', NULL, 'career_page', NULL, NULL, '97805184-54a1-4aad-8078-d42e8a77eb8c', false, false, false, NULL, NULL, NULL, 'completed', 89, NULL, 'low', '#', NULL, NULL, NULL, NULL, '2026-06-05 23:07:25.867257+05:30', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO public.applicants VALUES ('c449fc1a-1642-42ef-abad-4852f787fea0', 'Marcus Thorne', 'marcus.thorne.pm@email.com', '+1 (555) 567-8901', 'bulk_upload', 'uploads/resumes/resume_project_manager_scrum_master.pdf', NULL, 'b52cd6ff-98b2-4d94-8dd1-f9ed36f7d656', true, false, false, 'scheduled', 84, '2026-06-12 13:00:00+05:30', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, '2026-06-11 17:07:22.966821+05:30', NULL, NULL, NULL, '{"mustHaveMatches":[{"criteria":"8+ years of product management experience","met":false,"reason":"Resume shows 5+ years of project management experience, not product management."},{"criteria":"3+ years owning platform/infrastructure products in a senior role","met":false,"reason":"No evidence of owning platform/infrastructure products; experience is in project management."},{"criteria":"Experience in fintech, banking, or insurance regulated environment","met":false,"reason":"No mention of fintech, banking, or insurance; financial enterprise clients are not explicitly regulated."}],"goodToHaveMatches":[{"criteria":"Background in financial services: trade lifecycle, clearing, settlement, or custody","met":false,"reason":"No experience in trade lifecycle, clearing, settlement, or custody."},{"criteria":"MBA or CFA","met":false,"reason":"Resume shows Bachelor''s degree; no MBA or CFA mentioned."},{"criteria":"Experience managing through major production incidents with structural changes","met":false,"reason":"No mention of managing production incidents."}],"redFlagsDetected":[{"flag":"No experience with platform or infrastructure products","detected":true,"reason":"Experience is in project management, not product management for platforms/infrastructure."},{"flag":"Lacks any understanding of databases or query performance","detected":true,"reason":"No mention of database schema, query performance, or technical depth."},{"flag":"No experience managing PMs or leading teams","detected":false,"reason":"Managed 3 scrum squads, but not PMs; role is project manager, not product manager."}],"summary":"The candidate has 5+ years of project management experience but lacks the required product management background, platform/infrastructure ownership, and technical depth for a Director of Product Management role. No experience in fintech or regulated environments, and no evidence of managing PMs or understanding databases.","experienceYears":"5 years","skills":{"detected":["Agile","Scrum","Kanban","Jira","Confluence","Asana","MS Project","Stakeholder Communication","Risk Management","Cross-functional Management"],"matched":[],"missing":["Product Management","Platform/Infrastructure Products","Database Schema","Query Performance","Regulated Environment","Team Leadership of PMs","OKR Cycles","Client Management"]},"scorecard":{"technical":2,"experience":3,"communication":6,"cultureFit":4},"recommendation":"Reject","recommendationReason":"Does not meet must-have criteria: lacks 8+ years of product management, platform/infrastructure ownership, and regulated environment experience.","matchScore":0}', '568227ae-ac7e-4d5a-9ed9-614c345c0706', 'sim-cal-63e30e46-a052-492a-9b11-0b83a1266c8c', NULL, NULL, 0);


--
-- Data for Name: interview_reports; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: job_collaborators; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.job_collaborators VALUES ('977d2951-62eb-48a8-a3a8-50393916ab60', '79150b56-8b1a-4a35-8b81-79456bd50f07', '0dd62c89-a9a1-4668-8084-74e6367f16bf', '2026-06-05 23:07:25.867257+05:30');
INSERT INTO public.job_collaborators VALUES ('492e71ec-b317-4b89-b7f9-b12d9b52b81a', '79150b56-8b1a-4a35-8b81-79456bd50f07', 'b661b0e7-1dc9-427c-aead-835b9336e851', '2026-06-05 23:07:25.867257+05:30');
INSERT INTO public.job_collaborators VALUES ('fc190ff1-a3f8-448c-82d2-7c3883416d59', 'cc9d80a3-f778-44d2-863c-c0e809aaab56', '0dd62c89-a9a1-4668-8084-74e6367f16bf', '2026-06-05 23:07:25.867257+05:30');
INSERT INTO public.job_collaborators VALUES ('b9e551e8-58a2-4466-80a5-c194796dc89c', 'ef10e239-f67c-49fe-9740-fc96605dad4a', 'b661b0e7-1dc9-427c-aead-835b9336e851', '2026-06-05 23:07:25.867257+05:30');
INSERT INTO public.job_collaborators VALUES ('4a1d420b-2c7d-4c54-9d17-52cc846c0718', '97805184-54a1-4aad-8078-d42e8a77eb8c', '6d483371-e23b-4384-a9e3-55f9b996c2fa', '2026-06-05 23:07:25.867257+05:30');
INSERT INTO public.job_collaborators VALUES ('0ae17e65-6086-43e9-9caf-bc1fff77dfca', '97805184-54a1-4aad-8078-d42e8a77eb8c', '04c13488-c59b-4a15-9309-a9f90ba5c386', '2026-06-05 23:07:25.867257+05:30');
INSERT INTO public.job_collaborators VALUES ('187d7d1d-a60e-4be1-a299-5c5dcb4fd3b1', 'a24180f7-9541-42d4-a89b-70d2c3b7c5b7', '6d483371-e23b-4384-a9e3-55f9b996c2fa', '2026-06-05 23:07:25.867257+05:30');
INSERT INTO public.job_collaborators VALUES ('d08a6680-6481-44f6-920d-1023ad574dad', '865ceb65-07b9-46fa-943e-ac03eea5825d', '04c13488-c59b-4a15-9309-a9f90ba5c386', '2026-06-05 23:07:25.867257+05:30');
INSERT INTO public.job_collaborators VALUES ('1cd91e1c-bc39-4cfb-a73d-d611f0e21ac4', 'b52cd6ff-98b2-4d94-8dd1-f9ed36f7d656', '48d1c50c-af82-41c3-a5a0-dd1e677e1772', '2026-06-11 15:34:09.640359+05:30');
INSERT INTO public.job_collaborators VALUES ('be4dc479-835c-488c-8cbd-75e35c55c328', '06cdc83e-33fa-4c3e-a915-42108dd18b65', '48d1c50c-af82-41c3-a5a0-dd1e677e1772', '2026-06-12 11:48:47.41378+05:30');


--
-- Data for Name: jobs; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.jobs VALUES ('cc9d80a3-f778-44d2-863c-c0e809aaab56', 'AKRO62EF45E26DF5', 'Full Stack Developer Hiring - Demo', 'Full Stack Developer', 'published', '1-4 Years', NULL, NULL, NULL, NULL, true, NULL, NULL, NULL, NULL, true, true, true, '48d1c50c-af82-41c3-a5a0-dd1e677e1772', '2026-06-05 23:07:25.858572+05:30', NULL, 'cbc684c2-63f6-4a66-ab4e-4f795fbe97a3');
INSERT INTO public.jobs VALUES ('ef10e239-f67c-49fe-9740-fc96605dad4a', 'AKRO62EF45E26NEW', 'DevOps Engineer Hiring - Demo', 'DevOps Engineer', 'published', '2-5 Years', NULL, NULL, NULL, NULL, true, NULL, NULL, NULL, NULL, true, true, true, '48d1c50c-af82-41c3-a5a0-dd1e677e1772', '2026-06-05 23:07:25.858572+05:30', NULL, 'cbc684c2-63f6-4a66-ab4e-4f795fbe97a3');
INSERT INTO public.jobs VALUES ('97805184-54a1-4aad-8078-d42e8a77eb8c', 'DESN99F12345E67A', 'Lead UI/UX Designer Position', 'UI/UX Designer', 'published', '3-6 Years', NULL, NULL, NULL, NULL, true, NULL, NULL, NULL, NULL, true, true, true, '771ac546-dc8e-4097-93f6-14e0ca65e2d7', '2026-06-05 23:07:25.858572+05:30', NULL, '662d3d2f-9aca-4cc0-8acc-80aaf031d243');
INSERT INTO public.jobs VALUES ('a24180f7-9541-42d4-a89b-70d2c3b7c5b7', 'DESN99F12345E67B', 'Product Designer Position', 'Product Designer', 'published', '2-4 Years', NULL, NULL, NULL, NULL, true, NULL, NULL, NULL, NULL, true, true, true, '771ac546-dc8e-4097-93f6-14e0ca65e2d7', '2026-06-05 23:07:25.858572+05:30', NULL, '662d3d2f-9aca-4cc0-8acc-80aaf031d243');
INSERT INTO public.jobs VALUES ('865ceb65-07b9-46fa-943e-ac03eea5825d', 'DESN99F12345E67C', 'Graphic Designer Position', 'Graphic Designer', 'published', '0-2 Years', NULL, NULL, NULL, NULL, true, NULL, NULL, NULL, NULL, true, true, true, '771ac546-dc8e-4097-93f6-14e0ca65e2d7', '2026-06-05 23:07:25.858572+05:30', NULL, '662d3d2f-9aca-4cc0-8acc-80aaf031d243');
INSERT INTO public.jobs VALUES ('79150b56-8b1a-4a35-8b81-79456bd50f07', 'AKRO62EF45E26EA1', 'Government Tender & Proposal Executive..', 'Government Tender & Proposal Executive', 'published', 'Upto 2 Years', NULL, '', NULL, NULL, true, '{"mustHave": [], "redFlags": [], "goodToHave": [], "goodToHaveMinMatch": 1}', NULL, '{"topics": [{"name": "AI Generated Vetting Rubric", "type": "Theoretical", "difficulty": "Medium", "questions": []}]}', NULL, true, true, true, '48d1c50c-af82-41c3-a5a0-dd1e677e1772', '2026-06-05 23:07:25.858572+05:30', '2026-06-08 11:49:11.766117+05:30', 'cbc684c2-63f6-4a66-ab4e-4f795fbe97a3');
INSERT INTO public.jobs VALUES ('b52cd6ff-98b2-4d94-8dd1-f9ed36f7d656', NULL, 'Director of Product Management - Fintech Platform', 'Director, Product Management Enterprise Platforms & Core Infrastructure', 'published', '5+ Years', NULL, 'Job overview
Quorum Financial Group seeks a Director of Product Management to own the core enterprise platform handling $4B+ daily transaction volume. Set product vision for internal developer platforms and client-facing infrastructure while leading a team of four PMs and driving cross-functional alignment.

Key responsibilities
- Own multi-year roadmap for core settlement, custody, and reconciliation infrastructure
- Define product strategy for internal developer platforms: shared APIs, SDKs, and tooling
- Drive quarterly OKR cycles for the product pod with rigorous tracking
- Manage relationships with 8–10 Tier 1 institutional clients, presenting roadmap to CTOs
- Hire, coach, and level four PMs, including senior and opinionated team members

Requirements
- 8+ years in product management, with at least 3 years owning platform/infrastructure products
- Ability to read a database schema and discuss query performance meaningfully
- Experience in a regulated environment (fintech, banking, insurance, etc.)
- Track record of deprecating legacy systems and making hard trade-offs
- Strong written communication skills for async-first engineering culture', NULL, NULL, false, '{"mustHave": ["8+ years of product management experience", "3+ years owning platform/infrastructure products in a senior role", "Experience in fintech, banking, or insurance regulated environment"], "redFlags": ["No experience with platform or infrastructure products", "Lacks any understanding of databases or query performance", "No experience managing PMs or leading teams"], "goodToHave": ["Background in financial services: trade lifecycle, clearing, settlement, or custody", "MBA or CFA", "Experience managing through major production incidents with structural changes"], "goodToHaveMinMatch": 1}', '{"experience": [{"parameter": "Total Experience", "preferred_response": "8+ years", "required": true, "flexibility": ""}, {"parameter": "Relevant Experience", "preferred_response": "3+ years in platform/infrastructure", "required": true, "flexibility": ""}], "academic": [{"parameter": "Minimum CGPA", "preferred_response": "Not specified", "required": false, "flexibility": ""}, {"parameter": "Eligible Branches", "preferred_response": "Not specified", "required": false, "flexibility": ""}], "location": [{"parameter": "Current Location", "preferred_response": "New York, NY or willing to relocate", "required": false, "flexibility": ""}, {"parameter": "Ready to relocate", "preferred_response": "Yes", "required": true, "flexibility": ""}], "compensation": [{"parameter": "Current CTC", "preferred_response": "Market competitive", "required": false, "flexibility": ""}, {"parameter": "Expected CTC", "preferred_response": "Within budget", "required": false, "flexibility": ""}, {"parameter": "Stipend", "preferred_response": "Not applicable", "required": false, "flexibility": ""}]}', '{"topics": [{"name": "AI Generated Vetting Rubric", "type": "Theoretical", "difficulty": "Medium", "questions": ["How would you prioritize between improving platform reliability vs. adding new features for clients?", "Describe a case where you had to balance technical debt reduction with business demands.", "Walk through how you would design a real-time trade settlement system handling $4B/day.", "Explain how you would approach a postmortem for a production incident and what structural changes you would recommend."]}]}', NULL, true, true, true, '48d1c50c-af82-41c3-a5a0-dd1e677e1772', '2026-06-11 15:34:09.595308+05:30', '2026-06-11 15:34:51.47376+05:30', 'cbc684c2-63f6-4a66-ab4e-4f795fbe97a3');
INSERT INTO public.jobs VALUES ('06cdc83e-33fa-4c3e-a915-42108dd18b65', NULL, 'Tech Support Agent', 'Tech Support Agent - Remote US', 'published', 'Upto 2 Years', NULL, 'Job overview
We are looking for a Technical Support Agent to handle inbound phone calls, chats, and emails, providing training and technical support to TitleTec customers within our SaaS platforms. This full-time remote role requires strong customer focus, basic troubleshooting skills, and prior telephone-based customer service experience.

Key responsibilities
- Handle inbound phone calls, chats, and emails to provide technical support and training.
- Work technical support tickets according to urgency in a triage manner.
- Engage in active listening, confirm information, and manage calls following state requirements.
- Meet call volume standards and other key performance indicators.
- Document and report activities in CRM system (Salesforce).

Requirements
- High school diploma or equivalent.
- Prior experience with telephone-based customer service.
- Basic troubleshooting skills and critical thinking abilities.
- Calm under pressure and able to think/react quickly.
- Dedication to learn products thoroughly; ability to work from home in a quiet designated workspace.', NULL, NULL, false, '{"mustHave": ["High school diploma or equivalent", "Prior telephone-based customer service experience", "Basic troubleshooting skills"], "redFlags": ["No customer service experience", "Lack of remote work setup", "Unable to work EST hours including Saturday"], "goodToHave": ["Experience with CRM systems like Salesforce", "Experience with SaaS platforms", "Call center or high-volume call experience"], "goodToHaveMinMatch": 1}', '{"experience": [{"parameter": "Total Experience", "preferred_response": "1+ years", "required": true, "flexibility": ""}, {"parameter": "Relevant Experience", "preferred_response": "Prior telephone-based customer service", "required": true, "flexibility": ""}], "academic": [{"parameter": "Minimum Education", "preferred_response": "High school diploma or equivalent", "required": true, "flexibility": ""}], "location": [{"parameter": "Remote Eligibility", "preferred_response": "Must be based in US", "required": true, "flexibility": ""}, {"parameter": "Quiet Workspace", "preferred_response": "Yes", "required": true, "flexibility": ""}], "compensation": [{"parameter": "Current CTC", "preferred_response": "Market competitive", "required": false, "flexibility": ""}, {"parameter": "Expected CTC", "preferred_response": "Within budget", "required": false, "flexibility": ""}]}', '{"topics": [{"name": "AI Generated Vetting Rubric", "type": "Theoretical", "difficulty": "Medium", "questions": ["Describe a time you handled a difficult customer call. How did you resolve the issue?", "How do you prioritize and manage technical support tickets when multiple come in at once?", "Walk me through how you would troubleshoot a customer unable to log into a SaaS platform.", "What steps would you take to learn a new software product quickly to support customers?"]}]}', NULL, true, true, true, '48d1c50c-af82-41c3-a5a0-dd1e677e1772', '2026-06-12 11:48:47.351829+05:30', '2026-06-12 11:49:52.704635+05:30', 'cbc684c2-63f6-4a66-ab4e-4f795fbe97a3');


--
-- Data for Name: organisations; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.organisations VALUES ('cbc684c2-63f6-4a66-ab4e-4f795fbe97a3', 'devasri-tech', 'devasri-tech.zeko.ai', 'devasri@zeko.ai', 'https://zeko.ai', 'Remote', NULL, 'Build the future of technology with us.', '2026-06-05 23:07:24.473026+05:30', NULL);
INSERT INTO public.organisations VALUES ('662d3d2f-9aca-4cc0-8acc-80aaf031d243', 'DesignIO', 'design.io', 'hello@design.io', 'https://design.io', 'San Francisco', NULL, 'Creating beautiful interfaces.', '2026-06-05 23:07:24.473026+05:30', NULL);


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.users VALUES ('fb6f7f39-b8e8-423c-a4b1-5e674069b461', 'Super Admin', 'admin@interviehire.com', 'Super Admin', 'super_admin', 'active', '$2b$12$gEqsISPF1MXDygs30vW9XuMnWbzJ0ku0tsFWqcpKnYTiq2XO6FqEu', '2026-06-05 23:07:24.476608+05:30', '2026-06-05 23:07:24.476608+05:30', NULL, NULL, NULL, NULL);
INSERT INTO public.users VALUES ('48d1c50c-af82-41c3-a5a0-dd1e677e1772', 'Devasri', 'devasri@zeko.ai', 'Org. Admin', 'org_admin', 'active', '$2b$12$5eXb8kLHpKP5WHr35Otfdus6qx.mAYcCgfdZd76hnCWIbtyjHg33K', '2026-06-05 23:07:24.476608+05:30', '2026-06-05 23:07:24.476608+05:30', 'cbc684c2-63f6-4a66-ab4e-4f795fbe97a3', NULL, NULL, NULL);
INSERT INTO public.users VALUES ('0dd62c89-a9a1-4668-8084-74e6367f16bf', 'Aditya', 'aditya@zeko.ai', 'Recruiter', 'member', 'active', '$2b$12$TKY4vXPps11in0jLUB4YJ.kdirhMPUOAer5pPDG4UVr5IueTYC2Mi', '2026-06-05 23:07:24.476608+05:30', '2026-06-05 23:07:24.476608+05:30', 'cbc684c2-63f6-4a66-ab4e-4f795fbe97a3', NULL, NULL, NULL);
INSERT INTO public.users VALUES ('b661b0e7-1dc9-427c-aead-835b9336e851', 'Aditya Colleague', 'aditya_member2@zeko.ai', 'Recruiter', 'member', 'active', '$2b$12$E0Ot5PQ9OywKz6PjreY4TOIBX03zL8NJ8R1Q2zRs/tZk94Auxu82u', '2026-06-05 23:07:24.476608+05:30', '2026-06-05 23:07:24.476608+05:30', 'cbc684c2-63f6-4a66-ab4e-4f795fbe97a3', NULL, NULL, NULL);
INSERT INTO public.users VALUES ('771ac546-dc8e-4097-93f6-14e0ca65e2d7', 'Design Admin', 'design_admin@design.io', 'Design Admin', 'org_admin', 'active', '$2b$12$NSAg6KiqZl31E7epdulcY.yRYrkhmylpzK08olMsfQawmP2YRpHsu', '2026-06-05 23:07:24.476608+05:30', '2026-06-05 23:07:24.476608+05:30', '662d3d2f-9aca-4cc0-8acc-80aaf031d243', NULL, NULL, NULL);
INSERT INTO public.users VALUES ('6d483371-e23b-4384-a9e3-55f9b996c2fa', 'Design Recruiter 1', 'design_member1@design.io', 'UX Recruiter', 'member', 'active', '$2b$12$sjv0ipBFv/z6PNI0LvltgOIq6/nffFDjVqFjOaw4ccZQXRRUosITS', '2026-06-05 23:07:24.476608+05:30', '2026-06-05 23:07:24.476608+05:30', '662d3d2f-9aca-4cc0-8acc-80aaf031d243', NULL, NULL, NULL);
INSERT INTO public.users VALUES ('04c13488-c59b-4a15-9309-a9f90ba5c386', 'Design Recruiter 2', 'design_member2@design.io', 'UI Recruiter', 'member', 'active', '$2b$12$jnvFUm.9L5TI3bdgI.JXhOep48ujun/3qkJducaytluuyhP9aIAam', '2026-06-05 23:07:24.476608+05:30', '2026-06-05 23:07:24.476608+05:30', '662d3d2f-9aca-4cc0-8acc-80aaf031d243', NULL, NULL, NULL);


--
-- Name: Candidate Candidate_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Candidate"
    ADD CONSTRAINT "Candidate_pkey" PRIMARY KEY (id);


--
-- Name: Company Company_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Company"
    ADD CONSTRAINT "Company_pkey" PRIMARY KEY (id);


--
-- Name: Company Company_slug_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Company"
    ADD CONSTRAINT "Company_slug_key" UNIQUE (slug);


--
-- Name: InterviewSession InterviewSession_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."InterviewSession"
    ADD CONSTRAINT "InterviewSession_pkey" PRIMARY KEY (id);


--
-- Name: JobRole JobRole_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."JobRole"
    ADD CONSTRAINT "JobRole_pkey" PRIMARY KEY (id);


--
-- Name: ProctoringLog ProctoringLog_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ProctoringLog"
    ADD CONSTRAINT "ProctoringLog_pkey" PRIMARY KEY (id);


--
-- Name: Question Question_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Question"
    ADD CONSTRAINT "Question_pkey" PRIMARY KEY (id);


--
-- Name: applicants applicants_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.applicants
    ADD CONSTRAINT applicants_pkey PRIMARY KEY (id);


--
-- Name: interview_reports interview_reports_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.interview_reports
    ADD CONSTRAINT interview_reports_pkey PRIMARY KEY (id);


--
-- Name: job_collaborators job_collaborators_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.job_collaborators
    ADD CONSTRAINT job_collaborators_pkey PRIMARY KEY (id);


--
-- Name: jobs jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.jobs
    ADD CONSTRAINT jobs_pkey PRIMARY KEY (id);


--
-- Name: organisations organisations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.organisations
    ADD CONSTRAINT organisations_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: idx_applicants_email; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_applicants_email ON public.applicants USING btree (email);


--
-- Name: idx_users_email; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_users_email ON public.users USING btree (email);


--
-- Name: ix_applicants_email; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_applicants_email ON public.applicants USING btree (email);


--
-- Name: ix_interview_reports_applicant_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX ix_interview_reports_applicant_id ON public.interview_reports USING btree (applicant_id);


--
-- Name: ix_users_email; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX ix_users_email ON public.users USING btree (email);


--
-- Name: Candidate Candidate_companyId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Candidate"
    ADD CONSTRAINT "Candidate_companyId_fkey" FOREIGN KEY ("companyId") REFERENCES public."Company"(id) ON DELETE CASCADE;


--
-- Name: InterviewSession InterviewSession_candidateId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."InterviewSession"
    ADD CONSTRAINT "InterviewSession_candidateId_fkey" FOREIGN KEY ("candidateId") REFERENCES public."Candidate"(id) ON DELETE CASCADE;


--
-- Name: InterviewSession InterviewSession_companyId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."InterviewSession"
    ADD CONSTRAINT "InterviewSession_companyId_fkey" FOREIGN KEY ("companyId") REFERENCES public."Company"(id) ON DELETE CASCADE;


--
-- Name: InterviewSession InterviewSession_jobRoleId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."InterviewSession"
    ADD CONSTRAINT "InterviewSession_jobRoleId_fkey" FOREIGN KEY ("jobRoleId") REFERENCES public."JobRole"(id) ON DELETE CASCADE;


--
-- Name: JobRole JobRole_companyId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."JobRole"
    ADD CONSTRAINT "JobRole_companyId_fkey" FOREIGN KEY ("companyId") REFERENCES public."Company"(id) ON DELETE CASCADE;


--
-- Name: ProctoringLog ProctoringLog_sessionId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ProctoringLog"
    ADD CONSTRAINT "ProctoringLog_sessionId_fkey" FOREIGN KEY ("sessionId") REFERENCES public."InterviewSession"(id) ON DELETE CASCADE;


--
-- Name: Question Question_companyId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Question"
    ADD CONSTRAINT "Question_companyId_fkey" FOREIGN KEY ("companyId") REFERENCES public."Company"(id) ON DELETE CASCADE;


--
-- Name: Question Question_jobRoleId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Question"
    ADD CONSTRAINT "Question_jobRoleId_fkey" FOREIGN KEY ("jobRoleId") REFERENCES public."JobRole"(id) ON DELETE SET NULL;


--
-- Name: applicants applicants_job_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.applicants
    ADD CONSTRAINT applicants_job_id_fkey FOREIGN KEY (job_id) REFERENCES public.jobs(id);


--
-- Name: interview_reports interview_reports_applicant_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.interview_reports
    ADD CONSTRAINT interview_reports_applicant_id_fkey FOREIGN KEY (applicant_id) REFERENCES public.applicants(id) ON DELETE CASCADE;


--
-- Name: job_collaborators job_collaborators_job_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.job_collaborators
    ADD CONSTRAINT job_collaborators_job_id_fkey FOREIGN KEY (job_id) REFERENCES public.jobs(id);


--
-- Name: job_collaborators job_collaborators_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.job_collaborators
    ADD CONSTRAINT job_collaborators_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: jobs jobs_created_by_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.jobs
    ADD CONSTRAINT jobs_created_by_id_fkey FOREIGN KEY (created_by_id) REFERENCES public.users(id);


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;


--
-- PostgreSQL database dump complete
--

-- \unrestrict ngy2d4UswWZOi8A4hQGRzgb2qBrUBsYm1Gp1fPxNvhOaA8bCwJfRUgZgAPKgxNa

