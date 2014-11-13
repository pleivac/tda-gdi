--
-- PostgreSQL database dump
--

-- Started on 2013-08-30 14:32:33 CST

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

--
-- TOC entry 9 (class 2615 OID 2977429)
-- Name: sch_gdi; Type: SCHEMA; Schema: -; Owner: www-data
--

CREATE SCHEMA sch_gdi;


ALTER SCHEMA sch_gdi OWNER TO "www-data";

SET search_path = sch_gdi, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = true;

--
-- TOC entry 794 (class 1259 OID 2977430)
-- Dependencies: 5029 9
-- Name: td_di_actividades_aprendizaje; Type: TABLE; Schema: sch_gdi; Owner: www-data; Tablespace: 
--

CREATE TABLE td_di_actividades_aprendizaje (
    actividades_aprendizaje_id integer NOT NULL,
    disenno_instruccional_id integer NOT NULL,
    instrumento_id integer,
    num_sesion integer NOT NULL,
    nom_actividad_aprendizaje character varying(10000) NOT NULL,
    material_apoyo_id integer,
    estado smallint DEFAULT 0 NOT NULL
);


ALTER TABLE sch_gdi.td_di_actividades_aprendizaje OWNER TO "www-data";

--
-- TOC entry 795 (class 1259 OID 2977434)
-- Dependencies: 794 9
-- Name: td_di_actividades_aprendizaje_actividades_aprendizaje_id_seq; Type: SEQUENCE; Schema: sch_gdi; Owner: www-data
--

CREATE SEQUENCE td_di_actividades_aprendizaje_actividades_aprendizaje_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE sch_gdi.td_di_actividades_aprendizaje_actividades_aprendizaje_id_seq OWNER TO "www-data";

--
-- TOC entry 5127 (class 0 OID 0)
-- Dependencies: 795
-- Name: td_di_actividades_aprendizaje_actividades_aprendizaje_id_seq; Type: SEQUENCE OWNED BY; Schema: sch_gdi; Owner: www-data
--

ALTER SEQUENCE td_di_actividades_aprendizaje_actividades_aprendizaje_id_seq OWNED BY td_di_actividades_aprendizaje.actividades_aprendizaje_id;


--
-- TOC entry 5128 (class 0 OID 0)
-- Dependencies: 795
-- Name: td_di_actividades_aprendizaje_actividades_aprendizaje_id_seq; Type: SEQUENCE SET; Schema: sch_gdi; Owner: www-data
--

SELECT pg_catalog.setval('td_di_actividades_aprendizaje_actividades_aprendizaje_id_seq', 9665, true);


SET default_with_oids = false;

--
-- TOC entry 821 (class 1259 OID 3673237)
-- Dependencies: 9
-- Name: td_di_cursos_asociados; Type: TABLE; Schema: sch_gdi; Owner: www-data; Tablespace: 
--

CREATE TABLE td_di_cursos_asociados (
    asociacion_id integer NOT NULL,
    community_id integer,
    disenno_instruccional_id integer
);


ALTER TABLE sch_gdi.td_di_cursos_asociados OWNER TO "www-data";

--
-- TOC entry 820 (class 1259 OID 3673235)
-- Dependencies: 821 9
-- Name: td_di_cursos_asociados_asociacion_id_seq; Type: SEQUENCE; Schema: sch_gdi; Owner: www-data
--

CREATE SEQUENCE td_di_cursos_asociados_asociacion_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE sch_gdi.td_di_cursos_asociados_asociacion_id_seq OWNER TO "www-data";

--
-- TOC entry 5129 (class 0 OID 0)
-- Dependencies: 820
-- Name: td_di_cursos_asociados_asociacion_id_seq; Type: SEQUENCE OWNED BY; Schema: sch_gdi; Owner: www-data
--

ALTER SEQUENCE td_di_cursos_asociados_asociacion_id_seq OWNED BY td_di_cursos_asociados.asociacion_id;


--
-- TOC entry 5130 (class 0 OID 0)
-- Dependencies: 820
-- Name: td_di_cursos_asociados_asociacion_id_seq; Type: SEQUENCE SET; Schema: sch_gdi; Owner: www-data
--

SELECT pg_catalog.setval('td_di_cursos_asociados_asociacion_id_seq', 192, true);


SET default_with_oids = true;

--
-- TOC entry 796 (class 1259 OID 2977436)
-- Dependencies: 5031 9
-- Name: td_di_evaluacion; Type: TABLE; Schema: sch_gdi; Owner: www-data; Tablespace: 
--

CREATE TABLE td_di_evaluacion (
    evaluacion_id integer NOT NULL,
    disenno_instruccional_id integer NOT NULL,
    num_sesion integer NOT NULL,
    nom_evaluacion character varying(10000) NOT NULL,
    material_apoyo_id integer,
    estado smallint DEFAULT 0 NOT NULL
);


ALTER TABLE sch_gdi.td_di_evaluacion OWNER TO "www-data";

--
-- TOC entry 797 (class 1259 OID 2977440)
-- Dependencies: 9 796
-- Name: td_di_evaluacion_evaluacion_id_seq; Type: SEQUENCE; Schema: sch_gdi; Owner: www-data
--

CREATE SEQUENCE td_di_evaluacion_evaluacion_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE sch_gdi.td_di_evaluacion_evaluacion_id_seq OWNER TO "www-data";

--
-- TOC entry 5131 (class 0 OID 0)
-- Dependencies: 797
-- Name: td_di_evaluacion_evaluacion_id_seq; Type: SEQUENCE OWNED BY; Schema: sch_gdi; Owner: www-data
--

ALTER SEQUENCE td_di_evaluacion_evaluacion_id_seq OWNED BY td_di_evaluacion.evaluacion_id;


--
-- TOC entry 5132 (class 0 OID 0)
-- Dependencies: 797
-- Name: td_di_evaluacion_evaluacion_id_seq; Type: SEQUENCE SET; Schema: sch_gdi; Owner: www-data
--

SELECT pg_catalog.setval('td_di_evaluacion_evaluacion_id_seq', 11086, true);


--
-- TOC entry 798 (class 1259 OID 2977442)
-- Dependencies: 5033 9
-- Name: td_di_medios_materiales; Type: TABLE; Schema: sch_gdi; Owner: www-data; Tablespace: 
--

CREATE TABLE td_di_medios_materiales (
    medios_materiales_id integer NOT NULL,
    disenno_instruccional_id integer NOT NULL,
    num_sesion integer NOT NULL,
    nom_medio_material character varying(10000) NOT NULL,
    material_apoyo_id integer,
    estado smallint DEFAULT 0 NOT NULL
);


ALTER TABLE sch_gdi.td_di_medios_materiales OWNER TO "www-data";

--
-- TOC entry 799 (class 1259 OID 2977446)
-- Dependencies: 9 798
-- Name: td_di_medios_materiales_medios_materiales_id_seq; Type: SEQUENCE; Schema: sch_gdi; Owner: www-data
--

CREATE SEQUENCE td_di_medios_materiales_medios_materiales_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE sch_gdi.td_di_medios_materiales_medios_materiales_id_seq OWNER TO "www-data";

--
-- TOC entry 5133 (class 0 OID 0)
-- Dependencies: 799
-- Name: td_di_medios_materiales_medios_materiales_id_seq; Type: SEQUENCE OWNED BY; Schema: sch_gdi; Owner: www-data
--

ALTER SEQUENCE td_di_medios_materiales_medios_materiales_id_seq OWNED BY td_di_medios_materiales.medios_materiales_id;


