-- BENCHMARK QUERIES FOR CASES 1 AND 2 (ORIGINAL SCHEMA)

use keyist;


SET @num_iterations = 1000;

-- Retrieve name and description of all red products featured by an height of at least 5 cm and a name starting with 'H'
drop procedure if exists bench_products;
DELIMITER $$
CREATE PROCEDURE bench_products(num_iterations INT)
BEGIN
DECLARE i INT DEFAULT 0; 
WHILE (i < num_iterations) DO
SELECT P.name, P.long_desc
FROM keyist.product P, keyist.product_category PC, keyist.product_variant PV, keyist.color C
WHERE P.category_id = PC.id AND PV.product_id = P.id AND PV.color_id = C.id 
	AND C.name = 'red' AND PV.height >= 5 AND P.name LIKE 'H%';
SET i = i+1;
END WHILE;
END $$ 
DELIMITER ;
CALL bench_products(@num_iterations);
    
-- Retrieve name, composition and price of all products containing copper and with a sell count greater than 5
drop procedure if exists bench_products_2;
DELIMITER $$
CREATE PROCEDURE bench_products_2(num_iterations INT)
BEGIN
DECLARE i INT DEFAULT 0; 
WHILE (i < num_iterations) DO
SELECT P.name, PV.composition, PV.cargo_price
FROM keyist.product P, keyist.product_variant PV
WHERE PV.product_id = P.id AND PV.composition LIKE 'Copper%' and PV.sell_count > 5;
SET i = i+1;
END WHILE;
END $$ 
DELIMITER ;
CALL bench_products_2(@num_iterations);
    
-- Retrieve name, surname, email and current cart price of all the users living in Milan
drop procedure if exists bench_users;
DELIMITER $$
CREATE PROCEDURE bench_users(num_iterations INT)
BEGIN
DECLARE i INT DEFAULT 0; 
WHILE (i < num_iterations) DO
SELECT U.first_name, U.last_name, U.email, C.total_price
FROM keyist.user U, keyist.cart C
WHERE U.id = C.user_id AND U.city = 'Milan';
SET i = i+1;
END WHILE;
END $$ 
DELIMITER ;
CALL bench_users(@num_iterations);

-- Retrieve product variant id, amount, billing address and discount percent of all the orders made by Mario Rossi
drop procedure if exists bench_orders;
DELIMITER $$
CREATE PROCEDURE bench_orders(num_iterations INT)
BEGIN
DECLARE i INT DEFAULT 0; 
WHILE (i < num_iterations) DO
SELECT OD.product_variant_id, OD.amount, O.billing_address, D.discount_percent
FROM keyist.user U, keyist.orders O, keyist.order_detail OD, keyist.discount D 
WHERE U.id = O.user_id AND O.discount_id = D.id AND OD.order_id = O.id
	AND U.first_name = 'Mario' AND U.last_name = 'Rossi';
SET i = i+1;
END WHILE;
END $$ 
DELIMITER ;
CALL bench_orders(@num_iterations);
    
-- Retrieve the total amount of cart entries for products with height greater than 2cm, considering only orders with a cargo price greater than 10$
drop procedure if exists bench_carts;
DELIMITER $$
CREATE PROCEDURE bench_carts(num_iterations INT)
BEGIN
DECLARE i INT DEFAULT 0; 
WHILE (i < num_iterations) DO
SELECT SUM(CI.amount) AS total_entries
FROM keyist.cart_item CI, keyist.product_variant PV, keyist.cart C
WHERE C.id = CI.cart_id AND CI.product_variant_id = PV.id
	AND PV.height > 2 AND C.total_cargo_price > 10;
SET i = i+1;
END WHILE;
END $$ 
DELIMITER ;
CALL bench_carts(@num_iterations);