--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.23
-- Dumped by pg_dump version 9.6.23

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
-- Name: categories; Type: TABLE; Schema: public; Owner: scaly
--

CREATE TABLE public.categories (
    id integer NOT NULL,
    store_id integer,
    name character varying(100)
);


ALTER TABLE public.categories OWNER TO scaly;

--
-- Name: products; Type: TABLE; Schema: public; Owner: scaly
--

CREATE TABLE public.products (
    id integer NOT NULL,
    store_id integer,
    category_id integer,
    name character varying(200),
    description text,
    price money
);


ALTER TABLE public.products OWNER TO scaly;

--
-- Name: stores; Type: TABLE; Schema: public; Owner: scaly
--

CREATE TABLE public.stores (
    id integer NOT NULL,
    name character varying
);


ALTER TABLE public.stores OWNER TO scaly;

--
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: scaly
--

COPY public.categories (id, store_id, name) FROM stdin;
1	2	Tools
2	2	Electrical Mashines
\.


--
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: scaly
--

COPY public.products (id, store_id, category_id, name, description, price) FROM stdin;
1	2	1	Hammer	Some description	$12.00
2	2	2	Compact Dril	Some description	$125.00
\.


--
-- Data for Name: stores; Type: TABLE DATA; Schema: public; Owner: scaly
--

COPY public.stores (id, name) FROM stdin;
1	Souvenirs Store
2	Hardware Store
\.


--
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: scaly
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: scaly
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);


--
-- Name: stores stores_pkey; Type: CONSTRAINT; Schema: public; Owner: scaly
--

ALTER TABLE ONLY public.stores
    ADD CONSTRAINT stores_pkey PRIMARY KEY (id);


--
-- Name: categories categories_store_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: scaly
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_store_id_fkey FOREIGN KEY (store_id) REFERENCES public.stores(id);


--
-- Name: products products_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: scaly
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.categories(id);


--
-- Name: products products_store_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: scaly
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_store_id_fkey FOREIGN KEY (store_id) REFERENCES public.stores(id);


--
-- PostgreSQL database dump complete
--

