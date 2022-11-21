#tables created
CREATE TABLE list(
list_id decimal(10) NOT NULL PRIMARY KEY,.
seller_id decimal(10),
list_name VARCHAR(30),
list_description VARCHAR(100)
);

CREATE TABLE seller(
seller_id decimal(10) NOT NULL PRIMARY KEY,
seller_name VARCHAR(30),
seller_phone DECIMAL(20,2)
);

CREATE TABLE ship(
seller_id decimal(10),
product_id decimal(10),
unit_id decimal(10),
shipmethod VARCHAR(100),
PRIMARY KEY (seller_ID, product_ID)
);

CREATE TABLE retrieve(
list_id decimal(10),
product_id decimal(10),
PRIMARY KEY (list_ID, product_ID)
);

CREATE TABLE unit(
unit_id decimal(10) NOT NULL PRIMARY KEY,
seller_id decimal(10),
product_id decimal(10),
condition VARCHAR(100)
);

CREATE TABLE category(
category_id decimal(10) NOT NULL PRIMARY KEY,
name VARCHAR(30) not null,
description VARCHAR(100)
);

CREATE TABLE product(
product_id DECIMAL(10) NOT NULL PRIMARY KEY,
category_id decimal(10),
product_name VARCHAR(30) NOT NULL,
description VARCHAR(100) NOT NULL,
price DECIMAL(10,2) NOT NULL
);

CREATE TABLE inventory(
inventory_id DECIMAL(10) NOT NULL PRIMARY KEY,
unit_id decimal(10),
product_id decimal(10),
account_id decimal(10),
quantity DECIMAL(10,2)
);

CREATE TABLE orders(
order_id DECIMAL(10) NOT NULL PRIMARY KEY,
product_id decimal(10),
customer_id decimal(10),
package_id decimal(10),
quantity decimal(10)
);

CREATE TABLE package(
package_id DECIMAL(10) NOT NULL PRIMARY KEY,
order_id decimal(10),
issuer varchar(50)
);

CREATE TABLE identifier(
identifier_id DECIMAL(10) NOT NULL PRIMARY KEY,
account_id decimal(10),
package_id DECIMAL(10),
create_on date
);

CREATE TABLE account(
account_id DECIMAL(10) NOT NULL PRIMARY KEY,
customer_id decimal(10),
account_name varchar(50)
);

CREATE TABLE shipment(
shipment_id decimal(10) NOT NULL PRIMARY KEY,
order_id decimal(10),
customer_id decimal(10),
shipmethod varchar(50)
);

CREATE TABLE customer(
customer_id decimal(10) NOT NULL PRIMARY KEY,
first_name VARCHAR(30),
last_name VARCHAR(30),
phone DECIMAL(20,2),
address varchar(50),
email varchar(50)
);

#foreign key insert
ALTER TABLE list
ADD FOREIGN KEY (seller_id) REFERENCES seller(seller_id);

ALTER TABLE ship
ADD FOREIGN KEY (seller_id) REFERENCES seller(seller_id);

ALTER TABLE ship
ADD FOREIGN KEY (product_id) REFERENCES product(product_id);

ALTER TABLE ship
ADD FOREIGN KEY (unit_id) REFERENCES unit(unit_id);

ALTER TABLE retrieve
ADD FOREIGN KEY (list_id) REFERENCES list(list_id);

ALTER TABLE retrieve
ADD FOREIGN KEY (product_id) REFERENCES product(product_id);

ALTER TABLE unit
ADD FOREIGN KEY (product_id) REFERENCES product(product_id);

ALTER TABLE unit
ADD FOREIGN KEY (seller_id) REFERENCES seller(seller_id);

ALTER TABLE product
ADD FOREIGN KEY (category_id) REFERENCES category(category_id);

ALTER TABLE inventory
ADD FOREIGN KEY (unit_id) REFERENCES unit(unit_id);

ALTER TABLE inventory
ADD FOREIGN KEY (product_id) REFERENCES product(product_id);

ALTER TABLE inventory
ADD FOREIGN KEY (account_id) REFERENCES account(account_id);

ALTER TABLE orders
ADD FOREIGN KEY (product_id) REFERENCES product(product_id);

ALTER TABLE orders
ADD FOREIGN KEY (customer_id) REFERENCES customer(customer_id);

ALTER TABLE orders
ADD FOREIGN KEY (package_id) REFERENCES package(package_id);

ALTER TABLE package
ADD FOREIGN KEY (order_id) REFERENCES orders(order_id);