--
-- TOC entry 5134 (class 0 OID 0)
-- Dependencies: 799
-- Name: td_di_medios_materiales_medios_materiales_id_seq; Type: SEQUENCE SET; Schema: sch_gdi; Owner: www-data
--

SELECT pg_catalog.setval('td_di_medios_materiales_medios_materiales_id_seq', 1708, true);


--
-- TOC entry 800 (class 1259 OID 2977448)
-- Dependencies: 5035 9
-- Name: td_di_modulos_contenidos; Type: TABLE; Schema: sch_gdi; Owner: www-data; Tablespace: 
--

CREATE TABLE td_di_modulos_contenidos (
    modulos_contenidos_id integer NOT NULL,
    disenno_instruccional_id integer NOT NULL,
    num_sesion integer NOT NULL,
    material_apoyo_id integer,
    nom_modulo_contenido character varying(10000) NOT NULL,
    estado smallint DEFAULT 0 NOT NULL
);


ALTER TABLE sch_gdi.td_di_modulos_contenidos OWNER TO "www-data";

--
-- TOC entry 801 (class 1259 OID 2977452)
-- Dependencies: 9 800
-- Name: td_di_modulos_contenidos_modulos_contenidos_id_seq; Type: SEQUENCE; Schema: sch_gdi; Owner: www-data
--

CREATE SEQUENCE td_di_modulos_contenidos_modulos_contenidos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE sch_gdi.td_di_modulos_contenidos_modulos_contenidos_id_seq OWNER TO "www-data";

--
-- TOC entry 5135 (class 0 OID 0)
-- Dependencies: 801
-- Name: td_di_modulos_contenidos_modulos_contenidos_id_seq; Type: SEQUENCE OWNED BY; Schema: sch_gdi; Owner: www-data
--

ALTER SEQUENCE td_di_modulos_contenidos_modulos_contenidos_id_seq OWNED BY td_di_modulos_contenidos.modulos_contenidos_id;


--
-- TOC entry 5136 (class 0 OID 0)
-- Dependencies: 801
-- Name: td_di_modulos_contenidos_modulos_contenidos_id_seq; Type: SEQUENCE SET; Schema: sch_gdi; Owner: www-data
--

SELECT pg_catalog.setval('td_di_modulos_contenidos_modulos_contenidos_id_seq', 10399, true);


--
-- TOC entry 802 (class 1259 OID 2977454)
-- Dependencies: 5037 9
-- Name: td_di_objetivos_aprendizaje; Type: TABLE; Schema: sch_gdi; Owner: www-data; Tablespace: 
--

CREATE TABLE td_di_objetivos_aprendizaje (
    objetivos_aprendizaje_id integer NOT NULL,
    disenno_instruccional_id integer NOT NULL,
    nom_objetivo_aprendizaje character varying(10000) NOT NULL,
    num_sesion integer NOT NULL,
    material_apoyo_id integer,
    estado smallint DEFAULT 0 NOT NULL
);


ALTER TABLE sch_gdi.td_di_objetivos_aprendizaje OWNER TO "www-data";

--
-- TOC entry 803 (class 1259 OID 2977458)
-- Dependencies: 802 9
-- Name: td_di_objetivos_aprendizaje_objetivos_aprendizaje_id_seq; Type: SEQUENCE; Schema: sch_gdi; Owner: www-data
--

CREATE SEQUENCE td_di_objetivos_aprendizaje_objetivos_aprendizaje_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE sch_gdi.td_di_objetivos_aprendizaje_objetivos_aprendizaje_id_seq OWNER TO "www-data";

--
-- TOC entry 5137 (class 0 OID 0)
-- Dependencies: 803
-- Name: td_di_objetivos_aprendizaje_objetivos_aprendizaje_id_seq; Type: SEQUENCE OWNED BY; Schema: sch_gdi; Owner: www-data
--

ALTER SEQUENCE td_di_objetivos_aprendizaje_objetivos_aprendizaje_id_seq OWNED BY td_di_objetivos_aprendizaje.objetivos_aprendizaje_id;


--
-- TOC entry 5138 (class 0 OID 0)
-- Dependencies: 803
-- Name: td_di_objetivos_aprendizaje_objetivos_aprendizaje_id_seq; Type: SEQUENCE SET; Schema: sch_gdi; Owner: www-data
--

SELECT pg_catalog.setval('td_di_objetivos_aprendizaje_objetivos_aprendizaje_id_seq', 9670, true);


SET default_with_oids = false;

--
-- TOC entry 804 (class 1259 OID 2977460)
-- Dependencies: 5039 9
-- Name: td_di_preguntas_contexto; Type: TABLE; Schema: sch_gdi; Owner: www-data; Tablespace: 
--

CREATE TABLE td_di_preguntas_contexto (
    desc_pregunta character varying(5000) NOT NULL,
    pregunta_id integer NOT NULL,
    pregunta_habilitada boolean DEFAULT true NOT NULL,
    ayuda_pregunta character varying(10000)
);


ALTER TABLE sch_gdi.td_di_preguntas_contexto OWNER TO "www-data";

--
-- TOC entry 805 (class 1259 OID 2977467)
-- Dependencies: 804 9
-- Name: td_di_preguntas_contexto_pregunta_id_seq; Type: SEQUENCE; Schema: sch_gdi; Owner: www-data
--

CREATE SEQUENCE td_di_preguntas_contexto_pregunta_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE sch_gdi.td_di_preguntas_contexto_pregunta_id_seq OWNER TO "www-data";

--
-- TOC entry 5139 (class 0 OID 0)
-- Dependencies: 805
-- Name: td_di_preguntas_contexto_pregunta_id_seq; Type: SEQUENCE OWNED BY; Schema: sch_gdi; Owner: www-data
--

ALTER SEQUENCE td_di_preguntas_contexto_pregunta_id_seq OWNED BY td_di_preguntas_contexto.pregunta_id;


--
-- TOC entry 5140 (class 0 OID 0)
-- Dependencies: 805
-- Name: td_di_preguntas_contexto_pregunta_id_seq; Type: SEQUENCE SET; Schema: sch_gdi; Owner: www-data
--

SELECT pg_catalog.setval('td_di_preguntas_contexto_pregunta_id_seq', 9, true);


--
-- TOC entry 806 (class 1259 OID 2977469)
-- Dependencies: 5041 9
-- Name: td_di_respuestas_contexto; Type: TABLE; Schema: sch_gdi; Owner: www-data; Tablespace: 
--

CREATE TABLE td_di_respuestas_contexto (
    disenno_instruccional_id integer NOT NULL,
    desc_respuesta character varying(5000),
    pregunta_id integer NOT NULL,
    respuesta_id integer NOT NULL,
    estado_respuesta integer DEFAULT 0
);


ALTER TABLE sch_gdi.td_di_respuestas_contexto OWNER TO "www-data";

--
-- TOC entry 807 (class 1259 OID 2977475)
-- Dependencies: 9 806
-- Name: td_di_respuestas_contexto_respuesta_id_seq; Type: SEQUENCE; Schema: sch_gdi; Owner: www-data
--

CREATE SEQUENCE td_di_respuestas_contexto_respuesta_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE sch_gdi.td_di_respuestas_contexto_respuesta_id_seq OWNER TO "www-data";

--
-- TOC entry 5141 (class 0 OID 0)
-- Dependencies: 807
-- Name: td_di_respuestas_contexto_respuesta_id_seq; Type: SEQUENCE OWNED BY; Schema: sch_gdi; Owner: www-data
--

ALTER SEQUENCE td_di_respuestas_contexto_respuesta_id_seq OWNED BY td_di_respuestas_contexto.respuesta_id;


