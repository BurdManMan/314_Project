--
-- PostgreSQL database dump
--

-- Dumped from database version 12.20 (Ubuntu 12.20-0ubuntu0.20.04.1)
-- Dumped by pg_dump version 12.20 (Ubuntu 12.20-0ubuntu0.20.04.1)

-- Started on 2025-05-14 17:01:46 AEST

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
-- TOC entry 3047 (class 1262 OID 16389)
-- Name: event_management; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE event_management WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_AU.UTF-8' LC_CTYPE = 'en_AU.UTF-8';


ALTER DATABASE event_management OWNER TO postgres;

\connect event_management

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
-- TOC entry 215 (class 1255 OID 16538)
-- Name: restore_tickets_available(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.restore_tickets_available() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    UPDATE public.event
    SET tickets_available = tickets_available + 1
    WHERE event_id = OLD.event_id;
    RETURN OLD;
END;
$$;


ALTER FUNCTION public.restore_tickets_available() OWNER TO postgres;

--
-- TOC entry 214 (class 1255 OID 16536)
-- Name: update_tickets_available(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.update_tickets_available() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    UPDATE public.event
    SET tickets_available = tickets_available - 1
    WHERE event_id = NEW.event_id;
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.update_tickets_available() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 205 (class 1259 OID 16404)
-- Name: customer; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.customer (
    user_id integer NOT NULL,
    site_user_id integer NOT NULL,
    name character varying(100) NOT NULL,
    email character varying(100) NOT NULL
);


ALTER TABLE public.customer OWNER TO postgres;

--
-- TOC entry 204 (class 1259 OID 16402)
-- Name: customer_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.customer_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.customer_user_id_seq OWNER TO postgres;

--
-- TOC entry 3048 (class 0 OID 0)
-- Dependencies: 204
-- Name: customer_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.customer_user_id_seq OWNED BY public.customer.user_id;


--
-- TOC entry 209 (class 1259 OID 16469)
-- Name: event; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.event (
    event_id integer NOT NULL,
    organiser_id integer NOT NULL,
    name character varying(100) NOT NULL,
    location character varying(255) NOT NULL,
    event_date timestamp without time zone NOT NULL,
    description text,
    ticket_total integer NOT NULL,
    tickets_available integer NOT NULL,
    CONSTRAINT ticket_total_check CHECK ((ticket_total >= 0)),
    CONSTRAINT tickets_available_check CHECK ((tickets_available >= 0))
);


ALTER TABLE public.event OWNER TO postgres;

--
-- TOC entry 208 (class 1259 OID 16467)
-- Name: event_event_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.event_event_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.event_event_id_seq OWNER TO postgres;

--
-- TOC entry 3049 (class 0 OID 0)
-- Dependencies: 208
-- Name: event_event_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.event_event_id_seq OWNED BY public.event.event_id;


--
-- TOC entry 206 (class 1259 OID 16417)
-- Name: organiser; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.organiser (
    site_user_id integer NOT NULL,
    name character varying(100) NOT NULL,
    email character varying(100) NOT NULL,
    organiser_id integer NOT NULL
);


ALTER TABLE public.organiser OWNER TO postgres;

--
-- TOC entry 207 (class 1259 OID 16454)
-- Name: organiser_organiser_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.organiser_organiser_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.organiser_organiser_id_seq OWNER TO postgres;

--
-- TOC entry 3050 (class 0 OID 0)
-- Dependencies: 207
-- Name: organiser_organiser_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.organiser_organiser_id_seq OWNED BY public.organiser.organiser_id;


--
-- TOC entry 211 (class 1259 OID 16487)
-- Name: registration; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.registration (
    registration_id integer NOT NULL,
    user_id integer NOT NULL,
    event_id integer NOT NULL,
    registration_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    status character varying(20),
    details text,
    CONSTRAINT status_check CHECK (((status)::text = ANY ((ARRAY['Pending'::character varying, 'Approved'::character varying, 'Rejected'::character varying])::text[])))
);


ALTER TABLE public.registration OWNER TO postgres;

--
-- TOC entry 210 (class 1259 OID 16485)
-- Name: registration_registration_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.registration_registration_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.registration_registration_id_seq OWNER TO postgres;

--
-- TOC entry 3051 (class 0 OID 0)
-- Dependencies: 210
-- Name: registration_registration_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.registration_registration_id_seq OWNED BY public.registration.registration_id;


--
-- TOC entry 203 (class 1259 OID 16395)
-- Name: site_user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.site_user (
    site_user_id integer NOT NULL,
    account_name character varying(100) NOT NULL,
    account_type character varying(20) NOT NULL,
    username character varying(50) NOT NULL,
    password character varying(50) NOT NULL,
    CONSTRAINT account_type_check CHECK (((account_type)::text = ANY ((ARRAY['Customer'::character varying, 'Organiser'::character varying])::text[])))
);


ALTER TABLE public.site_user OWNER TO postgres;

--
-- TOC entry 202 (class 1259 OID 16393)
-- Name: site_user_site_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.site_user_site_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.site_user_site_user_id_seq OWNER TO postgres;

--
-- TOC entry 3052 (class 0 OID 0)
-- Dependencies: 202
-- Name: site_user_site_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.site_user_site_user_id_seq OWNED BY public.site_user.site_user_id;


--
-- TOC entry 213 (class 1259 OID 16510)
-- Name: ticket; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ticket (
    ticket_id integer NOT NULL,
    event_id integer NOT NULL,
    registration_id integer NOT NULL,
    ticket_type character varying(20) NOT NULL,
    seat character varying(20),
    details text,
    price numeric(10,2) NOT NULL,
    CONSTRAINT ticket_type_check CHECK (((ticket_type)::text = ANY ((ARRAY['Standard'::character varying, 'VIP'::character varying])::text[])))
);


ALTER TABLE public.ticket OWNER TO postgres;

--
-- TOC entry 212 (class 1259 OID 16508)
-- Name: ticket_ticket_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.ticket_ticket_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ticket_ticket_id_seq OWNER TO postgres;

--
-- TOC entry 3053 (class 0 OID 0)
-- Dependencies: 212
-- Name: ticket_ticket_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.ticket_ticket_id_seq OWNED BY public.ticket.ticket_id;


--
-- TOC entry 2867 (class 2604 OID 16407)
-- Name: customer user_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer ALTER COLUMN user_id SET DEFAULT nextval('public.customer_user_id_seq'::regclass);


--
-- TOC entry 2869 (class 2604 OID 16472)
-- Name: event event_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event ALTER COLUMN event_id SET DEFAULT nextval('public.event_event_id_seq'::regclass);


--
-- TOC entry 2868 (class 2604 OID 16456)
-- Name: organiser organiser_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.organiser ALTER COLUMN organiser_id SET DEFAULT nextval('public.organiser_organiser_id_seq'::regclass);


--
-- TOC entry 2872 (class 2604 OID 16490)
-- Name: registration registration_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.registration ALTER COLUMN registration_id SET DEFAULT nextval('public.registration_registration_id_seq'::regclass);


--
-- TOC entry 2865 (class 2604 OID 16398)
-- Name: site_user site_user_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.site_user ALTER COLUMN site_user_id SET DEFAULT nextval('public.site_user_site_user_id_seq'::regclass);


--
-- TOC entry 2875 (class 2604 OID 16513)
-- Name: ticket ticket_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ticket ALTER COLUMN ticket_id SET DEFAULT nextval('public.ticket_ticket_id_seq'::regclass);


-- Completed on 2025-05-14 17:01:46 AEST

--
-- PostgreSQL database dump complete
--

