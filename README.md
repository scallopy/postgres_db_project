# Create Sample Database with Postgres and Postbird on Linux

## postgres_db_project

- github repo: `https://github.com/scallopy/postgres_db_project`

- How to do that: `https://docs.google.com/document/d/1p6ubkmZDJ3SS7CMpqIYN5XP9snodKYh5sOyp9wkkaWg/edit#heading=h.5sl4klq4t07j`

## Project tasks:

- requirements: PostgreSQL, Postbird

- Research the topic of your choosing to create a entity relationship diagram for your database

Let's create a database of e-commers.

1. Create user to manage database
2. Create tables for product, categories and stores with `create_tables.sql`
3. Export database: backup1.sql

- Create the schema of the database using PostgreSQL

1. Create db diagram with  [dbdiagram.io](https://dbdiagram.io/home)

- Save the Diagram as a PDF file: `db_diagram/Copy of Sample Ecommerce.pdf`

- Export postgres sql file from dbdiagram.io

- Populate your database with some data: `backup/backup2`.

- Update your database to ensure your data stays intact. This could include adding constraints and roles

- Update your database to ensure your database stays fast. This could include adding indexes, normalizing your database, and actively monitoring and maintaining your database:

```
backup/backup3
```

Tables:

![Table categories](images/table_categories.png)
