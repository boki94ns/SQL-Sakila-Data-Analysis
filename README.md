# SQL Practice – Sakila Database

A collection of MySQL exercises that explore data aggregation, analytical queries, and reporting with a customized version of the Sakila movie-rental database.

## Project overview

This project focuses on writing SQL queries to analyze customers, payments, films, rentals, actors, and store performance. It demonstrates core reporting workflows as well as more advanced MySQL features.

## SQL concepts covered

- **JOINs:** Combine related data from multiple tables.
- **Aggregation:** `SUM()`, `COUNT()`, `AVG()`, `MIN()`, and `MAX()`.
- **Grouping:** `GROUP BY`, `HAVING`, and `WITH ROLLUP`.
- **Window functions:** `ROW_NUMBER()`, `RANK()`, `DENSE_RANK()`, and running aggregates using `OVER()`.
- **Temporary tables:** Intermediate results for film actors, rentals, and income.
- **Views:** Reusable monthly payment summaries.
- **Date functions:** `DATE_FORMAT()`, `EXTRACT()`, `YEAR()`, `MONTH()`, `DATEDIFF()`, and `DATE_ADD()`.

## Analyses included

- Total revenue, customer-level spending, and staff-level payments.
- Monthly customer revenue and payment statistics.
- Actor counts, rental counts, and revenue by film.
- Store and employee subtotals using `ROLLUP`.
- Actor and film rankings using window functions.
- Yearly and monthly revenue views.

## Technologies

MySQL • SQL • Sakila sample database (customized)

## Repository file

- `vezbanje.sql` — practice queries, temporary tables, window functions, and views.

## Setup notes

The script begins with `USE sakila4_182;`. Change this to the name of the database available on your machine. It also references `actor_analytics` and `film_analytics`, which are not part of the default Sakila sample database; those queries require the matching custom tables or views. Window functions require MySQL 8.0 or later.

This is a **learning and practice repository**, not a packaged end-to-end application. Some exercises may need adjustments to run in a different Sakila setup.

## Learning goal

Strengthen practical SQL skills for reporting, database querying, and entry-level data analysis.
