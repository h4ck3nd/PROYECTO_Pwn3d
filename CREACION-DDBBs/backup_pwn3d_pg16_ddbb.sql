--
-- PostgreSQL database dump
--

-- Dumped from database version 17.4
-- Dumped by pg_dump version 17.4

-- Started on 2025-05-28 18:24:57

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 232 (class 1259 OID 73889)
-- Name: editprofile; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.editprofile (
    id integer NOT NULL,
    user_id integer NOT NULL,
    social_icon character varying(255) NOT NULL,
    title_social character varying(100) NOT NULL,
    url_social character varying(255) NOT NULL,
    estado character varying(10) DEFAULT 'Privado'::character varying NOT NULL,
    CONSTRAINT editprofile_estado_check CHECK (((estado)::text = ANY ((ARRAY['Publico'::character varying, 'Privado'::character varying])::text[])))
);


ALTER TABLE public.editprofile OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 73888)
-- Name: editprofile_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.editprofile_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.editprofile_id_seq OWNER TO postgres;

--
-- TOC entry 5068 (class 0 OID 0)
-- Dependencies: 231
-- Name: editprofile_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.editprofile_id_seq OWNED BY public.editprofile.id;


--
-- TOC entry 236 (class 1259 OID 90285)
-- Name: feedbacks; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.feedbacks (
    id integer NOT NULL,
    user_id integer NOT NULL,
    message text NOT NULL,
    estado character varying(50) DEFAULT 'Por contestar...'::character varying,
    time_created timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.feedbacks OWNER TO postgres;

--
-- TOC entry 235 (class 1259 OID 90284)
-- Name: feedbacks_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.feedbacks_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.feedbacks_id_seq OWNER TO postgres;

--
-- TOC entry 5069 (class 0 OID 0)
-- Dependencies: 235
-- Name: feedbacks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.feedbacks_id_seq OWNED BY public.feedbacks.id;


--
-- TOC entry 228 (class 1259 OID 57521)
-- Name: flags; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.flags (
    id integer NOT NULL,
    id_user integer NOT NULL,
    vm_name character varying(255) NOT NULL,
    username character varying(50) NOT NULL,
    tipo_flag character varying(10) NOT NULL,
    flag character varying(255) NOT NULL,
    first_flag_user boolean NOT NULL,
    first_flag_root boolean NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT flags_tipo_flag_check CHECK (((tipo_flag)::text = ANY ((ARRAY['user'::character varying, 'root'::character varying])::text[])))
);


ALTER TABLE public.flags OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 57520)
-- Name: flags_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.flags_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.flags_id_seq OWNER TO postgres;

--
-- TOC entry 5070 (class 0 OID 0)
-- Dependencies: 227
-- Name: flags_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.flags_id_seq OWNED BY public.flags.id;


--
-- TOC entry 230 (class 1259 OID 65697)
-- Name: imgprofile; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.imgprofile (
    id integer NOT NULL,
    user_id integer NOT NULL,
    pathimg character varying(255) NOT NULL
);


ALTER TABLE public.imgprofile OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 65696)
-- Name: imgprofile_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.imgprofile_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.imgprofile_id_seq OWNER TO postgres;

--
-- TOC entry 5071 (class 0 OID 0)
-- Dependencies: 229
-- Name: imgprofile_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.imgprofile_id_seq OWNED BY public.imgprofile.id;


--
-- TOC entry 244 (class 1259 OID 114849)
-- Name: info_notices_machines; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.info_notices_machines (
    id integer NOT NULL,
    description text,
    vm_name character varying(100) NOT NULL,
    date text NOT NULL,
    time_created timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    estado character varying(20) NOT NULL,
    os character varying(50),
    difficulty character varying(50),
    environment character varying(100),
    second_environment character varying(100),
    path_info_notice text,
    CONSTRAINT info_notices_machines_estado_check CHECK (((estado)::text = ANY ((ARRAY['publico'::character varying, 'privado'::character varying])::text[])))
);


ALTER TABLE public.info_notices_machines OWNER TO postgres;

--
-- TOC entry 243 (class 1259 OID 114848)
-- Name: info_notices_machines_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.info_notices_machines_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.info_notices_machines_id_seq OWNER TO postgres;

--
-- TOC entry 5072 (class 0 OID 0)
-- Dependencies: 243
-- Name: info_notices_machines_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.info_notices_machines_id_seq OWNED BY public.info_notices_machines.id;


--
-- TOC entry 218 (class 1259 OID 32936)
-- Name: machines; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.machines (
    id character varying(50) NOT NULL,
    name_machine character varying(100),
    size character varying(20),
    os character varying(20),
    enviroment character varying(20),
    enviroment2 character varying(20),
    creator character varying(100),
    difficulty_card character varying(20),
    difficulty character varying(20),
    date character varying(20),
    md5 character varying(64),
    writeup_url text,
    first_user character varying(100),
    first_root character varying(100),
    img_name_os character varying(100),
    download_url text,
    user_flag character varying(255) DEFAULT ''::character varying,
    root_flag character varying(255) DEFAULT ''::character varying,
    description text
);


ALTER TABLE public.machines OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 32935)
-- Name: machines_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.machines_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.machines_id_seq OWNER TO postgres;

--
-- TOC entry 5073 (class 0 OID 0)
-- Dependencies: 217
-- Name: machines_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.machines_id_seq OWNED BY public.machines.id;


--
-- TOC entry 226 (class 1259 OID 57506)
-- Name: new_vm; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.new_vm (
    id integer NOT NULL,
    user_id integer NOT NULL,
    name_vm character varying(50) NOT NULL,
    difficulty character varying(20) NOT NULL,
    creator character varying(50) NOT NULL,
    url_vm text NOT NULL,
    user_flag character varying(64) NOT NULL,
    root_flag character varying(64) NOT NULL,
    url_writeup text,
    contact character varying(100),
    tags character varying(255),
    estado character varying(20) DEFAULT 'Pendiente'::character varying,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.new_vm OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 57505)
-- Name: new_vm_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.new_vm_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.new_vm_id_seq OWNER TO postgres;

--
-- TOC entry 5074 (class 0 OID 0)
-- Dependencies: 225
-- Name: new_vm_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.new_vm_id_seq OWNED BY public.new_vm.id;


--
-- TOC entry 242 (class 1259 OID 106657)
-- Name: notices; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.notices (
    id integer NOT NULL,
    vm_name character varying(100) NOT NULL,
    date character varying(50) NOT NULL,
    creator character varying(100) NOT NULL,
    second_vm_name character varying(100),
    second_date character varying(50),
    second_creator character varying(100),
    created_notice timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    description_page text,
    estado character varying(10) NOT NULL
);


