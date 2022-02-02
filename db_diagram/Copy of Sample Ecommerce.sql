CREATE TYPE "order_status" AS ENUM (
  'new',
  'on_hold',
  'pending_supplier',
  'pending_customer',
  'confirmed',
  'canselled',
  'abandoned_cart'
);

CREATE TYPE "products_status" AS ENUM (
  'out_of_stock',
  'in_stock',
  'running_low'
);

CREATE TABLE "orders" (
  "id" int PRIMARY KEY,
  "customer_id" int UNIQUE NOT NULL,
  "status" order_status,
  "created_at" varchar
);

CREATE TABLE "order_items" (
  "order_id" int,
  "product_id" int,
  "quantity" int
);

CREATE TABLE "products" (
  "id" int PRIMARY KEY,
  "category_id" int,
  "store_id" int,
  "name" varchar,
  "price" int,
  "status" products_status,
  "created_at" datetime DEFAULT (now())
);

CREATE TABLE "customers" (
  "id" SERIAL PRIMARY KEY,
  "full_name" varchar,
  "email" varchar UNIQUE,
  "gender" varchar,
  "date_of_birth" varchar,
  "created_at" timestamp
);

CREATE TABLE "categories" (
  "id" int PRIMARY KEY,
  "store_id" int,
  "cat_name" varchar,
  "parent_id" int
);

CREATE TABLE "stores" (
  "id" int PRIMARY KEY,
  "store_name" varchar
);

ALTER TABLE "orders" ADD FOREIGN KEY ("customer_id") REFERENCES "customers" ("id");

ALTER TABLE "order_items" ADD FOREIGN KEY ("order_id") REFERENCES "orders" ("id");

ALTER TABLE "order_items" ADD FOREIGN KEY ("product_id") REFERENCES "products" ("id");

ALTER TABLE "products" ADD FOREIGN KEY ("store_id") REFERENCES "stores" ("id");

ALTER TABLE "products" ADD FOREIGN KEY ("category_id") REFERENCES "categories" ("id");

ALTER TABLE "categories" ADD FOREIGN KEY ("store_id") REFERENCES "stores" ("id");

ALTER TABLE "categories" ADD FOREIGN KEY ("parent_id") REFERENCES "categories" ("id");

CREATE INDEX "product_status" ON "products" ("status");

CREATE UNIQUE INDEX ON "products" ("id");