--
-- TOC entry 5142 (class 0 OID 0)
-- Dependencies: 807
-- Name: td_di_respuestas_contexto_respuesta_id_seq; Type: SEQUENCE SET; Schema: sch_gdi; Owner: www-data
--

SELECT pg_catalog.setval('td_di_respuestas_contexto_respuesta_id_seq', 19646, true);


SET default_with_oids = true;

--
-- TOC entry 808 (class 1259 OID 2977477)
-- Dependencies: 5043 9
-- Name: td_di_titulo; Type: TABLE; Schema: sch_gdi; Owner: www-data; Tablespace: 
--

CREATE TABLE td_di_titulo (
    titulo_id integer NOT NULL,
    disenno_instruccional_id integer NOT NULL,
    num_sesion integer NOT NULL,
    material_apoyo_id integer,
    nom_titulo character varying(1000) NOT NULL,
    estado smallint DEFAULT 0 NOT NULL
);


ALTER TABLE sch_gdi.td_di_titulo OWNER TO "www-data";

--
-- TOC entry 809 (class 1259 OID 2977481)
-- Dependencies: 9 808
-- Name: td_di_titulo_titulo_id_seq; Type: SEQUENCE; Schema: sch_gdi; Owner: www-data
--

CREATE SEQUENCE td_di_titulo_titulo_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE sch_gdi.td_di_titulo_titulo_id_seq OWNER TO "www-data";

--
-- TOC entry 5143 (class 0 OID 0)
-- Dependencies: 809
-- Name: td_di_titulo_titulo_id_seq; Type: SEQUENCE OWNED BY; Schema: sch_gdi; Owner: www-data
--

ALTER SEQUENCE td_di_titulo_titulo_id_seq OWNED BY td_di_titulo.titulo_id;


--
-- TOC entry 5144 (class 0 OID 0)
-- Dependencies: 809
-- Name: td_di_titulo_titulo_id_seq; Type: SEQUENCE SET; Schema: sch_gdi; Owner: www-data
--

SELECT pg_catalog.setval('td_di_titulo_titulo_id_seq', 17314, true);


--
-- TOC entry 810 (class 1259 OID 2977483)
-- Dependencies: 9
-- Name: td_di_usuarios; Type: TABLE; Schema: sch_gdi; Owner: www-data; Tablespace: 
--

CREATE TABLE td_di_usuarios (
    usuario_id integer NOT NULL,
    nom_usuario text NOT NULL
);


ALTER TABLE sch_gdi.td_di_usuarios OWNER TO "www-data";

--
-- TOC entry 811 (class 1259 OID 2977489)
-- Dependencies: 810 9
-- Name: td_di_usuarios_usuario_id_seq; Type: SEQUENCE; Schema: sch_gdi; Owner: www-data
--

CREATE SEQUENCE td_di_usuarios_usuario_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE sch_gdi.td_di_usuarios_usuario_id_seq OWNER TO "www-data";

--
-- TOC entry 5145 (class 0 OID 0)
-- Dependencies: 811
-- Name: td_di_usuarios_usuario_id_seq; Type: SEQUENCE OWNED BY; Schema: sch_gdi; Owner: www-data
--

ALTER SEQUENCE td_di_usuarios_usuario_id_seq OWNED BY td_di_usuarios.usuario_id;


--
-- TOC entry 5146 (class 0 OID 0)
-- Dependencies: 811
-- Name: td_di_usuarios_usuario_id_seq; Type: SEQUENCE SET; Schema: sch_gdi; Owner: www-data
--

SELECT pg_catalog.setval('td_di_usuarios_usuario_id_seq', 1, false);


--
-- TOC entry 812 (class 1259 OID 2977491)
-- Dependencies: 9
-- Name: td_disenno_instruccional; Type: TABLE; Schema: sch_gdi; Owner: www-data; Tablespace: 
--

CREATE TABLE td_disenno_instruccional (
    disenno_instruccional_id integer NOT NULL,
    tipo_derecho_autor_id integer,
    programa_estudio_id integer NOT NULL,
    fec_creacion timestamp without time zone NOT NULL,
    fec_ultima_modificacion timestamp without time zone NOT NULL,
    cod_compartido boolean,
    estado_descripcion text,
    cod_curso character varying(80),
    sesiones integer NOT NULL,
    nombre_curso text,
    nombre_escuela character varying(10000)
);


ALTER TABLE sch_gdi.td_disenno_instruccional OWNER TO "www-data";

--
-- TOC entry 813 (class 1259 OID 2977497)
-- Dependencies: 812 9
-- Name: td_disenno_instruccional_disenno_instruccional_id_seq; Type: SEQUENCE; Schema: sch_gdi; Owner: www-data
--

CREATE SEQUENCE td_disenno_instruccional_disenno_instruccional_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE sch_gdi.td_disenno_instruccional_disenno_instruccional_id_seq OWNER TO "www-data";

--
-- TOC entry 5147 (class 0 OID 0)
-- Dependencies: 813
-- Name: td_disenno_instruccional_disenno_instruccional_id_seq; Type: SEQUENCE OWNED BY; Schema: sch_gdi; Owner: www-data
--

ALTER SEQUENCE td_disenno_instruccional_disenno_instruccional_id_seq OWNED BY td_disenno_instruccional.disenno_instruccional_id;


--
-- TOC entry 5148 (class 0 OID 0)
-- Dependencies: 813
-- Name: td_disenno_instruccional_disenno_instruccional_id_seq; Type: SEQUENCE SET; Schema: sch_gdi; Owner: www-data
--

SELECT pg_catalog.setval('td_disenno_instruccional_disenno_instruccional_id_seq', 15050, true);


--
-- TOC entry 814 (class 1259 OID 2977499)
-- Dependencies: 9
-- Name: td_disenno_instruccional_x_usuario; Type: TABLE; Schema: sch_gdi; Owner: www-data; Tablespace: 
--

CREATE TABLE td_disenno_instruccional_x_usuario (
    disenno_instruccional_x_usuario_id integer NOT NULL,
    disenno_instruccional_id integer NOT NULL,
    usuario_id integer NOT NULL,
    tipo_permiso_descripcion text,
    nom_di character varying(2000) NOT NULL
);


ALTER TABLE sch_gdi.td_disenno_instruccional_x_usuario OWNER TO "www-data";

--
-- TOC entry 815 (class 1259 OID 2977505)
-- Dependencies: 814 9
-- Name: td_disenno_instruccional_x_us_disenno_instruccional_x_usuar_seq; Type: SEQUENCE; Schema: sch_gdi; Owner: www-data
--

CREATE SEQUENCE td_disenno_instruccional_x_us_disenno_instruccional_x_usuar_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE sch_gdi.td_disenno_instruccional_x_us_disenno_instruccional_x_usuar_seq OWNER TO "www-data";

--
-- TOC entry 5149 (class 0 OID 0)
-- Dependencies: 815
-- Name: td_disenno_instruccional_x_us_disenno_instruccional_x_usuar_seq; Type: SEQUENCE OWNED BY; Schema: sch_gdi; Owner: www-data
--

ALTER SEQUENCE td_disenno_instruccional_x_us_disenno_instruccional_x_usuar_seq OWNED BY td_disenno_instruccional_x_usuario.disenno_instruccional_x_usuario_id;


--
-- TOC entry 5150 (class 0 OID 0)
-- Dependencies: 815
-- Name: td_disenno_instruccional_x_us_disenno_instruccional_x_usuar_seq; Type: SEQUENCE SET; Schema: sch_gdi; Owner: www-data
--

