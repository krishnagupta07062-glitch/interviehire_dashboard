--
-- PostgreSQL database dump
--

-- \restrict 9URVVj4c6hbBEmjuK6X9c3FJMtTD8YHpn3PhZ7m6gaxeXBvxNj0HoCYV7LbCPbD

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

-- \unrestrict 9URVVj4c6hbBEmjuK6X9c3FJMtTD8YHpn3PhZ7m6gaxeXBvxNj0HoCYV7LbCPbD