ALTER TABLE public.notices OWNER TO postgres;

--
-- TOC entry 241 (class 1259 OID 106656)
-- Name: notices_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.notices_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.notices_id_seq OWNER TO postgres;

--
-- TOC entry 5075 (class 0 OID 0)
-- Dependencies: 241
-- Name: notices_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.notices_id_seq OWNED BY public.notices.id;


--
-- TOC entry 238 (class 1259 OID 90297)
-- Name: request_loves; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.request_loves (
    id integer NOT NULL,
    user_id integer NOT NULL,
    request_id integer NOT NULL
);


ALTER TABLE public.request_loves OWNER TO postgres;

--
-- TOC entry 237 (class 1259 OID 90296)
-- Name: request_loves_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.request_loves_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.request_loves_id_seq OWNER TO postgres;

--
-- TOC entry 5076 (class 0 OID 0)
-- Dependencies: 237
-- Name: request_loves_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.request_loves_id_seq OWNED BY public.request_loves.id;


--
-- TOC entry 234 (class 1259 OID 90273)
-- Name: requests; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.requests (
    id integer NOT NULL,
    user_id integer NOT NULL,
    message text NOT NULL,
    estado character varying(20) DEFAULT 'En progreso'::character varying,
    time_created timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    loves integer DEFAULT 0
);


ALTER TABLE public.requests OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 90272)
-- Name: requests_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.requests_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.requests_id_seq OWNER TO postgres;

--
-- TOC entry 5077 (class 0 OID 0)
-- Dependencies: 233
-- Name: requests_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.requests_id_seq OWNED BY public.requests.id;


--
-- TOC entry 240 (class 1259 OID 98465)
-- Name: stars_machines; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.stars_machines (
    id integer NOT NULL,
    user_id integer NOT NULL,
    vm_name character varying(255) NOT NULL,
    number_stars integer,
    time_created timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT stars_machines_number_stars_check CHECK (((number_stars >= 1) AND (number_stars <= 5)))
);


ALTER TABLE public.stars_machines OWNER TO postgres;

--
-- TOC entry 239 (class 1259 OID 98464)
-- Name: stars_machines_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.stars_machines_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.stars_machines_id_seq OWNER TO postgres;

--
-- TOC entry 5078 (class 0 OID 0)
-- Dependencies: 239
-- Name: stars_machines_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.stars_machines_id_seq OWNED BY public.stars_machines.id;


--
-- TOC entry 220 (class 1259 OID 41121)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer NOT NULL,
    nombre character varying(100) NOT NULL,
    apellido character varying(100) NOT NULL,
    usuario character varying(50) NOT NULL,
    email character varying(100) NOT NULL,
    password character varying(255) NOT NULL,
    rol character varying(20) DEFAULT 'user'::character varying,
    cookie text,
    flags_user integer DEFAULT 0,
    flags_root integer DEFAULT 0,
    ultimo_inicio timestamp without time zone,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    code_secure character varying(255),
    puntos integer DEFAULT 0,
    pais character varying(50)
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 41120)
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO postgres;

--
-- TOC entry 5079 (class 0 OID 0)
-- Dependencies: 219
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- TOC entry 222 (class 1259 OID 49323)
-- Name: writeups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.writeups (
    id integer NOT NULL,
    url character varying(500) NOT NULL,
    vm_name character varying(100) NOT NULL,
    user_id integer NOT NULL,
    creator character varying(100) NOT NULL,
    content_type character varying(20) NOT NULL,
    language character varying(20) NOT NULL,
    opinion text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    estado character varying(20) DEFAULT 'Pendiente'::character varying
);


ALTER TABLE public.writeups OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 49322)
-- Name: writeups_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.writeups_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.writeups_id_seq OWNER TO postgres;

--
-- TOC entry 5080 (class 0 OID 0)
-- Dependencies: 221
-- Name: writeups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.writeups_id_seq OWNED BY public.writeups.id;


--
-- TOC entry 224 (class 1259 OID 49334)
-- Name: writeups_public; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.writeups_public (
    id integer NOT NULL,
    url text NOT NULL,
    vm_name character varying(100) NOT NULL,
    user_id integer NOT NULL,
    creator character varying(100) NOT NULL,
    fecha_publicacion timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    content_type character varying(20) DEFAULT 'text'::character varying NOT NULL
);


ALTER TABLE public.writeups_public OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 49333)
-- Name: writeups_public_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.writeups_public_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.writeups_public_id_seq OWNER TO postgres;

--
-- TOC entry 5081 (class 0 OID 0)
-- Dependencies: 223
-- Name: writeups_public_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.writeups_public_id_seq OWNED BY public.writeups_public.id;


--
-- TOC entry 4828 (class 2604 OID 73892)
-- Name: editprofile id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.editprofile ALTER COLUMN id SET DEFAULT nextval('public.editprofile_id_seq'::regclass);


--
-- TOC entry 4834 (class 2604 OID 90288)
-- Name: feedbacks id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.feedbacks ALTER COLUMN id SET DEFAULT nextval('public.feedbacks_id_seq'::regclass);


--
-- TOC entry 4825 (class 2604 OID 57524)
-- Name: flags id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.flags ALTER COLUMN id SET DEFAULT nextval('public.flags_id_seq'::regclass);


--
-- TOC entry 4827 (class 2604 OID 65700)
-- Name: imgprofile id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.imgprofile ALTER COLUMN id SET DEFAULT nextval('public.imgprofile_id_seq'::regclass);


--
-- TOC entry 4842 (class 2604 OID 114852)
-- Name: info_notices_machines id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.info_notices_machines ALTER COLUMN id SET DEFAULT nextval('public.info_notices_machines_id_seq'::regclass);


--
-- TOC entry 4807 (class 2604 OID 32944)
-- Name: machines id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.machines ALTER COLUMN id SET DEFAULT nextval('public.machines_id_seq'::regclass);


--
-- TOC entry 4822 (class 2604 OID 57509)
-- Name: new_vm id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.new_vm ALTER COLUMN id SET DEFAULT nextval('public.new_vm_id_seq'::regclass);


--
-- TOC entry 4840 (class 2604 OID 106660)
-- Name: notices id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notices ALTER COLUMN id SET DEFAULT nextval('public.notices_id_seq'::regclass);