--SELECT pg_catalog.setval('td_disenno_instruccional_x_us_disenno_instruccional_x_usuar_seq', 15063, true);


--
-- TOC entry 816 (class 1259 OID 2977507)
-- Dependencies: 9
-- Name: td_material_apoyo; Type: TABLE; Schema: sch_gdi; Owner: www-data; Tablespace: 
--

CREATE TABLE td_material_apoyo (
    material_apoyo_id integer NOT NULL,
    tipo_material_apoyo_id integer NOT NULL,
    nom_material_apoyo character varying(10000) NOT NULL,
    orden_presentacion integer NOT NULL,
    titulo_material_apoyo character varying(5000)
);


ALTER TABLE sch_gdi.td_material_apoyo OWNER TO "www-data";

--
-- TOC entry 817 (class 1259 OID 2977513)
-- Dependencies: 816 9
-- Name: td_material_apoyo_material_apoyo_id_seq; Type: SEQUENCE; Schema: sch_gdi; Owner: www-data
--

CREATE SEQUENCE td_material_apoyo_material_apoyo_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE sch_gdi.td_material_apoyo_material_apoyo_id_seq OWNER TO "www-data";

--
-- TOC entry 5151 (class 0 OID 0)
-- Dependencies: 817
-- Name: td_material_apoyo_material_apoyo_id_seq; Type: SEQUENCE OWNED BY; Schema: sch_gdi; Owner: www-data
--

ALTER SEQUENCE td_material_apoyo_material_apoyo_id_seq OWNED BY td_material_apoyo.material_apoyo_id;


--
-- TOC entry 5152 (class 0 OID 0)
-- Dependencies: 817
-- Name: td_material_apoyo_material_apoyo_id_seq; Type: SEQUENCE SET; Schema: sch_gdi; Owner: www-data
--

SELECT pg_catalog.setval('td_material_apoyo_material_apoyo_id_seq', 4, true);


--
-- TOC entry 818 (class 1259 OID 2977515)
-- Dependencies: 9
-- Name: td_tipo_material_apoyo; Type: TABLE; Schema: sch_gdi; Owner: www-data; Tablespace: 
--

CREATE TABLE td_tipo_material_apoyo (
    tipo_material_apoyo_id integer NOT NULL,
    nom_tipo_material_apoyo character varying(10000) NOT NULL
);


ALTER TABLE sch_gdi.td_tipo_material_apoyo OWNER TO "www-data";

--
-- TOC entry 819 (class 1259 OID 2977518)
-- Dependencies: 9 818
-- Name: td_tipo_material_apoyo_tipo_material_apoyo_id_seq; Type: SEQUENCE; Schema: sch_gdi; Owner: www-data
--

CREATE SEQUENCE td_tipo_material_apoyo_tipo_material_apoyo_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE sch_gdi.td_tipo_material_apoyo_tipo_material_apoyo_id_seq OWNER TO "www-data";

--
-- TOC entry 5153 (class 0 OID 0)
-- Dependencies: 819
-- Name: td_tipo_material_apoyo_tipo_material_apoyo_id_seq; Type: SEQUENCE OWNED BY; Schema: sch_gdi; Owner: www-data
--

ALTER SEQUENCE td_tipo_material_apoyo_tipo_material_apoyo_id_seq OWNED BY td_tipo_material_apoyo.tipo_material_apoyo_id;


--
-- TOC entry 5154 (class 0 OID 0)
-- Dependencies: 819
-- Name: td_tipo_material_apoyo_tipo_material_apoyo_id_seq; Type: SEQUENCE SET; Schema: sch_gdi; Owner: www-data
--

SELECT pg_catalog.setval('td_tipo_material_apoyo_tipo_material_apoyo_id_seq', 1, false);


--
-- TOC entry 5028 (class 2604 OID 2977520)
-- Dependencies: 795 794
-- Name: actividades_aprendizaje_id; Type: DEFAULT; Schema: sch_gdi; Owner: www-data
--

ALTER TABLE ONLY td_di_actividades_aprendizaje ALTER COLUMN actividades_aprendizaje_id SET DEFAULT nextval('td_di_actividades_aprendizaje_actividades_aprendizaje_id_seq'::regclass);


--
-- TOC entry 5049 (class 2604 OID 3673240)
-- Dependencies: 820 821 821
-- Name: asociacion_id; Type: DEFAULT; Schema: sch_gdi; Owner: www-data
--

ALTER TABLE ONLY td_di_cursos_asociados ALTER COLUMN asociacion_id SET DEFAULT nextval('td_di_cursos_asociados_asociacion_id_seq'::regclass);


--
-- TOC entry 5030 (class 2604 OID 2977521)
-- Dependencies: 797 796
-- Name: evaluacion_id; Type: DEFAULT; Schema: sch_gdi; Owner: www-data
--

ALTER TABLE ONLY td_di_evaluacion ALTER COLUMN evaluacion_id SET DEFAULT nextval('td_di_evaluacion_evaluacion_id_seq'::regclass);


--
-- TOC entry 5032 (class 2604 OID 2977522)
-- Dependencies: 799 798
-- Name: medios_materiales_id; Type: DEFAULT; Schema: sch_gdi; Owner: www-data
--

ALTER TABLE ONLY td_di_medios_materiales ALTER COLUMN medios_materiales_id SET DEFAULT nextval('td_di_medios_materiales_medios_materiales_id_seq'::regclass);


--
-- TOC entry 5034 (class 2604 OID 2977523)
-- Dependencies: 801 800
-- Name: modulos_contenidos_id; Type: DEFAULT; Schema: sch_gdi; Owner: www-data
--

ALTER TABLE ONLY td_di_modulos_contenidos ALTER COLUMN modulos_contenidos_id SET DEFAULT nextval('td_di_modulos_contenidos_modulos_contenidos_id_seq'::regclass);


--
-- TOC entry 5036 (class 2604 OID 2977524)
-- Dependencies: 803 802
-- Name: objetivos_aprendizaje_id; Type: DEFAULT; Schema: sch_gdi; Owner: www-data
--

ALTER TABLE ONLY td_di_objetivos_aprendizaje ALTER COLUMN objetivos_aprendizaje_id SET DEFAULT nextval('td_di_objetivos_aprendizaje_objetivos_aprendizaje_id_seq'::regclass);


--
-- TOC entry 5038 (class 2604 OID 2977525)
-- Dependencies: 805 804
-- Name: pregunta_id; Type: DEFAULT; Schema: sch_gdi; Owner: www-data
--

ALTER TABLE ONLY td_di_preguntas_contexto ALTER COLUMN pregunta_id SET DEFAULT nextval('td_di_preguntas_contexto_pregunta_id_seq'::regclass);


--
-- TOC entry 5040 (class 2604 OID 2977526)
-- Dependencies: 807 806
-- Name: respuesta_id; Type: DEFAULT; Schema: sch_gdi; Owner: www-data
--

ALTER TABLE ONLY td_di_respuestas_contexto ALTER COLUMN respuesta_id SET DEFAULT nextval('td_di_respuestas_contexto_respuesta_id_seq'::regclass);


--
-- TOC entry 5042 (class 2604 OID 2977527)
-- Dependencies: 809 808
-- Name: titulo_id; Type: DEFAULT; Schema: sch_gdi; Owner: www-data
--

ALTER TABLE ONLY td_di_titulo ALTER COLUMN titulo_id SET DEFAULT nextval('td_di_titulo_titulo_id_seq'::regclass);


--
-- TOC entry 5044 (class 2604 OID 2977528)
-- Dependencies: 811 810
-- Name: usuario_id; Type: DEFAULT; Schema: sch_gdi; Owner: www-data
--

