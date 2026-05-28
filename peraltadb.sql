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

CREATE SEQUENCE public.denuncia_den_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE public.denuncia_den_id_seq OWNER TO postgres;

ALTER SEQUENCE public.denuncia_den_id_seq OWNED BY public.denuncias.den_id;

CREATE TABLE public.feedbacks (
    fee_id integer NOT NULL,
    fee_texto text,
    den_id integer
);

ALTER TABLE public.feedbacks OWNER TO postgres;

CREATE SEQUENCE public.feedback_fee_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE public.feedback_fee_id_seq OWNER TO postgres;

ALTER SEQUENCE public.feedback_fee_id_seq OWNED BY public.feedbacks.fee_id;

CREATE TABLE public.fotos (
    foto_id integer NOT NULL,
    den_id integer NOT NULL,
    foto_arq character varying
);

ALTER TABLE public.fotos OWNER TO postgres;

CREATE SEQUENCE public.fotos_foto_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE public.fotos_foto_id_seq OWNER TO postgres;

ALTER SEQUENCE public.fotos_foto_id_seq OWNED BY public.fotos.foto_id;

CREATE TABLE public.orgaos (
    org_id integer NOT NULL,
    org_nome character varying
);

ALTER TABLE public.orgaos OWNER TO postgres;

CREATE SEQUENCE public.orgaos_org_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE public.orgaos_org_id_seq OWNER TO postgres;

ALTER SEQUENCE public.orgaos_org_id_seq OWNED BY public.orgaos.org_id;

CREATE TABLE public.tipos (
    tip_id integer NOT NULL,
    tip_nome character varying
);

ALTER TABLE public.tipos OWNER TO postgres;

CREATE SEQUENCE public.tipo_tip_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE public.tipo_tip_id_seq OWNER TO postgres;

ALTER SEQUENCE public.tipo_tip_id_seq OWNED BY public.tipos.tip_id;

CREATE TABLE public.usuarios (
    usu_id integer NOT NULL,
    usu_email character varying NOT NULL,
    usu_nivel numeric(1,0) NOT NULL,
    usu_senha character varying,
    usu_cpf character varying(14)
);

ALTER TABLE public.usuarios OWNER TO postgres;

CREATE SEQUENCE public.usuario_usu_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE public.usuario_usu_id_seq OWNER TO postgres;

ALTER SEQUENCE public.usuario_usu_id_seq OWNED BY public.usuarios.usu_id;

ALTER TABLE ONLY public.denuncias ALTER COLUMN den_id SET DEFAULT nextval('public.denuncia_den_id_seq'::regclass);

ALTER TABLE ONLY public.feedbacks ALTER COLUMN fee_id SET DEFAULT nextval('public.feedback_fee_id_seq'::regclass);

ALTER TABLE ONLY public.fotos ALTER COLUMN foto_id SET DEFAULT nextval('public.fotos_foto_id_seq'::regclass);

ALTER TABLE ONLY public.orgaos ALTER COLUMN org_id SET DEFAULT nextval('public.orgaos_org_id_seq'::regclass);

ALTER TABLE ONLY public.tipos ALTER COLUMN tip_id SET DEFAULT nextval('public.tipo_tip_id_seq'::regclass);

ALTER TABLE ONLY public.usuarios ALTER COLUMN usu_id SET DEFAULT nextval('public.usuario_usu_id_seq'::regclass);

INSERT INTO public.denuncias VALUES (1, 'semaforo quebrado', 'semaforo da av da saudede perto do campua I da Unoeste não está funcionando', 4, 4, '2023-05-12 00:00:00', 1, 2);

INSERT INTO public.orgaos VALUES (1, 'SEDUC');
INSERT INTO public.orgaos VALUES (2, 'Policia militar');
INSERT INTO public.orgaos VALUES (3, 'Policia Civil');
INSERT INTO public.orgaos VALUES (4, 'SETRAN');

INSERT INTO public.tipos VALUES (1, 'trânsito');
INSERT INTO public.tipos VALUES (2, 'educação');
INSERT INTO public.tipos VALUES (3, 'ambiental');
INSERT INTO public.tipos VALUES (4, 'segurança');

INSERT INTO public.usuarios VALUES (2, 'ze@cidadao.com.br', 2, NULL, NULL);
INSERT INTO public.usuarios VALUES (1, 'admin', 1, 'admin123', NULL);
INSERT INTO public.usuarios VALUES (4, 'pedrosa2843@gmail.com', 2, 'pedro123', '50522650856');
INSERT INTO public.usuarios VALUES (5, 'igor@gmail.com', 2, 'igor123', '12345678978');

SELECT pg_catalog.setval('public.denuncia_den_id_seq', 1, true);

SELECT pg_catalog.setval('public.feedback_fee_id_seq', 1, false);

SELECT pg_catalog.setval('public.fotos_foto_id_seq', 1, false);

SELECT pg_catalog.setval('public.orgaos_org_id_seq', 4, true);

SELECT pg_catalog.setval('public.tipo_tip_id_seq', 4, true);

SELECT pg_catalog.setval('public.usuario_usu_id_seq', 5, true);

ALTER TABLE ONLY public.fotos
    ADD CONSTRAINT denuncia_fotos_pkey PRIMARY KEY (foto_id);

ALTER TABLE ONLY public.denuncias
    ADD CONSTRAINT denuncia_pkey PRIMARY KEY (den_id);

ALTER TABLE ONLY public.feedbacks
    ADD CONSTRAINT feedback_pkey PRIMARY KEY (fee_id);

ALTER TABLE ONLY public.orgaos
    ADD CONSTRAINT orgaos_pkey PRIMARY KEY (org_id);

ALTER TABLE ONLY public.tipos
    ADD CONSTRAINT tipo_pkey PRIMARY KEY (tip_id);

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuario_pkey PRIMARY KEY (usu_id);

ALTER TABLE ONLY public.fotos
    ADD CONSTRAINT "FK_denFoto_den" FOREIGN KEY (den_id) REFERENCES public.denuncias(den_id);

ALTER TABLE ONLY public.denuncias
    ADD CONSTRAINT denuncia_org_id_fkey FOREIGN KEY (org_id) REFERENCES public.orgaos(org_id) NOT VALID;

ALTER TABLE ONLY public.denuncias
    ADD CONSTRAINT denuncia_tip_id_fkey FOREIGN KEY (tip_id) REFERENCES public.tipos(tip_id) NOT VALID;

ALTER TABLE ONLY public.denuncias
    ADD CONSTRAINT denuncia_usu_id_fkey FOREIGN KEY (usu_id) REFERENCES public.usuarios(usu_id) NOT VALID;

ALTER TABLE ONLY public.feedbacks
    ADD CONSTRAINT feedback_den_id_fkey FOREIGN KEY (den_id) REFERENCES public.denuncias(den_id);