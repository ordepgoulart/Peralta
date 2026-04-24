--
-- PostgreSQL database dump
--

-- Dumped from database version 16.6
-- Dumped by pg_dump version 16.6

-- Started on 2026-04-24 11:54:04

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
-- TOC entry 215 (class 1259 OID 16456)
-- Name: denuncia; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.denuncia (
    den_id integer NOT NULL,
    den_titulo character varying(40),
    den_texto text,
    den_urgencia numeric(1,0),
    org_id integer,
    den_data timestamp without time zone,
    tip_id integer,
    usu_id integer
);


ALTER TABLE public.denuncia OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 16461)
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

ALTER SEQUENCE public.denuncia_den_id_seq OWNED BY public.denuncia.den_id;


--
-- TOC entry 225 (class 1259 OID 16515)
-- Name: denuncia_fotos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.denuncia_fotos (
    den_foto_id integer NOT NULL,
    den_foto_arq bytea NOT NULL,
    den_foto_fk_den_id integer NOT NULL
);


ALTER TABLE public.denuncia_fotos OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 16462)
-- Name: feedback; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.feedback (
    fee_id integer NOT NULL,
    fee_texto text,
    den_id integer
);


ALTER TABLE public.feedback OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 16467)
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

ALTER SEQUENCE public.feedback_fee_id_seq OWNED BY public.feedback.fee_id;


--
-- TOC entry 219 (class 1259 OID 16468)
-- Name: orgaos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.orgaos (
    org_id integer NOT NULL,
    org_nome character varying(30)
);


ALTER TABLE public.orgaos OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 16471)
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
-- Dependencies: 220
-- Name: orgaos_org_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.orgaos_org_id_seq OWNED BY public.orgaos.org_id;


--
-- TOC entry 221 (class 1259 OID 16472)
-- Name: tipo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tipo (
    tip_id integer NOT NULL,
    tip_nome character varying(30)
);


ALTER TABLE public.tipo OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 16475)
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
-- Dependencies: 222
-- Name: tipo_tip_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tipo_tip_id_seq OWNED BY public.tipo.tip_id;


--
-- TOC entry 223 (class 1259 OID 16476)
-- Name: usuario; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.usuario (
    usu_id integer NOT NULL,
    usu_cpf numeric(11,0) NOT NULL,
    usu_email character varying(40) NOT NULL,
    usu_senha numeric(6,0) NOT NULL,
    usu_nivel numeric(1,0) NOT NULL
);


ALTER TABLE public.usuario OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 16479)
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
-- Dependencies: 224
-- Name: usuario_usu_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.usuario_usu_id_seq OWNED BY public.usuario.usu_id;


--
-- TOC entry 4712 (class 2604 OID 16480)
-- Name: denuncia den_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.denuncia ALTER COLUMN den_id SET DEFAULT nextval('public.denuncia_den_id_seq'::regclass);


--
-- TOC entry 4713 (class 2604 OID 16481)
-- Name: feedback fee_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.feedback ALTER COLUMN fee_id SET DEFAULT nextval('public.feedback_fee_id_seq'::regclass);


--
-- TOC entry 4714 (class 2604 OID 16482)
-- Name: orgaos org_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orgaos ALTER COLUMN org_id SET DEFAULT nextval('public.orgaos_org_id_seq'::regclass);


--
-- TOC entry 4715 (class 2604 OID 16483)
-- Name: tipo tip_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipo ALTER COLUMN tip_id SET DEFAULT nextval('public.tipo_tip_id_seq'::regclass);


--
-- TOC entry 4716 (class 2604 OID 16484)
-- Name: usuario usu_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario ALTER COLUMN usu_id SET DEFAULT nextval('public.usuario_usu_id_seq'::regclass);


--
-- TOC entry 4877 (class 0 OID 16456)
-- Dependencies: 215
-- Data for Name: denuncia; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.denuncia VALUES (1, 'semaforo quebrado', 'semaforo da av da saudede perto do campua I da Unoeste não está funcionando', 4, 4, '2023-05-12 00:00:00', 1, 2);