ALTER TABLE ONLY td_di_usuarios ALTER COLUMN usuario_id SET DEFAULT nextval('td_di_usuarios_usuario_id_seq'::regclass);


--
-- TOC entry 5045 (class 2604 OID 2977529)
-- Dependencies: 813 812
-- Name: disenno_instruccional_id; Type: DEFAULT; Schema: sch_gdi; Owner: www-data
--

ALTER TABLE ONLY td_disenno_instruccional ALTER COLUMN disenno_instruccional_id SET DEFAULT nextval('td_disenno_instruccional_disenno_instruccional_id_seq'::regclass);


--
-- TOC entry 5046 (class 2604 OID 2977530)
-- Dependencies: 815 814
-- Name: disenno_instruccional_x_usuario_id; Type: DEFAULT; Schema: sch_gdi; Owner: www-data
--

ALTER TABLE ONLY td_disenno_instruccional_x_usuario ALTER COLUMN disenno_instruccional_x_usuario_id SET DEFAULT nextval('td_disenno_instruccional_x_us_disenno_instruccional_x_usuar_seq'::regclass);


--
-- TOC entry 5047 (class 2604 OID 2977531)
-- Dependencies: 817 816
-- Name: material_apoyo_id; Type: DEFAULT; Schema: sch_gdi; Owner: www-data
--

ALTER TABLE ONLY td_material_apoyo ALTER COLUMN material_apoyo_id SET DEFAULT nextval('td_material_apoyo_material_apoyo_id_seq'::regclass);


--
-- TOC entry 5048 (class 2604 OID 2977532)
-- Dependencies: 819 818
-- Name: tipo_material_apoyo_id; Type: DEFAULT; Schema: sch_gdi; Owner: www-data
--

ALTER TABLE ONLY td_tipo_material_apoyo ALTER COLUMN tipo_material_apoyo_id SET DEFAULT nextval('td_tipo_material_apoyo_tipo_material_apoyo_id_seq'::regclass);


--
-- TOC entry 5111 (class 0 OID 2977430)
-- Dependencies: 794
-- Data for Name: td_di_actividades_aprendizaje; Type: TABLE DATA; Schema: sch_gdi; Owner: www-data
--



--
-- TOC entry 5124 (class 0 OID 3673237)
-- Dependencies: 821
-- Data for Name: td_di_cursos_asociados; Type: TABLE DATA; Schema: sch_gdi; Owner: www-data
--

--
-- TOC entry 5112 (class 0 OID 2977436)
-- Dependencies: 796
-- Data for Name: td_di_evaluacion; Type: TABLE DATA; Schema: sch_gdi; Owner: www-data
--



--
-- TOC entry 5113 (class 0 OID 2977442)
-- Dependencies: 798
-- Data for Name: td_di_medios_materiales; Type: TABLE DATA; Schema: sch_gdi; Owner: www-data
--



--
-- TOC entry 5114 (class 0 OID 2977448)
-- Dependencies: 800
-- Data for Name: td_di_modulos_contenidos; Type: TABLE DATA; Schema: sch_gdi; Owner: www-data
--



--
-- TOC entry 5115 (class 0 OID 2977454)
-- Dependencies: 802
-- Data for Name: td_di_objetivos_aprendizaje; Type: TABLE DATA; Schema: sch_gdi; Owner: www-data
--



--
-- TOC entry 5116 (class 0 OID 2977460)
-- Dependencies: 804
-- Data for Name: td_di_preguntas_contexto; Type: TABLE DATA; Schema: sch_gdi; Owner: www-data
--

INSERT INTO td_di_preguntas_contexto (desc_pregunta, pregunta_id, pregunta_habilitada, ayuda_pregunta) VALUES ('#tda-gdi.td_di_preguntas_contexto-participants#', 5, true, '#tda-gdi.td_di_preguntas_contexto-participants-help#');
INSERT INTO td_di_preguntas_contexto (desc_pregunta, pregunta_id, pregunta_habilitada, ayuda_pregunta) VALUES ('#tda-gdi.td_di_preguntas_contexto-requirements#', 6, true, '#tda-gdi.td_di_preguntas_contexto-requirements-help#');
INSERT INTO td_di_preguntas_contexto (desc_pregunta, pregunta_id, pregunta_habilitada, ayuda_pregunta) VALUES ('#tda-gdi.td_di_preguntas_contexto-groupdetails#', 7, true, '#tda-gdi.td_di_preguntas_contexto-groupdetails-help#');
INSERT INTO td_di_preguntas_contexto (desc_pregunta, pregunta_id, pregunta_habilitada, ayuda_pregunta) VALUES ('#tda-gdi.td_di_preguntas_contexto-coursestyle#', 8, true, '#tda-gdi.td_di_preguntas_contexto-coursestyle-help#');
INSERT INTO td_di_preguntas_contexto (desc_pregunta, pregunta_id, pregunta_habilitada, ayuda_pregunta) VALUES ('#tda-gdi.td_di_preguntas_contexto-tutors#', 9, true, '#tda-gdi.td_di_preguntas_contexto-tutors-help#');


--
-- TOC entry 5117 (class 0 OID 2977469)
-- Dependencies: 806
-- Data for Name: td_di_respuestas_contexto; Type: TABLE DATA; Schema: sch_gdi; Owner: www-data
--



--
-- TOC entry 5118 (class 0 OID 2977477)
-- Dependencies: 808
-- Data for Name: td_di_titulo; Type: TABLE DATA; Schema: sch_gdi; Owner: www-data
--



--
-- TOC entry 5119 (class 0 OID 2977483)
-- Dependencies: 810
-- Data for Name: td_di_usuarios; Type: TABLE DATA; Schema: sch_gdi; Owner: www-data
--


--
-- TOC entry 5122 (class 0 OID 2977507)
-- Dependencies: 816
-- Data for Name: td_material_apoyo; Type: TABLE DATA; Schema: sch_gdi; Owner: www-data
--