--
-- TOC entry 4837 (class 2604 OID 90300)
-- Name: request_loves id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.request_loves ALTER COLUMN id SET DEFAULT nextval('public.request_loves_id_seq'::regclass);


--
-- TOC entry 4830 (class 2604 OID 90276)
-- Name: requests id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.requests ALTER COLUMN id SET DEFAULT nextval('public.requests_id_seq'::regclass);


--
-- TOC entry 4838 (class 2604 OID 98468)
-- Name: stars_machines id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stars_machines ALTER COLUMN id SET DEFAULT nextval('public.stars_machines_id_seq'::regclass);


--
-- TOC entry 4810 (class 2604 OID 41124)
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- TOC entry 4816 (class 2604 OID 49326)
-- Name: writeups id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.writeups ALTER COLUMN id SET DEFAULT nextval('public.writeups_id_seq'::regclass);


--
-- TOC entry 4819 (class 2604 OID 49337)
-- Name: writeups_public id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.writeups_public ALTER COLUMN id SET DEFAULT nextval('public.writeups_public_id_seq'::regclass);


--
-- TOC entry 5050 (class 0 OID 73889)
-- Dependencies: 232
-- Data for Name: editprofile; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.editprofile (id, user_id, social_icon, title_social, url_social, estado) FROM stdin;
18	1	website.png	Pwn3d!	https://pwn3d.es/	Privado
23	1	youtube.png	HackerLabs	https://hackerlabs.es/	Privado
24	2	x.png	test	https://test.es/	Publico
\.


--
-- TOC entry 5054 (class 0 OID 90285)
-- Dependencies: 236
-- Data for Name: feedbacks; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.feedbacks (id, user_id, message, estado, time_created) FROM stdin;
2	2	Estaria bien implementar mas decoracion en la pagina de machines.	Por contestar...	2025-05-23 16:50:13.924876
1	1	Estaria bien meter una mejora a nivel de editar el perfil del usuario.	Gracias, nos pondremos con ello pronto!	2025-05-23 16:32:36.198329
3	17	Esta muy bien la plataforma, me encanta muchisimo, seguir asi!!	Por contestar...	2025-05-24 12:37:45.22732
\.


--
-- TOC entry 5046 (class 0 OID 57521)
-- Dependencies: 228
-- Data for Name: flags; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.flags (id, id_user, vm_name, username, tipo_flag, flag, first_flag_user, first_flag_root, created_at) FROM stdin;
1	2	Avengers	admin	user	FLAG{user_flag_avengers}	t	f	2025-05-21 19:13:02.341839
2	2	Avengers	admin	root	FLAG{root_flag_avengers}	f	t	2025-05-21 19:13:02.341839
3	1	Avengers	user	user	FLAG{user_flag_avengers}	f	f	2025-05-21 19:13:02.341839
4	1	Avengers	user	root	FLAG{root_flag_avengers}	f	f	2025-05-21 19:13:02.341839
8	17	Avengers	test2	user	FLAG{user_flag_avengers}	f	f	2025-05-21 19:13:02.341839
5	1	Ctrl-X	user	user	b1ce018caed50700faffff22b16f5903	t	f	2025-05-21 19:13:02.341839
6	2	Ctrl-X	admin	root	97e2171b74984a382b62fcb39ab893c8	f	t	2025-05-21 19:13:02.341839
7	2	Ctrl-X	admin	user	b1ce018caed50700faffff22b16f5903	f	f	2025-05-21 19:13:02.341839
9	2	TpRoot	admin	user	vacio	t	f	2025-05-21 19:13:02.341839
10	2	TpRoot	admin	root	261fd3f32200f950f231816b4e9a0594	f	t	2025-05-21 19:13:02.341839
11	2	Memesploit	admin	user	58a071849802bb0d1a782f928d5a4121	t	f	2025-05-21 19:13:02.341839
12	2	Memesploit	admin	root	b57069733c1fbdf4795c0b36597c307a	f	t	2025-05-21 19:13:02.341839
13	2	r00tless	admin	user	381484fa9a5dfc3f62f0883a1297700c	t	f	2025-05-21 19:13:02.341839
14	2	r00tless	admin	root	ba10787e7f3a49c890439a44515da649	f	t	2025-05-21 19:13:02.341839
15	1	Flow	user	user	8faa61e648fe0368af3336cf7f975410	t	f	2025-05-21 19:14:04.197737
16	1	Flow	user	root	c8b85b82985842d2edddb7956cfac7b8	f	t	2025-05-21 19:14:26.875311
18	2	LFI.elf	admin	user	ed87c5c288f4909dde74cd499acbce92	t	f	2025-05-22 10:34:38.686124
19	2	LFI.elf	admin	root	2d264e1f92a8230d442750d69fba4cc5	f	t	2025-05-22 10:52:45.590515
\.


--
-- TOC entry 5048 (class 0 OID 65697)
-- Dependencies: 230
-- Data for Name: imgprofile; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.imgprofile (id, user_id, pathimg) FROM stdin;
2	1	imgProfile/avatar_1_1747817615918.png
1	2	imgProfile/avatar_2_1747914519518.jpg
3	17	imgProfile/avatar_17_1748088021831.jpg
\.


--
-- TOC entry 5062 (class 0 OID 114849)
-- Dependencies: 244
-- Data for Name: info_notices_machines; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.info_notices_machines (id, description, vm_name, date, time_created, estado, os, difficulty, environment, second_environment, path_info_notice) FROM stdin;
1	Es una maquina Windows facil, dedicada para los mas novatos que se quieren especializar en el mundo del hacking en sistemas como Windows...	Eternal	30 de Mayo, 9:00 AM	2025-05-28 10:39:46.990178	publico	Windows	Fácil	VMWare	Virtual Box	img/notices/eternal.png
\.