--
-- TOC entry 4887 (class 0 OID 16515)
-- Dependencies: 225
-- Data for Name: denuncia_fotos; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4879 (class 0 OID 16462)
-- Dependencies: 217
-- Data for Name: feedback; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4881 (class 0 OID 16468)
-- Dependencies: 219
-- Data for Name: orgaos; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.orgaos VALUES (1, 'SEDUC');
INSERT INTO public.orgaos VALUES (2, 'Policia militar');
INSERT INTO public.orgaos VALUES (3, 'Policia Civil');
INSERT INTO public.orgaos VALUES (4, 'SETRAN');


--
-- TOC entry 4883 (class 0 OID 16472)
-- Dependencies: 221
-- Data for Name: tipo; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.tipo VALUES (1, 'trânsito');
INSERT INTO public.tipo VALUES (2, 'educação');
INSERT INTO public.tipo VALUES (3, 'ambiental');
INSERT INTO public.tipo VALUES (4, 'segurança');


--
-- TOC entry 4885 (class 0 OID 16476)
-- Dependencies: 223
-- Data for Name: usuario; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.usuario VALUES (1, 12111158963, 'admin@pm.br', 123321, 1);
INSERT INTO public.usuario VALUES (2, 5488889915, 'ze@cidadao.com.br', 123, 2);


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
-- Dependencies: 220
-- Name: orgaos_org_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.orgaos_org_id_seq', 4, true);


--
-- TOC entry 4901 (class 0 OID 0)
-- Dependencies: 222
-- Name: tipo_tip_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tipo_tip_id_seq', 4, true);


--
-- TOC entry 4902 (class 0 OID 0)
-- Dependencies: 224
-- Name: usuario_usu_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.usuario_usu_id_seq', 2, true);


--
-- TOC entry 4728 (class 2606 OID 16521)
-- Name: denuncia_fotos denuncia_fotos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.denuncia_fotos
    ADD CONSTRAINT denuncia_fotos_pkey PRIMARY KEY (den_foto_id);


--
-- TOC entry 4718 (class 2606 OID 16486)
-- Name: denuncia denuncia_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.denuncia
    ADD CONSTRAINT denuncia_pkey PRIMARY KEY (den_id);


--
-- TOC entry 4720 (class 2606 OID 16488)
-- Name: feedback feedback_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.feedback
    ADD CONSTRAINT feedback_pkey PRIMARY KEY (fee_id);


--
-- TOC entry 4722 (class 2606 OID 16490)
-- Name: orgaos orgaos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orgaos
    ADD CONSTRAINT orgaos_pkey PRIMARY KEY (org_id);


--
-- TOC entry 4724 (class 2606 OID 16492)
-- Name: tipo tipo_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipo
    ADD CONSTRAINT tipo_pkey PRIMARY KEY (tip_id);


--
-- TOC entry 4726 (class 2606 OID 16494)
-- Name: usuario usuario_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_pkey PRIMARY KEY (usu_id);


--
-- TOC entry 4733 (class 2606 OID 16522)
-- Name: denuncia_fotos FK_denFoto_den; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.denuncia_fotos
    ADD CONSTRAINT "FK_denFoto_den" FOREIGN KEY (den_foto_fk_den_id) REFERENCES public.denuncia(den_id);


--
-- TOC entry 4729 (class 2606 OID 16495)
-- Name: denuncia denuncia_org_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.denuncia
    ADD CONSTRAINT denuncia_org_id_fkey FOREIGN KEY (org_id) REFERENCES public.orgaos(org_id) NOT VALID;


--
-- TOC entry 4730 (class 2606 OID 16500)
-- Name: denuncia denuncia_tip_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.denuncia
    ADD CONSTRAINT denuncia_tip_id_fkey FOREIGN KEY (tip_id) REFERENCES public.tipo(tip_id) NOT VALID;


--
-- TOC entry 4731 (class 2606 OID 16505)
-- Name: denuncia denuncia_usu_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.denuncia
    ADD CONSTRAINT denuncia_usu_id_fkey FOREIGN KEY (usu_id) REFERENCES public.usuario(usu_id) NOT VALID;


--
-- TOC entry 4732 (class 2606 OID 16510)
-- Name: feedback feedback_den_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.feedback
    ADD CONSTRAINT feedback_den_id_fkey FOREIGN KEY (den_id) REFERENCES public.denuncia(den_id);


-- Completed on 2026-04-24 11:54:04

--
-- PostgreSQL database dump complete
--