INSERT INTO td_material_apoyo (material_apoyo_id, tipo_material_apoyo_id, nom_material_apoyo, orden_presentacion, titulo_material_apoyo) VALUES (1, 1, '#tda-gdi.td_material_apoyo-title#', 1, NULL);
INSERT INTO td_material_apoyo (material_apoyo_id, tipo_material_apoyo_id, nom_material_apoyo, orden_presentacion, titulo_material_apoyo) VALUES (7, 2, '#tda-gdi.td_material_apoyo-design#', 1, '#tda-gdi.td_material_apoyo-title-design#');
INSERT INTO td_material_apoyo (material_apoyo_id, tipo_material_apoyo_id, nom_material_apoyo, orden_presentacion, titulo_material_apoyo) VALUES (2, 1, '#tda-gdi.td_material_apoyo-objectives#', 2, NULL);
INSERT INTO td_material_apoyo (material_apoyo_id, tipo_material_apoyo_id, nom_material_apoyo, orden_presentacion, titulo_material_apoyo) VALUES (3, 1, '#tda-gdi.td_material_apoyo-contents#', 3, NULL);
INSERT INTO td_material_apoyo (material_apoyo_id, tipo_material_apoyo_id, nom_material_apoyo, orden_presentacion, titulo_material_apoyo) VALUES (8, 2, '#tda-gdi.td_material_apoyo-id#', 2, '#tda-gdi.td_material_apoyo-title-id#');
INSERT INTO td_material_apoyo (material_apoyo_id, tipo_material_apoyo_id, nom_material_apoyo, orden_presentacion, titulo_material_apoyo) VALUES (4, 1, '#tda-gdi.td_material_apoyo-activities#', 4, NULL);
INSERT INTO td_material_apoyo (material_apoyo_id, tipo_material_apoyo_id, nom_material_apoyo, orden_presentacion, titulo_material_apoyo) VALUES (5, 1, '#tda-gdi.td_material_apoyo-resources#', 5, NULL);
INSERT INTO td_material_apoyo (material_apoyo_id, tipo_material_apoyo_id, nom_material_apoyo, orden_presentacion, titulo_material_apoyo) VALUES (9, 2, '#tda-gdi.td_material_apoyo-students#', 3, '#tda-gdi.td_material_apoyo-title-students#');
INSERT INTO td_material_apoyo (material_apoyo_id, tipo_material_apoyo_id, nom_material_apoyo, orden_presentacion, titulo_material_apoyo) VALUES (6, 1, '#tda-gdi.td_material_apoyo-achievements#', 6, NULL);
INSERT INTO td_material_apoyo (material_apoyo_id, tipo_material_apoyo_id, nom_material_apoyo, orden_presentacion, titulo_material_apoyo) VALUES (10, 2, '#tda-gdi.td_material_apoyo-generalobjectives#', 4, '#tda-gdi.td_material_apoyo-title-generalobjectives#');
INSERT INTO td_material_apoyo (material_apoyo_id, tipo_material_apoyo_id, nom_material_apoyo, orden_presentacion, titulo_material_apoyo) VALUES (11, 2, '#tda-gdi.td_material_apoyo-learningbjectives#', 5, '#tda-gdi.td_material_apoyo-title-learningbjectives#');
INSERT INTO td_material_apoyo (material_apoyo_id, tipo_material_apoyo_id, nom_material_apoyo, orden_presentacion, titulo_material_apoyo) VALUES (12, 2, '#tda-gdi.td_material_apoyo-contentshelp#', 6, '#tda-gdi.td_material_apoyo-title-contents#');


--
-- TOC entry 5123 (class 0 OID 2977515)
-- Dependencies: 818
-- Data for Name: td_tipo_material_apoyo; Type: TABLE DATA; Schema: sch_gdi; Owner: www-data
--

INSERT INTO td_tipo_material_apoyo (tipo_material_apoyo_id, nom_tipo_material_apoyo) VALUES (1, 'Breve');
INSERT INTO td_tipo_material_apoyo (tipo_material_apoyo_id, nom_tipo_material_apoyo) VALUES (2, 'Completa');


--
-- TOC entry 5093 (class 2606 OID 3673242)
-- Dependencies: 821 821
-- Name: pk_asociacion; Type: CONSTRAINT; Schema: sch_gdi; Owner: www-data; Tablespace: 
--

ALTER TABLE ONLY td_di_cursos_asociados
    ADD CONSTRAINT pk_asociacion PRIMARY KEY (asociacion_id);


--
-- TOC entry 5052 (class 2606 OID 2977534)
-- Dependencies: 794 794
-- Name: pk_td_di_actividades_aprendizaje; Type: CONSTRAINT; Schema: sch_gdi; Owner: www-data; Tablespace: 
--

ALTER TABLE ONLY td_di_actividades_aprendizaje
    ADD CONSTRAINT pk_td_di_actividades_aprendizaje PRIMARY KEY (actividades_aprendizaje_id);


--
-- TOC entry 5056 (class 2606 OID 2977536)
-- Dependencies: 796 796
-- Name: pk_td_di_evaluacion; Type: CONSTRAINT; Schema: sch_gdi; Owner: www-data; Tablespace: 
--

ALTER TABLE ONLY td_di_evaluacion
    ADD CONSTRAINT pk_td_di_evaluacion PRIMARY KEY (evaluacion_id);


--
-- TOC entry 5060 (class 2606 OID 2977538)
-- Dependencies: 798 798
-- Name: pk_td_di_medios_materiales; Type: CONSTRAINT; Schema: sch_gdi; Owner: www-data; Tablespace: 
--

ALTER TABLE ONLY td_di_medios_materiales
    ADD CONSTRAINT pk_td_di_medios_materiales PRIMARY KEY (medios_materiales_id);


--
-- TOC entry 5064 (class 2606 OID 2977540)
-- Dependencies: 800 800
-- Name: pk_td_di_modulos_contenidos; Type: CONSTRAINT; Schema: sch_gdi; Owner: www-data; Tablespace: 
--

ALTER TABLE ONLY td_di_modulos_contenidos
    ADD CONSTRAINT pk_td_di_modulos_contenidos PRIMARY KEY (modulos_contenidos_id);


--
-- TOC entry 5068 (class 2606 OID 2977542)
-- Dependencies: 802 802
-- Name: pk_td_di_objetivos_aprendizaje; Type: CONSTRAINT; Schema: sch_gdi; Owner: www-data; Tablespace: 
--

ALTER TABLE ONLY td_di_objetivos_aprendizaje
    ADD CONSTRAINT pk_td_di_objetivos_aprendizaje PRIMARY KEY (objetivos_aprendizaje_id);


--
-- TOC entry 5080 (class 2606 OID 2977544)
-- Dependencies: 810 810
-- Name: pk_td_di_usuarios; Type: CONSTRAINT; Schema: sch_gdi; Owner: www-data; Tablespace: 
--

ALTER TABLE ONLY td_di_usuarios
    ADD CONSTRAINT pk_td_di_usuarios PRIMARY KEY (usuario_id);


--
-- TOC entry 5082 (class 2606 OID 2977546)
-- Dependencies: 812 812
-- Name: pk_td_disenno_instruccional; Type: CONSTRAINT; Schema: sch_gdi; Owner: www-data; Tablespace: 
--

ALTER TABLE ONLY td_disenno_instruccional
    ADD CONSTRAINT pk_td_disenno_instruccional PRIMARY KEY (disenno_instruccional_id);


--
-- TOC entry 5086 (class 2606 OID 2977548)
-- Dependencies: 814 814
-- Name: pk_td_disenno_instruccional_x_usuario; Type: CONSTRAINT; Schema: sch_gdi; Owner: www-data; Tablespace: 
--

ALTER TABLE ONLY td_disenno_instruccional_x_usuario
    ADD CONSTRAINT pk_td_disenno_instruccional_x_usuario PRIMARY KEY (disenno_instruccional_x_usuario_id);


--
-- TOC entry 5089 (class 2606 OID 2977550)
-- Dependencies: 816 816
-- Name: pk_td_material_apoyo; Type: CONSTRAINT; Schema: sch_gdi; Owner: www-data; Tablespace: 
--

ALTER TABLE ONLY td_material_apoyo
    ADD CONSTRAINT pk_td_material_apoyo PRIMARY KEY (material_apoyo_id);


--
-- TOC entry 5091 (class 2606 OID 2977552)
-- Dependencies: 818 818
-- Name: pk_td_tipo_material_apoyo; Type: CONSTRAINT; Schema: sch_gdi; Owner: www-data; Tablespace: 
--

ALTER TABLE ONLY td_tipo_material_apoyo
    ADD CONSTRAINT pk_td_tipo_material_apoyo UNIQUE (tipo_material_apoyo_id);


--
-- TOC entry 5078 (class 2606 OID 2977554)
-- Dependencies: 808 808
-- Name: pk_titulo; Type: CONSTRAINT; Schema: sch_gdi; Owner: www-data; Tablespace: 
--

ALTER TABLE ONLY td_di_titulo
    ADD CONSTRAINT pk_titulo PRIMARY KEY (titulo_id);


