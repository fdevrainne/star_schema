SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET default_tablespace = '';
SET default_with_oids = false;


-- Drop the fact table if exists
DROP TABLE IF EXISTS facts;

-- Create the fact table schema
CREATE TABLE facts (
    customer_id bpchar REFERENCES customers,
    employee_id SMALLINT REFERENCES employees,
    product_id SMALLINT REFERENCES products,
    category_id SMALLINT REFERENCES categories,
    supplier_id SMALLINT REFERENCES suppliers,
    order_date DATE,
    unit_price REAL,
    quantity CHARACTER VARYING(20),
    discount REAL,
    CONSTRAINT pk PRIMARY KEY (customer_id, employee_id, product_id,
                               category_id, supplier_id, order_date)
);


-- Load data into the star schema
INSERT INTO facts

SELECT
    ord.customer_id,
    ord.employee_id,
    det.product_id,
    pro.category_id,
    pro.supplier_id,
    ord.order_date,
    det.unit_price,
    det.quantity,
    det.discount

FROM orders AS ord
LEFT JOIN order_details AS det ON ord.order_id = det.order_id
LEFT JOIN products AS pro ON pro.product_id = det.product_id
;
