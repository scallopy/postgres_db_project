CREATE TABLE stores (
    id integer PRIMARY KEY,
    name varchar
);

CREATE TABLE categories (
    id integer PRIMARY KEY,
    store_id integer REFERENCES stores(id),
    name varchar(100)
);

CREATE TABLE products (
    id integer PRIMARY KEY,
    store_id integer REFERENCES stores(id),
    category_id integer REFERENCES categories(id),
    name varchar(200),
    description text,
    price money
);

SELECT constraint_name, table_name, column_name
FROM information_schema.key_column_usage
WHERE table_name = 'stores';

SELECT constraint_name, table_name, column_name
FROM information_schema.key_column_usage
WHERE table_name = 'categories';

SELECT constraint_name, table_name, column_name
FROM information_schema.key_column_usage
WHERE table_name = 'products';