--
-- TOC entry 5070 (class 2606 OID 2977556)
-- Dependencies: 804 804
-- Name: pregunta_id_pk; Type: CONSTRAINT; Schema: sch_gdi; Owner: www-data; Tablespace: 
--

ALTER TABLE ONLY td_di_preguntas_contexto
    ADD CONSTRAINT pregunta_id_pk PRIMARY KEY (pregunta_id);


--
-- TOC entry 5074 (class 2606 OID 2977558)
-- Dependencies: 806 806
-- Name: respuesta_id_pk; Type: CONSTRAINT; Schema: sch_gdi; Owner: www-data; Tablespace: 
--

ALTER TABLE ONLY td_di_respuestas_contexto
    ADD CONSTRAINT respuesta_id_pk PRIMARY KEY (respuesta_id);


--
-- TOC entry 5071 (class 1259 OID 2977559)
-- Dependencies: 806
-- Name: fki_disenno_instruccional_id_fk; Type: INDEX; Schema: sch_gdi; Owner: www-data; Tablespace: 
--

CREATE INDEX fki_disenno_instruccional_id_fk ON td_di_respuestas_contexto USING btree (disenno_instruccional_id);


--
-- TOC entry 5072 (class 1259 OID 2977560)
-- Dependencies: 806
-- Name: fki_pregunta_id_fk; Type: INDEX; Schema: sch_gdi; Owner: www-data; Tablespace: 
--

CREATE INDEX fki_pregunta_id_fk ON td_di_respuestas_contexto USING btree (pregunta_id);


--
-- TOC entry 5083 (class 1259 OID 2977561)
-- Dependencies: 814
-- Name: idx_rd_disenno_instruccional_x_usuario; Type: INDEX; Schema: sch_gdi; Owner: www-data; Tablespace: 
--

CREATE INDEX idx_rd_disenno_instruccional_x_usuario ON td_disenno_instruccional_x_usuario USING btree (disenno_instruccional_id);


--
-- TOC entry 5050 (class 1259 OID 2977562)
-- Dependencies: 794
-- Name: idx_td_di_actividades_aprendizaje; Type: INDEX; Schema: sch_gdi; Owner: www-data; Tablespace: 
--

CREATE INDEX idx_td_di_actividades_aprendizaje ON td_di_actividades_aprendizaje USING btree (disenno_instruccional_id);


--
-- TOC entry 5053 (class 1259 OID 2977563)
-- Dependencies: 796
-- Name: idx_td_di_evaluacion; Type: INDEX; Schema: sch_gdi; Owner: www-data; Tablespace: 
--

CREATE INDEX idx_td_di_evaluacion ON td_di_evaluacion USING btree (disenno_instruccional_id);


--
-- TOC entry 5054 (class 1259 OID 2977564)
-- Dependencies: 796
-- Name: idx_td_di_evaluacion_0; Type: INDEX; Schema: sch_gdi; Owner: www-data; Tablespace: 
--

CREATE INDEX idx_td_di_evaluacion_0 ON td_di_evaluacion USING btree (material_apoyo_id);


--
-- TOC entry 5057 (class 1259 OID 2977565)
-- Dependencies: 798
-- Name: idx_td_di_medios_materiales; Type: INDEX; Schema: sch_gdi; Owner: www-data; Tablespace: 
--

CREATE INDEX idx_td_di_medios_materiales ON td_di_medios_materiales USING btree (disenno_instruccional_id);


--
-- TOC entry 5058 (class 1259 OID 2977566)
-- Dependencies: 798
-- Name: idx_td_di_medios_materiales_0; Type: INDEX; Schema: sch_gdi; Owner: www-data; Tablespace: 
--

CREATE INDEX idx_td_di_medios_materiales_0 ON td_di_medios_materiales USING btree (material_apoyo_id);


--
-- TOC entry 5061 (class 1259 OID 2977567)
-- Dependencies: 800
-- Name: idx_td_di_modulos_contenidos; Type: INDEX; Schema: sch_gdi; Owner: www-data; Tablespace: 
--

CREATE INDEX idx_td_di_modulos_contenidos ON td_di_modulos_contenidos USING btree (disenno_instruccional_id);


--
-- TOC entry 5062 (class 1259 OID 2977568)
-- Dependencies: 800
-- Name: idx_td_di_modulos_contenidos_1; Type: INDEX; Schema: sch_gdi; Owner: www-data; Tablespace: 
--

CREATE INDEX idx_td_di_modulos_contenidos_1 ON td_di_modulos_contenidos USING btree (material_apoyo_id);


--
-- TOC entry 5065 (class 1259 OID 2977569)
-- Dependencies: 802
-- Name: idx_td_di_objetivos_aprendizaje; Type: INDEX; Schema: sch_gdi; Owner: www-data; Tablespace: 
--

CREATE INDEX idx_td_di_objetivos_aprendizaje ON td_di_objetivos_aprendizaje USING btree (disenno_instruccional_id);


--
-- TOC entry 5066 (class 1259 OID 2977570)
-- Dependencies: 802
-- Name: idx_td_di_objetivos_aprendizaje_0; Type: INDEX; Schema: sch_gdi; Owner: www-data; Tablespace: 
--

CREATE INDEX idx_td_di_objetivos_aprendizaje_0 ON td_di_objetivos_aprendizaje USING btree (material_apoyo_id);


--
-- TOC entry 5075 (class 1259 OID 2977571)
-- Dependencies: 808
-- Name: idx_td_di_titulo; Type: INDEX; Schema: sch_gdi; Owner: www-data; Tablespace: 
--

CREATE INDEX idx_td_di_titulo ON td_di_titulo USING btree (material_apoyo_id);


--
-- TOC entry 5076 (class 1259 OID 2977572)
-- Dependencies: 808
-- Name: idx_td_di_titulo_0; Type: INDEX; Schema: sch_gdi; Owner: www-data; Tablespace: 
--

CREATE INDEX idx_td_di_titulo_0 ON td_di_titulo USING btree (disenno_instruccional_id);


--
-- TOC entry 5084 (class 1259 OID 2977573)
-- Dependencies: 814
-- Name: idx_td_disenno_instruccional_x_usuario; Type: INDEX; Schema: sch_gdi; Owner: www-data; Tablespace: 
--

CREATE INDEX idx_td_disenno_instruccional_x_usuario ON td_disenno_instruccional_x_usuario USING btree (usuario_id);


--
-- TOC entry 5087 (class 1259 OID 2977574)
-- Dependencies: 816
-- Name: idx_td_material_apoyo; Type: INDEX; Schema: sch_gdi; Owner: www-data; Tablespace: 
--

CREATE INDEX idx_td_material_apoyo ON td_material_apoyo USING btree (tipo_material_apoyo_id);


--
-- TOC entry 5105 (class 2606 OID 2977575)
-- Dependencies: 5081 812 806
-- Name: disenno_instruccional_id_fk; Type: FK CONSTRAINT; Schema: sch_gdi; Owner: www-data
--

ALTER TABLE ONLY td_di_respuestas_contexto
    ADD CONSTRAINT disenno_instruccional_id_fk FOREIGN KEY (disenno_instruccional_id) REFERENCES td_disenno_instruccional(disenno_instruccional_id);


--
-- TOC entry 5095 (class 2606 OID 2977580)
-- Dependencies: 5081 794 812
-- Name: fk_td_di_actividades_aprendizaje; Type: FK CONSTRAINT; Schema: sch_gdi; Owner: www-data
--