--
-- TOC entry 5036 (class 0 OID 32936)
-- Dependencies: 218
-- Data for Name: machines; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.machines (id, name_machine, size, os, enviroment, enviroment2, creator, difficulty_card, difficulty, date, md5, writeup_url, first_user, first_root, img_name_os, download_url, user_flag, root_flag, description) FROM stdin;
24	Darkweb	168MB	Linux	docker	\N	d1se0	Hard	hard	2024-12-17	FSLFJDKSFLSKDFS	https://dise0.gitbook.io/h4cker_b00k/ctf/ctfs/ctf-darkweb-hard			Linux	https://1024terabox.com/s/1ZABciHE1cQaiMvIrwHTbeQ	2eedcb4e067f16aa9c795fd05f3056bd	dee080ee744e9fb38952f236457f543b	\N
19	HackMeDaddy	128MB	Linux	docker	\N	d1se0	Hard	hard	2024-08-13	FSLFJDKSFLSKDFS	https://dise0.gitbook.io/h4cker_b00k/ctf/ctfs/ctf-hackmedaddy-hard			Linux	https://1024terabox.com/s/1-vNTu5NSzu7L_Ebu2r5DDA	d8109448593f23776d57bd512f322eff	2d264e1f92a8230d442750d69fba4cc5	\N
21	Jenkhack	1.05GB	Linux	docker	\N	d1se0	Easy	easy	2024-09-02	FSLFJDKSFLSKDFS	https://1024terabox.com/s/17MrEV8oN9YDM53gEwRNiNQ			Linux	https://1024terabox.com/s/10cuCmZ2Vu_gHP9soSmv5xw	3635ccd7044e99813883c8a1b95ced04	c43cb8e62105280785c7500ba705a9fc	\N
1	Ctrl-X	117MB	Linux	docker	\N	d1se0	Easy	easy	2024-08-24	61c6fa7fecce71a589e406a7b89f2f9e	https://dise0.gitbook.io/h4cker_b00k/ctf/ctfs/ctf-ctrl-x-easy	\N	\N	Linux	https://1024terabox.com/s/1USy9pZ2vJjABLiYVWi_rGw	b1ce018caed50700faffff22b16f5903	97e2171b74984a382b62fcb39ab893c8	\N
18	Memesploit	263MB	Linux	docker	\N	d1se0	Medium	medium	2024-09-01	FSLFJDKSFLSKDFS	https://dise0.gitbook.io/h4cker_b00k/ctf/ctfs/ctf-memesploit-intermediate			Linux	https://1024terabox.com/s/19TNllZXWvk6hH6Bi_eGyVg	58a071849802bb0d1a782f928d5a4121	b57069733c1fbdf4795c0b36597c307a	\N
14	Avengers	1.7GB	Linux	vbox	\N	d1se0	Easy	easy	2024-02-12	FSLFJDKSFLSKDFS	https://dise0.gitbook.io/h4cker_b00k/ctf/ctfs/ctf-avengers-easy	\N	\N	Linux	https://1024terabox.com/s/1yyH_0yHiRYoa52JD9kxtEg	FLAG{user_flag_avengers}	FLAG{root_flag_avengers}	\N
10	0xc0ffee	215MB	Linux	docker	\N	d1se0	Medium	medium	2024-08-29	538fa8395897f0b5a1f085cb19ad2809	https://dise0.gitbook.io/h4cker_b00k/ctf/ctfs/ctf-0xc0ffee-intermediate	\N	\N	Linux	https://1024terabox.com/s/1EFB58MbOBk41SUToSy8kUA	f5d22841e337cab01739e59cce3275e9	d6c4a33bec66ea2948f09a0db32335de	Explotación de Buffer Overflow con escritura de pila.
12	VulnVault	123MB	Linux	docker	\N	d1se0	Medium	medium	2024-06-01	FSLFJDKSFLSKDFS	https://dise0.gitbook.io/h4cker_b00k/ctf/ctfs/ctf-vulnvault-intermediate	\N	\N	Linux	https://1024terabox.com/s/1N6e_iaTXt249oQeJcAKbGw	030208509edea7480a10b84baca3df3e	640c89bbfa2f70a4038fd570c65d6dcc	\N
13	GuardiansOfGalaxy	2.2GB	Linux	vbox	vmware	antonio	Hard	hard	2024-07-15	FSLFJDKSFLSKDFS	\N	\N	\N	Linux	https://1024terabox.com/s/1ZJQqrpHipdFwIzpYbN8x4g	vacio	vacio	\N
16	404-not-found	125MB	Linux	docker	\N	d1se0	Easy	easy	2024-08-19	FSLFJDKSFLSKDFS	https://dise0.gitbook.io/h4cker_b00k/ctf/ctfs/ctf-404-not-found-easy			Linux	https://drive.google.com/file/d/1EF-a2vshKyVlETi33XspsmGeNsqND8JC/view?usp=sharing	bef4bb318a17abd01158337811750bcf	2424b2a3292e20c6e1ade39ed3e77629	\N
20	Mapache2	127MB	Linux	docker	\N	d1se0	Medium	medium	2024-08-23	FSLFJDKSFLSKDFS	https://dise0.gitbook.io/h4cker_b00k/ctf/ctfs/ctf-mapache2-intermediate			Linux	https://1024terabox.com/s/1hMRdUSHSnkhI4ui82kR-Og	497686fad25d7b5464ac8fd745ad1b17	e180269a01be15fc0b889bd34fd93c5c	\N
3	inj3ct0rs	327MB	Linux	docker	\N	d1se0	Medium	medium	2024-08-15	FSLFJDKSFLSKDFS	https://dise0.gitbook.io/h4cker_b00k/ctf/ctfs/ctf-inj3ct0rs-intermediate	\N	\N	Linux	https://1024terabox.com/s/1hQoBIY_Gnn5ZDjbJFGnl2Q	382af2fb41eb95b1d6c6358b6c55ffce	8e776bdaed0b6748686b7ce6d38ccca3	\N
22	chmod-4755	150MB	Linux	docker	\N	d1se0	Medium	medium	2024-09-03	FSLFJDKSFLSKDFS	https://dise0.gitbook.io/h4cker_b00k/ctf/ctfs/ctf-chmod-4755-intermediate			Linux	https://drive.google.com/file/d/1NdzO9vNuZNz6z2I7ZdpQU90Ut0NtU6HC/view?usp=sharing	04aee8d6f21f746d0655233aa1d1541a	1e4e4054308a62a2bbaacd02074f1ad2	\N
11	r00tless	334MB	Linux	docker	\N	d1se0	Hard	hard	2024-08-27	8edc5df9c19ef5576b63db9fb1549874	https://dise0.gitbook.io/h4cker_b00k/ctf/ctfs/ctf-r00tless-hard	\N	\N	Linux	https://1024terabox.com/s/1L44UipcoXTRwib11A4twSQ	381484fa9a5dfc3f62f0883a1297700c	ba10787e7f3a49c890439a44515da649	\N
23	Hackzones	127MB	Linux	docker	\N	d1se0	Medium	medium	2024-11-17	FSLFJDKSFLSKDFS	https://dise0.gitbook.io/h4cker_b00k/ctf/ctfs/ctf-hackzones-intermediate			Linux	https://1024terabox.com/s/1UgvXadfykkmMmHC9gysxeg	c187e24646744125f041582154a534bb	f034967ad357f8f912740101d3af5e71	\N
25	Flow	127MB	Linux	docker	\N	d1se0	Hard	hard	2024-12-24	FSLFJDKSFLSKDFS	https://dise0.gitbook.io/h4cker_b00k/ctf/ctfs/ctf-flow-hard			Linux	https://1024terabox.com/s/1X9CW6omD_cwtb5lmEUaeBg	8faa61e648fe0368af3336cf7f975410	c8b85b82985842d2edddb7956cfac7b8	\N
15	CrackOff	582MB	Linux	docker	\N	d1se0	Hard	hard	2024-08-21	FSLFJDKSFLSKDFS	https://dise0.gitbook.io/h4cker_b00k/ctf/ctfs/ctf-crackoff-hard			Linux	https://1024terabox.com/s/1-xvO00pJcM6gbawbO8F2tA	d099be3ff7be7294c9344daadebca767	c33b3d6c28dddad9fadd90b81fc57d24	\N
5	dance-samba	140MB	Linux	docker	\N	d1se0	Medium	medium	2024-08-19	FSLFJDKSFLSKDFS	https://dise0.gitbook.io/h4cker_b00k/ctf/ctfs/ctf-dance-samba-intermediate	\N	\N	Linux	https://1024terabox.com/s/15WebY-l9q10SeJwk05VYMg	ef65ad731de0ebabcb371fa3ad4972f1	efb6984b9b0eb57451aca3f93c8ce6b7	\N
8	LFI.elf	191MB	Linux	docker	\N	d1se0	Easy	easy	2024-08-17	FSLFJDKSFLSKDFS	https://dise0.gitbook.io/h4cker_b00k/ctf/ctfs/ctf-lfi.elf-easy	\N	\N	Linux	https://1024terabox.com/s/1VQdwiZkngICzeQ-Ph3mvzQ	ed87c5c288f4909dde74cd499acbce92	2d264e1f92a8230d442750d69fba4cc5	\N
17	PressEnter	228MB	Linux	docker	\N	d1se0	Easy	easy	2024-08-22	FSLFJDKSFLSKDFS	https://dise0.gitbook.io/h4cker_b00k/ctf/ctfs/ctf-pressenter-easy			Linux	https://1024terabox.com/s/1c5XoijfjIlUhWjkTvePTIg	4a05a7bc45edb56b1f033ca1606e176c	4e4a603de810988e0842777de1d97e68	\N
34	Goodness	4.3GB	Linux	vbox	vmware	d1se0	Easy	easy	2025-04-20	FSLFJDKSFLSKDFS	https://dise0.gitbook.io/h4cker_b00k/ctf/ctfs/ctf-goodness-easy			Linux	https://drive.google.com/file/d/1ZfCHQlCeloiXfcwoz4iXhbsv3e2mY0oM/view?usp=sharing	FLAG{user_goodness_flag}	FLAG{goodness_flag}	\N
7	Cyb3rSh1€ld	2.8GB	Linux	vbox	\N	d1se0	Medium	medium	2024-05-20	FSLFJDKSFLSKDFS	https://dise0.gitbook.io/h4cker_b00k/ctf/ctfs/ctf-cyb3rsh1eurld-intermediate	\N	\N	Linux	https://1024terabox.com/s/1VByhz9BBHXQcpyJLVN-iFw	vacio	vacio	\N
35	LogisticCloud	500MB	Linux	docker	\N	d1se0	Medium	medium	2025-05-13	FSLFJDKSFLSKDFS	https://dise0.gitbook.io/h4cker_b00k/ctf/ctfs/ctf-logisticcloud-intermediate			Linux	https://1024terabox.com/s/1bY_dtYL8qb0rr4sYGupJqg	a303ce44f50628e5511aca3538d11f3e	16ceffb6b5f596855037e8ab1718b75f	\N
36	GhostCTF	2.2GB	Linux	vbox	\N	d1se0	Hard	hard	2024-02-07	FSLFJDKSFLSKDFS	https://dise0.gitbook.io/h4cker_b00k/ctf/ctfs/ghost-ctf-hard			Linux	https://1024terabox.com/s/1ji2dLMNXY3KrzvGYqPj9qQ	FLAG{Pwn3d_user_b1ae0edce46ffb78bdd12893515d044e}	FLAG{Pwn3d_root_3a6b01999ead2569fef7ba52ce9e1243}	Maquina con tecnicas como "Reverse shell", fuerza bruta, permisos mal configurados, etc...
6	Tusty	118MB	Linux	docker	\N	d1se0	Very-Easy	very-easy	2024-08-11	FSLFJDKSFLSKDFS	\N	\N	\N	Linux	https://1024terabox.com/s/16XJ6RdORFI9KPUICSPmNkw	vacio	vacio	\N
31	TpRoot	207MB	Linux	docker	\N	d1se0	Very-Easy	very-easy	2025-02-10	FSLFJDKSFLSKDFS	https://dise0.gitbook.io/h4cker_b00k/ctf/ctfs/ctf-tproot-very-easy			Linux	https://1024terabox.com/s/1_lPd5G1HOI6LcYQ434tvFg	vacio	261fd3f32200f950f231816b4e9a0594	\N
9	Nezuko	2.8GB	Linux	vbox	\N	d1se0	Medium	medium	2024-04-28	FSLFJDKSFLSKDFS	https://d1se0.github.io/hackerlabs/writeups/Walkthrough_nezuko.pdf	\N	\N	Linux	https://1024terabox.com/s/1G-IThS_UGi-S2-8vlENq8A	vacio	vacio	\N
2	Ciberhack	1.7GB	Linux	vbox	\N	d1se0	Medium	medium	2024-04-05	FSLFJDKSFLSKDFS	https://dise0.gitbook.io/h4cker_b00k/ctf/ctfs/ctf-ciberhack-intermediate	\N	\N	Linux	https://1024terabox.com/s/15xsjpvg1JM_5dGhekeDRhA	vacio	vacio	\N
26	Sender	160MB	Linux	docker	\N	d1se0	Medium	medium	2024-12-24	FSLFJDKSFLSKDFS	https://dise0.gitbook.io/h4cker_b00k/ctf/ctfs/ctf-sender-intermediate			Linux	https://1024terabox.com/s/1NtDeAjZ0s9jsV2VRr71XPw	8d32849a53e71168af4cf5d7d03c8c53	7b99571a3a54ade50fec6091cb42e9ab	\N
30	LifeOrDead	130MB	Linux	docker	\N	d1se0	Hard	hard	2025-01-26	FSLFJDKSFLSKDFS	https://dise0.gitbook.io/h4cker_b00k/ctf/ctfs/ctf-lifeordead-hard			Linux	https://1024terabox.com/s/1JeyJsnD8VLc_qpfd7FnpTA	c92b22766f900e5bdab6700ab88dabb8	e04292d1067e92530c22e87ebfc87d28	\N
32	Gitea	390MB	Linux	docker	\N	d1se0	Medium	medium	2025-02-28	FSLFJDKSFLSKDFS	https://dise0.gitbook.io/h4cker_b00k/ctf/ctfs/ctf-gitea-intermediate			Linux	https://1024terabox.com/s/1bZqi5Vd4kHVMNN9PpumAVA	4683f3b0c2f083bb9588370c0f8ab284	d5a28ab3b2fe6d8191eb01fc3a76f5cb	\N
28	Express	234MB	Linux	docker	\N	d1se0	Medium	medium	2025-01-11	FSLFJDKSFLSKDFS	https://dise0.gitbook.io/h4cker_b00k/ctf/ctfs/ctf-express-intermediate			Linux	https://1024terabox.com/s/1NpPdubSXuKsxOaTe4Z401g	b3c3a88e29a2770f381cab74163e5a94	8d4efee97352c73a8b059a94fe69dcd1	\N
27	Cracker	121MB	Linux	docker	\N	d1se0	Medium	medium	2024-12-28	FSLFJDKSFLSKDFS	https://dise0.gitbook.io/h4cker_b00k/ctf/ctfs/ctf-cracker-intermediate			Linux	https://1024terabox.com/s/149gn1azBWcMi_DYKvlXcig	5daa85f6664733de9e889c30fe4f3792	b4276a308734432987ea1b6abb8f9ff9	\N
4	Overflow	919MB	Linux	vbox	vmware	d1se0	Easy	easy	2024-04-25	FSLFJDKSFLSKDFS	\N	\N	\N	Linux	https://1024terabox.com/s/15H4wySfCeAWiuNNDYR4qjg	vacio	vacio	\N
29	CineHack	120MB	Linux	docker	\N	d1se0	Medium	medium	2025-01-17	FSLFJDKSFLSKDFS	https://dise0.gitbook.io/h4cker_b00k/ctf/ctfs/ctf-cinehack-intermediate			Linux	https://1024terabox.com/s/1XxgrPgakLm938R_CdVLy6g	93a85c1e99d62afe15c179d4fd005f40	687f891cbfd513ac53641755ce0efe5e	\N
33	SecureLAB	299MB	Linux	docker	\N	d1se0	Hard	hard	2025-03-11	FSLFJDKSFLSKDFS	https://dise0.gitbook.io/h4cker_b00k/ctf/ctfs/ctf-securelab-hard			Linux	https://1024terabox.com/s/16D4rx5MpHl-8B03iWUCuiQ	1be10a286d4effa0df103518e39ea316	9866b73304dbe02c58a9ac37ec4c185d	\N
\.


