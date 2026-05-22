--
-- PostgreSQL database dump
--

-- Dumped from database version 16.6
-- Dumped by pg_dump version 16.6

-- Started on 2026-05-22 11:57:22

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
-- TOC entry 215 (class 1259 OID 16399)
-- Name: denuncias; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.denuncias (
    den_id integer NOT NULL,
    den_titulo character varying,
    den_texto text,
    den_urgencia numeric(1,0),
    org_id integer,
    den_data timestamp without time zone,
    tip_id integer,
    usu_id integer
);


ALTER TABLE public.denuncias OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 16404)
-- Name: denuncia_den_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.denuncia_den_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.denuncia_den_id_seq OWNER TO postgres;

--
-- TOC entry 4893 (class 0 OID 0)
-- Dependencies: 216
-- Name: denuncia_den_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.denuncia_den_id_seq OWNED BY public.denuncias.den_id;


--
-- TOC entry 217 (class 1259 OID 16405)
-- Name: feedbacks; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.feedbacks (
    fee_id integer NOT NULL,
    fee_texto text,
    den_id integer
);


ALTER TABLE public.feedbacks OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 16410)
-- Name: feedback_fee_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.feedback_fee_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.feedback_fee_id_seq OWNER TO postgres;

--
-- TOC entry 4894 (class 0 OID 0)
-- Dependencies: 218
-- Name: feedback_fee_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.feedback_fee_id_seq OWNED BY public.feedbacks.fee_id;


--
-- TOC entry 219 (class 1259 OID 16411)
-- Name: fotos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fotos (
    foto_id integer NOT NULL,
    den_id integer NOT NULL,
    foto_arq character varying
);


ALTER TABLE public.fotos OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 16416)
-- Name: orgaos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.orgaos (
    org_id integer NOT NULL,
    org_nome character varying
);


ALTER TABLE public.orgaos OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16421)
-- Name: orgaos_org_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.orgaos_org_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.orgaos_org_id_seq OWNER TO postgres;

--
-- TOC entry 4895 (class 0 OID 0)
-- Dependencies: 221
-- Name: orgaos_org_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.orgaos_org_id_seq OWNED BY public.orgaos.org_id;


--
-- TOC entry 222 (class 1259 OID 16422)
-- Name: tipos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tipos (
    tip_id integer NOT NULL,
    tip_nome character varying
);


ALTER TABLE public.tipos OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 16427)
-- Name: tipo_tip_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tipo_tip_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tipo_tip_id_seq OWNER TO postgres;

--
-- TOC entry 4896 (class 0 OID 0)
-- Dependencies: 223
-- Name: tipo_tip_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tipo_tip_id_seq OWNED BY public.tipos.tip_id;


--
-- TOC entry 224 (class 1259 OID 16428)
-- Name: usuarios; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.usuarios (
    usu_id integer NOT NULL,
    usu_email character varying NOT NULL,
    usu_nivel numeric(1,0) NOT NULL,
    usu_senha character varying,
    usu_cpf character varying(14)
);


ALTER TABLE public.usuarios OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 16433)
-- Name: usuario_usu_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.usuario_usu_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.usuario_usu_id_seq OWNER TO postgres;

--
-- TOC entry 4897 (class 0 OID 0)
-- Dependencies: 225
-- Name: usuario_usu_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.usuario_usu_id_seq OWNED BY public.usuarios.usu_id;


--
-- TOC entry 4712 (class 2604 OID 16434)
-- Name: denuncias den_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.denuncias ALTER COLUMN den_id SET DEFAULT nextval('public.denuncia_den_id_seq'::regclass);


--
-- TOC entry 4713 (class 2604 OID 16435)
-- Name: feedbacks fee_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.feedbacks ALTER COLUMN fee_id SET DEFAULT nextval('public.feedback_fee_id_seq'::regclass);


--
-- TOC entry 4714 (class 2604 OID 16436)
-- Name: orgaos org_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orgaos ALTER COLUMN org_id SET DEFAULT nextval('public.orgaos_org_id_seq'::regclass);


--
-- TOC entry 4715 (class 2604 OID 16437)
-- Name: tipos tip_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipos ALTER COLUMN tip_id SET DEFAULT nextval('public.tipo_tip_id_seq'::regclass);


--
-- TOC entry 4716 (class 2604 OID 16438)
-- Name: usuarios usu_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios ALTER COLUMN usu_id SET DEFAULT nextval('public.usuario_usu_id_seq'::regclass);


--
-- TOC entry 4877 (class 0 OID 16399)
-- Dependencies: 215
-- Data for Name: denuncias; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.denuncias VALUES (1, 'semaforo quebrado', 'semaforo da av da saudede perto do campua I da Unoeste não está funcionando', 4, 4, '2023-05-12 00:00:00', 1, 2);