ALTER TABLE ONLY td_di_actividades_aprendizaje
    ADD CONSTRAINT fk_td_di_actividades_aprendizaje FOREIGN KEY (disenno_instruccional_id) REFERENCES td_disenno_instruccional(disenno_instruccional_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 5094 (class 2606 OID 2977585)
-- Dependencies: 5088 816 794
-- Name: fk_td_di_actividades_aprendizaje_0; Type: FK CONSTRAINT; Schema: sch_gdi; Owner: www-data
--

ALTER TABLE ONLY td_di_actividades_aprendizaje
    ADD CONSTRAINT fk_td_di_actividades_aprendizaje_0 FOREIGN KEY (material_apoyo_id) REFERENCES td_material_apoyo(material_apoyo_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 5097 (class 2606 OID 2977590)
-- Dependencies: 812 796 5081
-- Name: fk_td_di_evaluacion; Type: FK CONSTRAINT; Schema: sch_gdi; Owner: www-data
--

ALTER TABLE ONLY td_di_evaluacion
    ADD CONSTRAINT fk_td_di_evaluacion FOREIGN KEY (disenno_instruccional_id) REFERENCES td_disenno_instruccional(disenno_instruccional_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 5096 (class 2606 OID 2977595)
-- Dependencies: 816 5088 796
-- Name: fk_td_di_evaluacion_0; Type: FK CONSTRAINT; Schema: sch_gdi; Owner: www-data
--

ALTER TABLE ONLY td_di_evaluacion
    ADD CONSTRAINT fk_td_di_evaluacion_0 FOREIGN KEY (material_apoyo_id) REFERENCES td_material_apoyo(material_apoyo_id) ON DELETE CASCADE;


--
-- TOC entry 5099 (class 2606 OID 2977600)
-- Dependencies: 5081 798 812
-- Name: fk_td_di_medios_materiales; Type: FK CONSTRAINT; Schema: sch_gdi; Owner: www-data
--

ALTER TABLE ONLY td_di_medios_materiales
    ADD CONSTRAINT fk_td_di_medios_materiales FOREIGN KEY (disenno_instruccional_id) REFERENCES td_disenno_instruccional(disenno_instruccional_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 5098 (class 2606 OID 2977605)
-- Dependencies: 798 816 5088
-- Name: fk_td_di_medios_materiales_0; Type: FK CONSTRAINT; Schema: sch_gdi; Owner: www-data
--

ALTER TABLE ONLY td_di_medios_materiales
    ADD CONSTRAINT fk_td_di_medios_materiales_0 FOREIGN KEY (material_apoyo_id) REFERENCES td_material_apoyo(material_apoyo_id) ON DELETE CASCADE;


--
-- TOC entry 5101 (class 2606 OID 2977610)
-- Dependencies: 800 812 5081
-- Name: fk_td_di_modulos_contenidos; Type: FK CONSTRAINT; Schema: sch_gdi; Owner: www-data
--

ALTER TABLE ONLY td_di_modulos_contenidos
    ADD CONSTRAINT fk_td_di_modulos_contenidos FOREIGN KEY (disenno_instruccional_id) REFERENCES td_disenno_instruccional(disenno_instruccional_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 5100 (class 2606 OID 2977615)
-- Dependencies: 5088 800 816
-- Name: fk_td_di_modulos_contenidos_0; Type: FK CONSTRAINT; Schema: sch_gdi; Owner: www-data
--

ALTER TABLE ONLY td_di_modulos_contenidos
    ADD CONSTRAINT fk_td_di_modulos_contenidos_0 FOREIGN KEY (material_apoyo_id) REFERENCES td_material_apoyo(material_apoyo_id) ON DELETE CASCADE;


--
-- TOC entry 5103 (class 2606 OID 2977620)
-- Dependencies: 812 5081 802
-- Name: fk_td_di_objetivos_aprendizaje; Type: FK CONSTRAINT; Schema: sch_gdi; Owner: www-data
--

ALTER TABLE ONLY td_di_objetivos_aprendizaje
    ADD CONSTRAINT fk_td_di_objetivos_aprendizaje FOREIGN KEY (disenno_instruccional_id) REFERENCES td_disenno_instruccional(disenno_instruccional_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 5102 (class 2606 OID 2977625)
-- Dependencies: 5088 816 802
-- Name: fk_td_di_objetivos_aprendizaje_0; Type: FK CONSTRAINT; Schema: sch_gdi; Owner: www-data
--

ALTER TABLE ONLY td_di_objetivos_aprendizaje
    ADD CONSTRAINT fk_td_di_objetivos_aprendizaje_0 FOREIGN KEY (material_apoyo_id) REFERENCES td_material_apoyo(material_apoyo_id) ON DELETE CASCADE;


--
-- TOC entry 5107 (class 2606 OID 2977630)
-- Dependencies: 5088 808 816
-- Name: fk_td_di_titulo; Type: FK CONSTRAINT; Schema: sch_gdi; Owner: www-data
--

ALTER TABLE ONLY td_di_titulo
    ADD CONSTRAINT fk_td_di_titulo FOREIGN KEY (material_apoyo_id) REFERENCES td_material_apoyo(material_apoyo_id) ON DELETE CASCADE;


--
-- TOC entry 5106 (class 2606 OID 2977635)
-- Dependencies: 5081 808 812
-- Name: fk_td_di_titulo_0; Type: FK CONSTRAINT; Schema: sch_gdi; Owner: www-data
--

ALTER TABLE ONLY td_di_titulo
    ADD CONSTRAINT fk_td_di_titulo_0 FOREIGN KEY (disenno_instruccional_id) REFERENCES td_disenno_instruccional(disenno_instruccional_id) ON DELETE CASCADE;


--
-- TOC entry 5109 (class 2606 OID 2977640)
-- Dependencies: 810 814 5079
-- Name: fk_td_disenno_instruccional_x_usuario; Type: FK CONSTRAINT; Schema: sch_gdi; Owner: www-data
--

ALTER TABLE ONLY td_disenno_instruccional_x_usuario
    ADD CONSTRAINT fk_td_disenno_instruccional_x_usuario FOREIGN KEY (usuario_id) REFERENCES td_di_usuarios(usuario_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 5108 (class 2606 OID 2977645)
-- Dependencies: 814 5081 812
-- Name: fk_td_disenno_instruccional_x_usuario_0; Type: FK CONSTRAINT; Schema: sch_gdi; Owner: www-data
--

ALTER TABLE ONLY td_disenno_instruccional_x_usuario
    ADD CONSTRAINT fk_td_disenno_instruccional_x_usuario_0 FOREIGN KEY (disenno_instruccional_id) REFERENCES td_disenno_instruccional(disenno_instruccional_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 5110 (class 2606 OID 2977650)
-- Dependencies: 818 816 5090
-- Name: fk_td_material_apoyo; Type: FK CONSTRAINT; Schema: sch_gdi; Owner: www-data
--

ALTER TABLE ONLY td_material_apoyo
    ADD CONSTRAINT fk_td_material_apoyo FOREIGN KEY (tipo_material_apoyo_id) REFERENCES td_tipo_material_apoyo(tipo_material_apoyo_id) ON DELETE CASCADE;


--
-- TOC entry 5104 (class 2606 OID 2977663)
-- Dependencies: 804 5069 806
-- Name: pregunta_id_fk; Type: FK CONSTRAINT; Schema: sch_gdi; Owner: www-data
--

ALTER TABLE ONLY td_di_respuestas_contexto
    ADD CONSTRAINT pregunta_id_fk FOREIGN KEY (pregunta_id) REFERENCES td_di_preguntas_contexto(pregunta_id);


-- Completed on 2013-08-30 14:32:34 CST

--
-- PostgreSQL database dump complete
--