--
-- TOC entry 5044 (class 0 OID 57506)
-- Dependencies: 226
-- Data for Name: new_vm; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.new_vm (id, user_id, name_vm, difficulty, creator, url_vm, user_flag, root_flag, url_writeup, contact, tags, estado, created_at) FROM stdin;
1	1	cloudMachine	Medium	d1se0	https://new_vm.es/vm_cloud	FLAG{pw_cloud_user}	FLAG{pw_cloud_root}	https://writeup.es/cloudMachine	d1se0@gmail.com	cloud,ctf,medium	Publicado	2025-05-18 12:24:55.918135
2	1	Avengers	Easy	d1se0	https://new_vm.es/vm_avengers	FLAG{pw_avengers_user}	FLAG{pw_avengers_root}	https://writeup.es/avengers			Publicado	2025-05-18 12:50:39.146898
\.


--
-- TOC entry 5060 (class 0 OID 106657)
-- Dependencies: 242
-- Data for Name: notices; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.notices (id, vm_name, date, creator, second_vm_name, second_date, second_creator, created_notice, description_page, estado) FROM stdin;
3	Eternal	30th May 9:00 CTE	d1se0				2025-05-27 21:09:29.996274	Es una maquina Windows en la que podras parcticar a nivel basico una vulnerabilidad muy famosa...	new
\.


