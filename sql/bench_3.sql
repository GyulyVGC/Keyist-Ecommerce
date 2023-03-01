-- BENCHMARK QUERIES FOR CASE 3 (MODIFIED SCHEMA)

use keyist;


SET @num_iterations = 1000;

-- Retrieve name and description of all red products featured by an height of at least 5 cm and a name starting with 'H'
drop procedure if exists bench_products;
DELIMITER $$
CREATE PROCEDURE bench_products(num_iterations INT)
BEGIN
DECLARE i INT DEFAULT 0; 
WHILE (i < num_iterations) DO
SELECT P_2.name, P_2.long_desc
FROM keyist.product P, keyist.product_2 P_2, keyist.product_3 P_3, keyist.product_category PC, keyist.product_category_2 PC_2,
	keyist.product_variant PV, keyist.product_variant_2 PV_2, keyist.product_variant_3 PV_3,
    keyist.color C, keyist.color_2 C_2
WHERE P.category_id = PC.id AND PV.product_id = P.id AND PV.color_id = C.id AND PC_2.category_id = PC.id
	AND P_2.product_id = P.id AND P_3.product_id = P.id AND C_2.color_id = C.id
    AND PV.id = PV_2.variant_id AND PV.id = PV_3.variant_id
	AND C.name = 'red' AND PV_2.height >= 5 AND P_2.name LIKE 'H%';
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
SELECT P_2.name, PV_2.composition, PV_2.cargo_price
FROM keyist.product P, keyist.product_2 P_2, keyist.product_3 P_3, 
	keyist.product_variant PV, keyist.product_variant_2 PV_2, keyist.product_variant_3 PV_3
WHERE PV.product_id = P.id AND PV_2.composition LIKE 'Copper%' and PV_2.sell_count > 5
	AND P_2.product_id = P.id AND P_3.product_id = P.id AND PV.id = PV_2.variant_id AND PV.id = PV_3.variant_id;
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
SELECT U.first_name, U.last_name, U.email, C_2.total_price
FROM keyist.user U, keyist.user_2 U_2, keyist.user_3 U_3, keyist.cart C, keyist.cart_2 C_2
WHERE U.id = C.user_id AND U_2.user_id = U.id AND U_3.user_id = U.id AND C.id = C_2.cart_id
	AND U_2.city = 'Milan';
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
SELECT OD.product_variant_id, OD_2.amount, O.billing_address, D_2.discount_percent
FROM keyist.user U, keyist.user_2 U_2, keyist.user_3 U_3,
	keyist.orders O, keyist.orders_2 O_2, keyist.orders_3 O_3, keyist.order_detail OD, keyist.order_detail_2 OD_2,
    keyist.discount D, keyist.discount_2 D_2
WHERE U.id = O.user_id AND O_3.discount_id = D.id AND OD.order_id = O.id
	AND U_2.user_id = U.id AND U_3.user_id = U.id
    AND O_2.orders_id = O.id AND O_3.orders_id = O.id AND OD_2.order_detail_id = OD.id
    AND D_2.discount_id = D.id
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
SELECT SUM(CI_2.amount) AS total_entries
FROM keyist.cart_item CI, keyist.cart_item_2 CI_2, 
	keyist.product_variant PV, keyist.product_variant_2 PV_2, keyist.product_variant_3 PV_3,
    keyist.cart C, keyist.cart_2 C_2
WHERE C.id = CI.cart_id AND CI.product_variant_id = PV.id
	AND PV.id = PV_2.variant_id AND PV.id = PV_3.variant_id
    AND C.id = C_2.cart_id AND CI_2.cart_item_id = CI.id
	AND PV_2.height > 2 AND C_2.total_cargo_price > 10;
SET i = i+1;
END WHILE;
END $$ 
DELIMITER ;
CALL bench_carts(@num_iterations);