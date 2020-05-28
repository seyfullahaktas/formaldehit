--
-- PostgreSQL database dump
--

-- Dumped from database version 12.3
-- Dumped by pg_dump version 12.3

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: answer; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.answer (
    id integer NOT NULL,
    usersid integer,
    questionid integer,
    explain character varying(45),
    status character varying(1),
    createdate date,
    media character varying(60)
);


ALTER TABLE public.answer OWNER TO postgres;

--
-- Name: answer_ID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.answer ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."answer_ID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: interest; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.interest (
    id integer NOT NULL,
    content character varying(45)[],
    usersid integer
);


ALTER TABLE public.interest OWNER TO postgres;

--
-- Name: interest_ID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.interest ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."interest_ID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: person; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.person (
    id integer NOT NULL,
    name character varying(45),
    lastname character varying(45),
    birthday date,
    job character varying(45),
    sex character varying(45)
);


ALTER TABLE public.person OWNER TO postgres;

--
-- Name: person_ID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.person ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."person_ID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: photo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.photo (
    id integer NOT NULL,
    path character varying(300)
);


ALTER TABLE public.photo OWNER TO postgres;

--
-- Name: photo_ID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.photo ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."photo_ID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: profilephoto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.profilephoto (
    id integer NOT NULL,
    path character varying(200)
);


ALTER TABLE public.profilephoto OWNER TO postgres;

--
-- Name: profilephoto_ID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.profilephoto ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."profilephoto_ID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: question; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.question (
    id integer NOT NULL,
    money numeric,
    earnid integer,
    ownid integer,
    photoid integer,
    name character varying(45),
    createdate character varying(45),
    tag character varying(45),
    status character varying(1),
    explain character varying(45)
);


ALTER TABLE public.question OWNER TO postgres;

--
-- Name: question_ID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.question ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."question_ID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer NOT NULL,
    balance numeric,
    point numeric,
    profilephotoid integer,
    personid integer,
    nickname character varying(45),
    password character varying(45),
    mail character varying(45),
    status character varying(1),
    interest character varying(45)
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_ID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.users ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."users_ID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Data for Name: answer; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.answer (id, usersid, questionid, explain, status, createdate, media) FROM stdin;
18	3	16	123	T	2020-05-28	asd
17	3	16	asdf	F	2020-05-28	asdfasdf
\.


--
-- Data for Name: interest; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.interest (id, content, usersid) FROM stdin;
\.


--
-- Data for Name: person; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.person (id, name, lastname, birthday, job, sex) FROM stdin;
1	Seyfullah	AKTAS	\N	Developer	M
2	Seyfullah	AKTAS	\N	Developer	M
3	"+ person_name.Value.ToString() + "	"+ person_lastname.Value.ToString() + "	\N	"+ jobs.Text + "	"+ sex + "
4	dsfgsdfg	sdfgsdfg	\N	Developer	M
5	hah	hahaha	\N	Developer	M
6	Seyfullah	AKTAS	\N	Developer	M
7	ata1	ata2	\N	Developer	M
8	abd	syrl	\N	Developer	M
9	admin1	admin1	\N	Developer	M
10	Ad1	Soyad1	\N	Developer	M
\.


--
-- Data for Name: photo; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.photo (id, path) FROM stdin;
4	deneme
5	/images/111.jpg
6	/images/111.jpg
7	/images/111.jpg
8	/images/111.jpg
9	/images/111.jpg
10	/images/ccc.png
11	/images/111.jpg
12	/images/27750420_1836082899735822_9198731784984962065_n.jpg
13	/images/Koala.jpg
14	/images/death.jpg
15	/images/donusum.png
16	/images/gazi_universitesi_logo.png
17	/images/jj.png
18	/images/fan.jpg
19	/images/donusum.png
20	/images/game.png
21	/images/imasssges.png
22	/images/Koala.jpg
23	/images/img_3.jpg
\.


