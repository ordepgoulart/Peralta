--
-- PostgreSQL database dump
--

\restrict D9q9UepahyhRTlm22T89jEn7mTlhKLZQESK9ADDUqZfQ9S6nyBXwTdRkvJIDi0V

-- Dumped from database version 16.10
-- Dumped by pg_dump version 16.10

-- Started on 2026-05-29 01:04:46

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
-- TOC entry 215 (class 1259 OID 65628)
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
-- TOC entry 216 (class 1259 OID 65633)
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
-- TOC entry 4943 (class 0 OID 0)
-- Dependencies: 216
-- Name: denuncia_den_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.denuncia_den_id_seq OWNED BY public.denuncias.den_id;


--
-- TOC entry 217 (class 1259 OID 65634)
-- Name: feedbacks; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.feedbacks (
    fee_id integer NOT NULL,
    fee_texto text,
    den_id integer
);


ALTER TABLE public.feedbacks OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 65639)
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
-- TOC entry 4944 (class 0 OID 0)
-- Dependencies: 218
-- Name: feedback_fee_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.feedback_fee_id_seq OWNED BY public.feedbacks.fee_id;


--
-- TOC entry 219 (class 1259 OID 65640)
-- Name: fotos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fotos (
    foto_id integer NOT NULL,
    den_id integer NOT NULL,
    foto_arq character varying
);


ALTER TABLE public.fotos OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 65645)
-- Name: fotos_foto_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.fotos_foto_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.fotos_foto_id_seq OWNER TO postgres;

--
-- TOC entry 4945 (class 0 OID 0)
-- Dependencies: 220
-- Name: fotos_foto_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.fotos_foto_id_seq OWNED BY public.fotos.foto_id;


--
-- TOC entry 221 (class 1259 OID 65646)
-- Name: orgaos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.orgaos (
    org_id integer NOT NULL,
    org_nome character varying
);


ALTER TABLE public.orgaos OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 65651)
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
-- TOC entry 4946 (class 0 OID 0)
-- Dependencies: 222
-- Name: orgaos_org_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.orgaos_org_id_seq OWNED BY public.orgaos.org_id;


--
-- TOC entry 223 (class 1259 OID 65652)
-- Name: tipos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tipos (
    tip_id integer NOT NULL,
    tip_nome character varying
);


ALTER TABLE public.tipos OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 65657)
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
-- TOC entry 4947 (class 0 OID 0)
-- Dependencies: 224
-- Name: tipo_tip_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tipo_tip_id_seq OWNED BY public.tipos.tip_id;


--
-- TOC entry 225 (class 1259 OID 65658)
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
-- TOC entry 226 (class 1259 OID 65663)
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
-- TOC entry 4948 (class 0 OID 0)
-- Dependencies: 226
-- Name: usuario_usu_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.usuario_usu_id_seq OWNED BY public.usuarios.usu_id;


--
-- TOC entry 4760 (class 2604 OID 65664)
-- Name: denuncias den_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.denuncias ALTER COLUMN den_id SET DEFAULT nextval('public.denuncia_den_id_seq'::regclass);


--
-- TOC entry 4761 (class 2604 OID 65665)
-- Name: feedbacks fee_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.feedbacks ALTER COLUMN fee_id SET DEFAULT nextval('public.feedback_fee_id_seq'::regclass);


--
-- TOC entry 4762 (class 2604 OID 65666)
-- Name: fotos foto_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fotos ALTER COLUMN foto_id SET DEFAULT nextval('public.fotos_foto_id_seq'::regclass);


--
-- TOC entry 4763 (class 2604 OID 65667)
-- Name: orgaos org_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orgaos ALTER COLUMN org_id SET DEFAULT nextval('public.orgaos_org_id_seq'::regclass);


--
-- TOC entry 4764 (class 2604 OID 65668)
-- Name: tipos tip_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipos ALTER COLUMN tip_id SET DEFAULT nextval('public.tipo_tip_id_seq'::regclass);


--
-- TOC entry 4765 (class 2604 OID 65669)
-- Name: usuarios usu_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios ALTER COLUMN usu_id SET DEFAULT nextval('public.usuario_usu_id_seq'::regclass);


--
-- TOC entry 4926 (class 0 OID 65628)
-- Dependencies: 215
-- Data for Name: denuncias; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.denuncias VALUES (1, 'semaforo quebrado', 'semaforo da av da saudede perto do campua I da Unoeste não está funcionando', 4, 4, '2023-05-12 00:00:00', 1, 2);
INSERT INTO public.denuncias VALUES (6, 'DASDSAD', 'ADASDSA', 2, 2, '2026-05-29 00:00:00', 3, 4);


--
-- TOC entry 4928 (class 0 OID 65634)
-- Dependencies: 217
-- Data for Name: feedbacks; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.feedbacks VALUES (1, 'Consetado', 1);
INSERT INTO public.feedbacks VALUES (2, 'a', 6);


--
-- TOC entry 4930 (class 0 OID 65640)
-- Dependencies: 219
-- Data for Name: fotos; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.fotos VALUES (8, 6, 'DASDSAD_pedrosa2843@gmail.com_32026-05-290.png');
INSERT INTO public.fotos VALUES (9, 6, 'DASDSAD_pedrosa2843@gmail.com_32026-05-291.png');


