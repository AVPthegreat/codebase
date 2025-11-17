--
-- PostgreSQL database dump
--

-- Dumped from database version 10.23
-- Dumped by pg_dump version 10.23

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: acm_contest_rank; Type: TABLE; Schema: public; Owner: onlinejudge
--

CREATE TABLE public.acm_contest_rank (
    id integer NOT NULL,
    submission_number integer NOT NULL,
    accepted_number integer NOT NULL,
    total_time integer NOT NULL,
    submission_info jsonb NOT NULL,
    contest_id integer NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public.acm_contest_rank OWNER TO onlinejudge;

--
-- Name: acm_contest_rank_id_seq; Type: SEQUENCE; Schema: public; Owner: onlinejudge
--

CREATE SEQUENCE public.acm_contest_rank_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.acm_contest_rank_id_seq OWNER TO onlinejudge;

--
-- Name: acm_contest_rank_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: onlinejudge
--

ALTER SEQUENCE public.acm_contest_rank_id_seq OWNED BY public.acm_contest_rank.id;


--
-- Name: announcement; Type: TABLE; Schema: public; Owner: onlinejudge
--

CREATE TABLE public.announcement (
    id integer NOT NULL,
    title text NOT NULL,
    content text NOT NULL,
    create_time timestamp with time zone NOT NULL,
    last_update_time timestamp with time zone NOT NULL,
    visible boolean NOT NULL,
    created_by_id integer NOT NULL
);


ALTER TABLE public.announcement OWNER TO onlinejudge;

--
-- Name: announcement_id_seq; Type: SEQUENCE; Schema: public; Owner: onlinejudge
--

CREATE SEQUENCE public.announcement_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.announcement_id_seq OWNER TO onlinejudge;

--
-- Name: announcement_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: onlinejudge
--

ALTER SEQUENCE public.announcement_id_seq OWNED BY public.announcement.id;


--
-- Name: auth_group; Type: TABLE; Schema: public; Owner: onlinejudge
--

CREATE TABLE public.auth_group (
    id integer NOT NULL,
    name character varying(150) NOT NULL
);


ALTER TABLE public.auth_group OWNER TO onlinejudge;

--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: onlinejudge
--

CREATE SEQUENCE public.auth_group_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_id_seq OWNER TO onlinejudge;

--
-- Name: auth_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: onlinejudge
--

ALTER SEQUENCE public.auth_group_id_seq OWNED BY public.auth_group.id;


--
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: onlinejudge
--

CREATE TABLE public.auth_group_permissions (
    id integer NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_group_permissions OWNER TO onlinejudge;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: onlinejudge
--

CREATE SEQUENCE public.auth_group_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_permissions_id_seq OWNER TO onlinejudge;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: onlinejudge
--

ALTER SEQUENCE public.auth_group_permissions_id_seq OWNED BY public.auth_group_permissions.id;


--
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: onlinejudge
--

CREATE TABLE public.auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


ALTER TABLE public.auth_permission OWNER TO onlinejudge;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: onlinejudge
--

CREATE SEQUENCE public.auth_permission_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_permission_id_seq OWNER TO onlinejudge;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: onlinejudge
--

ALTER SEQUENCE public.auth_permission_id_seq OWNED BY public.auth_permission.id;


--
-- Name: contest; Type: TABLE; Schema: public; Owner: onlinejudge
--

CREATE TABLE public.contest (
    id integer NOT NULL,
    title text NOT NULL,
    description text NOT NULL,
    real_time_rank boolean NOT NULL,
    password text,
    rule_type text NOT NULL,
    start_time timestamp with time zone NOT NULL,
    end_time timestamp with time zone NOT NULL,
    create_time timestamp with time zone NOT NULL,
    last_update_time timestamp with time zone NOT NULL,
    visible boolean NOT NULL,
    created_by_id integer NOT NULL,
    allowed_ip_ranges jsonb NOT NULL,
    freeze_time timestamp with time zone,
    results_emailed_at timestamp with time zone
);


ALTER TABLE public.contest OWNER TO onlinejudge;

--
-- Name: contest_announcement; Type: TABLE; Schema: public; Owner: onlinejudge
--

CREATE TABLE public.contest_announcement (
    id integer NOT NULL,
    title text NOT NULL,
    content text NOT NULL,
    create_time timestamp with time zone NOT NULL,
    contest_id integer NOT NULL,
    created_by_id integer NOT NULL,
    visible boolean NOT NULL
);


ALTER TABLE public.contest_announcement OWNER TO onlinejudge;

--
-- Name: contest_announcement_id_seq; Type: SEQUENCE; Schema: public; Owner: onlinejudge
--

CREATE SEQUENCE public.contest_announcement_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.contest_announcement_id_seq OWNER TO onlinejudge;

--
-- Name: contest_announcement_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: onlinejudge
--

ALTER SEQUENCE public.contest_announcement_id_seq OWNED BY public.contest_announcement.id;


--
-- Name: contest_id_seq; Type: SEQUENCE; Schema: public; Owner: onlinejudge
--

CREATE SEQUENCE public.contest_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.contest_id_seq OWNER TO onlinejudge;

--
-- Name: contest_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: onlinejudge
--

ALTER SEQUENCE public.contest_id_seq OWNED BY public.contest.id;


--
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: onlinejudge
--

CREATE TABLE public.django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE public.django_content_type OWNER TO onlinejudge;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: onlinejudge
--

CREATE SEQUENCE public.django_content_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_content_type_id_seq OWNER TO onlinejudge;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: onlinejudge
--

ALTER SEQUENCE public.django_content_type_id_seq OWNED BY public.django_content_type.id;


--
-- Name: django_dramatiq_task; Type: TABLE; Schema: public; Owner: onlinejudge
--

CREATE TABLE public.django_dramatiq_task (
    id uuid NOT NULL,
    status character varying(8) NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    message_data bytea NOT NULL
);


ALTER TABLE public.django_dramatiq_task OWNER TO onlinejudge;

--
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: onlinejudge
--

CREATE TABLE public.django_migrations (
    id integer NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


ALTER TABLE public.django_migrations OWNER TO onlinejudge;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: onlinejudge
--

CREATE SEQUENCE public.django_migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_migrations_id_seq OWNER TO onlinejudge;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: onlinejudge
--

ALTER SEQUENCE public.django_migrations_id_seq OWNED BY public.django_migrations.id;


--
-- Name: django_session; Type: TABLE; Schema: public; Owner: onlinejudge
--

CREATE TABLE public.django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


ALTER TABLE public.django_session OWNER TO onlinejudge;

--
-- Name: judge_server; Type: TABLE; Schema: public; Owner: onlinejudge
--

CREATE TABLE public.judge_server (
    id integer NOT NULL,
    hostname text NOT NULL,
    ip text,
    judger_version text NOT NULL,
    cpu_core integer NOT NULL,
    memory_usage double precision NOT NULL,
    cpu_usage double precision NOT NULL,
    last_heartbeat timestamp with time zone NOT NULL,
    create_time timestamp with time zone NOT NULL,
    task_number integer NOT NULL,
    service_url text,
    is_disabled boolean NOT NULL
);


ALTER TABLE public.judge_server OWNER TO onlinejudge;

--
-- Name: judge_server_id_seq; Type: SEQUENCE; Schema: public; Owner: onlinejudge
--

CREATE SEQUENCE public.judge_server_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.judge_server_id_seq OWNER TO onlinejudge;

--
-- Name: judge_server_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: onlinejudge
--

ALTER SEQUENCE public.judge_server_id_seq OWNED BY public.judge_server.id;


--
-- Name: oi_contest_rank; Type: TABLE; Schema: public; Owner: onlinejudge
--

CREATE TABLE public.oi_contest_rank (
    id integer NOT NULL,
    submission_number integer NOT NULL,
    total_score integer NOT NULL,
    submission_info jsonb NOT NULL,
    contest_id integer NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public.oi_contest_rank OWNER TO onlinejudge;

--
-- Name: oi_contest_rank_id_seq; Type: SEQUENCE; Schema: public; Owner: onlinejudge
--

CREATE SEQUENCE public.oi_contest_rank_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.oi_contest_rank_id_seq OWNER TO onlinejudge;

--
-- Name: oi_contest_rank_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: onlinejudge
--

ALTER SEQUENCE public.oi_contest_rank_id_seq OWNED BY public.oi_contest_rank.id;


--
-- Name: options_sysoptions; Type: TABLE; Schema: public; Owner: onlinejudge
--

CREATE TABLE public.options_sysoptions (
    id integer NOT NULL,
    key text NOT NULL,
    value jsonb NOT NULL
);


ALTER TABLE public.options_sysoptions OWNER TO onlinejudge;

--
-- Name: options_sysoptions_id_seq; Type: SEQUENCE; Schema: public; Owner: onlinejudge
--

CREATE SEQUENCE public.options_sysoptions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.options_sysoptions_id_seq OWNER TO onlinejudge;

--
-- Name: options_sysoptions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: onlinejudge
--

ALTER SEQUENCE public.options_sysoptions_id_seq OWNED BY public.options_sysoptions.id;


--
-- Name: problem; Type: TABLE; Schema: public; Owner: onlinejudge
--

CREATE TABLE public.problem (
    id integer NOT NULL,
    title text NOT NULL,
    description text NOT NULL,
    input_description text NOT NULL,
    output_description text NOT NULL,
    samples jsonb NOT NULL,
    test_case_id text NOT NULL,
    test_case_score jsonb NOT NULL,
    hint text,
    languages jsonb NOT NULL,
    template jsonb NOT NULL,
    create_time timestamp with time zone NOT NULL,
    last_update_time timestamp with time zone,
    time_limit integer NOT NULL,
    memory_limit integer NOT NULL,
    spj boolean NOT NULL,
    spj_language text,
    spj_code text,
    spj_version text,
    rule_type text NOT NULL,
    visible boolean NOT NULL,
    difficulty text NOT NULL,
    source text,
    submission_number bigint NOT NULL,
    accepted_number bigint NOT NULL,
    created_by_id integer NOT NULL,
    _id text NOT NULL,
    statistic_info jsonb NOT NULL,
    total_score integer NOT NULL,
    contest_id integer,
    is_public boolean NOT NULL,
    spj_compile_ok boolean NOT NULL,
    io_mode jsonb NOT NULL,
    share_submission boolean NOT NULL,
    editorial text
);


ALTER TABLE public.problem OWNER TO onlinejudge;

--
-- Name: problem_id_seq; Type: SEQUENCE; Schema: public; Owner: onlinejudge
--

CREATE SEQUENCE public.problem_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.problem_id_seq OWNER TO onlinejudge;

--
-- Name: problem_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: onlinejudge
--

ALTER SEQUENCE public.problem_id_seq OWNED BY public.problem.id;


--
-- Name: problem_tag; Type: TABLE; Schema: public; Owner: onlinejudge
--

CREATE TABLE public.problem_tag (
    id integer NOT NULL,
    name text NOT NULL
);


ALTER TABLE public.problem_tag OWNER TO onlinejudge;

--
-- Name: problem_tag_id_seq; Type: SEQUENCE; Schema: public; Owner: onlinejudge
--

CREATE SEQUENCE public.problem_tag_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.problem_tag_id_seq OWNER TO onlinejudge;

--
-- Name: problem_tag_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: onlinejudge
--

ALTER SEQUENCE public.problem_tag_id_seq OWNED BY public.problem_tag.id;


--
-- Name: problem_tags; Type: TABLE; Schema: public; Owner: onlinejudge
--

CREATE TABLE public.problem_tags (
    id integer NOT NULL,
    problem_id integer NOT NULL,
    problemtag_id integer NOT NULL
);


ALTER TABLE public.problem_tags OWNER TO onlinejudge;

--
-- Name: problem_tags_id_seq; Type: SEQUENCE; Schema: public; Owner: onlinejudge
--

CREATE SEQUENCE public.problem_tags_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.problem_tags_id_seq OWNER TO onlinejudge;

--
-- Name: problem_tags_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: onlinejudge
--

ALTER SEQUENCE public.problem_tags_id_seq OWNED BY public.problem_tags.id;


--
-- Name: submission; Type: TABLE; Schema: public; Owner: onlinejudge
--

CREATE TABLE public.submission (
    id text NOT NULL,
    contest_id integer,
    problem_id integer NOT NULL,
    create_time timestamp with time zone NOT NULL,
    user_id integer NOT NULL,
    code text NOT NULL,
    result integer NOT NULL,
    info jsonb NOT NULL,
    language text NOT NULL,
    shared boolean NOT NULL,
    statistic_info jsonb NOT NULL,
    username text NOT NULL,
    ip text
);


ALTER TABLE public.submission OWNER TO onlinejudge;

--
-- Name: user; Type: TABLE; Schema: public; Owner: onlinejudge
--

CREATE TABLE public."user" (
    id integer NOT NULL,
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    username text NOT NULL,
    email text,
    create_time timestamp with time zone,
    admin_type text NOT NULL,
    reset_password_token text,
    reset_password_token_expire_time timestamp with time zone,
    auth_token text,
    two_factor_auth boolean NOT NULL,
    tfa_token text,
    open_api boolean NOT NULL,
    open_api_appkey text,
    is_disabled boolean NOT NULL,
    problem_permission text NOT NULL,
    session_keys jsonb NOT NULL,
    email_verified boolean NOT NULL,
    email_verify_token text,
    email_verify_token_expire_time timestamp with time zone
);


ALTER TABLE public."user" OWNER TO onlinejudge;

--
-- Name: user_id_seq; Type: SEQUENCE; Schema: public; Owner: onlinejudge
--

CREATE SEQUENCE public.user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_id_seq OWNER TO onlinejudge;

--
-- Name: user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: onlinejudge
--

ALTER SEQUENCE public.user_id_seq OWNED BY public."user".id;


--
-- Name: user_profile; Type: TABLE; Schema: public; Owner: onlinejudge
--

CREATE TABLE public.user_profile (
    id integer NOT NULL,
    acm_problems_status jsonb NOT NULL,
    avatar text NOT NULL,
    blog character varying(200),
    mood text,
    accepted_number integer NOT NULL,
    submission_number integer NOT NULL,
    github text,
    school text,
    major text,
    user_id integer NOT NULL,
    total_score bigint NOT NULL,
    oi_problems_status jsonb NOT NULL,
    real_name text,
    language text
);


ALTER TABLE public.user_profile OWNER TO onlinejudge;

--
-- Name: user_profile_id_seq; Type: SEQUENCE; Schema: public; Owner: onlinejudge
--

CREATE SEQUENCE public.user_profile_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_profile_id_seq OWNER TO onlinejudge;

--
-- Name: user_profile_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: onlinejudge
--

ALTER SEQUENCE public.user_profile_id_seq OWNED BY public.user_profile.id;


--
-- Name: acm_contest_rank id; Type: DEFAULT; Schema: public; Owner: onlinejudge
--

ALTER TABLE ONLY public.acm_contest_rank ALTER COLUMN id SET DEFAULT nextval('public.acm_contest_rank_id_seq'::regclass);


--
-- Name: announcement id; Type: DEFAULT; Schema: public; Owner: onlinejudge
--

ALTER TABLE ONLY public.announcement ALTER COLUMN id SET DEFAULT nextval('public.announcement_id_seq'::regclass);


--
-- Name: auth_group id; Type: DEFAULT; Schema: public; Owner: onlinejudge
--

ALTER TABLE ONLY public.auth_group ALTER COLUMN id SET DEFAULT nextval('public.auth_group_id_seq'::regclass);


--
-- Name: auth_group_permissions id; Type: DEFAULT; Schema: public; Owner: onlinejudge
--

ALTER TABLE ONLY public.auth_group_permissions ALTER COLUMN id SET DEFAULT nextval('public.auth_group_permissions_id_seq'::regclass);


--
-- Name: auth_permission id; Type: DEFAULT; Schema: public; Owner: onlinejudge
--

ALTER TABLE ONLY public.auth_permission ALTER COLUMN id SET DEFAULT nextval('public.auth_permission_id_seq'::regclass);


--
-- Name: contest id; Type: DEFAULT; Schema: public; Owner: onlinejudge
--

ALTER TABLE ONLY public.contest ALTER COLUMN id SET DEFAULT nextval('public.contest_id_seq'::regclass);


--
-- Name: contest_announcement id; Type: DEFAULT; Schema: public; Owner: onlinejudge
--

ALTER TABLE ONLY public.contest_announcement ALTER COLUMN id SET DEFAULT nextval('public.contest_announcement_id_seq'::regclass);


--
-- Name: django_content_type id; Type: DEFAULT; Schema: public; Owner: onlinejudge
--

ALTER TABLE ONLY public.django_content_type ALTER COLUMN id SET DEFAULT nextval('public.django_content_type_id_seq'::regclass);


--
-- Name: django_migrations id; Type: DEFAULT; Schema: public; Owner: onlinejudge
--

ALTER TABLE ONLY public.django_migrations ALTER COLUMN id SET DEFAULT nextval('public.django_migrations_id_seq'::regclass);


--
-- Name: judge_server id; Type: DEFAULT; Schema: public; Owner: onlinejudge
--

ALTER TABLE ONLY public.judge_server ALTER COLUMN id SET DEFAULT nextval('public.judge_server_id_seq'::regclass);


--
-- Name: oi_contest_rank id; Type: DEFAULT; Schema: public; Owner: onlinejudge
--

ALTER TABLE ONLY public.oi_contest_rank ALTER COLUMN id SET DEFAULT nextval('public.oi_contest_rank_id_seq'::regclass);


--
-- Name: options_sysoptions id; Type: DEFAULT; Schema: public; Owner: onlinejudge
--

ALTER TABLE ONLY public.options_sysoptions ALTER COLUMN id SET DEFAULT nextval('public.options_sysoptions_id_seq'::regclass);


--
-- Name: problem id; Type: DEFAULT; Schema: public; Owner: onlinejudge
--

ALTER TABLE ONLY public.problem ALTER COLUMN id SET DEFAULT nextval('public.problem_id_seq'::regclass);


--
-- Name: problem_tag id; Type: DEFAULT; Schema: public; Owner: onlinejudge
--

ALTER TABLE ONLY public.problem_tag ALTER COLUMN id SET DEFAULT nextval('public.problem_tag_id_seq'::regclass);


--
-- Name: problem_tags id; Type: DEFAULT; Schema: public; Owner: onlinejudge
--

ALTER TABLE ONLY public.problem_tags ALTER COLUMN id SET DEFAULT nextval('public.problem_tags_id_seq'::regclass);


--
-- Name: user id; Type: DEFAULT; Schema: public; Owner: onlinejudge
--

ALTER TABLE ONLY public."user" ALTER COLUMN id SET DEFAULT nextval('public.user_id_seq'::regclass);


--
-- Name: user_profile id; Type: DEFAULT; Schema: public; Owner: onlinejudge
--

ALTER TABLE ONLY public.user_profile ALTER COLUMN id SET DEFAULT nextval('public.user_profile_id_seq'::regclass);


--
-- Data for Name: acm_contest_rank; Type: TABLE DATA; Schema: public; Owner: onlinejudge
--

COPY public.acm_contest_rank (id, submission_number, accepted_number, total_time, submission_info, contest_id, user_id) FROM stdin;
1	11	2	716907	{"1": {"is_ac": true, "ac_time": 609878.418327, "is_first_ac": true, "error_number": 0}, "3": {"is_ac": true, "ac_time": 98629.150168, "is_first_ac": true, "error_number": 7}}	2	2
2	2	1	692142	{"1": {"is_ac": true, "ac_time": 692142.958239, "is_first_ac": false, "error_number": 0}}	2	3
3	2	1	4899	{"4": {"is_ac": true, "ac_time": 3699.325686, "is_first_ac": true, "error_number": 1}}	4	3
4	1	1	148	{"5": {"is_ac": true, "ac_time": 148.96857, "is_first_ac": true, "error_number": 0}}	5	3
\.


--
-- Data for Name: announcement; Type: TABLE DATA; Schema: public; Owner: onlinejudge
--

COPY public.announcement (id, title, content, create_time, last_update_time, visible, created_by_id) FROM stdin;
2	SOLVE BUGS	<p>solve bug and get bounty<br />click for more</p>	2025-11-06 04:54:24.557511+00	2025-11-06 04:54:24.557559+00	t	1
3	PROBLEM OF THE DAY	<p>Solve the problem of the day and stand out among top developers out there</p>	2025-11-06 04:54:59.626819+00	2025-11-06 04:54:59.626852+00	t	1
4	TUESDAY 11-12-25 PRACTICE CONTEST	<p>practice contest to check the scaling and strength of backend</p>	2025-11-06 04:56:03.966089+00	2025-11-06 04:56:03.966228+00	t	1
\.


--
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: onlinejudge
--

COPY public.auth_group (id, name) FROM stdin;
\.


--
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: onlinejudge
--

COPY public.auth_group_permissions (id, group_id, permission_id) FROM stdin;
\.


--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: onlinejudge
--

COPY public.auth_permission (id, name, content_type_id, codename) FROM stdin;
1	Can add permission	1	add_permission
2	Can change permission	1	change_permission
3	Can delete permission	1	delete_permission
4	Can view permission	1	view_permission
5	Can add group	2	add_group
6	Can change group	2	change_group
7	Can delete group	2	delete_group
8	Can view group	2	view_group
9	Can add session	3	add_session
10	Can change session	3	change_session
11	Can delete session	3	delete_session
12	Can view session	3	view_session
13	Can add content type	4	add_contenttype
14	Can change content type	4	change_contenttype
15	Can delete content type	4	delete_contenttype
16	Can view content type	4	view_contenttype
17	Can add task	5	add_task
18	Can change task	5	change_task
19	Can delete task	5	delete_task
20	Can view task	5	view_task
21	Can add user	6	add_user
22	Can change user	6	change_user
23	Can delete user	6	delete_user
24	Can view user	6	view_user
25	Can add user profile	7	add_userprofile
26	Can change user profile	7	change_userprofile
27	Can delete user profile	7	delete_userprofile
28	Can view user profile	7	view_userprofile
29	Can add announcement	8	add_announcement
30	Can change announcement	8	change_announcement
31	Can delete announcement	8	delete_announcement
32	Can view announcement	8	view_announcement
33	Can add judge server	9	add_judgeserver
34	Can change judge server	9	change_judgeserver
35	Can delete judge server	9	delete_judgeserver
36	Can view judge server	9	view_judgeserver
37	Can add problem	10	add_problem
38	Can change problem	10	change_problem
39	Can delete problem	10	delete_problem
40	Can view problem	10	view_problem
41	Can add problem tag	11	add_problemtag
42	Can change problem tag	11	change_problemtag
43	Can delete problem tag	11	delete_problemtag
44	Can view problem tag	11	view_problemtag
45	Can add acm contest rank	12	add_acmcontestrank
46	Can change acm contest rank	12	change_acmcontestrank
47	Can delete acm contest rank	12	delete_acmcontestrank
48	Can view acm contest rank	12	view_acmcontestrank
49	Can add contest	13	add_contest
50	Can change contest	13	change_contest
51	Can delete contest	13	delete_contest
52	Can view contest	13	view_contest
53	Can add contest announcement	14	add_contestannouncement
54	Can change contest announcement	14	change_contestannouncement
55	Can delete contest announcement	14	delete_contestannouncement
56	Can view contest announcement	14	view_contestannouncement
57	Can add oi contest rank	15	add_oicontestrank
58	Can change oi contest rank	15	change_oicontestrank
59	Can delete oi contest rank	15	delete_oicontestrank
60	Can view oi contest rank	15	view_oicontestrank
61	Can add submission	16	add_submission
62	Can change submission	16	change_submission
63	Can delete submission	16	delete_submission
64	Can view submission	16	view_submission
65	Can add sys options	17	add_sysoptions
66	Can change sys options	17	change_sysoptions
67	Can delete sys options	17	delete_sysoptions
68	Can view sys options	17	view_sysoptions
69	Can add discussion message	18	add_discussionmessage
70	Can change discussion message	18	change_discussionmessage
71	Can delete discussion message	18	delete_discussionmessage
72	Can view discussion message	18	view_discussionmessage
73	Can add contest attempt	19	add_contestattempt
74	Can change contest attempt	19	change_contestattempt
75	Can delete contest attempt	19	delete_contestattempt
76	Can view contest attempt	19	view_contestattempt
77	Can add contest attempt problem stat	20	add_contestattemptproblemstat
78	Can change contest attempt problem stat	20	change_contestattemptproblemstat
79	Can delete contest attempt problem stat	20	delete_contestattemptproblemstat
80	Can view contest attempt problem stat	20	view_contestattemptproblemstat
\.


--
-- Data for Name: contest; Type: TABLE DATA; Schema: public; Owner: onlinejudge
--

COPY public.contest (id, title, description, real_time_rank, password, rule_type, start_time, end_time, create_time, last_update_time, visible, created_by_id, allowed_ip_ranges, freeze_time, results_emailed_at) FROM stdin;
2	Platform Testing-1 (v1.89)	<p>Welcome to<strong>Platform Testing-1 (v1.89)</strong></p><p>This contest is organized to verify the full functionality and stability of the Codebase platform.<br />Participants are requested to attempt the given problems to help test:</p><ul><li><p>Code submission and verdict accuracy</p></li><li><p>Real-time ranking updates</p></li><li><p>Timer synchronization and leaderboard refresh</p></li><li><p>Problem statement rendering and input/output handling</p></li></ul><p><strong>Note:</strong></p><ul><li><p>This is an internal testing round — scores will not affect your actual ratings.</p></li><li><p>Feel free to submit multiple times to test the judging system.</p></li><li><p>If you encounter bugs or delays, please record the steps and report them to the admin panel.</p></li></ul><p>Let’s make sure Codebase runs flawlessly before the official Beta launch 🚀</p>	t	\N	ACM	2025-10-29 18:30:00+00	2030-10-31 18:30:00+00	2025-10-30 08:48:02.600387+00	2025-11-02 18:45:01.91287+00	t	1	[]	\N	\N
1	AFTER DIWALI SURPRISE	<p>CHECK CHECK</p>	t	\N	ACM	2025-10-19 18:30:00+00	2025-10-29 18:30:00+00	2025-10-22 19:56:36.630178+00	2025-11-06 19:28:54.114121+00	t	1	[]	\N	2025-11-08 14:07:44.490443+00
3	Platform Testing-1 (v1.90.12)	<p>Welcome toPlatform Testing-1 (v1.90 )</p><p>This contest is organized to verify the full functionality and stability of the Codebase platform.<br />Participants are requested to attempt the given problems to help test:</p><ul><li><p>Code submission and verdict accuracy</p></li><li><p>Real-time ranking updates</p></li><li><p>Timer synchronization and leaderboard refresh</p></li><li><p>Problem statement rendering and input/output handling</p></li></ul><p>Note:</p><ul><li><p>This is an internal testing round — scores will not affect your actual ratings.</p></li><li><p>Feel free to submit multiple times to test the judging system.</p></li><li><p>If you encounter bugs or delays, please record the steps and report them to the admin panel.</p></li></ul><p>Let’s make sure Codebase runs flawlessly before the official Beta launch 🚀</p>	t		ACM	2025-11-02 18:30:00+00	2025-11-06 18:30:00+00	2025-11-02 18:46:42.691089+00	2025-11-02 18:46:42.691097+00	t	1	[]	\N	2025-11-08 14:07:44.850208+00
4	Mail testing (1.90.23)	<p>mail checking</p>	t	\N	ACM	2025-11-06 18:30:00+00	2025-11-06 19:50:00+00	2025-11-06 19:29:24.503434+00	2025-11-06 19:48:13.268901+00	t	1	[]	\N	2025-11-08 14:07:44.854607+00
5	Mail checking two	<p>part 2 smtp checking</p>	t	\N	ACM	2025-11-06 20:00:34+00	2025-11-06 20:04:36+00	2025-11-06 20:00:47.407585+00	2025-11-06 20:02:00.742454+00	t	1	[]	\N	2025-11-08 14:07:44.857968+00
\.


--
-- Data for Name: contest_announcement; Type: TABLE DATA; Schema: public; Owner: onlinejudge
--

COPY public.contest_announcement (id, title, content, create_time, contest_id, created_by_id, visible) FROM stdin;
1	Platform Testing-1 (v1.89)	<p>SHARP AT 10 PM<br />COMMON HALL OF PST HOSTEL</p>	2025-10-30 08:48:50.01223+00	2	1	t
\.


--
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: onlinejudge
--

COPY public.django_content_type (id, app_label, model) FROM stdin;
1	auth	permission
2	auth	group
3	sessions	session
4	contenttypes	contenttype
5	django_dramatiq	task
6	account	user
7	account	userprofile
8	announcement	announcement
9	conf	judgeserver
10	problem	problem
11	problem	problemtag
12	contest	acmcontestrank
13	contest	contest
14	contest	contestannouncement
15	contest	oicontestrank
16	submission	submission
17	options	sysoptions
18	discussion	discussionmessage
19	contest	contestattempt
20	contest	contestattemptproblemstat
\.


--
-- Data for Name: django_dramatiq_task; Type: TABLE DATA; Schema: public; Owner: onlinejudge
--

COPY public.django_dramatiq_task (id, status, created_at, updated_at, message_data) FROM stdin;
\.


--
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: onlinejudge
--

COPY public.django_migrations (id, app, name, applied) FROM stdin;
1	account	0001_initial	2025-10-22 19:39:49.688457+00
2	account	0002_auto_20170209_1028	2025-10-22 19:39:49.704463+00
3	account	0003_userprofile_total_score	2025-10-22 19:39:49.71602+00
4	account	0005_auto_20170830_1154	2025-10-22 19:39:49.729939+00
5	account	0006_user_session_keys	2025-10-22 19:39:49.744034+00
6	account	0008_auto_20171011_1214	2025-10-22 19:39:49.844508+00
7	account	0009_auto_20171125_1514	2025-10-22 19:39:49.849005+00
8	account	0010_auto_20180501_0436	2025-10-22 19:39:49.873963+00
9	account	0011_auto_20180501_0456	2025-10-22 19:39:49.876622+00
10	account	0012_userprofile_language	2025-10-22 19:39:49.879257+00
11	announcement	0001_initial	2025-10-22 19:39:49.895046+00
12	announcement	0002_auto_20171011_1214	2025-10-22 19:39:49.904242+00
13	announcement	0003_auto_20180501_0436	2025-10-22 19:39:49.907851+00
14	contenttypes	0001_initial	2025-10-22 19:39:49.923561+00
15	contenttypes	0002_remove_content_type_name	2025-10-22 19:39:49.929161+00
16	auth	0001_initial	2025-10-22 19:39:49.949993+00
17	auth	0002_alter_permission_name_max_length	2025-10-22 19:39:49.953165+00
18	auth	0003_alter_user_email_max_length	2025-10-22 19:39:49.956052+00
19	auth	0004_alter_user_username_opts	2025-10-22 19:39:49.959094+00
20	auth	0005_alter_user_last_login_null	2025-10-22 19:39:49.962121+00
21	auth	0006_require_contenttypes_0002	2025-10-22 19:39:49.962711+00
22	auth	0007_alter_validators_add_error_messages	2025-10-22 19:39:49.966756+00
23	auth	0008_alter_user_username_max_length	2025-10-22 19:39:49.969922+00
24	auth	0009_alter_user_last_name_max_length	2025-10-22 19:39:49.972772+00
25	conf	0001_initial	2025-10-22 19:39:49.98716+00
26	conf	0002_auto_20171011_1214	2025-10-22 19:39:50.0106+00
27	conf	0003_judgeserver_is_disabled	2025-10-22 19:39:50.016003+00
28	conf	0004_auto_20180501_0436	2025-10-22 19:39:50.022949+00
29	problem	0001_initial	2025-10-22 19:39:50.043621+00
30	contest	0001_initial	2025-10-22 19:39:50.126769+00
31	contest	0002_auto_20170209_0845	2025-10-22 19:39:50.16179+00
32	contest	0003_auto_20170217_0820	2025-10-22 19:39:50.221538+00
33	contest	0004_auto_20170717_1324	2025-10-22 19:39:50.238154+00
34	contest	0005_auto_20170823_0918	2025-10-22 19:39:50.258445+00
35	contest	0006_auto_20171011_1214	2025-10-22 19:39:50.305595+00
36	contest	0007_contestannouncement_visible	2025-10-22 19:39:50.334348+00
37	contest	0008_contest_allowed_ip_ranges	2025-10-22 19:39:50.367522+00
38	contest	0009_auto_20180501_0436	2025-10-22 19:39:50.411004+00
39	contest	0010_auto_20190326_0201	2025-10-22 19:39:50.437466+00
40	django_dramatiq	0001_initial	2025-10-22 19:39:50.449922+00
41	options	0001_initial	2025-10-22 19:39:50.459465+00
42	options	0002_auto_20180501_0436	2025-10-22 19:39:50.463727+00
43	options	0003_migrate_languages_options	2025-10-22 19:39:50.469169+00
44	submission	0001_initial	2025-10-22 19:39:50.486017+00
45	submission	0002_auto_20170509_1203	2025-10-22 19:39:50.495517+00
46	submission	0005_submission_username	2025-10-22 19:39:50.505397+00
47	submission	0006_auto_20170830_1154	2025-10-22 19:39:50.510893+00
48	submission	0007_auto_20170923_1318	2025-10-22 19:39:50.587555+00
49	submission	0008_submission_ip	2025-10-22 19:39:50.599187+00
50	submission	0009_delete_user_output	2025-10-22 19:39:50.611828+00
51	problem	0002_problem__id	2025-10-22 19:39:50.634777+00
52	problem	0003_auto_20170217_0820	2025-10-22 19:39:50.668793+00
53	problem	0004_auto_20170501_0637	2025-10-22 19:39:50.730103+00
54	problem	0005_auto_20170815_1258	2025-10-22 19:39:50.76502+00
55	problem	0006_auto_20170823_0918	2025-10-22 19:39:50.826562+00
56	problem	0008_auto_20170923_1318	2025-10-22 19:39:50.94733+00
57	problem	0009_auto_20171011_1214	2025-10-22 19:39:51.047535+00
58	problem	0010_problem_spj_compile_ok	2025-10-22 19:39:51.06693+00
59	problem	0011_fix_problem_ac_count	2025-10-22 19:39:51.081329+00
60	problem	0012_auto_20180501_0436	2025-10-22 19:39:51.177299+00
61	problem	0013_problem_io_mode	2025-10-22 19:39:51.198704+00
62	problem	0014_problem_share_submission	2025-10-22 19:39:51.212477+00
63	sessions	0001_initial	2025-10-22 19:39:51.219624+00
64	submission	0011_fix_submission_number	2025-10-22 19:39:51.231317+00
65	submission	0012_auto_20180501_0436	2025-10-22 19:39:51.255369+00
66	account	0013_auto_20251106_0901	2025-11-08 06:24:40.924214+00
67	auth	0010_alter_group_name_max_length	2025-11-08 06:24:40.952974+00
68	auth	0011_update_proxy_permissions	2025-11-08 06:24:40.96419+00
69	auth	0012_alter_user_first_name_max_length	2025-11-08 06:24:40.968117+00
70	problem	0015_auto_20251106_0901	2025-11-08 06:33:38.323491+00
71	contest	0011_auto_20251106_0901	2025-11-08 12:29:07.654144+00
72	contest	0012_contest_results_emailed_at	2025-11-08 12:29:18.549917+00
73	django_dramatiq	0002_auto_20191104_1354	2025-11-08 12:29:18.555806+00
74	django_dramatiq	0003_auto_20200204_0842	2025-11-08 12:29:18.556987+00
\.


--
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: onlinejudge
--

COPY public.django_session (session_key, session_data, expire_date) FROM stdin;
\.


--
-- Data for Name: judge_server; Type: TABLE DATA; Schema: public; Owner: onlinejudge
--

COPY public.judge_server (id, hostname, ip, judger_version, cpu_core, memory_usage, cpu_usage, last_heartbeat, create_time, task_number, service_url, is_disabled) FROM stdin;
7	082a35473b46	172.18.0.3	2.1.1	8	20.1999999999999993	0	2025-10-31 08:38:52.860399+00	2025-10-30 16:43:38.999783+00	0	http://judge-server:8080	f
5	6dedd41f6259	172.18.0.3	2.1.1	8	21.8000000000000007	0	2025-10-30 16:41:12.434146+00	2025-10-30 16:38:12.364712+00	0	http://judge-server:8080	f
3	299428aaac09	172.18.0.3	2.1.1	8	24.8000000000000007	0	2025-10-30 13:13:11.489533+00	2025-10-30 13:10:22.942462+00	0	http://judge-server:8080	f
4	57228b6c4bc3	172.18.0.3	2.1.1	8	24.6999999999999993	25	2025-10-30 16:38:05.06708+00	2025-10-30 13:13:18.557522+00	0	http://judge-server:8080	f
2	7bdd222077a2	172.18.0.3	2.1.1	8	25.1999999999999993	33.2999999999999972	2025-10-30 13:10:15.562026+00	2025-10-30 11:12:13.392861+00	0	http://judge-server:8080	f
6	9d90bf8c9fb3	172.18.0.3	2.1.1	8	21.6000000000000014	0	2025-10-30 16:43:31.458863+00	2025-10-30 16:41:23.276446+00	0	http://judge-server:8080	f
1	d6f0f5f4669d	172.18.0.3	2.1.1	8	23.3000000000000007	20	2025-10-30 11:12:02.114766+00	2025-10-22 19:39:55.114347+00	0	http://backend:8000	f
8	d73749431fcd	172.18.0.2	2.1.1	8	19.6999999999999993	0	2025-11-07 23:07:30.899205+00	2025-10-31 08:38:59.943637+00	0	http://judge-server:8080	f
\.


--
-- Data for Name: oi_contest_rank; Type: TABLE DATA; Schema: public; Owner: onlinejudge
--

COPY public.oi_contest_rank (id, submission_number, total_score, submission_info, contest_id, user_id) FROM stdin;
\.


--
-- Data for Name: options_sysoptions; Type: TABLE DATA; Schema: public; Owner: onlinejudge
--

COPY public.options_sysoptions (id, key, value) FROM stdin;
1	website_base_url	"http://127.0.0.1"
2	website_name	"Online Judge"
3	website_name_shortcut	"oj"
4	website_footer	"Online Judge Footer"
5	allow_register	true
6	submission_list_show_all	true
7	smtp_config	{}
9	throttling	{"ip": {"capacity": 100, "fill_rate": 0.1, "default_capacity": 50}, "user": {"capacity": 20, "fill_rate": 0.03, "default_capacity": 10}}
8	judge_server_token	""
10	languages	[{"spj": {"config": {"command": "{exe_path} {in_file_path} {user_out_file_path}", "exe_name": "spj-{spj_version}", "seccomp_rule": "c_cpp"}, "compile": {"exe_name": "spj-{spj_version}", "src_name": "spj-{spj_version}.c", "max_memory": 1073741824, "max_cpu_time": 3000, "max_real_time": 10000, "compile_command": "/usr/bin/gcc -DONLINE_JUDGE -O2 -w -fmax-errors=3 -std=c11 {src_path} -lm -o {exe_path}"}}, "name": "C", "config": {"run": {"env": ["LANG=en_US.UTF-8", "LANGUAGE=en_US:en", "LC_ALL=en_US.UTF-8"], "command": "{exe_path}", "seccomp_rule": {"File IO": "c_cpp_file_io", "Standard IO": "c_cpp"}}, "compile": {"exe_name": "main", "src_name": "main.c", "max_memory": 268435456, "max_cpu_time": 3000, "max_real_time": 10000, "compile_command": "/usr/bin/gcc -DONLINE_JUDGE -O2 -w -fmax-errors=3 -std=c11 {src_path} -lm -o {exe_path}"}, "template": "//PREPEND BEGIN\\n#include <stdio.h>\\n//PREPEND END\\n\\n//TEMPLATE BEGIN\\nint add(int a, int b) {\\n  // Please fill this blank\\n  return ___________;\\n}\\n//TEMPLATE END\\n\\n//APPEND BEGIN\\nint main() {\\n  printf(\\"%d\\", add(1, 2));\\n  return 0;\\n}\\n//APPEND END"}, "description": "GCC 9.4", "content_type": "text/x-csrc"}, {"spj": {"config": {"command": "{exe_path} {in_file_path} {user_out_file_path}", "exe_name": "spj-{spj_version}", "seccomp_rule": "c_cpp"}, "compile": {"exe_name": "spj-{spj_version}", "src_name": "spj-{spj_version}.cpp", "max_memory": 1073741824, "max_cpu_time": 10000, "max_real_time": 20000, "compile_command": "/usr/bin/g++ -DONLINE_JUDGE -O2 -w -fmax-errors=3 -std=c++14 {src_path} -lm -o {exe_path}"}}, "name": "C++", "config": {"run": {"env": ["LANG=en_US.UTF-8", "LANGUAGE=en_US:en", "LC_ALL=en_US.UTF-8"], "command": "{exe_path}", "seccomp_rule": {"File IO": "c_cpp_file_io", "Standard IO": "c_cpp"}}, "compile": {"exe_name": "main", "src_name": "main.cpp", "max_memory": 1073741824, "max_cpu_time": 10000, "max_real_time": 20000, "compile_command": "/usr/bin/g++ -DONLINE_JUDGE -O2 -w -fmax-errors=3 -std=c++14 {src_path} -lm -o {exe_path}"}, "template": "//PREPEND BEGIN\\n#include <iostream>\\n//PREPEND END\\n\\n//TEMPLATE BEGIN\\nint add(int a, int b) {\\n  // Please fill this blank\\n  return ___________;\\n}\\n//TEMPLATE END\\n\\n//APPEND BEGIN\\nint main() {\\n  std::cout << add(1, 2);\\n  return 0;\\n}\\n//APPEND END"}, "description": "G++ 9.4", "content_type": "text/x-c++src"}, {"name": "Java", "config": {"run": {"env": ["LANG=en_US.UTF-8", "LANGUAGE=en_US:en", "LC_ALL=en_US.UTF-8"], "command": "/usr/bin/java -cp {exe_dir} -XX:MaxRAM={max_memory}k Main", "seccomp_rule": null, "memory_limit_check_only": 1}, "compile": {"exe_name": "Main", "src_name": "Main.java", "max_memory": -1, "max_cpu_time": 5000, "max_real_time": 10000, "compile_command": "/usr/bin/javac {src_path} -d {exe_dir} -encoding UTF8"}, "template": "//PREPEND BEGIN\\n//PREPEND END\\n\\n//TEMPLATE BEGIN\\n//TEMPLATE END\\n\\n//APPEND BEGIN\\n//APPEND END"}, "description": "OpenJDK 11", "content_type": "text/x-java"}, {"name": "Python2", "config": {"run": {"env": ["LANG=en_US.UTF-8", "LANGUAGE=en_US:en", "LC_ALL=en_US.UTF-8"], "command": "/usr/bin/python {exe_path}", "seccomp_rule": "general"}, "compile": {"exe_name": "solution.pyc", "src_name": "solution.py", "max_memory": 134217728, "max_cpu_time": 3000, "max_real_time": 10000, "compile_command": "/usr/bin/python -m py_compile {src_path}"}, "template": "//PREPEND BEGIN\\n//PREPEND END\\n\\n//TEMPLATE BEGIN\\n//TEMPLATE END\\n\\n//APPEND BEGIN\\n//APPEND END"}, "description": "Python 2.7", "content_type": "text/x-python"}, {"name": "Python3", "config": {"run": {"env": ["LANG=en_US.UTF-8", "LANGUAGE=en_US:en", "LC_ALL=en_US.UTF-8", "PYTHONIOENCODING=utf-8"], "command": "/usr/bin/python3 -BS {exe_path}", "seccomp_rule": "general"}, "compile": {"exe_name": "solution.py", "src_name": "solution.py", "max_memory": 134217728, "max_cpu_time": 3000, "max_real_time": 10000, "compile_command": "/usr/bin/python3 -m py_compile {src_path}"}, "template": "//PREPEND BEGIN\\n//PREPEND END\\n\\n//TEMPLATE BEGIN\\n//TEMPLATE END\\n\\n//APPEND BEGIN\\n//APPEND END"}, "description": "Python 3.6", "content_type": "text/x-python"}, {"name": "Golang", "config": {"run": {"env": ["GODEBUG=madvdontneed=1", "GOMAXPROCS=1", "LANG=en_US.UTF-8", "LANGUAGE=en_US:en", "LC_ALL=en_US.UTF-8"], "command": "{exe_path}", "seccomp_rule": "golang", "memory_limit_check_only": 1}, "compile": {"env": ["GOCACHE=/tmp", "GOPATH=/tmp", "GOMAXPROCS=1", "LANG=en_US.UTF-8", "LANGUAGE=en_US:en", "LC_ALL=en_US.UTF-8"], "exe_name": "main", "src_name": "main.go", "max_memory": 1073741824, "max_cpu_time": 3000, "max_real_time": 5000, "compile_command": "/usr/bin/go build -o {exe_path} {src_path}"}, "template": "//PREPEND BEGIN\\n//PREPEND END\\n\\n//TEMPLATE BEGIN\\n//TEMPLATE END\\n\\n//APPEND BEGIN\\n//APPEND END"}, "description": "Golang 1.17", "content_type": "text/x-go"}, {"name": "JavaScript", "config": {"run": {"env": ["LANG=en_US.UTF-8", "LANGUAGE=en_US:en", "LC_ALL=en_US.UTF-8"], "command": "/usr/bin/node {exe_path}", "seccomp_rule": "node", "memory_limit_check_only": 1}, "compile": {"env": ["LANG=en_US.UTF-8", "LANGUAGE=en_US:en", "LC_ALL=en_US.UTF-8"], "exe_name": "main.js", "src_name": "main.js", "max_memory": 1073741824, "max_cpu_time": 3000, "max_real_time": 5000, "compile_command": "/usr/bin/node --check {src_path}"}, "template": "//PREPEND BEGIN\\n//PREPEND END\\n\\n//TEMPLATE BEGIN\\n//TEMPLATE END\\n\\n//APPEND BEGIN\\n//APPEND END"}, "description": "Node 14", "content_type": "text/javascript"}]
\.


--
-- Data for Name: problem; Type: TABLE DATA; Schema: public; Owner: onlinejudge
--

COPY public.problem (id, title, description, input_description, output_description, samples, test_case_id, test_case_score, hint, languages, template, create_time, last_update_time, time_limit, memory_limit, spj, spj_language, spj_code, spj_version, rule_type, visible, difficulty, source, submission_number, accepted_number, created_by_id, _id, statistic_info, total_score, contest_id, is_public, spj_compile_ok, io_mode, share_submission, editorial) FROM stdin;
1	Hello Codebase	<p>Your task is simple — print the exact line:</p><pre><code class="lang-css"><div class="contain-inline-size rounded-2xl relative bg-token-sidebar-surface-primary"><div class="sticky top-9"><div class="absolute end-0 bottom-0 flex h-9 items-center pe-2"></div></div><div class="overflow-y-auto p-4"><code class="whitespace-pre!">Welcome <span class="hljs-selector-tag">to</span> Codebase Online Judge!</code></div></div></code></pre>	<p>no input</p>	<p><code>Welcome to Codebase Online Judge!</code><br /></p>	[{"input": " ", "output": "Welcome to Codebase Online Judge!"}]	8440a0dd6412795983de6b4302807cfa	[{"score": 100, "input_name": "1.in", "output_name": "1.out"}]		["C", "C++", "Golang", "Java", "JavaScript", "Python2", "Python3"]	{}	2025-10-30 09:51:48.765173+00	\N	1000	256	f	\N	\N	\N	ACM	t	Low		4	2	1	CB101	{"0": 2, "-2": 2}	0	2	f	f	{"input": "input.txt", "output": "output.txt", "io_mode": "Standard IO"}	f	\N
4	Sum of Large Numbers	<p>Given two integers<strong>A</strong>and<strong>B</strong>, output their sum.<br />This problem tests large integer handling, basic stdin/stdout parsing, and multiple language consistency.<br /></p>	<p>Two integers<strong>A</strong>and<strong>B</strong>separated by a space.</p><p>(1 ≤ A, B ≤ 10¹⁸)</p>	<p>Print<strong>A + B</strong><br /></p>	[{"input": "999999999999999999 1\\n", "output": "1000000000000000000\\n"}]	36801126cd6738baafc8fdf071491c7e	[{"score": 33, "input_name": "1.in", "output_name": "1.out"}, {"score": 33, "input_name": "2.in", "output_name": "2.out"}, {"score": 33, "input_name": "3.in", "output_name": "3.out"}]		["C", "C++", "Golang", "Java", "JavaScript", "Python2", "Python3"]	{}	2025-11-06 19:29:46.692551+00	\N	60000	256	f	\N	\N	\N	ACM	t	Low		2	1	1	cb102	{"0": 1, "4": 1}	0	4	t	f	{"input": "input.txt", "output": "output.txt", "io_mode": "Standard IO"}	t	\N
3	Sum of Large Numbers	<p>Given two integers<strong>A</strong>and<strong>B</strong>, output their sum.<br />This problem tests large integer handling, basic stdin/stdout parsing, and multiple language consistency.<br /></p>	<p>Two integers<strong>A</strong>and<strong>B</strong>separated by a space.</p><p>(1 ≤ A, B ≤ 10¹⁸)</p>	<p>Print<strong>A + B</strong><br /></p>	[{"input": "999999999999999999 1\\n", "output": "1000000000000000000\\n"}]	36801126cd6738baafc8fdf071491c7e	[{"score": 33, "input_name": "1.in", "output_name": "1.out"}, {"score": 33, "input_name": "2.in", "output_name": "2.out"}, {"score": 33, "input_name": "3.in", "output_name": "3.out"}]		["C", "C++", "Golang", "Java", "JavaScript", "Python2", "Python3"]	{}	2025-10-30 18:00:16.221787+00	\N	60000	256	f	\N	\N	\N	ACM	t	Low		9	1	1	CB102	{"0": 1, "4": 7, "-2": 1}	0	2	t	f	{"input": "input.txt", "output": "output.txt", "io_mode": "Standard IO"}	t	\N
5	Sum of Large Numbers	<p>Given two integers<strong>A</strong>and<strong>B</strong>, output their sum.<br />This problem tests large integer handling, basic stdin/stdout parsing, and multiple language consistency.<br /></p>	<p>Two integers<strong>A</strong>and<strong>B</strong>separated by a space.</p><p>(1 ≤ A, B ≤ 10¹⁸)</p>	<p>Print<strong>A + B</strong><br /></p>	[{"input": "999999999999999999 1\\n", "output": "1000000000000000000\\n"}]	36801126cd6738baafc8fdf071491c7e	[{"score": 33, "input_name": "1.in", "output_name": "1.out"}, {"score": 33, "input_name": "2.in", "output_name": "2.out"}, {"score": 33, "input_name": "3.in", "output_name": "3.out"}]		["C", "C++", "Golang", "Java", "JavaScript", "Python2", "Python3"]	{}	2025-11-06 20:00:56.629863+00	\N	60000	256	f	\N	\N	\N	ACM	t	Low		1	1	1	cb102	{"0": 1}	0	5	t	f	{"input": "input.txt", "output": "output.txt", "io_mode": "Standard IO"}	t	\N
2	Sum of Large Numbers	<p>Given two integers<strong>A</strong>and<strong>B</strong>, output their sum.<br />This problem tests large integer handling, basic stdin/stdout parsing, and multiple language consistency.<br /></p>	<p>Two integers<strong>A</strong>and<strong>B</strong>separated by a space.</p><p>(1 ≤ A, B ≤ 10¹⁸)</p>	<p>Print<strong>A + B</strong><br /></p>	[{"input": "999999999999999999 1\\n", "output": "1000000000000000000\\n"}]	36801126cd6738baafc8fdf071491c7e	[{"score": 33, "input_name": "1.in", "output_name": "1.out"}, {"score": 33, "input_name": "2.in", "output_name": "2.out"}, {"score": 33, "input_name": "3.in", "output_name": "3.out"}]		["C", "C++", "Golang", "Java", "JavaScript", "Python2", "Python3"]	{}	2025-10-30 17:59:39.084842+00	\N	60000	256	f	\N	\N	\N	ACM	t	Low		30	15	1	CB102	{"0": 15, "4": 4, "-1": 1, "-2": 8}	0	\N	f	f	{"input": "input.txt", "output": "output.txt", "io_mode": "Standard IO"}	t	\N
\.


--
-- Data for Name: problem_tag; Type: TABLE DATA; Schema: public; Owner: onlinejudge
--

COPY public.problem_tag (id, name) FROM stdin;
1	strings
2	io
3	basic
4	math
5	big-integer
\.


--
-- Data for Name: problem_tags; Type: TABLE DATA; Schema: public; Owner: onlinejudge
--

COPY public.problem_tags (id, problem_id, problemtag_id) FROM stdin;
1	1	1
2	1	2
3	1	3
16	2	2
17	2	4
18	2	5
19	3	2
20	3	4
21	3	5
22	4	2
23	4	4
24	4	5
25	5	2
26	5	4
27	5	5
\.


--
-- Data for Name: submission; Type: TABLE DATA; Schema: public; Owner: onlinejudge
--

COPY public.submission (id, contest_id, problem_id, create_time, user_id, code, result, info, language, shared, statistic_info, username, ip) FROM stdin;
ddd7d7be56956bc2f2ce53ab3fe50d5e	2	1	2025-10-30 09:53:43.898887+00	1	print("Welcome to Codebase Online Judge!")	5	{}	Python3	f	{}	root	172.18.0.1
463650b4808dba4ba2553c7685e05720	2	1	2025-10-30 09:54:07.957769+00	1	print("Welcome to Codebase Online Judge!")	5	{}	Python3	f	{}	root	172.18.0.1
67cb9b6b7684f393c4519b7fe5d80e55	2	1	2025-11-04 20:49:59.110141+00	1	print("Welcome to Codebase Online Judge!")	0	{"err": null, "data": [{"error": 0, "memory": 6729728, "output": null, "result": 0, "signal": 0, "cpu_time": 2, "exit_code": 0, "real_time": 4, "test_case": "1", "output_md5": "11880b02f189b0a6037a89cc50141e27"}]}	Python3	f	{"time_cost": 2, "memory_cost": 6729728}	root	172.18.0.1
f146e96f19ac353d617d36b119a50889	2	1	2025-10-30 09:54:38.623054+00	1	print("Hello World!")	5	{}	Python3	f	{}	root	172.18.0.1
81cfd26049877e4ceff066f8ef4a14e2	2	1	2025-10-30 09:55:58.006743+00	2	print("Welcome to Codebase Online Judge!")	5	{}	Python3	f	{}	avpthegreat	172.18.0.1
551b4102b664f5b43b0c20d2e10dc201	2	1	2025-10-30 12:37:26.783819+00	1	print("Welcome to Codebase Online Judge!")	-2	{}	C	f	{"score": 0, "err_info": "/judger/run/71bc0a711a134269a1b6aa219ce0bd6a/main.c:1:7: error: expected declaration specifiers or '...' before string constant\\n    1 | print(\\"Welcome to Codebase Online Judge!\\")\\n      |       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"}	root	172.18.0.1
41a7b647ffaf0791a576bca7b150d60a	2	1	2025-10-30 12:38:24.61011+00	1	print("Welcome to Codebase Online Judge!")	-2	{}	Python3	f	{"score": 0, "err_info": "ValueError :Error occurred while calling judger: b'rosetta error: mmap_anonymous_rw mmap failed, size=1000\\\\n '"}	root	172.18.0.1
23bfa64a58d0fe32ddd373b098f44500	\N	2	2025-11-06 07:00:58.570682+00	2	import (\n\t"fmt"\n)\n\nfunc main() {\n\tvar a, b int64\n\tfmt.Scan(&a, &b)\n\tfmt.Println(a + b)\n}	-2	{}	Golang	f	{"score": 0, "err_info": "main.go:1:1: expected 'package', found 'import'"}	avpthegreat	172.18.0.1
28b55ee8b9efd3bc8137060cc1d05279	2	1	2025-10-30 12:39:26.59086+00	1	#include <stdio.h>\n\nint main() {\n    printf("Welcome to Codebase Online Judge!");\n    return 0;\n}	0	{"err": null, "data": [{"error": 0, "memory": 1085440, "output": null, "result": 0, "signal": 0, "cpu_time": 0, "exit_code": 0, "real_time": 1, "test_case": "1", "output_md5": "11880b02f189b0a6037a89cc50141e27"}]}	C	f	{"score": 0, "err_info": "Test case not found", "time_cost": 0, "memory_cost": 1085440}	root	172.18.0.1
1db021580c5648f88497a4fb4116082f	2	3	2025-10-30 18:01:21.008461+00	2	print(A+B)	4	{"err": null, "data": [{"error": 0, "memory": 7163904, "output": null, "result": 4, "signal": 0, "cpu_time": 5, "exit_code": 2, "real_time": 10, "test_case": "1", "output_md5": null}, {"error": 0, "memory": 7180288, "output": null, "result": 4, "signal": 0, "cpu_time": 5, "exit_code": 2, "real_time": 10, "test_case": "2", "output_md5": null}, {"error": 0, "memory": 7180288, "output": null, "result": 4, "signal": 0, "cpu_time": 6, "exit_code": 2, "real_time": 14, "test_case": "3", "output_md5": null}]}	Python3	f	{"time_cost": 6, "memory_cost": 7180288}	avpthegreat	172.18.0.1
23652f74fe6468db10960598693683e1	2	3	2025-10-30 18:02:27.115443+00	2	print(A+B)	-2	{}	Python2	f	{"score": 0, "err_info": "Compiler runtime error, info: {\\"cpu_time\\": 0, \\"real_time\\": 0, \\"memory\\": 0, \\"signal\\": 10, \\"exit_code\\": 0, \\"error\\": 0, \\"result\\": 5}"}	avpthegreat	172.18.0.1
23309caddc670b4a37b1e350197cd5ae	2	3	2025-10-30 18:04:16.655318+00	2	A, B = map(int, input().split())\nprint(A + B)	4	{"err": null, "data": [{"error": 0, "memory": 7180288, "output": null, "result": 4, "signal": 0, "cpu_time": 4, "exit_code": 2, "real_time": 9, "test_case": "1", "output_md5": null}, {"error": 0, "memory": 7106560, "output": null, "result": 4, "signal": 0, "cpu_time": 4, "exit_code": 2, "real_time": 9, "test_case": "2", "output_md5": null}, {"error": 0, "memory": 7163904, "output": null, "result": 4, "signal": 0, "cpu_time": 4, "exit_code": 2, "real_time": 9, "test_case": "3", "output_md5": null}]}	Python3	f	{"time_cost": 4, "memory_cost": 7180288}	avpthegreat	172.18.0.1
26efece15ec5e8cabbf0ec81d4f158a5	2	3	2025-10-30 18:04:35.676853+00	2	print(A + B)	4	{"err": null, "data": [{"error": 0, "memory": 7176192, "output": null, "result": 4, "signal": 0, "cpu_time": 6, "exit_code": 2, "real_time": 9, "test_case": "1", "output_md5": null}, {"error": 0, "memory": 7180288, "output": null, "result": 4, "signal": 0, "cpu_time": 6, "exit_code": 2, "real_time": 10, "test_case": "2", "output_md5": null}, {"error": 0, "memory": 7180288, "output": null, "result": 4, "signal": 0, "cpu_time": 7, "exit_code": 2, "real_time": 10, "test_case": "3", "output_md5": null}]}	Python3	f	{"time_cost": 7, "memory_cost": 7180288}	avpthegreat	172.18.0.1
c34fb056a63582f8ddb5ca1654157e39	2	3	2025-10-30 18:06:04.236271+00	2	print(A + B)	4	{"err": null, "data": [{"error": 0, "memory": 7114752, "output": null, "result": 4, "signal": 0, "cpu_time": 7, "exit_code": 2, "real_time": 10, "test_case": "1", "output_md5": null}, {"error": 0, "memory": 7180288, "output": null, "result": 4, "signal": 0, "cpu_time": 5, "exit_code": 2, "real_time": 9, "test_case": "2", "output_md5": null}, {"error": 0, "memory": 7180288, "output": null, "result": 4, "signal": 0, "cpu_time": 6, "exit_code": 2, "real_time": 9, "test_case": "3", "output_md5": null}]}	Python3	f	{"time_cost": 7, "memory_cost": 7180288}	avpthegreat	172.18.0.1
3a50b787194fef845e568bc73566a395	\N	2	2025-10-30 18:07:09.276199+00	2	A = int(input())\nB = int(input())\nprint(A+B)	4	{"err": null, "data": [{"error": 0, "memory": 7180288, "output": null, "result": 4, "signal": 0, "cpu_time": 6, "exit_code": 2, "real_time": 11, "test_case": "1", "output_md5": null}, {"error": 0, "memory": 7180288, "output": null, "result": 4, "signal": 0, "cpu_time": 4, "exit_code": 2, "real_time": 10, "test_case": "2", "output_md5": null}, {"error": 0, "memory": 7180288, "output": null, "result": 4, "signal": 0, "cpu_time": 3, "exit_code": 2, "real_time": 10, "test_case": "3", "output_md5": null}]}	Python3	f	{"time_cost": 6, "memory_cost": 7180288}	avpthegreat	172.18.0.1
670760585a173e1138a146571f9cc91a	2	3	2025-10-30 18:43:02.198804+00	1	A = int(input())\nB = int(input())\nprint(A+B)	4	{"err": null, "data": [{"error": 0, "memory": 7114752, "output": null, "result": 4, "signal": 0, "cpu_time": 5, "exit_code": 2, "real_time": 8, "test_case": "1", "output_md5": null}, {"error": 0, "memory": 7180288, "output": null, "result": 4, "signal": 0, "cpu_time": 5, "exit_code": 2, "real_time": 8, "test_case": "2", "output_md5": null}, {"error": 0, "memory": 7106560, "output": null, "result": 4, "signal": 0, "cpu_time": 6, "exit_code": 2, "real_time": 8, "test_case": "3", "output_md5": null}]}	Python3	f	{"time_cost": 6, "memory_cost": 7180288}	root	172.18.0.1
8bda1cc00060260f6b7f687e69b8c4f8	2	3	2025-10-30 21:53:19.877432+00	2	a, b = map(int, input().split())\nprint(a + b)	4	{"err": null, "data": [{"error": 0, "memory": 7094272, "output": null, "result": 4, "signal": 0, "cpu_time": 7, "exit_code": 2, "real_time": 11, "test_case": "1", "output_md5": null}, {"error": 0, "memory": 7077888, "output": null, "result": 4, "signal": 0, "cpu_time": 7, "exit_code": 2, "real_time": 10, "test_case": "2", "output_md5": null}, {"error": 0, "memory": 7090176, "output": null, "result": 4, "signal": 0, "cpu_time": 5, "exit_code": 2, "real_time": 11, "test_case": "3", "output_md5": null}]}	Python3	f	{"time_cost": 7, "memory_cost": 7094272}	avpthegreat	172.18.0.1
c916912e08881beacd320b1ca25e5406	2	3	2025-10-30 21:53:49.150168+00	2	a, b = map(int, input().split())\nprint(a + b)	0	{"err": null, "data": [{"error": 0, "memory": 6971392, "output": null, "result": 0, "signal": 0, "cpu_time": 5, "exit_code": 0, "real_time": 9, "test_case": "1", "output_md5": "c20ad4d76fe97759aa27a0c99bff6710"}, {"error": 0, "memory": 6987776, "output": null, "result": 0, "signal": 0, "cpu_time": 5, "exit_code": 0, "real_time": 9, "test_case": "2", "output_md5": "e4da3b7fbbce2345d7772b0674a318d5"}, {"error": 0, "memory": 7024640, "output": null, "result": 0, "signal": 0, "cpu_time": 4, "exit_code": 0, "real_time": 9, "test_case": "3", "output_md5": "65a3ae52c278e2b96852e99530d41233"}]}	Python3	f	{"time_cost": 5, "memory_cost": 7024640}	avpthegreat	172.18.0.1
8e7ae16dd8992d441c0f7dcecbe0bbe5	\N	2	2025-10-31 05:13:04.669238+00	1	a, b = map(int, input().split())\nprint(a + b)	0	{"err": null, "data": [{"error": 0, "memory": 6975488, "output": null, "result": 0, "signal": 0, "cpu_time": 5, "exit_code": 0, "real_time": 8, "test_case": "1", "output_md5": "c20ad4d76fe97759aa27a0c99bff6710"}, {"error": 0, "memory": 6975488, "output": null, "result": 0, "signal": 0, "cpu_time": 5, "exit_code": 0, "real_time": 10, "test_case": "2", "output_md5": "e4da3b7fbbce2345d7772b0674a318d5"}, {"error": 0, "memory": 6967296, "output": null, "result": 0, "signal": 0, "cpu_time": 4, "exit_code": 0, "real_time": 8, "test_case": "3", "output_md5": "65a3ae52c278e2b96852e99530d41233"}]}	Python3	f	{"time_cost": 5, "memory_cost": 6975488}	root	\N
ec842699816258a8f77832fd4e372017	\N	2	2025-10-31 05:21:01.751673+00	2	a, b = map(int, input().split())\nprint(a + b)	0	{"err": null, "data": [{"error": 0, "memory": 7028736, "output": null, "result": 0, "signal": 0, "cpu_time": 4, "exit_code": 0, "real_time": 8, "test_case": "1", "output_md5": "c20ad4d76fe97759aa27a0c99bff6710"}, {"error": 0, "memory": 7032832, "output": null, "result": 0, "signal": 0, "cpu_time": 5, "exit_code": 0, "real_time": 8, "test_case": "2", "output_md5": "e4da3b7fbbce2345d7772b0674a318d5"}, {"error": 0, "memory": 6955008, "output": null, "result": 0, "signal": 0, "cpu_time": 6, "exit_code": 0, "real_time": 8, "test_case": "3", "output_md5": "65a3ae52c278e2b96852e99530d41233"}]}	Python3	t	{"time_cost": 6, "memory_cost": 7032832}	avpthegreat	172.18.0.1
7923ae0b68be141d28a341dd13586943	\N	2	2025-10-31 05:21:59.040023+00	2	a = int(input())\nb = int(input())\nprint(a+b)	4	{"err": null, "data": [{"error": 0, "memory": 7049216, "output": null, "result": 4, "signal": 0, "cpu_time": 4, "exit_code": 1, "real_time": 10, "test_case": "1", "output_md5": null}, {"error": 0, "memory": 6975488, "output": null, "result": 4, "signal": 0, "cpu_time": 4, "exit_code": 1, "real_time": 10, "test_case": "2", "output_md5": null}, {"error": 0, "memory": 7061504, "output": null, "result": 4, "signal": 0, "cpu_time": 4, "exit_code": 1, "real_time": 10, "test_case": "3", "output_md5": null}]}	Python3	f	{"time_cost": 4, "memory_cost": 7061504}	avpthegreat	172.18.0.1
61ce18c2bb4af514fc7a02bbdd596ccf	\N	2	2025-10-31 05:22:15.834322+00	2	a,b = int(input())\nprint(a+b)	4	{"err": null, "data": [{"error": 0, "memory": 7024640, "output": null, "result": 4, "signal": 0, "cpu_time": 4, "exit_code": 1, "real_time": 11, "test_case": "1", "output_md5": null}, {"error": 0, "memory": 7057408, "output": null, "result": 4, "signal": 0, "cpu_time": 7, "exit_code": 1, "real_time": 12, "test_case": "2", "output_md5": null}, {"error": 0, "memory": 6971392, "output": null, "result": 4, "signal": 0, "cpu_time": 4, "exit_code": 1, "real_time": 11, "test_case": "3", "output_md5": null}]}	Python3	f	{"time_cost": 7, "memory_cost": 7057408}	avpthegreat	172.18.0.1
6ad388573f0bf895aaf1be85c45e63a7	\N	2	2025-10-31 05:22:53.047396+00	2	package main\n\nimport "fmt"\n\nfunc main() {\n\tvar a, b int\n\tfmt.Scan(&a, &b)\n\tfmt.Println(a + b)\n}	-2	{}	Golang	f	{"score": 0, "err_info": "Compiler runtime error, info: {\\"cpu_time\\": 0, \\"real_time\\": 1, \\"memory\\": 0, \\"signal\\": 10, \\"exit_code\\": 0, \\"error\\": 0, \\"result\\": 5}"}	avpthegreat	172.18.0.1
965cc65422c153391d2119fabb9a7043	\N	2	2025-10-31 05:23:02.736011+00	2	package main\n\nimport "fmt"\n\nfunc main() {\n\tvar a, b int\n\tfmt.Scan(&a, &b)\n\tfmt.Println(a + b)\n}	-2	{}	Golang	f	{"score": 0, "err_info": "Compiler runtime error, info: {\\"cpu_time\\": 0, \\"real_time\\": 1, \\"memory\\": 0, \\"signal\\": 10, \\"exit_code\\": 0, \\"error\\": 0, \\"result\\": 5}"}	avpthegreat	172.18.0.1
7b4dc2d85e29b50c02d535cc1a886e74	\N	2	2025-10-31 05:23:22.334134+00	2	console.log(a+b)	4	{"err": null, "data": [{"error": 0, "memory": 37986304, "output": null, "result": 4, "signal": 0, "cpu_time": 15, "exit_code": 1, "real_time": 20, "test_case": "1", "output_md5": null}, {"error": 0, "memory": 38162432, "output": null, "result": 4, "signal": 0, "cpu_time": 14, "exit_code": 1, "real_time": 20, "test_case": "2", "output_md5": null}, {"error": 0, "memory": 38047744, "output": null, "result": 4, "signal": 0, "cpu_time": 12, "exit_code": 1, "real_time": 20, "test_case": "3", "output_md5": null}]}	JavaScript	f	{"time_cost": 15, "memory_cost": 38162432}	avpthegreat	172.18.0.1
a20e2a704dbe09867d3616eed5e471a7	\N	2	2025-10-31 08:40:32.653701+00	1	package main\nimport "fmt"\n\nfunc main() {\n    var a, b int\n    fmt.Scan(&a, &b)\n    fmt.Println(a + b)\n}	0	{"err": null, "data": [{"error": 0, "memory": 3432448, "output": null, "result": 0, "signal": 0, "cpu_time": 0, "exit_code": 0, "real_time": 2, "test_case": "1", "output_md5": "c20ad4d76fe97759aa27a0c99bff6710"}, {"error": 0, "memory": 3420160, "output": null, "result": 0, "signal": 0, "cpu_time": 0, "exit_code": 0, "real_time": 2, "test_case": "2", "output_md5": "e4da3b7fbbce2345d7772b0674a318d5"}, {"error": 0, "memory": 3448832, "output": null, "result": 0, "signal": 0, "cpu_time": 0, "exit_code": 0, "real_time": 2, "test_case": "3", "output_md5": "65a3ae52c278e2b96852e99530d41233"}]}	Golang	f	{"time_cost": 0, "memory_cost": 3448832}	root	\N
b59533a09d6fe43855f82d904460ef0f	\N	2	2025-10-31 05:27:18.015558+00	1	package main\nimport "fmt"\nfunc main() {\n    var a, b int\n    fmt.Scan(&a, &b)\n    fmt.Println(a + b)\n}	-2	{}	Golang	f	{"score": 0, "err_info": "Compiler runtime error, info: {\\"cpu_time\\": 0, \\"real_time\\": 1, \\"memory\\": 0, \\"signal\\": 10, \\"exit_code\\": 0, \\"error\\": 0, \\"result\\": 5}"}	root	\N
d2cf6f1c167c519ec67da45890af0b5e	\N	2	2025-10-31 05:27:18.008646+00	1	#include <stdio.h>\nint main() {\n    int a, b;\n    scanf("%d %d", &a, &b);\n    printf("%d\n", a + b);\n    return 0;\n}	-2	{}	C	f	{"score": 0, "err_info": "/judger/run/c18baca58b664a50ad1f0580f04142c8/main.c: In function 'main':\\n/judger/run/c18baca58b664a50ad1f0580f04142c8/main.c:5:12: error: missing terminating \\" character\\n    5 |     printf(\\"%d\\n      |            ^~~\\n/judger/run/c18baca58b664a50ad1f0580f04142c8/main.c:6:1: error: missing terminating \\" character\\n    6 | \\", a + b);\\n      | ^~~~~~~~~~\\n/judger/run/c18baca58b664a50ad1f0580f04142c8/main.c:7:5: error: expected expression before 'return'\\n    7 |     return 0;\\n      |     ^~~~~~\\ncompilation terminated due to -fmax-errors=3."}	root	\N
79301fd3979a07f29f3427f0b5e36cd6	\N	2	2025-10-31 05:27:18.01507+00	1	const readline = require("readline");\nconst rl = readline.createInterface({input: process.stdin});\nrl.on("line", line => {\n    const [a, b] = line.split(" ").map(Number);\n    console.log(a + b);\n    rl.close();\n});	0	{"err": null, "data": [{"error": 0, "memory": 39825408, "output": null, "result": 0, "signal": 0, "cpu_time": 34, "exit_code": 0, "real_time": 46, "test_case": "1", "output_md5": "c20ad4d76fe97759aa27a0c99bff6710"}, {"error": 0, "memory": 39989248, "output": null, "result": 0, "signal": 0, "cpu_time": 26, "exit_code": 0, "real_time": 42, "test_case": "2", "output_md5": "e4da3b7fbbce2345d7772b0674a318d5"}, {"error": 0, "memory": 39723008, "output": null, "result": 0, "signal": 0, "cpu_time": 25, "exit_code": 0, "real_time": 44, "test_case": "3", "output_md5": "65a3ae52c278e2b96852e99530d41233"}]}	JavaScript	f	{"time_cost": 34, "memory_cost": 39989248}	root	\N
bd20bf17967a93aeb1bf12ba04908f31	\N	2	2025-10-31 05:27:18.014561+00	1	a, b = map(int, input().split())\nprint(a + b)	0	{"err": null, "data": [{"error": 0, "memory": 6975488, "output": null, "result": 0, "signal": 0, "cpu_time": 9, "exit_code": 0, "real_time": 15, "test_case": "1", "output_md5": "c20ad4d76fe97759aa27a0c99bff6710"}, {"error": 0, "memory": 6971392, "output": null, "result": 0, "signal": 0, "cpu_time": 2, "exit_code": 0, "real_time": 14, "test_case": "2", "output_md5": "e4da3b7fbbce2345d7772b0674a318d5"}, {"error": 0, "memory": 6975488, "output": null, "result": 0, "signal": 0, "cpu_time": 9, "exit_code": 0, "real_time": 15, "test_case": "3", "output_md5": "65a3ae52c278e2b96852e99530d41233"}]}	Python3	f	{"time_cost": 9, "memory_cost": 6975488}	root	\N
3ec3a70409d77e8358b8ded7e4ed1178	\N	2	2025-10-31 05:27:18.01333+00	1	#include <iostream>\nusing namespace std;\nint main() {\n    int a, b;\n    cin >> a >> b;\n    cout << a + b << endl;\n    return 0;\n}	0	{"err": null, "data": [{"error": 0, "memory": 2985984, "output": null, "result": 0, "signal": 0, "cpu_time": 0, "exit_code": 0, "real_time": 2, "test_case": "1", "output_md5": "c20ad4d76fe97759aa27a0c99bff6710"}, {"error": 0, "memory": 2953216, "output": null, "result": 0, "signal": 0, "cpu_time": 0, "exit_code": 0, "real_time": 2, "test_case": "2", "output_md5": "e4da3b7fbbce2345d7772b0674a318d5"}, {"error": 0, "memory": 2936832, "output": null, "result": 0, "signal": 0, "cpu_time": 0, "exit_code": 0, "real_time": 2, "test_case": "3", "output_md5": "65a3ae52c278e2b96852e99530d41233"}]}	C++	f	{"time_cost": 0, "memory_cost": 2985984}	root	\N
3263600a98587112a8ddae28b39c3855	\N	2	2025-10-31 05:27:18.013995+00	1	import java.util.Scanner;\nclass Main {\n    public static void main(String[] args) {\n        Scanner sc = new Scanner(System.in);\n        int a = sc.nextInt();\n        int b = sc.nextInt();\n        System.out.println(a + b);\n    }\n}	-1	{"err": null, "data": [{"error": 0, "memory": 45531136, "output": null, "result": -1, "signal": 0, "cpu_time": 90, "exit_code": 0, "real_time": 61, "test_case": "1", "output_md5": "a57a788ca952971a5cec1a6be901470e"}, {"error": 0, "memory": 44625920, "output": null, "result": -1, "signal": 0, "cpu_time": 85, "exit_code": 0, "real_time": 62, "test_case": "2", "output_md5": "4cf7c4d11c63d650edeb87c5206986d0"}, {"error": 0, "memory": 44347392, "output": null, "result": -1, "signal": 0, "cpu_time": 65, "exit_code": 0, "real_time": 64, "test_case": "3", "output_md5": "5598e3bc0b9cb3c2dd7a34a66cc952aa"}]}	Java	f	{"time_cost": 90, "memory_cost": 45531136}	root	\N
f759f724f299c253b8dfd32985ae4504	\N	2	2025-10-31 05:27:32.395191+00	1	a, b = map(int, input().split())\nprint(a + b)	0	{"err": null, "data": [{"error": 0, "memory": 7028736, "output": null, "result": 0, "signal": 0, "cpu_time": 3, "exit_code": 0, "real_time": 12, "test_case": "1", "output_md5": "c20ad4d76fe97759aa27a0c99bff6710"}, {"error": 0, "memory": 6967296, "output": null, "result": 0, "signal": 0, "cpu_time": 4, "exit_code": 0, "real_time": 9, "test_case": "2", "output_md5": "e4da3b7fbbce2345d7772b0674a318d5"}, {"error": 0, "memory": 7036928, "output": null, "result": 0, "signal": 0, "cpu_time": 4, "exit_code": 0, "real_time": 11, "test_case": "3", "output_md5": "65a3ae52c278e2b96852e99530d41233"}]}	Python3	f	{"time_cost": 4, "memory_cost": 7036928}	root	\N
f97cfe894867c880acf9f551a797fe13	\N	2	2025-10-31 05:27:32.389357+00	1	#include <stdio.h>\nint main() {\n    int a, b;\n    scanf("%d %d", &a, &b);\n    printf("%d\\n", a + b);\n    return 0;\n}	0	{"err": null, "data": [{"error": 0, "memory": 1216512, "output": null, "result": 0, "signal": 0, "cpu_time": 0, "exit_code": 0, "real_time": 2, "test_case": "1", "output_md5": "c20ad4d76fe97759aa27a0c99bff6710"}, {"error": 0, "memory": 1216512, "output": null, "result": 0, "signal": 0, "cpu_time": 0, "exit_code": 0, "real_time": 1, "test_case": "2", "output_md5": "e4da3b7fbbce2345d7772b0674a318d5"}, {"error": 0, "memory": 1212416, "output": null, "result": 0, "signal": 0, "cpu_time": 0, "exit_code": 0, "real_time": 3, "test_case": "3", "output_md5": "65a3ae52c278e2b96852e99530d41233"}]}	C	f	{"time_cost": 0, "memory_cost": 1216512}	root	\N
6695f4e4bc9b999bf3ec51328d80ca52	\N	2	2025-10-31 05:27:32.393507+00	1	#include <iostream>\nusing namespace std;\nint main() {\n    int a, b;\n    cin >> a >> b;\n    cout << a + b << endl;\n    return 0;\n}	0	{"err": null, "data": [{"error": 0, "memory": 2969600, "output": null, "result": 0, "signal": 0, "cpu_time": 1, "exit_code": 0, "real_time": 2, "test_case": "1", "output_md5": "c20ad4d76fe97759aa27a0c99bff6710"}, {"error": 0, "memory": 2846720, "output": null, "result": 0, "signal": 0, "cpu_time": 0, "exit_code": 0, "real_time": 2, "test_case": "2", "output_md5": "e4da3b7fbbce2345d7772b0674a318d5"}, {"error": 0, "memory": 2850816, "output": null, "result": 0, "signal": 0, "cpu_time": 1, "exit_code": 0, "real_time": 2, "test_case": "3", "output_md5": "65a3ae52c278e2b96852e99530d41233"}]}	C++	f	{"time_cost": 1, "memory_cost": 2969600}	root	\N
e6cc3453698dfff9032d52a3286759b2	\N	2	2025-10-31 08:11:17.025518+00	1	import java.util.Scanner;\nclass Main {\n    public static void main(String[] args) {\n        Scanner sc = new Scanner(System.in);\n        int a = sc.nextInt();\n        int b = sc.nextInt();\n        System.out.println(a + b);\n        sc.close();\n    }\n}	0	{"err": null, "data": [{"error": 0, "memory": 42127360, "output": null, "result": 0, "signal": 0, "cpu_time": 57, "exit_code": 0, "real_time": 53, "test_case": "1", "output_md5": "c20ad4d76fe97759aa27a0c99bff6710"}, {"error": 0, "memory": 42172416, "output": null, "result": 0, "signal": 0, "cpu_time": 52, "exit_code": 0, "real_time": 52, "test_case": "2", "output_md5": "e4da3b7fbbce2345d7772b0674a318d5"}, {"error": 0, "memory": 43065344, "output": null, "result": 0, "signal": 0, "cpu_time": 52, "exit_code": 0, "real_time": 65, "test_case": "3", "output_md5": "65a3ae52c278e2b96852e99530d41233"}]}	Java	f	{"time_cost": 57, "memory_cost": 43065344}	root	\N
40e1a49620d8492ba6b4c65553fbca9f	\N	2	2025-11-04 16:16:41.423812+00	2	# Read input\nA, B = map(int, input().split())\n\n# Print sum\nprint(A + B)	-2	{}	C	t	{"score": 0, "err_info": "/judger/run/7537816c4db3437cafff39e979c3fb1a/main.c:1:3: error: invalid preprocessing directive #Read\\n    1 | # Read input\\n      |   ^~~~\\n/judger/run/7537816c4db3437cafff39e979c3fb1a/main.c:2:12: error: expected expression before 'int'\\n    2 | A, B = map(int, input().split())\\n      |            ^~~\\n/judger/run/7537816c4db3437cafff39e979c3fb1a/main.c:4:3: error: invalid preprocessing directive #Print\\n    4 | # Print sum\\n      |   ^~~~~\\ncompilation terminated due to -fmax-errors=3."}	avpthegreat	192.168.65.1
622b4b5c341c918e6484826c19714c27	2	1	2025-11-04 20:50:15.311197+00	1	print("Welcome to Codebase Online Judge!")	0	{"err": null, "data": [{"error": 0, "memory": 6729728, "output": null, "result": 0, "signal": 0, "cpu_time": 1, "exit_code": 0, "real_time": 4, "test_case": "1", "output_md5": "11880b02f189b0a6037a89cc50141e27"}]}	Python3	f	{"time_cost": 1, "memory_cost": 6729728}	root	172.18.0.1
7c4bb5a32e4513ffe240533d208371b1	\N	2	2025-11-05 11:45:49.404892+00	2	package main\n\nimport (\n\t"fmt"\n)\n\nfunc main() {\n\tvar a, b int64\n\tfmt.Scan(&a, &b)\n\tfmt.Println(a + b)\n}	0	{"err": null, "data": [{"error": 0, "memory": 3428352, "output": null, "result": 0, "signal": 0, "cpu_time": 0, "exit_code": 0, "real_time": 2, "test_case": "1", "output_md5": "c20ad4d76fe97759aa27a0c99bff6710"}, {"error": 0, "memory": 3424256, "output": null, "result": 0, "signal": 0, "cpu_time": 0, "exit_code": 0, "real_time": 2, "test_case": "2", "output_md5": "e4da3b7fbbce2345d7772b0674a318d5"}, {"error": 0, "memory": 3416064, "output": null, "result": 0, "signal": 0, "cpu_time": 0, "exit_code": 0, "real_time": 2, "test_case": "3", "output_md5": "65a3ae52c278e2b96852e99530d41233"}]}	Golang	f	{"time_cost": 0, "memory_cost": 3428352}	avpthegreat	172.18.0.1
7c1516c089c1cdeab2817b3025af027d	2	1	2025-11-05 19:54:38.418327+00	2	print("Welcome to Codebase Online Judge!")	0	{"err": null, "data": [{"error": 0, "memory": 6729728, "output": null, "result": 0, "signal": 0, "cpu_time": 4, "exit_code": 0, "real_time": 7, "test_case": "1", "output_md5": "11880b02f189b0a6037a89cc50141e27"}]}	Python3	f	{"time_cost": 4, "memory_cost": 6729728}	avpthegreat	172.18.0.1
690f1e4c51757c1428efc9b341270831	2	1	2025-11-06 00:40:31.508369+00	2	print("Welcome to Codebase Online Judge!")	0	{"err": null, "data": [{"error": 0, "memory": 6729728, "output": null, "result": 0, "signal": 0, "cpu_time": 2, "exit_code": 0, "real_time": 5, "test_case": "1", "output_md5": "11880b02f189b0a6037a89cc50141e27"}]}	Python3	f	{"time_cost": 2, "memory_cost": 6729728}	avpthegreat	172.18.0.1
aab27f174d354aab43abf94345ba709a	\N	2	2025-10-31 05:27:32.394131+00	1	import java.util.Scanner;\nclass Main {\n    public static void main(String[] args) {\n        Scanner sc = new Scanner(System.in);\n        int a = sc.nextInt();\n        int b = sc.nextInt();\n        System.out.println(a + b);\n    }\n}	-1	{"err": null, "data": [{"error": 0, "memory": 45178880, "output": null, "result": -1, "signal": 0, "cpu_time": 136, "exit_code": 0, "real_time": 119, "test_case": "1", "output_md5": "a57a788ca952971a5cec1a6be901470e"}, {"error": 0, "memory": 44564480, "output": null, "result": -1, "signal": 0, "cpu_time": 125, "exit_code": 0, "real_time": 123, "test_case": "2", "output_md5": "4cf7c4d11c63d650edeb87c5206986d0"}, {"error": 0, "memory": 44777472, "output": null, "result": -1, "signal": 0, "cpu_time": 129, "exit_code": 0, "real_time": 118, "test_case": "3", "output_md5": "5598e3bc0b9cb3c2dd7a34a66cc952aa"}]}	Java	f	{"time_cost": 136, "memory_cost": 45178880}	root	\N
93fadcf305d7068334cd232ea853d8e5	2	1	2025-11-04 20:51:24.326876+00	1	console.log("Welcome to Codebase Online Judge!")	0	{"err": null, "data": [{"error": 0, "memory": 37183488, "output": null, "result": 0, "signal": 0, "cpu_time": 10, "exit_code": 0, "real_time": 15, "test_case": "1", "output_md5": "11880b02f189b0a6037a89cc50141e27"}]}	JavaScript	f	{"time_cost": 10, "memory_cost": 37183488}	root	172.18.0.1
44bee3f86e65d0d3fe0b4b641f7958cb	2	1	2025-11-05 19:54:30.849921+00	2	print("Welcome to Codebase Online Judge!\n")	-2	{}	Python3	f	{"score": 0, "err_info": "File \\"/judger/run/266971d678594c3c9eff02dfb0cf3403/solution.py\\", line 1\\n    print(\\"Welcome to Codebase Online Judge!\\n          ^\\nSyntaxError: unterminated string literal (detected at line 1)"}	avpthegreat	172.18.0.1
dbcb7391f032d0ebce394439728666ee	\N	2	2025-10-31 08:15:06.06619+00	1	const readline=require("readline");const rl=readline.createInterface({input:process.stdin});rl.on("line",line=>{const [a,b]=line.split(" ").map(Number);console.log(a+b);rl.close();});	0	{"err": null, "data": [{"error": 0, "memory": 39985152, "output": null, "result": 0, "signal": 0, "cpu_time": 24, "exit_code": 0, "real_time": 29, "test_case": "1", "output_md5": "c20ad4d76fe97759aa27a0c99bff6710"}, {"error": 0, "memory": 39501824, "output": null, "result": 0, "signal": 0, "cpu_time": 21, "exit_code": 0, "real_time": 29, "test_case": "2", "output_md5": "e4da3b7fbbce2345d7772b0674a318d5"}, {"error": 0, "memory": 39526400, "output": null, "result": 0, "signal": 0, "cpu_time": 21, "exit_code": 0, "real_time": 29, "test_case": "3", "output_md5": "65a3ae52c278e2b96852e99530d41233"}]}	JavaScript	f	{"time_cost": 24, "memory_cost": 39985152}	root	\N
bf0e009b53ae2a3ac30fe00dd39b3f10	\N	2	2025-10-31 08:15:06.076296+00	1	package main\nimport "fmt"\nfunc main() {\n    var a, b int\n    fmt.Scan(&a, &b)\n    fmt.Println(a + b)\n}	0	{"err": null, "data": [{"error": 0, "memory": 3428352, "output": null, "result": 0, "signal": 0, "cpu_time": 0, "exit_code": 0, "real_time": 3, "test_case": "1", "output_md5": "c20ad4d76fe97759aa27a0c99bff6710"}, {"error": 0, "memory": 3403776, "output": null, "result": 0, "signal": 0, "cpu_time": 0, "exit_code": 0, "real_time": 2, "test_case": "2", "output_md5": "e4da3b7fbbce2345d7772b0674a318d5"}, {"error": 0, "memory": 3461120, "output": null, "result": 0, "signal": 0, "cpu_time": 0, "exit_code": 0, "real_time": 2, "test_case": "3", "output_md5": "65a3ae52c278e2b96852e99530d41233"}]}	Golang	f	{"score": 0, "err_info": "Compiler runtime error, info: {\\"cpu_time\\": 0, \\"real_time\\": 1, \\"memory\\": 0, \\"signal\\": 10, \\"exit_code\\": 0, \\"error\\": 0, \\"result\\": 5}", "time_cost": 0, "memory_cost": 3461120}	root	\N
6ba3edadae87741f03e13c76b47cab64	2	1	2025-11-05 19:54:42.879111+00	2	print("Welcome to Codebase Online Judge!")	0	{"err": null, "data": [{"error": 0, "memory": 6729728, "output": null, "result": 0, "signal": 0, "cpu_time": 2, "exit_code": 0, "real_time": 8, "test_case": "1", "output_md5": "11880b02f189b0a6037a89cc50141e27"}]}	Python3	f	{"time_cost": 2, "memory_cost": 6729728}	avpthegreat	172.18.0.1
ce9990451105fe711d3ec00db51bac3b	\N	2	2025-11-05 20:20:56.024956+00	2	print("hello bitches")	-1	{"err": null, "data": [{"error": 0, "memory": 6729728, "output": null, "result": -1, "signal": 0, "cpu_time": 5, "exit_code": 0, "real_time": 9, "test_case": "1", "output_md5": "8c3d16bc6ef12ed3b89a43113c5e380b"}, {"error": 0, "memory": 6729728, "output": null, "result": -1, "signal": 0, "cpu_time": 7, "exit_code": 0, "real_time": 8, "test_case": "2", "output_md5": "8c3d16bc6ef12ed3b89a43113c5e380b"}, {"error": 0, "memory": 6729728, "output": null, "result": -1, "signal": 0, "cpu_time": 4, "exit_code": 0, "real_time": 8, "test_case": "3", "output_md5": "8c3d16bc6ef12ed3b89a43113c5e380b"}]}	Python3	f	{"time_cost": 7, "memory_cost": 6729728}	avpthegreat	172.18.0.1
a4ea993e4bc8b4467030285a90e47fa0	2	3	2025-11-06 02:15:29.990025+00	2	package main\n\nimport (\n\t"fmt"\n)\n\nfunc main() {\n\tvar a, b int64\n\tfmt.Scan(&a, &b)\n\tfmt.Println(a + b)\n}	0	{"err": null, "data": [{"error": 0, "memory": 3461120, "output": null, "result": 0, "signal": 0, "cpu_time": 0, "exit_code": 0, "real_time": 2, "test_case": "1", "output_md5": "c20ad4d76fe97759aa27a0c99bff6710"}, {"error": 0, "memory": 3457024, "output": null, "result": 0, "signal": 0, "cpu_time": 0, "exit_code": 0, "real_time": 2, "test_case": "2", "output_md5": "e4da3b7fbbce2345d7772b0674a318d5"}, {"error": 0, "memory": 3448832, "output": null, "result": 0, "signal": 0, "cpu_time": 0, "exit_code": 0, "real_time": 2, "test_case": "3", "output_md5": "65a3ae52c278e2b96852e99530d41233"}]}	Golang	f	{"time_cost": 0, "memory_cost": 3461120}	avpthegreat	172.18.0.1
66daa1d438258cd25f625f2f7b64b6af	\N	2	2025-11-06 07:00:34.516896+00	2	package main\n\nimport (\n\t"fmt"\n)\n\nfunc main() {\n\tvar a, b int64\n\tfmt.Scan(&a, &b)\n\tfmt.Println(a + b)\n}	-2	{}	C	f	{"score": 0, "err_info": "/judger/run/64da5d82164f41288cbf864da3e68d0f/main.c:1:1: error: unknown type name 'package'\\n    1 | package main\\n      | ^~~~~~~\\n/judger/run/64da5d82164f41288cbf864da3e68d0f/main.c:3:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'import'\\n    3 | import (\\n      | ^~~~~~"}	avpthegreat	172.18.0.1
77e28b5acc034b2b0b263c3605df9c18	\N	2	2025-11-06 07:01:07.863254+00	2	package main\nimport (\n\t"fmt"\n)\n\nfunc main() {\n\tvar a, b int64\n\tfmt.Scan(&a, &b)\n\tfmt.Println(a + b)\n}	0	{"err": null, "data": [{"error": 0, "memory": 3424256, "output": null, "result": 0, "signal": 0, "cpu_time": 0, "exit_code": 0, "real_time": 4, "test_case": "1", "output_md5": "c20ad4d76fe97759aa27a0c99bff6710"}, {"error": 0, "memory": 3407872, "output": null, "result": 0, "signal": 0, "cpu_time": 0, "exit_code": 0, "real_time": 4, "test_case": "2", "output_md5": "e4da3b7fbbce2345d7772b0674a318d5"}, {"error": 0, "memory": 3428352, "output": null, "result": 0, "signal": 0, "cpu_time": 0, "exit_code": 0, "real_time": 4, "test_case": "3", "output_md5": "65a3ae52c278e2b96852e99530d41233"}]}	Golang	f	{"time_cost": 0, "memory_cost": 3428352}	avpthegreat	172.18.0.1
5497b2110eff3819e41aeb390743c070	2	1	2025-11-06 07:03:51.264694+00	2	print("Welcome to Codebase Online Judge!")	0	{"err": null, "data": [{"error": 0, "memory": 6729728, "output": null, "result": 0, "signal": 0, "cpu_time": 4, "exit_code": 0, "real_time": 4, "test_case": "1", "output_md5": "11880b02f189b0a6037a89cc50141e27"}]}	Python3	f	{"time_cost": 4, "memory_cost": 6729728}	avpthegreat	172.18.0.1
563222c16c5805f9694bfc65c4b0f74b	\N	2	2025-11-06 07:07:28.879725+00	2	package main\nimport (\n\t"fmt"\n)\n\nfunc main() {\n\tvar a, b int64\n\tfmt.Scan(&a, &b)\n\tfmt.Println(a + b)\n}	0	{"err": null, "data": [{"error": 0, "memory": 3301376, "output": null, "result": 0, "signal": 0, "cpu_time": 0, "exit_code": 0, "real_time": 2, "test_case": "1", "output_md5": "c20ad4d76fe97759aa27a0c99bff6710"}, {"error": 0, "memory": 3280896, "output": null, "result": 0, "signal": 0, "cpu_time": 0, "exit_code": 0, "real_time": 2, "test_case": "2", "output_md5": "e4da3b7fbbce2345d7772b0674a318d5"}, {"error": 0, "memory": 3375104, "output": null, "result": 0, "signal": 0, "cpu_time": 0, "exit_code": 0, "real_time": 1, "test_case": "3", "output_md5": "65a3ae52c278e2b96852e99530d41233"}]}	Golang	f	{"time_cost": 0, "memory_cost": 3375104}	avpthegreat	172.18.0.1
503f553d4bc677f97bfab0e97fa56ff1	2	1	2025-11-06 07:09:32.127221+00	2	print("Welcome to Codebase Online Judge!")	0	{"err": null, "data": [{"error": 0, "memory": 6717440, "output": null, "result": 0, "signal": 0, "cpu_time": 2, "exit_code": 0, "real_time": 4, "test_case": "1", "output_md5": "11880b02f189b0a6037a89cc50141e27"}]}	Python3	f	{"time_cost": 2, "memory_cost": 6717440}	avpthegreat	172.18.0.1
589cf59ba1f8a2373c4c58be5330bb22	2	1	2025-11-06 18:45:26.191297+00	3	print("Welcome to Codebase Online Judge!")	-2	{}	C	f	{"score": 0, "err_info": "/judger/run/e142dd7d8f834b7d8d3e8cdcf9d3ae73/main.c:1:7: error: expected declaration specifiers or '...' before string constant\\n    1 | print(\\"Welcome to Codebase Online Judge!\\")\\n      |       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"}	anant	172.18.0.1
9558824e48e37d476e1b00c71a513ae6	2	1	2025-11-06 18:45:42.958239+00	3	print("Welcome to Codebase Online Judge!")	0	{"err": null, "data": [{"error": 0, "memory": 6729728, "output": null, "result": 0, "signal": 0, "cpu_time": 3, "exit_code": 0, "real_time": 4, "test_case": "1", "output_md5": "11880b02f189b0a6037a89cc50141e27"}]}	Python3	f	{"time_cost": 3, "memory_cost": 6729728}	anant	172.18.0.1
d2e8574d5ced6b12dc7002c3d5a86bc0	2	1	2025-11-06 18:46:28.865456+00	3	print("Welcome to Codebase Online Judge!")	0	{"err": null, "data": [{"error": 0, "memory": 6729728, "output": null, "result": 0, "signal": 0, "cpu_time": 2, "exit_code": 0, "real_time": 4, "test_case": "1", "output_md5": "11880b02f189b0a6037a89cc50141e27"}]}	Python3	f	{"time_cost": 2, "memory_cost": 6729728}	anant	172.18.0.1
f38f55b32cd7ede21beef1427e1b0112	4	4	2025-11-06 19:31:00.627687+00	3	console.log(A+B)	4	{"err": null, "data": [{"error": 0, "memory": 36806656, "output": null, "result": 4, "signal": 0, "cpu_time": 10, "exit_code": 1, "real_time": 23, "test_case": "1", "output_md5": null}, {"error": 0, "memory": 36679680, "output": null, "result": 4, "signal": 0, "cpu_time": 13, "exit_code": 1, "real_time": 23, "test_case": "2", "output_md5": null}, {"error": 0, "memory": 36773888, "output": null, "result": 4, "signal": 0, "cpu_time": 11, "exit_code": 1, "real_time": 23, "test_case": "3", "output_md5": null}]}	JavaScript	f	{"time_cost": 13, "memory_cost": 36806656}	anant	172.18.0.1
56ad958689f82182d1b9132a54ee99fd	4	4	2025-11-06 19:31:39.325686+00	3	import java.util.*;\npublic class Main {\n    public static void main(String[] args) {\n        Scanner sc = new Scanner(System.in);\n        long A = sc.nextLong();\n        long B = sc.nextLong();\n        System.out.println(A + B);\n    }\n}	0	{"err": null, "data": [{"error": 0, "memory": 42242048, "output": null, "result": 0, "signal": 0, "cpu_time": 33, "exit_code": 0, "real_time": 45, "test_case": "1", "output_md5": "c20ad4d76fe97759aa27a0c99bff6710"}, {"error": 0, "memory": 42184704, "output": null, "result": 0, "signal": 0, "cpu_time": 29, "exit_code": 0, "real_time": 45, "test_case": "2", "output_md5": "e4da3b7fbbce2345d7772b0674a318d5"}, {"error": 0, "memory": 43003904, "output": null, "result": 0, "signal": 0, "cpu_time": 37, "exit_code": 0, "real_time": 43, "test_case": "3", "output_md5": "65a3ae52c278e2b96852e99530d41233"}]}	Java	f	{"time_cost": 37, "memory_cost": 43003904}	anant	172.18.0.1
91e3964cc645626c02571ea9c5b35b02	5	5	2025-11-06 20:03:02.96857+00	3	package main\n\nimport "fmt"\n\nfunc main() {\n    var A, B int64\n    fmt.Scan(&A, &B)\n    fmt.Println(A + B)\n}	0	{"err": null, "data": [{"error": 0, "memory": 3305472, "output": null, "result": 0, "signal": 0, "cpu_time": 0, "exit_code": 0, "real_time": 3, "test_case": "1", "output_md5": "c20ad4d76fe97759aa27a0c99bff6710"}, {"error": 0, "memory": 3391488, "output": null, "result": 0, "signal": 0, "cpu_time": 0, "exit_code": 0, "real_time": 3, "test_case": "2", "output_md5": "e4da3b7fbbce2345d7772b0674a318d5"}, {"error": 0, "memory": 3375104, "output": null, "result": 0, "signal": 0, "cpu_time": 0, "exit_code": 0, "real_time": 3, "test_case": "3", "output_md5": "65a3ae52c278e2b96852e99530d41233"}]}	Golang	f	{"time_cost": 0, "memory_cost": 3391488}	anant	172.18.0.1
\.


--
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: onlinejudge
--

COPY public."user" (id, password, last_login, username, email, create_time, admin_type, reset_password_token, reset_password_token_expire_time, auth_token, two_factor_auth, tfa_token, open_api, open_api_appkey, is_disabled, problem_permission, session_keys, email_verified, email_verify_token, email_verify_token_expire_time) FROM stdin;
3	pbkdf2_sha256$120000$K3XfheDcI6AJ$CJ23/vynWk+wlmk3xDl3X9YfK1gJnyC3ILmYU15HAQk=	2025-11-06 20:02:12.842786+00	anant	dkpandeycan1@gmail.com	2025-11-06 18:21:43.342837+00	Regular User	\N	\N	\N	f	\N	f	\N	f	None	["tjozoqt91jdgh729bxrm2yx0sv3jj9bk", "h5b76bvncofpq7oeulybuagovbqqg165", "xcdwfgxgmhv505284cgfo4ohtzulatu7", "usoccs4t4lldobw49meucohb8jvp670y", "of4o8zyv5f0eanc8m147rbkefw3vu7al", "q3dwd2shz4st8lngnsopldxplcpju53q", "w9bazkhsg6z3d25wv740nsyzxg2fj4uh"]	f	\N	\N
2	pbkdf2_sha256$260000$VN4G2xtvGdHL3gisCrOKbI$IGJG0kYHi8TuzjTBetGr3Q8VLJwv3PncUroKQwwTF6A=	2025-11-08 15:08:05.986088+00	avpthegreat	anantwebsites@gmail.com	2025-10-30 05:43:19.886446+00	Regular User	\N	\N	\N	f	b674d9cb0ec709dfd0ae63b599e439a5	f	\N	f	None	["b4wqp9qmc4p3j1t5u5c3omxl06qpent2", "7pcv9rt62mh6lt68qtqv30pnp0utbekg", "t9775o9syibn46pgnhpydzuwn4yurhug", "quzziw4fk3ikhs64g6y6lkt9s9hzk0n6", "668228g4sobtpe4smjfqap98xuj8nea3"]	f	\N	\N
1	pbkdf2_sha256$260000$xhSj8a7ihg1oW8WW1S7BGR$xbOl9GpOTK6bijujYc9+T/0d9NB5HLjCN8yMyCdgT2w=	2025-11-08 15:07:53.454971+00	root	\N	2025-10-22 19:39:51.691566+00	Super Admin	\N	\N	\N	f	\N	f	\N	f	All	["f8qo404xddl4w4832xvg8c4i9h7nksnu", "wwvu97aecvhdzjsmhz2e539v5c6c8zhs", "d5h362wv41rw69jmqpzy1mi9hbpyfvnx", "8c7k95cl6ha9z414bs22reoyg69nlzvg", "qzlgmvaw9jva0cn5pum7qz32nw53yoib", "11d2tmrkqg1jgebj434851wujx7rcm6r"]	f	\N	\N
\.


--
-- Data for Name: user_profile; Type: TABLE DATA; Schema: public; Owner: onlinejudge
--

COPY public.user_profile (id, acm_problems_status, avatar, blog, mood, accepted_number, submission_number, github, school, major, user_id, total_score, oi_problems_status, real_name, language) FROM stdin;
2	{"problems": {"2": {"_id": "CB102", "status": 0}}, "contest_problems": {"1": {"_id": "CB101", "status": 0}, "3": {"_id": "CB102", "status": 0}}}	/public/avatar/203d0185d4.png	\N	\N	1	14	\N	\N	\N	2	0	{}	\N	\N
3	{"contest_problems": {"1": {"_id": "CB101", "status": 0}, "4": {"_id": "cb102", "status": 0}, "5": {"_id": "cb102", "status": 0}}}	/public/avatar/default.png	\N	\N	0	0	\N	\N	\N	3	0	{}	\N	\N
1	{"problems": {"2": {"_id": "CB102", "status": 0}}}	/public/avatar/default.png	\N	\N	1	16	\N	\N	\N	1	0	{}	\N	\N
\.


--
-- Name: acm_contest_rank_id_seq; Type: SEQUENCE SET; Schema: public; Owner: onlinejudge
--

SELECT pg_catalog.setval('public.acm_contest_rank_id_seq', 4, true);


--
-- Name: announcement_id_seq; Type: SEQUENCE SET; Schema: public; Owner: onlinejudge
--

SELECT pg_catalog.setval('public.announcement_id_seq', 4, true);


--
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: onlinejudge
--

SELECT pg_catalog.setval('public.auth_group_id_seq', 1, false);


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: onlinejudge
--

SELECT pg_catalog.setval('public.auth_group_permissions_id_seq', 1, false);


--
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: onlinejudge
--

SELECT pg_catalog.setval('public.auth_permission_id_seq', 80, true);


--
-- Name: contest_announcement_id_seq; Type: SEQUENCE SET; Schema: public; Owner: onlinejudge
--

SELECT pg_catalog.setval('public.contest_announcement_id_seq', 1, true);


--
-- Name: contest_id_seq; Type: SEQUENCE SET; Schema: public; Owner: onlinejudge
--

SELECT pg_catalog.setval('public.contest_id_seq', 5, true);


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: onlinejudge
--

SELECT pg_catalog.setval('public.django_content_type_id_seq', 20, true);


--
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: onlinejudge
--

SELECT pg_catalog.setval('public.django_migrations_id_seq', 74, true);


--
-- Name: judge_server_id_seq; Type: SEQUENCE SET; Schema: public; Owner: onlinejudge
--

SELECT pg_catalog.setval('public.judge_server_id_seq', 8, true);


--
-- Name: oi_contest_rank_id_seq; Type: SEQUENCE SET; Schema: public; Owner: onlinejudge
--

SELECT pg_catalog.setval('public.oi_contest_rank_id_seq', 1, false);


--
-- Name: options_sysoptions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: onlinejudge
--

SELECT pg_catalog.setval('public.options_sysoptions_id_seq', 10, true);


--
-- Name: problem_id_seq; Type: SEQUENCE SET; Schema: public; Owner: onlinejudge
--

SELECT pg_catalog.setval('public.problem_id_seq', 5, true);


--
-- Name: problem_tag_id_seq; Type: SEQUENCE SET; Schema: public; Owner: onlinejudge
--

SELECT pg_catalog.setval('public.problem_tag_id_seq', 5, true);


--
-- Name: problem_tags_id_seq; Type: SEQUENCE SET; Schema: public; Owner: onlinejudge
--

SELECT pg_catalog.setval('public.problem_tags_id_seq', 27, true);


--
-- Name: user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: onlinejudge
--

SELECT pg_catalog.setval('public.user_id_seq', 3, true);


--
-- Name: user_profile_id_seq; Type: SEQUENCE SET; Schema: public; Owner: onlinejudge
--

SELECT pg_catalog.setval('public.user_profile_id_seq', 3, true);


--
-- Name: acm_contest_rank acm_contest_rank_pkey; Type: CONSTRAINT; Schema: public; Owner: onlinejudge
--

ALTER TABLE ONLY public.acm_contest_rank
    ADD CONSTRAINT acm_contest_rank_pkey PRIMARY KEY (id);


--
-- Name: acm_contest_rank acm_contest_rank_user_id_contest_id_26151d10_uniq; Type: CONSTRAINT; Schema: public; Owner: onlinejudge
--

ALTER TABLE ONLY public.acm_contest_rank
    ADD CONSTRAINT acm_contest_rank_user_id_contest_id_26151d10_uniq UNIQUE (user_id, contest_id);


--
-- Name: announcement announcement_pkey; Type: CONSTRAINT; Schema: public; Owner: onlinejudge
--

ALTER TABLE ONLY public.announcement
    ADD CONSTRAINT announcement_pkey PRIMARY KEY (id);


--
-- Name: auth_group auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: onlinejudge
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- Name: auth_group_permissions auth_group_permissions_group_id_permission_id_0cd325b0_uniq; Type: CONSTRAINT; Schema: public; Owner: onlinejudge
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_0cd325b0_uniq UNIQUE (group_id, permission_id);


--
-- Name: auth_group_permissions auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: onlinejudge
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: onlinejudge
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- Name: auth_permission auth_permission_content_type_id_codename_01ab375a_uniq; Type: CONSTRAINT; Schema: public; Owner: onlinejudge
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_01ab375a_uniq UNIQUE (content_type_id, codename);


--
-- Name: auth_permission auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: onlinejudge
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- Name: contest_announcement contest_announcement_pkey; Type: CONSTRAINT; Schema: public; Owner: onlinejudge
--

ALTER TABLE ONLY public.contest_announcement
    ADD CONSTRAINT contest_announcement_pkey PRIMARY KEY (id);


--
-- Name: contest contest_pkey; Type: CONSTRAINT; Schema: public; Owner: onlinejudge
--

ALTER TABLE ONLY public.contest
    ADD CONSTRAINT contest_pkey PRIMARY KEY (id);


--
-- Name: django_content_type django_content_type_app_label_model_76bd3d3b_uniq; Type: CONSTRAINT; Schema: public; Owner: onlinejudge
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq UNIQUE (app_label, model);


--
-- Name: django_content_type django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: onlinejudge
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- Name: django_dramatiq_task django_dramatiq_task_pkey; Type: CONSTRAINT; Schema: public; Owner: onlinejudge
--

ALTER TABLE ONLY public.django_dramatiq_task
    ADD CONSTRAINT django_dramatiq_task_pkey PRIMARY KEY (id);


--
-- Name: django_migrations django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: onlinejudge
--

ALTER TABLE ONLY public.django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- Name: django_session django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: onlinejudge
--

ALTER TABLE ONLY public.django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- Name: judge_server judge_server_pkey; Type: CONSTRAINT; Schema: public; Owner: onlinejudge
--

ALTER TABLE ONLY public.judge_server
    ADD CONSTRAINT judge_server_pkey PRIMARY KEY (id);


--
-- Name: oi_contest_rank oi_contest_rank_pkey; Type: CONSTRAINT; Schema: public; Owner: onlinejudge
--

ALTER TABLE ONLY public.oi_contest_rank
    ADD CONSTRAINT oi_contest_rank_pkey PRIMARY KEY (id);


--
-- Name: oi_contest_rank oi_contest_rank_user_id_contest_id_fe51a302_uniq; Type: CONSTRAINT; Schema: public; Owner: onlinejudge
--

ALTER TABLE ONLY public.oi_contest_rank
    ADD CONSTRAINT oi_contest_rank_user_id_contest_id_fe51a302_uniq UNIQUE (user_id, contest_id);


--
-- Name: options_sysoptions options_sysoptions_key_key; Type: CONSTRAINT; Schema: public; Owner: onlinejudge
--

ALTER TABLE ONLY public.options_sysoptions
    ADD CONSTRAINT options_sysoptions_key_key UNIQUE (key);


--
-- Name: options_sysoptions options_sysoptions_pkey; Type: CONSTRAINT; Schema: public; Owner: onlinejudge
--

ALTER TABLE ONLY public.options_sysoptions
    ADD CONSTRAINT options_sysoptions_pkey PRIMARY KEY (id);


--
-- Name: problem problem__id_contest_id_346645fe_uniq; Type: CONSTRAINT; Schema: public; Owner: onlinejudge
--

ALTER TABLE ONLY public.problem
    ADD CONSTRAINT problem__id_contest_id_346645fe_uniq UNIQUE (_id, contest_id);


--
-- Name: problem problem_pkey; Type: CONSTRAINT; Schema: public; Owner: onlinejudge
--

ALTER TABLE ONLY public.problem
    ADD CONSTRAINT problem_pkey PRIMARY KEY (id);


--
-- Name: problem_tag problem_tag_pkey; Type: CONSTRAINT; Schema: public; Owner: onlinejudge
--

ALTER TABLE ONLY public.problem_tag
    ADD CONSTRAINT problem_tag_pkey PRIMARY KEY (id);


--
-- Name: problem_tags problem_tags_pkey; Type: CONSTRAINT; Schema: public; Owner: onlinejudge
--

ALTER TABLE ONLY public.problem_tags
    ADD CONSTRAINT problem_tags_pkey PRIMARY KEY (id);


--
-- Name: problem_tags problem_tags_problem_id_problemtag_id_318459d1_uniq; Type: CONSTRAINT; Schema: public; Owner: onlinejudge
--

ALTER TABLE ONLY public.problem_tags
    ADD CONSTRAINT problem_tags_problem_id_problemtag_id_318459d1_uniq UNIQUE (problem_id, problemtag_id);


--
-- Name: submission submission_pkey; Type: CONSTRAINT; Schema: public; Owner: onlinejudge
--

ALTER TABLE ONLY public.submission
    ADD CONSTRAINT submission_pkey PRIMARY KEY (id);


--
-- Name: user user_pkey; Type: CONSTRAINT; Schema: public; Owner: onlinejudge
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (id);


--
-- Name: user_profile user_profile_pkey; Type: CONSTRAINT; Schema: public; Owner: onlinejudge
--

ALTER TABLE ONLY public.user_profile
    ADD CONSTRAINT user_profile_pkey PRIMARY KEY (id);


--
-- Name: user_profile user_profile_user_id_key; Type: CONSTRAINT; Schema: public; Owner: onlinejudge
--

ALTER TABLE ONLY public.user_profile
    ADD CONSTRAINT user_profile_user_id_key UNIQUE (user_id);


--
-- Name: user user_username_key; Type: CONSTRAINT; Schema: public; Owner: onlinejudge
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key UNIQUE (username);


--
-- Name: acm_contest_rank_contest_id_21030ccd; Type: INDEX; Schema: public; Owner: onlinejudge
--

CREATE INDEX acm_contest_rank_contest_id_21030ccd ON public.acm_contest_rank USING btree (contest_id);


--
-- Name: acm_contest_rank_user_id_40391ab2; Type: INDEX; Schema: public; Owner: onlinejudge
--

CREATE INDEX acm_contest_rank_user_id_40391ab2 ON public.acm_contest_rank USING btree (user_id);


--
-- Name: announcement_created_by_id_359ccf50; Type: INDEX; Schema: public; Owner: onlinejudge
--

CREATE INDEX announcement_created_by_id_359ccf50 ON public.announcement USING btree (created_by_id);


--
-- Name: auth_group_name_a6ea08ec_like; Type: INDEX; Schema: public; Owner: onlinejudge
--

CREATE INDEX auth_group_name_a6ea08ec_like ON public.auth_group USING btree (name varchar_pattern_ops);


--
-- Name: auth_group_permissions_group_id_b120cbf9; Type: INDEX; Schema: public; Owner: onlinejudge
--

CREATE INDEX auth_group_permissions_group_id_b120cbf9 ON public.auth_group_permissions USING btree (group_id);


--
-- Name: auth_group_permissions_permission_id_84c5c92e; Type: INDEX; Schema: public; Owner: onlinejudge
--

CREATE INDEX auth_group_permissions_permission_id_84c5c92e ON public.auth_group_permissions USING btree (permission_id);


--
-- Name: auth_permission_content_type_id_2f476e4b; Type: INDEX; Schema: public; Owner: onlinejudge
--

CREATE INDEX auth_permission_content_type_id_2f476e4b ON public.auth_permission USING btree (content_type_id);


--
-- Name: contest_announcement_contest_id_a8cb419f; Type: INDEX; Schema: public; Owner: onlinejudge
--

CREATE INDEX contest_announcement_contest_id_a8cb419f ON public.contest_announcement USING btree (contest_id);


--
-- Name: contest_announcement_created_by_id_469a14ce; Type: INDEX; Schema: public; Owner: onlinejudge
--

CREATE INDEX contest_announcement_created_by_id_469a14ce ON public.contest_announcement USING btree (created_by_id);


--
-- Name: contest_created_by_id_a763ca7e; Type: INDEX; Schema: public; Owner: onlinejudge
--

CREATE INDEX contest_created_by_id_a763ca7e ON public.contest USING btree (created_by_id);


--
-- Name: django_session_expire_date_a5c62663; Type: INDEX; Schema: public; Owner: onlinejudge
--

CREATE INDEX django_session_expire_date_a5c62663 ON public.django_session USING btree (expire_date);


--
-- Name: django_session_session_key_c0390e0f_like; Type: INDEX; Schema: public; Owner: onlinejudge
--

CREATE INDEX django_session_session_key_c0390e0f_like ON public.django_session USING btree (session_key varchar_pattern_ops);


--
-- Name: oi_contest_rank_contest_id_171fcdaf; Type: INDEX; Schema: public; Owner: onlinejudge
--

CREATE INDEX oi_contest_rank_contest_id_171fcdaf ON public.oi_contest_rank USING btree (contest_id);


--
-- Name: oi_contest_rank_user_id_0ba36852; Type: INDEX; Schema: public; Owner: onlinejudge
--

CREATE INDEX oi_contest_rank_user_id_0ba36852 ON public.oi_contest_rank USING btree (user_id);


--
-- Name: problem__id_919b1d80; Type: INDEX; Schema: public; Owner: onlinejudge
--

CREATE INDEX problem__id_919b1d80 ON public.problem USING btree (_id);


--
-- Name: problem_contest_id_328e013a; Type: INDEX; Schema: public; Owner: onlinejudge
--

CREATE INDEX problem_contest_id_328e013a ON public.problem USING btree (contest_id);


--
-- Name: problem_created_by_id_cb362143; Type: INDEX; Schema: public; Owner: onlinejudge
--

CREATE INDEX problem_created_by_id_cb362143 ON public.problem USING btree (created_by_id);


--
-- Name: problem_tags_problem_id_866ecb8d; Type: INDEX; Schema: public; Owner: onlinejudge
--

CREATE INDEX problem_tags_problem_id_866ecb8d ON public.problem_tags USING btree (problem_id);


--
-- Name: problem_tags_problemtag_id_72d20571; Type: INDEX; Schema: public; Owner: onlinejudge
--

CREATE INDEX problem_tags_problemtag_id_72d20571 ON public.problem_tags USING btree (problemtag_id);


--
-- Name: submission_contest_id_775716d5; Type: INDEX; Schema: public; Owner: onlinejudge
--

CREATE INDEX submission_contest_id_775716d5 ON public.submission USING btree (contest_id);


--
-- Name: submission_problem_id_76847b55; Type: INDEX; Schema: public; Owner: onlinejudge
--

CREATE INDEX submission_problem_id_76847b55 ON public.submission USING btree (problem_id);


--
-- Name: submission_result_37e2f67a; Type: INDEX; Schema: public; Owner: onlinejudge
--

CREATE INDEX submission_result_37e2f67a ON public.submission USING btree (result);


--
-- Name: submission_user_id_3779a8c1; Type: INDEX; Schema: public; Owner: onlinejudge
--

CREATE INDEX submission_user_id_3779a8c1 ON public.submission USING btree (user_id);


--
-- Name: acm_contest_rank acm_contest_rank_contest_id_21030ccd_fk_contest_id; Type: FK CONSTRAINT; Schema: public; Owner: onlinejudge
--

ALTER TABLE ONLY public.acm_contest_rank
    ADD CONSTRAINT acm_contest_rank_contest_id_21030ccd_fk_contest_id FOREIGN KEY (contest_id) REFERENCES public.contest(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: acm_contest_rank acm_contest_rank_user_id_40391ab2_fk_user_id; Type: FK CONSTRAINT; Schema: public; Owner: onlinejudge
--

ALTER TABLE ONLY public.acm_contest_rank
    ADD CONSTRAINT acm_contest_rank_user_id_40391ab2_fk_user_id FOREIGN KEY (user_id) REFERENCES public."user"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: announcement announcement_created_by_id_359ccf50_fk_user_id; Type: FK CONSTRAINT; Schema: public; Owner: onlinejudge
--

ALTER TABLE ONLY public.announcement
    ADD CONSTRAINT announcement_created_by_id_359ccf50_fk_user_id FOREIGN KEY (created_by_id) REFERENCES public."user"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissio_permission_id_84c5c92e_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: onlinejudge
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissions_group_id_b120cbf9_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: onlinejudge
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_permission auth_permission_content_type_id_2f476e4b_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: onlinejudge
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: contest_announcement contest_announcement_contest_id_a8cb419f_fk_contest_id; Type: FK CONSTRAINT; Schema: public; Owner: onlinejudge
--

ALTER TABLE ONLY public.contest_announcement
    ADD CONSTRAINT contest_announcement_contest_id_a8cb419f_fk_contest_id FOREIGN KEY (contest_id) REFERENCES public.contest(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: contest_announcement contest_announcement_created_by_id_469a14ce_fk_user_id; Type: FK CONSTRAINT; Schema: public; Owner: onlinejudge
--

ALTER TABLE ONLY public.contest_announcement
    ADD CONSTRAINT contest_announcement_created_by_id_469a14ce_fk_user_id FOREIGN KEY (created_by_id) REFERENCES public."user"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: contest contest_created_by_id_a763ca7e_fk_user_id; Type: FK CONSTRAINT; Schema: public; Owner: onlinejudge
--

ALTER TABLE ONLY public.contest
    ADD CONSTRAINT contest_created_by_id_a763ca7e_fk_user_id FOREIGN KEY (created_by_id) REFERENCES public."user"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: oi_contest_rank oi_contest_rank_contest_id_171fcdaf_fk_contest_id; Type: FK CONSTRAINT; Schema: public; Owner: onlinejudge
--

ALTER TABLE ONLY public.oi_contest_rank
    ADD CONSTRAINT oi_contest_rank_contest_id_171fcdaf_fk_contest_id FOREIGN KEY (contest_id) REFERENCES public.contest(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: oi_contest_rank oi_contest_rank_user_id_0ba36852_fk_user_id; Type: FK CONSTRAINT; Schema: public; Owner: onlinejudge
--

ALTER TABLE ONLY public.oi_contest_rank
    ADD CONSTRAINT oi_contest_rank_user_id_0ba36852_fk_user_id FOREIGN KEY (user_id) REFERENCES public."user"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: problem problem_contest_id_328e013a_fk_contest_id; Type: FK CONSTRAINT; Schema: public; Owner: onlinejudge
--

ALTER TABLE ONLY public.problem
    ADD CONSTRAINT problem_contest_id_328e013a_fk_contest_id FOREIGN KEY (contest_id) REFERENCES public.contest(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: problem problem_created_by_id_cb362143_fk_user_id; Type: FK CONSTRAINT; Schema: public; Owner: onlinejudge
--

ALTER TABLE ONLY public.problem
    ADD CONSTRAINT problem_created_by_id_cb362143_fk_user_id FOREIGN KEY (created_by_id) REFERENCES public."user"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: problem_tags problem_tags_problem_id_866ecb8d_fk_problem_id; Type: FK CONSTRAINT; Schema: public; Owner: onlinejudge
--

ALTER TABLE ONLY public.problem_tags
    ADD CONSTRAINT problem_tags_problem_id_866ecb8d_fk_problem_id FOREIGN KEY (problem_id) REFERENCES public.problem(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: problem_tags problem_tags_problemtag_id_72d20571_fk_problem_tag_id; Type: FK CONSTRAINT; Schema: public; Owner: onlinejudge
--

ALTER TABLE ONLY public.problem_tags
    ADD CONSTRAINT problem_tags_problemtag_id_72d20571_fk_problem_tag_id FOREIGN KEY (problemtag_id) REFERENCES public.problem_tag(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: submission submission_contest_id_775716d5_fk_contest_id; Type: FK CONSTRAINT; Schema: public; Owner: onlinejudge
--

ALTER TABLE ONLY public.submission
    ADD CONSTRAINT submission_contest_id_775716d5_fk_contest_id FOREIGN KEY (contest_id) REFERENCES public.contest(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: submission submission_problem_id_76847b55_fk_problem_id; Type: FK CONSTRAINT; Schema: public; Owner: onlinejudge
--

ALTER TABLE ONLY public.submission
    ADD CONSTRAINT submission_problem_id_76847b55_fk_problem_id FOREIGN KEY (problem_id) REFERENCES public.problem(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: user_profile user_profile_user_id_8fdce8e2_fk_user_id; Type: FK CONSTRAINT; Schema: public; Owner: onlinejudge
--

ALTER TABLE ONLY public.user_profile
    ADD CONSTRAINT user_profile_user_id_8fdce8e2_fk_user_id FOREIGN KEY (user_id) REFERENCES public."user"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- PostgreSQL database dump complete
--

