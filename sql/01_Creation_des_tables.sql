--Création de la base de données olist_retail
CREATE DATABASE Olist_retail

--Pointe sur la base de données Olist_retail 
USE Olist_retail

-- Tables indépendantes

CREATE TABLE customers (
    customer_id VARCHAR(32) NOT NULL,
    customer_unique_id VARCHAR(32) NOT NULL,
    customer_zip_code_prefix VARCHAR(10) NOT NULL,
    customer_city VARCHAR(50) NOT NULL,
    customer_state CHAR(2) NOT NULL,
    PRIMARY KEY (customer_id)
);

CREATE TABLE sellers (
    seller_id VARCHAR(32) NOT NULL,
    seller_zip_code_prefix VARCHAR(10) NOT NULL,
    seller_city VARCHAR(50) NOT NULL,
    seller_state CHAR(2) NOT NULL,
    PRIMARY KEY (seller_id)
);

CREATE TABLE geolocation (
    geolocation_zip_code_prefix VARCHAR(10) NOT NULL,
    geolocation_lat DECIMAL(9,6) NOT NULL,
    geolocation_lng DECIMAL(9,6) NOT NULL,
    geolocation_city VARCHAR(50) NOT NULL,
    geolocation_state CHAR(2) NOT NULL
    -- pas de clé primaire : un même code postal se répète naturellement
);

CREATE TABLE products (
    product_id VARCHAR(32) NOT NULL,
    product_category_name VARCHAR(50) NULL,
    product_name_lenght SMALLINT NULL,
    product_description_lenght INT NULL,
    product_photos_qty TINYINT NULL,
    product_weight_g INT NULL,
    product_length_cm SMALLINT NULL,
    product_height_cm SMALLINT NULL,
    product_width_cm SMALLINT NULL,
    PRIMARY KEY (product_id)
);

-- Tables dépendantes

CREATE TABLE orders (
    order_id VARCHAR(32) NOT NULL,
    customer_id VARCHAR(32) NOT NULL,
    order_status VARCHAR(20) NOT NULL,
    order_purchase_timestamp DATETIME2 NOT NULL,
    order_approved_at DATETIME2 NULL,
    order_delivered_carrier_date DATETIME2 NULL,
    order_delivered_customer_date DATETIME2 NULL,
    order_estimated_delivery_date DATETIME2 NOT NULL,
    PRIMARY KEY (order_id),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE order_items (
    order_id VARCHAR(32) NOT NULL,
    order_item_id TINYINT NOT NULL,
    product_id VARCHAR(32) NOT NULL,
    seller_id VARCHAR(32) NOT NULL,
    shipping_limit_date DATETIME2 NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    freight_value DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (order_id, order_item_id),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id),
    FOREIGN KEY (seller_id) REFERENCES sellers(seller_id)
);

CREATE TABLE order_payments (
    order_id VARCHAR(32) NOT NULL,
    payment_sequential TINYINT NOT NULL,
    payment_type VARCHAR(15) NOT NULL,
    payment_installments TINYINT NOT NULL,
    payment_value DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (order_id, payment_sequential),
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

CREATE TABLE order_reviews (
    review_id VARCHAR(32) NOT NULL,
    order_id VARCHAR(32) NOT NULL,
    review_score TINYINT NOT NULL,
    review_comment_title VARCHAR(100) NULL,
    review_comment_message VARCHAR(MAX) NULL,
    review_creation_date DATETIME2 NOT NULL,
    review_answer_timestamp DATETIME2 NOT NULL,
    PRIMARY KEY (review_id, order_id),
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);