--
-- TOC entry 4932 (class 0 OID 65646)
-- Dependencies: 221
-- Data for Name: orgaos; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.orgaos VALUES (2, 'Policia militar');
INSERT INTO public.orgaos VALUES (4, 'SETRAN');
INSERT INTO public.orgaos VALUES (1, 'APAE');
INSERT INTO public.orgaos VALUES (6, 'SEDUC');
INSERT INTO public.orgaos VALUES (3, 'Polícia Civil');


--
-- TOC entry 4934 (class 0 OID 65652)
-- Dependencies: 223
-- Data for Name: tipos; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.tipos VALUES (2, 'educação');
INSERT INTO public.tipos VALUES (3, 'ambiental');
INSERT INTO public.tipos VALUES (4, 'segurança');
INSERT INTO public.tipos VALUES (1, 'Trânsito');
INSERT INTO public.tipos VALUES (5, 'Cerimonial');


--
-- TOC entry 4936 (class 0 OID 65658)
-- Dependencies: 225
-- Data for Name: usuarios; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.usuarios VALUES (1, 'admin', 1, 'admin123', NULL);
INSERT INTO public.usuarios VALUES (4, 'pedrosa2843@gmail.com', 2, 'pedro123', '50522650856');
INSERT INTO public.usuarios VALUES (5, 'igor@gmail.com', 2, 'igor123', '12345678978');
INSERT INTO public.usuarios VALUES (2, 'ze@cidadao.com.br', 2, '123', '50522750859');


--
-- TOC entry 4949 (class 0 OID 0)
-- Dependencies: 216
-- Name: denuncia_den_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.denuncia_den_id_seq', 6, true);


--
-- TOC entry 4950 (class 0 OID 0)
-- Dependencies: 218
-- Name: feedback_fee_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.feedback_fee_id_seq', 2, true);


--
-- TOC entry 4951 (class 0 OID 0)
-- Dependencies: 220
-- Name: fotos_foto_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.fotos_foto_id_seq', 9, true);


--
-- TOC entry 4952 (class 0 OID 0)
-- Dependencies: 222
-- Name: orgaos_org_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.orgaos_org_id_seq', 7, true);


--
-- TOC entry 4953 (class 0 OID 0)
-- Dependencies: 224
-- Name: tipo_tip_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tipo_tip_id_seq', 5, true);


--
-- TOC entry 4954 (class 0 OID 0)
-- Dependencies: 226
-- Name: usuario_usu_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.usuario_usu_id_seq', 5, true);


--
-- TOC entry 4771 (class 2606 OID 65671)
-- Name: fotos denuncia_fotos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fotos
    ADD CONSTRAINT denuncia_fotos_pkey PRIMARY KEY (foto_id);


--
-- TOC entry 4767 (class 2606 OID 65673)
-- Name: denuncias denuncia_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.denuncias
    ADD CONSTRAINT denuncia_pkey PRIMARY KEY (den_id);


--
-- TOC entry 4769 (class 2606 OID 65675)
-- Name: feedbacks feedback_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.feedbacks
    ADD CONSTRAINT feedback_pkey PRIMARY KEY (fee_id);


--
-- TOC entry 4773 (class 2606 OID 65677)
-- Name: orgaos orgaos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orgaos
    ADD CONSTRAINT orgaos_pkey PRIMARY KEY (org_id);


--
-- TOC entry 4775 (class 2606 OID 65679)
-- Name: tipos tipo_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipos
    ADD CONSTRAINT tipo_pkey PRIMARY KEY (tip_id);


--
-- TOC entry 4777 (class 2606 OID 65681)
-- Name: usuarios usuario_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuario_pkey PRIMARY KEY (usu_id);


--
-- TOC entry 4782 (class 2606 OID 65682)
-- Name: fotos FK_denFoto_den; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fotos
    ADD CONSTRAINT "FK_denFoto_den" FOREIGN KEY (den_id) REFERENCES public.denuncias(den_id);


--
-- TOC entry 4778 (class 2606 OID 65687)
-- Name: denuncias denuncia_org_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.denuncias
    ADD CONSTRAINT denuncia_org_id_fkey FOREIGN KEY (org_id) REFERENCES public.orgaos(org_id) NOT VALID;


--
-- TOC entry 4779 (class 2606 OID 65692)
-- Name: denuncias denuncia_tip_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.denuncias
    ADD CONSTRAINT denuncia_tip_id_fkey FOREIGN KEY (tip_id) REFERENCES public.tipos(tip_id) NOT VALID;


--
-- TOC entry 4780 (class 2606 OID 65697)
-- Name: denuncias denuncia_usu_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.denuncias
    ADD CONSTRAINT denuncia_usu_id_fkey FOREIGN KEY (usu_id) REFERENCES public.usuarios(usu_id) NOT VALID;


--
-- TOC entry 4781 (class 2606 OID 65702)
-- Name: feedbacks feedback_den_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.feedbacks
    ADD CONSTRAINT feedback_den_id_fkey FOREIGN KEY (den_id) REFERENCES public.denuncias(den_id);


-- Completed on 2026-05-29 01:04:46

--
-- PostgreSQL database dump complete
--

\unrestrict D9q9UepahyhRTlm22T89jEn7mTlhKLZQESK9ADDUqZfQ9S6nyBXwTdRkvJIDi0V