ALTER TABLE identifier
ADD FOREIGN KEY (account_id) REFERENCES account(account_id);

ALTER TABLE identifier
ADD FOREIGN KEY (package_id) REFERENCES package(package_id);

ALTER TABLE account
ADD FOREIGN KEY (customer_id) REFERENCES customer(customer_id);

ALTER TABLE shipment
ADD FOREIGN KEY (customer_id) REFERENCES customer(customer_id);

ALTER TABLE shipment
ADD FOREIGN KEY (order_id) REFERENCES orders(order_id);

#create sequence
CREATE SEQUENCE list_seq START WITH 1; 
CREATE SEQUENCE seller_seq START WITH 1; 
CREATE SEQUENCE ship_seq START WITH 1; 
CREATE SEQUENCE retrieve_seq START WITH 1; 
CREATE SEQUENCE unit_seq START WITH 1; 
CREATE SEQUENCE category_seq START WITH 1; 
CREATE SEQUENCE product_seq START WITH 1; 
CREATE SEQUENCE inventory_seq START WITH 1; 
CREATE SEQUENCE orders_seq START WITH 1; 
CREATE SEQUENCE package_seq START WITH 1; 
CREATE SEQUENCE identifier_seq START WITH 1; 
CREATE SEQUENCE account_seq START WITH 1; 
CREATE SEQUENCE shipment_seq START WITH 1; 
CREATE SEQUENCE customer_seq START WITH 1; 

#aspect1
create or replace procedure add_product(
	category_id_arg decimal,
	product_name_arg VARCHAR,
	description_arg VARCHAR,
	price_arg DECIMAL)
is
begin
	insert into product(product_id, category_id, product_name, description, price)
	values(product_seq.nextval, category_id_arg, product_name_arg, description_arg, price_arg);
END;

BEGIN
	add_product('7','floating lamp','floats in air rather than resting on a base', '10');
END;
/

BEGIN
	add_product('7','throwable camera','photographer can throw the camera into the air and take pictures in flight', '80');
END;
/

#additional products to help with aspect 1
BEGIN
	add_product('5','computer cable','cat 6 network cable', '8');
END;
/

BEGIN
	add_product('8','How to Trade in Stocks','Jesse Livermore was a loner, an individualist', '20');
END;
/

insert into category
values(category_seq.nextval,'Computers','Shop a wide selection of laptops, tablets, desktop computers, and accessories on Amazon.com');

insert into category
values(category_seq.nextval,'Electronics','Online shopping for from a great selection at Electronics Store');

insert into category
values(category_seq.nextval,'Furniture','Discover Furniture Items on Amazon.com at a great price');

insert into category
values(category_seq.nextval,'Books','Low Prices on Millions of Books');

#aspect1 query
select * from product where category_id = "5" or category_id = "6" and price <=25;


#aspect2
#insert more data
insert into seller
values(seller_seq.nextval,'cloverxi','123456789');

insert into seller
values(seller_seq.nextval,'carlyerxi','123445669');

insert into seller
values(seller_seq.nextval,'carlyerxi','123445669');

create or replace procedure delievry_unit(
	unit_id_arg decimal,
	product_id_arg VARCHAR,
	account_id_arg decimal,
	quantity_arg decimal)
is
begin
	insert into inventory(inventory_id, unit_id, product_id, account_id, quantity)
	values(inventory_seq.nextval, unit_id_arg, product_id_arg, account_id_arg, quantity_arg);
END;


BEGIN
	delievry_unit('8','22','','10');
END;
/

BEGIN
	delievry_unit('10','41','','10');
END;
/



insert into unit
values(unit_seq.nextval,'1','22','new');

insert into unit
values(unit_seq.nextval,'2','22','used');

insert into unit
values(unit_seq.nextval,'1','41','new');

insert into unit
values(unit_seq.nextval,'2','41','used');

insert into unit
values(unit_seq.nextval,'2','42','new');

insert into unit
values(unit_seq.nextval,'2','43','new');

#aspect 2 query
SELECT product.product_name, inventory.quantity
FROM product
full outer JOIN inventory on product.product_id = inventory.product_id
where inventory.quantity <= 12


#aspect 3

insert into customer
values(customer_seq.nextval,'hanlin','zou','222445678','anhui','125465@qq.com');

insert into customer
values(customer_seq.nextval,'xinyi','zou','241524168','anhui','11526465@qq.com');

insert into customer
values(customer_seq.nextval,'yaxin','zou','765439678','anhui','098655@qq.com');

insert into customer
values(customer_seq.nextval,'xinyu','wu','231235678','anhui','1234455@qq.com');

