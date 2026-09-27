SELECT 
    t.name AS table_name,
    c.name AS column_name,
    ic.key_ordinal AS ordre_dans_la_cle
FROM sys.tables t
JOIN sys.indexes i ON t.object_id = i.object_id AND i.is_primary_key = 1
JOIN sys.index_columns ic ON i.object_id = ic.object_id AND i.index_id = ic.index_id
JOIN sys.columns c ON ic.object_id = c.object_id AND ic.column_id = c.column_id
ORDER BY t.name, ic.key_ordinal;

-- orders dépend de customers
ALTER TABLE orders
ADD CONSTRAINT FK_orders_customers FOREIGN KEY (customer_id) REFERENCES customers(customer_id);

-- order_items dépend de orders, products, sellers
ALTER TABLE order_items
ADD CONSTRAINT FK_items_orders FOREIGN KEY (order_id) REFERENCES orders(order_id);

ALTER TABLE order_items
ADD CONSTRAINT FK_items_products FOREIGN KEY (product_id) REFERENCES products(product_id);

ALTER TABLE order_items
ADD CONSTRAINT FK_items_sellers FOREIGN KEY (seller_id) REFERENCES sellers(seller_id);

-- order_payments dépend de orders
ALTER TABLE order_payments
ADD CONSTRAINT FK_payments_orders FOREIGN KEY (order_id) REFERENCES orders(order_id);

-- order_reviews dépend de orders
ALTER TABLE order_reviews
ADD CONSTRAINT FK_reviews_orders FOREIGN KEY (order_id) REFERENCES orders(order_id);