--
-- TOC entry 4879 (class 0 OID 16405)
-- Dependencies: 217
-- Data for Name: feedbacks; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4881 (class 0 OID 16411)
-- Dependencies: 219
-- Data for Name: fotos; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4882 (class 0 OID 16416)
-- Dependencies: 220
-- Data for Name: orgaos; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.orgaos VALUES (1, 'SEDUC');
INSERT INTO public.orgaos VALUES (2, 'Policia militar');
INSERT INTO public.orgaos VALUES (3, 'Policia Civil');
INSERT INTO public.orgaos VALUES (4, 'SETRAN');


--
-- TOC entry 4884 (class 0 OID 16422)
-- Dependencies: 222
-- Data for Name: tipos; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.tipos VALUES (1, 'trânsito');
INSERT INTO public.tipos VALUES (2, 'educação');
INSERT INTO public.tipos VALUES (3, 'ambiental');
INSERT INTO public.tipos VALUES (4, 'segurança');


--
-- TOC entry 4886 (class 0 OID 16428)
-- Dependencies: 224
-- Data for Name: usuarios; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.usuarios VALUES (1, 'admin@pm.br', 1, NULL, NULL);
INSERT INTO public.usuarios VALUES (2, 'ze@cidadao.com.br', 2, NULL, NULL);
INSERT INTO public.usuarios VALUES (3, 'pedrosa@gmail.com', 0, 'pedro123', '50522650856');


--
-- TOC entry 4898 (class 0 OID 0)
-- Dependencies: 216
-- Name: denuncia_den_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.denuncia_den_id_seq', 1, true);


--
-- TOC entry 4899 (class 0 OID 0)
-- Dependencies: 218
-- Name: feedback_fee_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.feedback_fee_id_seq', 1, false);


--
-- TOC entry 4900 (class 0 OID 0)
-- Dependencies: 221
-- Name: orgaos_org_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.orgaos_org_id_seq', 4, true);


--
-- TOC entry 4901 (class 0 OID 0)
-- Dependencies: 223
-- Name: tipo_tip_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tipo_tip_id_seq', 4, true);


--
-- TOC entry 4902 (class 0 OID 0)
-- Dependencies: 225
-- Name: usuario_usu_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.usuario_usu_id_seq', 3, true);


--
-- TOC entry 4722 (class 2606 OID 16440)
-- Name: fotos denuncia_fotos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fotos
    ADD CONSTRAINT denuncia_fotos_pkey PRIMARY KEY (foto_id);


--
-- TOC entry 4718 (class 2606 OID 16442)
-- Name: denuncias denuncia_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.denuncias
    ADD CONSTRAINT denuncia_pkey PRIMARY KEY (den_id);


--
-- TOC entry 4720 (class 2606 OID 16444)
-- Name: feedbacks feedback_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.feedbacks
    ADD CONSTRAINT feedback_pkey PRIMARY KEY (fee_id);


--
-- TOC entry 4724 (class 2606 OID 16446)
-- Name: orgaos orgaos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orgaos
    ADD CONSTRAINT orgaos_pkey PRIMARY KEY (org_id);


--
-- TOC entry 4726 (class 2606 OID 16448)
-- Name: tipos tipo_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipos
    ADD CONSTRAINT tipo_pkey PRIMARY KEY (tip_id);


--
-- TOC entry 4728 (class 2606 OID 16450)
-- Name: usuarios usuario_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuario_pkey PRIMARY KEY (usu_id);


--
-- TOC entry 4733 (class 2606 OID 16451)
-- Name: fotos FK_denFoto_den; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fotos
    ADD CONSTRAINT "FK_denFoto_den" FOREIGN KEY (den_id) REFERENCES public.denuncias(den_id);


--
-- TOC entry 4729 (class 2606 OID 16456)
-- Name: denuncias denuncia_org_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.denuncias
    ADD CONSTRAINT denuncia_org_id_fkey FOREIGN KEY (org_id) REFERENCES public.orgaos(org_id) NOT VALID;


--
-- TOC entry 4730 (class 2606 OID 16461)
-- Name: denuncias denuncia_tip_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.denuncias
    ADD CONSTRAINT denuncia_tip_id_fkey FOREIGN KEY (tip_id) REFERENCES public.tipos(tip_id) NOT VALID;


--
-- TOC entry 4731 (class 2606 OID 16466)
-- Name: denuncias denuncia_usu_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.denuncias
    ADD CONSTRAINT denuncia_usu_id_fkey FOREIGN KEY (usu_id) REFERENCES public.usuarios(usu_id) NOT VALID;


--
-- TOC entry 4732 (class 2606 OID 16471)
-- Name: feedbacks feedback_den_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.feedbacks
    ADD CONSTRAINT feedback_den_id_fkey FOREIGN KEY (den_id) REFERENCES public.denuncias(den_id);


-- Completed on 2026-05-22 11:57:23

--
-- PostgreSQL database dump complete
--