insert into customer
values(customer_seq.nextval,'yifan','wu','324423278','beijing','bignoodle@qq.com');

insert into customer
values(customer_seq.nextval,'xiaotian','wei','254988878','anhui','littlesky@qq.com');

insert into customer
values(customer_seq.nextval,'di','qu','869442678','dalian','diq@qq.com');

insert into customer
values(customer_seq.nextval,'zhenhua','wen','289466658','anhui','ericwen@qq.com');

insert into customer
values(customer_seq.nextval,'xiaoyang','yuan','984662278','anhui','sheepsen@qq.com');


create or replace procedure create_account(
	customer_id_arg decimal,
	account_name_arg VARCHAR)
is
begin
	insert into account(account_id, customer_id, account_name)
	values(account_seq.nextval, customer_id_arg, account_name_arg);
END;

BEGIN
	create_account('1','rex1');
	create_account('1','rex2');
	create_account('1','rex3');
	create_account('2','elizabeth1');
    create_account('2','elizabeth2');
    create_account('2','elizabeth3');
    create_account('2','elizabeth4');
    create_account('3','grace1');
    create_account('4','gloria1');
    create_account('4','gloria2');
    create_account('4','gloria3');
    create_account('4','gloria4');
    create_account('5','kriswu');
    create_account('6','littlesky');
    create_account('7','dead');
    create_account('7','diq1');
    create_account('8','peaceerick');
    create_account('9','sheepsen');
END;
/

#aspect3 query
SELECT DISTINCT(customer.customer_id), customer.last_name, count(account.account_name) as "accounts associated"
FROM customer
full outer JOIN account on account.customer_id = customer.customer_id
group by customer.customer_id, customer.last_name
having count(account.account_name)>=3
order by customer.last_name desc


#aspect4
insert into customer
values(customer_seq.nextval,'Carter','Jim','232134128','newyork','carterJ@gmail.com');

insert into customer
values(customer_seq.nextval,'Delaney','Bob','9456567278','bloomington','bobD@gmail.com');


create or replace procedure purchase_product(
	product_id_arg decimal,
	customer_id_arg decimal,
	package_id_arg decimal,
    quantity_arg decimal)
is
begin
	insert into orders(order_id, product_id, customer_id, package_id, quantity)
	values(orders_seq.nextval, product_id_arg, customer_id_arg, package_id_arg, quantity_arg);
	update inventory
	set inventory.quantity = (inventory.quantity - quantity_arg)
    where inventory.product_id = product_id_arg;
END;

BEGIN
	purchase_product('22','21','','2');
END;
/


BEGIN
	purchase_product('41','22','','1');
END;
/

BEGIN
	purchase_product('41','5','','5');
END;
/

#aspect 4 query
SELECT customer.first_name, customer.last_name, customer.address
FROM customer
full outer JOIN orders on orders.customer_id = customer.customer_id
where orders.quantity >=4
order by customer.last_name desc


#aspect5
create or replace procedure ship_order(
	order_id_arg decimal,
    issuer_arg varchar)
is
begin
	insert into package(package_id, order_id, issuer)
	values(package_seq.nextval, order_id_arg, issuer_arg);

END;

BEGIN
	ship_order('2','amazon_prime');
END;
/

BEGIN
	ship_order('3','amazon_prime');
END;
/

insert into shipment
values(shipment_seq.nextval,'2','21','two‐day');

insert into shipment
values(shipment_seq.nextval,'3','22','two‐day');

insert into shipment
values(shipment_seq.nextval,'4','9','super saver shipping');

insert into shipment
values(shipment_seq.nextval,'5','5','standard shipping');

#aspect 5 query
select customer.customer_id, customer.first_name,customer.last_name, customer.phone, to_char(orders.quantity*product.price,'FML9999.00','NLS_CURRENCY=$') as total_price
from orders
full outer JOIN shipment on orders.order_id = shipment.order_id
full outer JOIN product on product.product_id= orders.product_id
full outer JOIN customer on orders.customer_id = customer.customer_id
full outer JOIN package on orders.order_id = package.order_id
WHERE shipment.shipmethod IN (SELECT shipment.shipmethod from shipment where shipmethod = 'standard shipping') or 
package.issuer IN (select package.issuer from package where issuer = 'amazon_prime')
;


#create index
#The reason why I created the index for a customer's phones and addresses is they are the unique identifier for a customer. The index can help us to find the specific customer quickly within the query we designed since it will follow the reference instead of going through the whole data list. In other words, using references is better than finding data one by one, especially in a large database.