--
-- Data for Name: profilephoto; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.profilephoto (id, path) FROM stdin;
1	/images/32ee7374-a7a2-4a93-bf4b-7a0683062ec4.jpg
2	/images/32ee7374-a7a2-4a93-bf4b-7a0683062ec4.jpg
3	/images/32ee7374-a7a2-4a93-bf4b-7a0683062ec4.jpg
4	/images/images11.png
5	/images/bcx.png
\.


--
-- Data for Name: question; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.question (id, money, earnid, ownid, photoid, name, createdate, tag, status, explain) FROM stdin;
16	12	\N	1	22	\N	2020-05-28	koala	T	Nesli Tükenen Koalalar
17	2	\N	1	23	\N	2020-05-28	asdfasdf	T	asdf
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, balance, point, profilephotoid, personid, nickname, password, mail, status, interest) FROM stdin;
2	0	0	3	6	Hawlun	32319497	seyfullahaktas387@gmail.com	T	\N
4	0	0	4	8	abdurrahman	1	abd1@gmail.com	T	\N
5	0	0	5	9	gladius	admin	admin	T	\N
1	52	0	3	5	hawlun	2	seyfullahaktas@gmail.com	T	\N
6	0	0	5	10	kullanıcı1	1	kullanıcı1@gmail.com	T	\N
3	32	0	3	7	ATAKAN	1234	ata1@gmail.com	T	\N
\.


--
-- Name: answer_ID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."answer_ID_seq"', 18, true);


--
-- Name: interest_ID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."interest_ID_seq"', 1, false);


--
-- Name: person_ID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."person_ID_seq"', 10, true);


--
-- Name: photo_ID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."photo_ID_seq"', 23, true);


--
-- Name: profilephoto_ID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."profilephoto_ID_seq"', 5, true);


--
-- Name: question_ID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."question_ID_seq"', 17, true);


--
-- Name: users_ID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."users_ID_seq"', 6, true);


--
-- Name: interest interest_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.interest
    ADD CONSTRAINT interest_pkey PRIMARY KEY (id);


--
-- Name: person person_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.person
    ADD CONSTRAINT person_pkey PRIMARY KEY (id);


--
-- Name: photo photo_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.photo
    ADD CONSTRAINT photo_pkey PRIMARY KEY (id);


--
-- Name: users pk_users_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT pk_users_id PRIMARY KEY (id);


--
-- Name: profilephoto profilephoto_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.profilephoto
    ADD CONSTRAINT profilephoto_pkey PRIMARY KEY (id);


--
-- Name: question question_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.question
    ADD CONSTRAINT question_pkey PRIMARY KEY (id);


--
-- Name: fki_earnid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_earnid ON public.question USING btree (earnid);


--
-- Name: fki_fk_photoid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_fk_photoid ON public.question USING btree (photoid);


--
-- Name: fki_ownid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_ownid ON public.question USING btree (ownid);


--
-- Name: fki_personid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_personid ON public.users USING btree (personid);


--
-- Name: fki_photoid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_photoid ON public.users USING btree (profilephotoid);


--
-- Name: fki_questionid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_questionid ON public.answer USING btree (questionid);


--
-- Name: users fk_person_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT fk_person_id FOREIGN KEY (personid) REFERENCES public.person(id) ON DELETE CASCADE;


--
-- Name: question fk_photoid; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.question
    ADD CONSTRAINT fk_photoid FOREIGN KEY (photoid) REFERENCES public.photo(id) ON DELETE CASCADE;


--
-- Name: users fk_profilephoto_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT fk_profilephoto_id FOREIGN KEY (profilephotoid) REFERENCES public.profilephoto(id) ON DELETE CASCADE;


--
-- Name: answer fk_questionid; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.answer
    ADD CONSTRAINT fk_questionid FOREIGN KEY (questionid) REFERENCES public.question(id) ON DELETE CASCADE;


--
-- Name: question fk_userid_e; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.question
    ADD CONSTRAINT fk_userid_e FOREIGN KEY (earnid) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: question fk_userid_o; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.question
    ADD CONSTRAINT fk_userid_o FOREIGN KEY (ownid) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