--
-- TOC entry 5056 (class 0 OID 90297)
-- Dependencies: 238
-- Data for Name: request_loves; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.request_loves (id, user_id, request_id) FROM stdin;
1	2	6
2	1	6
3	1	5
4	1	4
5	1	1
6	2	1
7	2	5
8	2	7
9	1	2
10	17	6
\.


--
-- TOC entry 5052 (class 0 OID 90273)
-- Dependencies: 234
-- Data for Name: requests; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.requests (id, user_id, message, estado, time_created, loves) FROM stdin;
3	1	Quiero mas retos de BufferOverflow pro favor	En progreso	2025-05-23 15:28:00.744713	0
4	1	Me gustaria mas retos sobre XSS porfa	Mas adelante	2025-05-23 15:30:29.313966	1
1	2	Me gustaria sugerir que cuando me meto en la pagina ranking no va, es como si no la encontrara solucionarlo pronto porfa!!	Mas adelante	2025-05-23 15:00:19.920997	2
5	17	Estaria bien implementar mas CTFs dedicados a la tecnica de SQLi	En progreso	2025-05-23 16:02:39.106705	2
7	2	Estaria bien implementar un mecanismo de seguridad anter robos de tokens.	Hecho	2025-05-23 17:34:43.013587	1
2	2	Quiero mas maquinas de wordpress!!	Hecho	2025-05-23 15:05:01.674621	1
6	1	Quiero mas CTFs sobre SSTI porfa	En progreso	2025-05-23 16:33:08.841318	3
\.


--
-- TOC entry 5058 (class 0 OID 98465)
-- Dependencies: 240
-- Data for Name: stars_machines; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.stars_machines (id, user_id, vm_name, number_stars, time_created) FROM stdin;
1	2	Ctrl-X	5	2025-05-24 10:04:20.081384
2	1	Ctrl-X	2	2025-05-24 10:17:19.762639
3	17	Ctrl-X	4	2025-05-24 14:07:18.577441
\.


