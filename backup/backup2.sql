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


--
-- Name: order_status; Type: TYPE; Schema: public; Owner: scaly
--

CREATE TYPE public.order_status AS ENUM (
    'new',
    'on_hold',
    'pending_supplier',
    'pending_customer',
    'confirmed',
    'canselled',
    'abandoned_cart'
);


ALTER TYPE public.order_status OWNER TO scaly;

--
-- Name: product_status; Type: TYPE; Schema: public; Owner: scaly
--

CREATE TYPE public.product_status AS ENUM (
    'out_of_stock',
    'in_stock',
    'running_low'
);


ALTER TYPE public.product_status OWNER TO scaly;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: categories; Type: TABLE; Schema: public; Owner: scaly
--

CREATE TABLE public.categories (
    id integer NOT NULL,
    store_id integer,
    name character varying(100),
    parent_id integer
);


ALTER TABLE public.categories OWNER TO scaly;

--
-- Name: customers; Type: TABLE; Schema: public; Owner: scaly
--

CREATE TABLE public.customers (
    id integer NOT NULL,
    full_name character varying,
    email character varying,
    gender character varying,
    date_of_birth character varying,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.customers OWNER TO scaly;

--
-- Name: customers_id_seq; Type: SEQUENCE; Schema: public; Owner: scaly
--

CREATE SEQUENCE public.customers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.customers_id_seq OWNER TO scaly;

--
-- Name: customers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: scaly
--

ALTER SEQUENCE public.customers_id_seq OWNED BY public.customers.id;


--
-- Name: order_items; Type: TABLE; Schema: public; Owner: scaly
--

CREATE TABLE public.order_items (
    order_id integer,
    product_id integer,
    quantity integer
);


ALTER TABLE public.order_items OWNER TO scaly;

--
-- Name: orders; Type: TABLE; Schema: public; Owner: scaly
--

CREATE TABLE public.orders (
    id integer NOT NULL,
    customer_id integer NOT NULL,
    status public.order_status
);


ALTER TABLE public.orders OWNER TO scaly;

--
-- Name: products; Type: TABLE; Schema: public; Owner: scaly
--

CREATE TABLE public.products (
    id integer NOT NULL,
    store_id integer,
    category_id integer,
    name character varying(200),
    description text,
    price money,
    status public.product_status,
    created_at timestamp without time zone
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
-- Name: customers id; Type: DEFAULT; Schema: public; Owner: scaly
--

ALTER TABLE ONLY public.customers ALTER COLUMN id SET DEFAULT nextval('public.customers_id_seq'::regclass);


--
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: scaly
--

COPY public.categories (id, store_id, name, parent_id) FROM stdin;
1	2	Tools	\N
2	2	Electrical Mashines	\N
\.


--
-- Data for Name: customers; Type: TABLE DATA; Schema: public; Owner: scaly
--

COPY public.customers (id, full_name, email, gender, date_of_birth, created_at) FROM stdin;
1	Peter Ver	peter@test.com	male	1974-03-15	2022-02-03 06:07:54.796523
2	Jan Ver	jan@test.com	male	1975-05-17	2022-02-03 06:08:57.025917
\.


--
-- Name: customers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: scaly
--

SELECT pg_catalog.setval('public.customers_id_seq', 1, false);


--
-- Data for Name: order_items; Type: TABLE DATA; Schema: public; Owner: scaly
--

COPY public.order_items (order_id, product_id, quantity) FROM stdin;
1	1	3
\.


--
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: scaly
--

COPY public.orders (id, customer_id, status) FROM stdin;
1	2	new
\.


--
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: scaly
--

COPY public.products (id, store_id, category_id, name, description, price, status, created_at) FROM stdin;
1	2	1	Hammer	Some description	$12.00	\N	\N
2	2	2	Compact Dril	Some description	$125.00	\N	\N
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
-- Name: customers customers_email_key; Type: CONSTRAINT; Schema: public; Owner: scaly
--

ALTER TABLE ONLY public.customers
    ADD CONSTRAINT customers_email_key UNIQUE (email);


--
-- Name: customers customers_pkey; Type: CONSTRAINT; Schema: public; Owner: scaly
--

ALTER TABLE ONLY public.customers
    ADD CONSTRAINT customers_pkey PRIMARY KEY (id);


--
-- Name: orders orders_customer_id_key; Type: CONSTRAINT; Schema: public; Owner: scaly
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_customer_id_key UNIQUE (customer_id);


--
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: scaly
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);


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
-- Name: categories categories_parent_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: scaly
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_parent_id_fkey FOREIGN KEY (parent_id) REFERENCES public.categories(id);


--
-- Name: categories categories_store_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: scaly
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_store_id_fkey FOREIGN KEY (store_id) REFERENCES public.stores(id);


--
-- Name: order_items order_items_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: scaly
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_order_id_fkey FOREIGN KEY (order_id) REFERENCES public.orders(id);


--
-- Name: order_items order_items_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: scaly
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(id);


--
-- Name: orders orders_customer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: scaly
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES public.customers(id);


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