CREATE INDEX idx_phone
ON customer(phone);

CREATE INDEX idx_address
ON customer(address);

#histroy table&trigger
CREATE TABLE product_price_history_trg (
product_id DECIMAL(12) NOT NULL,
old_price DECIMAL(10,2) NOT NULL,
new_price DECIMAL(10,2) NOT NULL,
change_date DATE NOT NULL,
FOREIGN KEY (product_id) REFERENCES product(product_id)); 
 

CREATE OR REPLACE TRIGGER product_price_history_trg
BEFORE UPDATE ON product
FOR EACH ROW
BEGIN
 IF :OLD.price <> :NEW.price THEN
 INSERT INTO product_price_history_trg(product_id, old_price, new_price, change_date)
 VALUES(:NEW.product_id, :OLD.price, :NEW.price, TRUNC(sysdate));
 END IF;
END; 

update product
set price = 15
where product_id = '43';

#Data Visualization 
#create new product data
BEGIN
	add_product('5','MSI RTX3060','3060', '500');
    add_product('5','MSI RTX3070','3070', '600');
    add_product('5','EVGA RTX3060','3060', '550');
    add_product('5','ZOTAC RTX3060','3060', '600');
    add_product('5','MSI RX6800','6800', '700');
    add_product('5','MSI RTX2080 SUPER','2080', '800');
    add_product('5','COLORFUL RX6800XT','6800', '850');
    add_product('5','ASUS RTX3090','3090', '1450');
    add_product('5','ZOTAC RTX3080TI','3080TI', '1300');
    add_product('5','ASUS RX6900 liquid-cooler','6900', '1500');
END;
/

#create new unit
insert into unit
values(unit_seq.nextval,'1','81','new');

insert into unit
values(unit_seq.nextval,'1','82','new');

insert into unit
values(unit_seq.nextval,'1','83','new');

insert into unit
values(unit_seq.nextval,'1','84','new');

insert into unit
values(unit_seq.nextval,'1','85','new');

insert into unit
values(unit_seq.nextval,'1','86','new');

insert into unit
values(unit_seq.nextval,'1','87','new');

insert into unit
values(unit_seq.nextval,'1','88','new');

insert into unit
values(unit_seq.nextval,'1','89','new');

insert into unit
values(unit_seq.nextval,'1','90','new');

#create inventory data

BEGIN
	delievry_unit('71','81','','10');
    delievry_unit('72','82','','10');
    delievry_unit('73','83','','10');
    delievry_unit('74','84','','10');
    delievry_unit('75','85','','10');
    delievry_unit('76','86','','10');
    delievry_unit('77','87','','10');
    delievry_unit('78','88','','10');
    delievry_unit('79','89','','10');
    delievry_unit('80','90','','10');
END;
/


#create new purchase order data

BEGIN
	purchase_product('89','1','','1');
	purchase_product('81','2','','1');
	purchase_product('82','3','','1');
	purchase_product('83','4','','1');
	purchase_product('84','5','','1');
	purchase_product('84','6','','1');
	purchase_product('85','7','','1');
	purchase_product('86','8','','1');
	purchase_product('87','9','','1');
	purchase_product('88','8','','1');
	purchase_product('89','9','','1');
	purchase_product('90','4','','1');
END;
/

#create shipmenthod(super saver shipping, standard shipping, two‐day, one‐day)

insert into shipment
values(shipment_seq.nextval,'21','1','one-day');

insert into shipment
values(shipment_seq.nextval,'22','2','super saver shipping');

insert into shipment
values(shipment_seq.nextval,'23','3','standard shipping');

insert into shipment
values(shipment_seq.nextval,'24','4','standard shipping');

insert into shipment
values(shipment_seq.nextval,'25','5','standard shipping');

insert into shipment
values(shipment_seq.nextval,'26','6','two-day');

insert into shipment
values(shipment_seq.nextval,'27','7','standard shipping');

insert into shipment
values(shipment_seq.nextval,'28','8','two-day');

insert into shipment
values(shipment_seq.nextval,'29','9','one-day');

insert into shipment
values(shipment_seq.nextval,'30','8','two-day');

insert into shipment
values(shipment_seq.nextval,'31','9','one-day');

insert into shipment
values(shipment_seq.nextval,'32','4','one-day');

#higher product price and shipping method query

select product.product_name, product.price, shipment.shipmethod
from orders
full outer join product on product.product_id = orders.product_id
full outer join shipment on orders.order_id = shipment.order_id
where product.category_id = '5'
order by product.price desc;