--
-- TOC entry 5038 (class 0 OID 41121)
-- Dependencies: 220
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, nombre, apellido, usuario, email, password, rol, cookie, flags_user, flags_root, ultimo_inicio, created_at, code_secure, puntos, pais) FROM stdin;
4	Test	Apellido	test	test@test.com	9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08	user	\N	0	0	2025-05-21 11:53:39.902316	2025-05-16 19:53:09.955949	5a3fe9bb-0c6b-4034-a267-3d5339d9a881	0	\N
20	Test3	Apellido3	test3	test4@test.com	6fec2a9601d5b3581c94f2150fc07fa3d6e45808079428354b868e412b76e6bb	user	\N	0	0	2025-05-22 19:46:38.000001	2025-05-21 18:36:57	affd84ed-bcef-4856-a09c-7cb17b3f4c1b	0	fr
2	Administrador	Boss	admin	admin@test.com	8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918	admin	\N	7	6	2025-05-28 13:15:58.942974	2025-05-16 19:48:35.822161	5f9a776b-a8b8-4c74-947d-25c2edad868c	102	es
1	Usuario	Apellido	user	user@test.com	04f8996da763b7a969b1028ee3007569eaf3a635486ddab211d512c85b9df8fb	user	\N	3	2	2025-05-28 10:32:08.344762	2025-05-16 19:08:26.411192	ff453cfd-4c24-4625-9677-050d6f9aa7a7	51	es
17	Test2	Apellido2	test2	test2@test.com	6fec2a9601d5b3581c94f2150fc07fa3d6e45808079428354b868e412b76e6bb	user	\N	1	0	2025-05-24 14:00:14.733556	2025-05-19 13:54:30.263126	3fd62ddc-c9a9-4faf-bf59-22d97c70db5c	7	\N
\.


--
-- TOC entry 5040 (class 0 OID 49323)
-- Dependencies: 222
-- Data for Name: writeups; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.writeups (id, url, vm_name, user_id, creator, content_type, language, opinion, created_at, estado) FROM stdin;
5	https://writeup.es/r00tless_writeup	r00tless	1	d1se0	Text	ES	\N	2025-05-17 17:15:48.626053	Publicado
11	https://writeup.es/VulnVault_writeup	VulnVault	1	d1se0	Video	ES	\N	2025-05-18 10:22:52.244194	Publicado
2	https://writeup.es/lower5_writeup	Ctrl-X	1	d1se0	Text	ES	Maravillosa maquinaa!	2025-05-17 16:22:08.617181	Publicado
8	https://writeup.es/lower5_writeup_admin	Ctrl-X	2	admin	Text	ES	\N	2025-05-17 17:37:57.043679	Publicado
14	https://test.com/writeup_test_url	Ctrl-X	1	mario	Text	ES	\N	2025-05-18 11:50:20.088769	Publicado
7	https://writeup.es/testNullMachine_writeup	GuardiansOfGalaxy	1	manu	Text	ES	Muy buena!	2025-05-17 17:34:49.691494	Publicado
13	https://writeup.es/change_writeup	Ciberhack	1	d1se0	Text	ES	Increible	2025-05-18 10:49:33.017468	Publicado
3	https://writeup.es/anon_writeup	inj3ct0rs	1	manu	Text	FR	\N	2025-05-17 16:45:51.553257	Publicado
9	https://writeup.es/anon_writeup_video	inj3ct0rs	1	d1se0	Video	ES	\N	2025-05-18 10:09:22.697084	Publicado
6	https://writeup.es/hit_writeup	Overflow	1	d1se0	Text	EN	\N	2025-05-17 17:28:19.864584	Publicado
15	https://noIpOnlyDomain.es/writeup_ip_null	Overflow	1	manu	Video	ES	\N	2025-05-18 11:53:37.499086	Publicado
10	https://writeup.es/tunnel_writeup_video	Tusty	1	d1se0	Video	ES	\N	2025-05-18 10:18:59.983811	Publicado
4	https://writeup.es/war_writeup	Cyb3rSh1€ld	1	mario	Text	ZH	Es increible	2025-05-17 17:15:17.804556	Publicado
12	https://writeup.es/manager_writeup_text	LFI.elf	1	admin	Text	ES	\N	2025-05-18 10:40:08.154833	Publicado
16	https://writeup.es/anon_writeup_test2	inj3ct0rs	17	test2	Text	ES	\N	2025-05-19 13:57:51.045229	Publicado
\.


--
-- TOC entry 5042 (class 0 OID 49334)
-- Dependencies: 224
-- Data for Name: writeups_public; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.writeups_public (id, url, vm_name, user_id, creator, fecha_publicacion, content_type) FROM stdin;
4	https://writeup.es/r00tless_writeup	r00tless	1	d1se0	2025-05-17 17:16:02.188545	text
11	https://writeup.es/VulnVault_writeup	VulnVault	1	d1se0	2025-05-18 10:23:06.449343	Video
1	https://writeup.es/lower5_writeup	Ctrl-X	1	d1se0	2025-05-17 16:22:42.042687	text
7	https://writeup.es/lower5_writeup_admin	Ctrl-X	2	admin	2025-05-17 17:38:13.340801	text
14	https://test.com/writeup_test_url	Ctrl-X	1	mario	2025-05-18 11:53:55.816282	Text
6	https://writeup.es/testNullMachine_writeup	GuardiansOfGalaxy	1	manu	2025-05-17 17:34:55.829823	text
13	https://writeup.es/change_writeup	Ciberhack	1	d1se0	2025-05-18 10:49:59.212025	Text
2	https://writeup.es/anon_writeup	inj3ct0rs	1	manu	2025-05-17 16:50:08.947	text
9	https://writeup.es/anon_writeup_video	inj3ct0rs	1	d1se0	2025-05-18 10:16:29.343011	Video
5	https://writeup.es/hit_writeup	Overflow	1	d1se0	2025-05-17 17:28:40.791116	text
15	https://noIpOnlyDomain.es/writeup_ip_null	Overflow	1	manu	2025-05-18 11:53:55.874091	Video
10	https://writeup.es/tunnel_writeup_video	Tusty	1	d1se0	2025-05-18 10:19:13.606172	Video
3	https://writeup.es/war_writeup	Cyb3rSh1€ld	1	mario	2025-05-17 17:16:02.123577	text
12	https://writeup.es/manager_writeup_text	LFI.elf	1	admin	2025-05-18 10:40:36.822457	Text
16	https://writeup.es/anon_writeup_test2	inj3ct0rs	17	test2	2025-05-20 16:30:40.013605	Text
\.


--
-- TOC entry 5082 (class 0 OID 0)
-- Dependencies: 231
-- Name: editprofile_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.editprofile_id_seq', 29, true);


--
-- TOC entry 5083 (class 0 OID 0)
-- Dependencies: 235
-- Name: feedbacks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.feedbacks_id_seq', 3, true);


--
-- TOC entry 5084 (class 0 OID 0)
-- Dependencies: 227
-- Name: flags_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.flags_id_seq', 19, true);


--
-- TOC entry 5085 (class 0 OID 0)
-- Dependencies: 229
-- Name: imgprofile_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.imgprofile_id_seq', 3, true);


--
-- TOC entry 5086 (class 0 OID 0)
-- Dependencies: 243
-- Name: info_notices_machines_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.info_notices_machines_id_seq', 4, true);


--
-- TOC entry 5087 (class 0 OID 0)
-- Dependencies: 217
-- Name: machines_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.machines_id_seq', 1, false);


--
-- TOC entry 5088 (class 0 OID 0)
-- Dependencies: 225
-- Name: new_vm_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.new_vm_id_seq', 2, true);


--
-- TOC entry 5089 (class 0 OID 0)
-- Dependencies: 241
-- Name: notices_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.notices_id_seq', 10, true);


--
-- TOC entry 5090 (class 0 OID 0)
-- Dependencies: 237
-- Name: request_loves_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.request_loves_id_seq', 10, true);


--
-- TOC entry 5091 (class 0 OID 0)
-- Dependencies: 233
-- Name: requests_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.requests_id_seq', 7, true);


--
-- TOC entry 5092 (class 0 OID 0)
-- Dependencies: 239
-- Name: stars_machines_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.stars_machines_id_seq', 3, true);


--
-- TOC entry 5093 (class 0 OID 0)
-- Dependencies: 219
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 22, true);


--
-- TOC entry 5094 (class 0 OID 0)
-- Dependencies: 221
-- Name: writeups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.writeups_id_seq', 16, true);


--
-- TOC entry 5095 (class 0 OID 0)
-- Dependencies: 223
-- Name: writeups_public_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.writeups_public_id_seq', 16, true);


--
-- TOC entry 4869 (class 2606 OID 73898)
-- Name: editprofile editprofile_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.editprofile
    ADD CONSTRAINT editprofile_pkey PRIMARY KEY (id);


--
-- TOC entry 4873 (class 2606 OID 90294)
-- Name: feedbacks feedbacks_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.feedbacks
    ADD CONSTRAINT feedbacks_pkey PRIMARY KEY (id);


--
-- TOC entry 4863 (class 2606 OID 57529)
-- Name: flags flags_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.flags
    ADD CONSTRAINT flags_pkey PRIMARY KEY (id);


--
-- TOC entry 4865 (class 2606 OID 65702)
-- Name: imgprofile imgprofile_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.imgprofile
    ADD CONSTRAINT imgprofile_pkey PRIMARY KEY (id);


--
-- TOC entry 4867 (class 2606 OID 65704)
-- Name: imgprofile imgprofile_user_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.imgprofile
    ADD CONSTRAINT imgprofile_user_id_key UNIQUE (user_id);


--
-- TOC entry 4885 (class 2606 OID 114858)
-- Name: info_notices_machines info_notices_machines_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.info_notices_machines
    ADD CONSTRAINT info_notices_machines_pkey PRIMARY KEY (id);


--
-- TOC entry 4849 (class 2606 OID 32946)
-- Name: machines machines_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.machines
    ADD CONSTRAINT machines_pkey PRIMARY KEY (id);


--
-- TOC entry 4861 (class 2606 OID 57515)
-- Name: new_vm new_vm_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.new_vm
    ADD CONSTRAINT new_vm_pkey PRIMARY KEY (id);


--
-- TOC entry 4883 (class 2606 OID 106665)
-- Name: notices notices_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notices
    ADD CONSTRAINT notices_pkey PRIMARY KEY (id);


--
-- TOC entry 4875 (class 2606 OID 90302)
-- Name: request_loves request_loves_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.request_loves
    ADD CONSTRAINT request_loves_pkey PRIMARY KEY (id);


--
-- TOC entry 4877 (class 2606 OID 90304)
-- Name: request_loves request_loves_user_id_request_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.request_loves
    ADD CONSTRAINT request_loves_user_id_request_id_key UNIQUE (user_id, request_id);


--
-- TOC entry 4871 (class 2606 OID 90282)
-- Name: requests requests_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.requests
    ADD CONSTRAINT requests_pkey PRIMARY KEY (id);


--
-- TOC entry 4879 (class 2606 OID 98472)
-- Name: stars_machines stars_machines_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stars_machines
    ADD CONSTRAINT stars_machines_pkey PRIMARY KEY (id);


--
-- TOC entry 4881 (class 2606 OID 98474)
-- Name: stars_machines stars_machines_user_id_vm_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stars_machines
    ADD CONSTRAINT stars_machines_user_id_vm_name_key UNIQUE (user_id, vm_name);


--
-- TOC entry 4851 (class 2606 OID 41136)
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- TOC entry 4853 (class 2606 OID 41132)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 4855 (class 2606 OID 41134)
-- Name: users users_usuario_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_usuario_key UNIQUE (usuario);


--
-- TOC entry 4857 (class 2606 OID 49331)
-- Name: writeups writeups_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.writeups
    ADD CONSTRAINT writeups_pkey PRIMARY KEY (id);


--
-- TOC entry 4859 (class 2606 OID 49342)
-- Name: writeups_public writeups_public_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.writeups_public
    ADD CONSTRAINT writeups_public_pkey PRIMARY KEY (id);


--
-- TOC entry 4887 (class 2606 OID 73899)
-- Name: editprofile editprofile_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.editprofile
    ADD CONSTRAINT editprofile_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- TOC entry 4886 (class 2606 OID 65705)
-- Name: imgprofile imgprofile_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.imgprofile
    ADD CONSTRAINT imgprofile_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- TOC entry 4888 (class 2606 OID 90310)
-- Name: request_loves request_loves_request_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.request_loves
    ADD CONSTRAINT request_loves_request_id_fkey FOREIGN KEY (request_id) REFERENCES public.requests(id);


--
-- TOC entry 4889 (class 2606 OID 90305)
-- Name: request_loves request_loves_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.request_loves
    ADD CONSTRAINT request_loves_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


-- Completed on 2025-05-28 18:24:57

--
-- PostgreSQL database dump complete
--

