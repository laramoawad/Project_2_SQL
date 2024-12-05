create table customer(
first_name varchar(30) not null, --not null means ino da required field cannot have it null
last_name varchar(30) not null, 
email varchar(60) not null, 
company varchar(60) not null, 
street varchar(50) not null, 
city varchar(40) not null, 
state char(2) not null, --char cux is fixed number of character cuz in US California for ex is CA and New York in NY
zip smallint not null, --cuz no need int (less storage)
phone varchar(20) not null,
birth_date date null, --maybe we dont get that w okay
sex char(1) not null, 
date_entered timestamp not null,--will store both the date and time
id serial primary key --gives unique number to each id
); 

select * from customer;

INSERT INTO customer(first_name, last_name, email, company, street, city, state, zip, phone, birth_date, sex, date_entered) VALUES 
	('Christopher', 'Jones', 'christopherjones@bp.com', 'BP', '347 Cedar St', 'Lawrenceville', 'GA', '30044', '348-848-8291', '1938-09-11', 'M', current_timestamp );


create type sex_type as enum ('M', 'F'); --means set number of values 

--changing data type for sex from char(1) to sex_type that has M or F
alter table customer 
alter column sex TYPE sex_type 
using sex::sex_type; 


--sales table
CREATE TABLE sales_person(
first_name VARCHAR(30) NOT NULL,
last_name VARCHAR(30) NOT NULL,
email VARCHAR(60) NOT NULL,
street VARCHAR(50) NOT NULL,
city VARCHAR(40) NOT NULL,
state CHAR(2) NOT NULL DEFAULT 'PA',
zip SMALLINT NOT NULL,
phone VARCHAR(20) NOT NULL,
birth_date DATE NULL,
sex sex_type NOT NULL,
date_hired TIMESTAMP NOT NULL,
id SERIAL PRIMARY KEY
);


CREATE TABLE product_type(
name VARCHAR(30) NOT NULL,
id SERIAL PRIMARY KEY
);

CREATE TABLE product(
type_id INTEGER REFERENCES product_type(id),
name VARCHAR(30) NOT NULL,
supplier VARCHAR(30) NOT NULL,
description TEXT NOT NULL,
id SERIAL PRIMARY KEY);

CREATE TABLE item(
product_id INTEGER REFERENCES product(id),
size INTEGER NOT NULL,
color VARCHAR(30) NOT NULL,
picture VARCHAR(256) NOT NULL,
price NUMERIC(6,2) NOT NULL,
id SERIAL PRIMARY KEY);


CREATE TABLE sales_order(
cust_id INTEGER REFERENCES customer(id),
sales_person_id INTEGER REFERENCES sales_person(id),
time_order_taken TIMESTAMP NOT NULL,
purchase_order_number INTEGER NOT NULL,
credit_card_number VARCHAR(16) NOT NULL,
credit_card_exper_month SMALLINT NOT NULL,
credit_card_exper_day SMALLINT NOT NULL,
credit_card_secret_code SMALLINT NOT NULL,
name_on_card VARCHAR(100) NOT NULL,
id SERIAL PRIMARY KEY
);


CREATE TABLE sales_item(
item_id INTEGER REFERENCES item(id),
sales_order_id INTEGER REFERENCES sales_order(id),
quantity INTEGER NOT NULL,
discount NUMERIC(3,2) NULL DEFAULT 0,  --means: the discount column will store numeric values with up to three digits, two of which can be after the decimal point, can have NULL values, and will default to 0 if no value is specified.
taxable BOOLEAN NOT NULL DEFAULT FALSE,
sales_tax_rate NUMERIC(5,2) NOT NULL DEFAULT 0,
id SERIAL PRIMARY KEY
);

--add column to a table
alter table sales_item 
add day_of_week varchar(8);

--modify column (to not null) 
alter table sales_item
alter column day_of_week set not null; 

--rename col
alter table sales_item 
rename column day_of_week to weekday; 


--drop col
alter table sales_item 
drop column weekday; 


--create table

create table transaction_type (
name varchar(50) not null, 
payment_type varchar(30) not null, 
id serial primary key	
); 

--rename table 
alter table transaction_type rename to transaction; 

--create index on individual col
create index transaction_id on transaction(name); 

--create index 
create index transaction_id_2 on transaction(name, payment_type); 

--remove all rows from a table without deleting the table itself
truncate table transaction; 

--drop table 
drop table transaction;


--insert values 
INSERT INTO product_type (name) VALUES ('Business');
INSERT INTO product_type (name) VALUES ('Casual');
INSERT INTO product_type (name) VALUES ('Athletic');
select * from product_type;

--TRUNCATE TABLE product_type RESTART IDENTITY CASCADE;

TRUNCATE TABLE product RESTART IDENTITY CASCADE;

INSERT INTO product VALUES
(1, 'Grandview', 'Allen Edmonds', 'Classic broguing adds texture to a charming longwing derby crafted in America from lustrous leather'),
(1, 'Clarkston', 'Allen Edmonds', 'Sharp broguing touches up a charming, American-made derby fashioned from finely textured leather'),
(1, 'Derby', 'John Varvatos', 'Leather upper, manmade sole'),
(1, 'Ramsey', 'Johnston & Murphy', 'Leather upper, manmade sole'),
(1, 'Hollis', 'Johnston & Murphy', 'Leather upper, manmade sole'),
(2, 'Venetian Loafer', 'Mezlan', 'Suede upper, leather sole'),
(2, 'Malek', 'Johnston & Murphy', 'Contrast insets at the toe and sides bring updated attitude to a retro-inspired sneaker set on a sporty foam sole and triangle-lugged tread.'),
(3, 'Air Max 270 React', 'Nike', 'The reggae inspired Nike Air 270 React fuses forest green with shades of tan to reveal your righteous spirit'),
(3, 'Joyride', 'Nike', 'Tiny foam beads underfoot conform to your foot for cushioning that stands up to your mileage'),
(2, 'Air Force 1', 'Nike', 'A modern take on the icon that blends classic style and fresh, crisp details'),
(3, 'Ghost 12', 'Brooks', 'Just know that it still strikes a just-right balance of DNA LOFT softness and BioMoGo DNA responsiveness'),
(3, 'Revel 3', 'Brooks', 'Style to spare, now even softer.'),
(3, 'Glycerin 17', 'Brooks', 'A plush fit and super soft transitions make every stride luxurious');

select * from product;

--need to change data type zip to integer cuz max is 32K 7aaga and zip codes in US could be larger
alter table customer 
alter column zip type integer; 

TRUNCATE TABLE customer RESTART IDENTITY CASCADE;

--insert to customer data 
INSERT INTO customer (first_name, last_name, email, company, street, city, state, zip, phone, birth_date, sex, date_entered) VALUES 
('Matthew', 'Martinez', 'matthewmartinez@ge.com', 'GE', '602 Main Place', 'Fontana', 'CA', '92336', '117-997-7764', '1931-09-04', 'M', '2015-01-01 22:39:28'), 
('Melissa', 'Moore', 'melissamoore@aramark.com', 'Aramark', '463 Park Rd', 'Lakewood', 'NJ', '08701', '269-720-7259', '1967-08-27', 'M', '2017-10-20 21:59:29'), 
('Melissa', 'Brown', 'melissabrown@verizon.com', 'Verizon', '712 View Ave', 'Houston', 'TX', '77084', '280-570-5166', '1948-06-14', 'F', '2016-07-16 12:26:45'), 
('Jennifer', 'Thomas', 'jenniferthomas@aramark.com', 'Aramark', '231 Elm St', 'Mission', 'TX', '78572', '976-147-9254', '1998-03-14', 'F', '2018-01-08 09:27:55'), 
('Stephanie', 'Martinez', 'stephaniemartinez@albertsons.com', 'Albertsons', '386 Second St', 'Lakewood', 'NJ', '08701', '820-131-6053', '1998-01-24', 'M', '2016-06-18 13:27:34'), 
('Daniel', 'Williams', 'danielwilliams@tjx.com', 'TJX', '107 Pine St', 'Katy', 'TX', '77449', '744-906-9837', '1985-07-20', 'F', '2015-07-03 10:40:18'), 
('Lauren', 'Anderson', 'laurenanderson@pepsi.com', 'Pepsi', '13 Maple Ave', 'Riverside', 'CA', '92503', '747-993-2446', '1973-09-09', 'F', '2018-02-01 16:43:51'), 
('Michael', 'Jackson', 'michaeljackson@disney.com', 'Disney', '818 Pine Ave', 'Mission', 'TX', '78572', '126-423-3144', '1951-03-03', 'F', '2017-04-02 21:57:36'), 
('Ashley', 'Johnson', 'ashleyjohnson@boeing.com', 'Boeing', '874 Oak Ave', 'Pacoima', 'CA', '91331', '127-475-1658', '1937-05-10', 'F', '2015-01-04 08:58:56'), 
('Brittany', 'Thomas', 'brittanythomas@walmart.com', 'Walmart', '187 Maple Ave', 'Brownsville', 'TX', '78521', '447-788-4913', '1986-10-22', 'F', '2018-05-23 08:04:32'), 
('Matthew', 'Smith', 'matthewsmith@ups.com', 'UPS', '123 Lake St', 'Brownsville', 'TX', '78521', '961-108-3758', '1950-06-16', 'F', '2018-03-15 10:08:54'), 
('Lauren', 'Wilson', 'laurenwilson@target.com', 'Target', '942 Fifth Ave', 'Mission', 'TX', '78572', '475-578-8519', '1965-12-26', 'M', '2017-07-16 11:01:01'), 
('Justin', 'Smith', 'justinsmith@boeing.com', 'Boeing', '844 Lake Ave', 'Lawrenceville', 'GA', '30044', '671-957-1492', '1956-03-16', 'F', '2017-10-07 10:50:08'), 
('Jessica', 'Garcia', 'jessicagarcia@toyota.com', 'Toyota', '123 Pine Place', 'Fontana', 'CA', '92336', '744-647-2359', '1996-08-05', 'F', '2016-09-14 12:33:05'), 
('Matthew', 'Jackson', 'matthewjackson@bp.com', 'BP', '538 Cedar Ave', 'Katy', 'TX', '77449', '363-430-1813', '1966-02-26', 'F', '2016-05-01 19:25:17'), 
('Stephanie', 'Thomas', 'stephaniethomas@apple.com', 'Apple', '804 Fourth Place', 'Brownsville', 'TX', '78521', '869-582-9955', '1988-08-26', 'F', '2018-10-21 22:01:57'), 
('Jessica', 'Jackson', 'jessicajackson@aramark.com', 'Aramark', '235 Pine Place', 'Chicago', 'IL', '60629', '587-334-1054', '1991-07-22', 'F', '2015-08-28 03:11:35'), 
('James', 'Martinez', 'jamesmartinez@kroger.com', 'Kroger', '831 Oak St', 'Brownsville', 'TX', '78521', '381-428-3119', '1927-12-22', 'F', '2018-01-27 07:41:48'), 
('Christopher', 'Robinson', 'christopherrobinson@ibm.com', 'IBM', '754 Cedar St', 'Pharr', 'TX', '78577', '488-694-7677', '1932-06-25', 'F', '2016-08-19 16:11:31');

select * from customer;

--change zip from smallint to int 
alter table sales_person 
alter column zip type integer;  

TRUNCATE TABLE sales_person RESTART IDENTITY CASCADE;

--enter sales people data 
INSERT INTO sales_person (first_name, last_name, email, street, city, state, zip, phone, birth_date, sex, date_hired) VALUES 
('Jennifer', 'Smith', 'jennifersmith@volkswagen.com', '610 Maple Place', 'Hawthorne', 'CA', '90250', '215-901-2287', '1941-08-09', 'F', '2014-02-06 12:22:48'), 
('Michael', 'Robinson', 'michaelrobinson@walmart.com', '164 Maple St', 'Pacoima', 'CA', '91331', '521-377-4462', '1956-04-23', 'M', '2014-09-12 17:27:23'), 
('Brittany', 'Jackson', 'brittanyjackson@disney.com', '263 Park Rd', 'Riverside', 'CA', '92503', '672-708-7601', '1934-07-05', 'F', '2015-01-17 02:51:55'), 
('Samantha', 'Moore', 'samanthamoore@ge.com', '107 Pine Place', 'Houston', 'TX', '77084', '893-423-2899', '1926-05-05', 'M', '2015-11-14 22:26:21'), 
('Jessica', 'Thompson', 'jessicathompson@fedex.com', '691 Third Place', 'Sylmar', 'CA', '91342', '349-203-4736', '1938-12-18', 'M', '2014-12-13 06:54:39');

select * from sales_person; 


TRUNCATE TABLE item RESTART IDENTITY CASCADE;

--data into items table 
INSERT INTO item VALUES 
(2, 10, 'Gray', 'Coming Soon', 199.60), 
(11, 12, 'Red', 'Coming Soon', 155.65), 
(2, 11, 'Red', 'Coming Soon', 128.87), 
(11, 11, 'Green', 'Coming Soon', 117.52), 
(5, 8, 'Black', 'Coming Soon', 165.39), 
(7, 11, 'Brown', 'Coming Soon', 168.15), 
(5, 8, 'Gray', 'Coming Soon', 139.48), 
(5, 11, 'Blue', 'Coming Soon', 100.14), 
(4, 10, 'Brown', 'Coming Soon', 117.66), 
(8, 10, 'Brown', 'Coming Soon', 193.53), 
(7, 8, 'Light Brown', 'Coming Soon', 154.62), 
(12, 10, 'Green', 'Coming Soon', 188.32), 
(3, 12, 'Green', 'Coming Soon', 101.49), 
(7, 9, 'Black', 'Coming Soon', 106.39), 
(8, 12, 'Red', 'Coming Soon', 124.77), 
(5, 8, 'Black', 'Coming Soon', 86.19), 
(8, 12, 'Blue', 'Coming Soon', 196.86), 
(8, 8, 'Blue', 'Coming Soon', 123.27), 
(7, 11, 'Red', 'Coming Soon', 130.76), 
(9, 12, 'Black', 'Coming Soon', 152.98), 
(11, 8, 'Blue', 'Coming Soon', 175.58), 
(7, 11, 'Light Brown', 'Coming Soon', 146.83), 
(4, 8, 'Green', 'Coming Soon', 159.82), 
(12, 8, 'Light Brown', 'Coming Soon', 171.92), 
(1, 12, 'Light Brown', 'Coming Soon', 128.77), 
(2, 10, 'Gray', 'Coming Soon', 102.45), 
(10, 8, 'Green', 'Coming Soon', 186.86), 
(1, 8, 'Blue', 'Coming Soon', 139.73), 
(9, 8, 'Light Brown', 'Coming Soon', 151.57), 
(2, 10, 'Green', 'Coming Soon', 177.16), 
(3, 9, 'Gray', 'Coming Soon', 124.87), 
(8, 8, 'Black', 'Coming Soon', 129.40), 
(5, 9, 'Black', 'Coming Soon', 107.55), 
(5, 8, 'Light Brown', 'Coming Soon', 103.71), 
(11, 10, 'Green', 'Coming Soon', 152.31), 
(6, 12, 'Red', 'Coming Soon', 108.96), 
(7, 12, 'Blue', 'Coming Soon', 173.14), 
(3, 10, 'Green', 'Coming Soon', 198.44), 
(1, 9, 'Light Brown', 'Coming Soon', 119.61), 
(1, 10, 'Black', 'Coming Soon', 114.36), 
(7, 9, 'Light Brown', 'Coming Soon', 181.93), 
(5, 10, 'Black', 'Coming Soon', 108.32), 
(1, 12, 'Black', 'Coming Soon', 153.97), 
(2, 12, 'Gray', 'Coming Soon', 184.27), 
(2, 9, 'Blue', 'Coming Soon', 151.63), 
(6, 8, 'Brown', 'Coming Soon', 159.39), 
(11, 9, 'Red', 'Coming Soon', 150.49), 
(9, 10, 'Gray', 'Coming Soon', 139.26), 
(4, 8, 'Gray', 'Coming Soon', 166.87), 
(12, 9, 'Red', 'Coming Soon', 110.77);

select * from item; 

--data in sales_order table 
--first off, integers store up to 2.1 mill, but we want to see just above 2.1 mill so lets store it as bigint, which stores even larger numbers
--so change it in properties when u right click on tabl einstead of doing it thro alter table 

TRUNCATE TABLE sales_order RESTART IDENTITY CASCADE;

INSERT INTO sales_order VALUES 
(1, 2, '2018-03-23 10:26:23', 20183231026, 5440314057399014, 3, 5, 415, 'Ashley Martin'), 
(8, 2, '2017-01-09 18:58:15', 2017191858, 6298551651340835, 10, 27, 962, 'Michael Smith'), 
(9, 3, '2018-12-21 21:26:57', 201812212126, 3194084144609442, 7, 16, 220, 'Lauren Garcia'), 
(8, 2, '2017-08-20 15:33:17', 20178201533, 2704487907300646, 7, 10, 430, 'Jessica Robinson'), 
(3, 4, '2017-09-19 13:28:35', 20179191328, 8102877849444788, 4, 15, 529, 'Melissa Jones'), 
(14, 1, '2016-10-02 18:30:13', 20161021830, 7294221943676784, 10, 22, 323, 'Lauren Moore'), 
(4, 2, '2016-03-21 07:24:30', 2016321724, 1791316080799942, 1, 24, 693, 'Joshua Wilson'), 
(1, 1, '2018-08-04 12:22:06', 2018841222, 4205390666512184, 5, 16, 758, 'Jennifer Garcia'), 
(8, 4, '2016-08-25 10:36:09', 20168251036, 3925972513042074, 1, 10, 587, 'Michael Thomas'), 
(8, 4, '2018-08-10 20:24:52', 20188102024, 2515001187633555, 10, 7, 354, 'David Martin'), 
(5, 2, '2016-11-28 15:21:48', 201611281521, 6715538212478349, 5, 25, 565, 'Jennifer Johnson'), 
(5, 3, '2016-12-07 10:20:05', 20161271020, 5125085038984547, 10, 27, 565, 'Brittany Garcia'), 
(13, 3, '2018-10-11 16:27:04', 201810111627, 5559881213107031, 7, 14, 593, 'Sarah Jackson'), 
(14, 1, '2018-04-26 20:35:34', 20184262035, 2170089500922701, 7, 26, 105, 'Daniel Harris'), 
(3, 2, '2016-11-14 04:32:50', 20161114432, 6389550669359545, 7, 19, 431, 'Brittany Williams'), 
(18, 3, '2016-07-10 17:55:01', 20167101755, 7693323933630220, 4, 22, 335, 'Christopher Thomas'), 
(12, 2, '2018-05-13 06:20:56', 2018513620, 1634255384507587, 1, 4, 364, 'Megan Garcia'), 
(3, 4, '2016-03-04 20:52:36', 2016342052, 7720584466409961, 2, 7, 546, 'Justin Taylor'), 
(17, 1, '2017-02-16 15:44:27', 20172161544, 7573753924723630, 3, 15, 148, 'Michael White'), 
(19, 3, '2017-08-04 07:24:30', 201784724, 9670036242643402, 10, 24, 803, 'Melissa Taylor'), 
(8, 2, '2018-07-08 15:51:11', 2018781551, 5865443195522495, 2, 2, 793, 'James Thompson'), 
(18, 1, '2017-03-02 03:08:03', 20173238, 9500873657482557, 6, 22, 793, 'Daniel Williams'), 
(7, 1, '2018-03-19 10:54:30', 20183191054, 7685678049357511, 2, 9, 311, 'Joshua Martinez'), 
(18, 1, '2017-07-04 18:48:02', 2017741848, 2254223828631172, 6, 18, 621, 'Justin Taylor'), 
(16, 1, '2018-07-23 21:44:51', 20187232144, 8669971462260333, 10, 3, 404, 'Ashley Garcia'), 
(8, 4, '2016-05-21 16:26:49', 20165211626, 9485792104395686, 2, 4, 270, 'Andrew Taylor'), 
(19, 4, '2018-09-04 18:24:36', 2018941824, 5293753403622328, 8, 4, 362, 'Matthew Miller'), 
(9, 2, '2018-07-01 18:19:10', 2018711819, 7480694928317516, 10, 5, 547, 'Justin Thompson'), 
(8, 4, '2018-09-10 20:15:06', 20189102015, 7284020879927491, 4, 15, 418, 'Samantha Anderson'), 
(17, 2, '2016-07-13 16:30:53', 20167131630, 7769197595493852, 1, 19, 404, 'Jessica Thomas'), 
(17, 4, '2016-09-22 22:58:11', 20169222258, 1394443435119786, 7, 5, 955, 'James Wilson'), 
(17, 4, '2017-10-28 11:35:05', 201710281135, 6788591532433513, 8, 13, 512, 'Michael Williams'), 
(12, 4, '2018-11-11 04:55:50', 20181111455, 1854718494260005, 3, 26, 928, 'Melissa Jones'), 
(15, 4, '2016-08-11 23:05:58', 2016811235, 7502173302686796, 3, 11, 836, 'Michael Thompson'), 
(2, 3, '2018-07-13 07:50:24', 2018713750, 5243198834590551, 10, 12, 725, 'Joseph Thomas'), 
(9, 3, '2017-09-28 11:42:16', 20179281142, 7221309687109696, 2, 5, 845, 'James Martinez'), 
(7, 1, '2016-01-09 18:15:08', 2016191815, 9202139348760334, 4, 4, 339, 'Samantha Wilson'), 
(18, 1, '2016-03-14 17:33:26', 20163141733, 3066530074499665, 6, 23, 835, 'David Garcia'), 
(12, 3, '2017-08-21 18:14:01', 20178211814, 1160849457958425, 8, 19, 568, 'Samantha Miller'), 
(8, 1, '2018-09-12 19:25:25', 20189121925, 6032844702934349, 8, 13, 662, 'Justin Brown'), 
(19, 2, '2016-11-06 03:07:33', 201611637, 1369214097312715, 9, 23, 330, 'Joseph Jones'), 
(3, 4, '2016-06-06 01:07:15', 20166617, 7103644598069058, 1, 5, 608, 'Brittany Thomas'), 
(13, 4, '2017-05-15 01:02:57', 201751512, 2920333635602602, 11, 14, 139, 'Stephanie Smith'), 
(15, 4, '2016-03-27 02:18:18', 2016327218, 7798214190926405, 5, 13, 809, 'Stephanie Taylor'), 
(9, 2, '2018-01-25 14:43:01', 20181251443, 4196223548846892, 10, 17, 115, 'Melissa Martin'), 
(6, 3, '2017-01-08 13:54:49', 2017181354, 8095784052038731, 8, 23, 416, 'Amanda White'), 
(12, 2, '2017-09-24 15:24:44', 20179241524, 6319974420646022, 2, 4, 755, 'Megan Anderson'), 
(11, 2, '2018-04-09 18:53:22', 2018491853, 3258192259182097, 11, 22, 730, 'Samantha Thompson'), 
(10, 2, '2018-01-11 22:20:29', 20181112220, 8336712415869878, 3, 18, 872, 'Melissa Wilson'), 
(14, 3, '2018-11-10 03:08:36', 2018111038, 6942550153605236, 9, 18, 250, 'Jessica Johnson'), 
(6, 4, '2016-06-26 16:48:19', 20166261648, 5789348928562200, 2, 7, 458, 'Christopher Jones'), 
(5, 1, '2018-06-23 02:25:16', 2018623225, 8550095429571317, 9, 25, 590, 'Samantha Wilson'), 
(18, 2, '2017-07-01 01:16:04', 201771116, 2651011719468438, 11, 11, 107, 'Andrew Miller'), 
(12, 4, '2017-01-17 21:42:51', 20171172142, 7354378345646144, 3, 14, 772, 'Andrew Moore'), 
(7, 3, '2016-01-07 22:56:31', 2016172256, 3429850164043973, 2, 6, 295, 'Joseph Taylor'), 
(10, 1, '2016-01-27 01:14:53', 2016127114, 2480926933843246, 7, 3, 704, 'Ashley Taylor'), 
(13, 1, '2018-09-15 08:15:17', 2018915815, 6626319262681476, 4, 8, 837, 'Stephanie Thomas'), 
(9, 1, '2018-04-06 15:40:28', 2018461540, 4226037621059886, 10, 26, 896, 'Stephanie Jones'), 
(17, 3, '2016-10-17 21:31:09', 201610172131, 7862008338119027, 10, 25, 767, 'Amanda Robinson'), 
(12, 2, '2016-06-04 22:27:57', 2016642227, 4472081783581101, 10, 9, 279, 'Justin Williams'), 
(9, 3, '2018-01-27 06:57:23', 2018127657, 2384491606066483, 11, 23, 417, 'Joshua Garcia'), 
(14, 2, '2018-07-19 22:11:23', 20187192211, 2680467440231722, 10, 8, 545, 'Ashley Wilson'), 
(19, 4, '2018-11-06 03:12:35', 2018116312, 3973342791188144, 10, 9, 749, 'Megan Martinez'), 
(11, 2, '2017-01-15 14:11:54', 20171151411, 3042008865691398, 8, 3, 695, 'Brittany White'), 
(10, 4, '2018-10-07 01:26:57', 2018107126, 7226038495242154, 8, 7, 516, 'Stephanie White'), 
(12, 3, '2018-10-02 16:13:23', 20181021613, 7474287104417454, 11, 1, 184, 'Daniel Davis'), 
(8, 1, '2018-08-12 23:54:52', 20188122354, 6454271840792089, 1, 19, 914, 'Michael Robinson'), 
(11, 2, '2016-07-06 04:57:33', 201676457, 6767948287515839, 8, 7, 127, 'Samantha Anderson'), 
(12, 2, '2018-09-06 10:34:03', 2018961034, 2724397042248973, 11, 11, 686, 'Ashley Harris'), 
(16, 1, '2017-11-12 07:05:38', 2017111275, 4832060124173185, 11, 27, 697, 'Brittany White'), 
(16, 4, '2016-06-08 17:38:18', 2016681738, 2187337846675221, 5, 9, 895, 'Megan Wilson'), 
(3, 3, '2016-02-08 21:46:46', 2016282146, 8361948319742012, 6, 26, 157, 'Jessica Taylor'), 
(8, 1, '2016-10-22 03:01:13', 2016102231, 1748352966511490, 8, 7, 815, 'Justin Davis'), 
(5, 4, '2018-12-06 12:51:24', 20181261251, 3987075017699453, 7, 18, 557, 'Andrew Martinez'), 
(4, 1, '2017-09-23 07:14:32', 2017923714, 4497706297852239, 2, 12, 756, 'Justin Moore'), 
(5, 3, '2016-02-28 23:16:42', 20162282316, 9406399694013062, 1, 26, 853, 'Joseph Moore'), 
(11, 4, '2016-05-24 14:37:36', 20165241437, 4754563147105980, 8, 8, 742, 'Amanda Brown'), 
(1, 2, '2018-04-08 09:35:58', 201848935, 5031182534686567, 2, 11, 760, 'Andrew Thompson'), 
(11, 1, '2017-10-07 20:45:13', 20171072045, 9736660892936088, 5, 19, 240, 'Megan Robinson'), 
(19, 2, '2017-03-19 23:03:38', 2017319233, 1154891936822433, 2, 14, 554, 'Christopher Davis'), 
(1, 1, '2018-04-26 11:58:53', 20184261158, 5672494499371853, 11, 18, 692, 'James Thomas'), 
(1, 3, '2018-07-20 10:05:17', 2018720105, 9695318985866569, 2, 12, 107, 'Jennifer Martin'), 
(7, 3, '2018-06-21 18:41:12', 20186211841, 2824438494479373, 1, 12, 296, 'Joseph Miller'), 
(6, 1, '2016-04-07 08:47:40', 201647847, 5608599820055114, 7, 2, 163, 'Brittany Brown'), 
(15, 3, '2016-07-22 19:25:23', 20167221925, 3011298350076480, 1, 9, 352, 'Jessica Jackson'), 
(16, 4, '2016-10-14 10:17:30', 201610141017, 5250543218399397, 9, 16, 975, 'David Wilson'), 
(3, 4, '2018-05-15 03:51:28', 2018515351, 8835896606865589, 11, 4, 675, 'Andrew Garcia'), 
(19, 3, '2017-05-25 07:44:57', 2017525744, 9159566098395188, 6, 23, 112, 'Ashley Brown'), 
(11, 2, '2017-12-02 19:07:39', 2017122197, 9920715756046783, 2, 25, 490, 'Joshua Garcia'), 
(7, 4, '2016-05-01 04:50:28', 201651450, 8393790616940265, 9, 22, 490, 'Matthew White'), 
(15, 3, '2018-01-21 19:54:46', 20181211954, 8078408967493993, 6, 18, 316, 'Jessica Thomas'), 
(6, 1, '2018-04-11 11:23:58', 20184111123, 3921559263693643, 11, 17, 221, 'Andrew Jackson'), 
(13, 3, '2018-03-05 10:26:27', 2018351026, 4739593984654108, 10, 18, 925, 'Samantha White'), 
(8, 4, '2018-11-15 14:53:55', 201811151453, 8752393645304583, 4, 14, 554, 'Daniel Jackson'), 
(10, 1, '2017-09-03 12:57:29', 2017931257, 3434269111389638, 6, 18, 360, 'Megan Johnson'), 
(7, 1, '2018-06-28 12:10:58', 20186281210, 6543388006451934, 5, 19, 491, 'Megan Thomas'), 
(15, 3, '2018-07-13 12:21:29', 20187131221, 4717498129166869, 5, 21, 386, 'Megan Davis'), 
(4, 1, '2016-08-01 16:26:39', 2016811626, 1822404586758111, 3, 2, 346, 'Joseph Davis'), 
(3, 2, '2016-10-27 10:53:05', 201610271053, 8446943405552052, 11, 17, 266, 'Daniel Smith'), 
(18, 3, '2018-10-20 15:28:54', 201810201528, 6433477195769821, 8, 26, 723, 'Lauren Smith');

select * from sales_order; 

select * from customer ; 

INSERT INTO sales_item VALUES 
(24, 70, 2, 0.11, false, 0.0), 
(8, 37, 2, 0.16, false, 0.0), 
(24, 90, 2, 0.06, false, 0.0), 
(34, 83, 2, 0.13, false, 0.0), 
(26, 55, 2, 0.13, false, 0.0), 
(19, 26, 1, 0.19, false, 0.0), 
(23, 2, 1, 0.13, false, 0.0), 
(48, 24, 2, 0.15, false, 0.0), 
(30, 11, 2, 0.06, false, 0.0), 
(1, 60, 2, 0.18, false, 0.0), 
(48, 2, 2, 0.12, false, 0.0), 
(35, 34, 2, 0.07, false, 0.0), 
(29, 13, 1, 0.15, false, 0.0), 
(15, 98, 2, 0.13, false, 0.0), 
(27, 35, 2, 0.07, false, 0.0), 
(30, 5, 1, 0.05, false, 0.0), 
(45, 33, 1, 0.09, false, 0.0), 
(31, 20, 1, 0.18, false, 0.0), 
(32, 88, 1, 0.13, false, 0.0), 
(47, 43, 1, 0.09, false, 0.0), 
(23, 20, 2, 0.16, false, 0.0), 
(44, 86, 2, 0.18, false, 0.0), 
(35, 75, 2, 0.12, false, 0.0), 
(24, 49, 1, 0.08, false, 0.0), 
(31, 37, 1, 0.14, false, 0.0), 
(21, 11, 2, 0.14, false, 0.0), 
(21, 71, 2, 0.06, false, 0.0), 
(48, 1, 1, 0.06, false, 0.0), 
(37, 87, 1, 0.11, false, 0.0), 
(38, 66, 1, 0.13, false, 0.0), 
(14, 7, 2, 0.13, false, 0.0), 
(26, 85, 2, 0.2, false, 0.0), 
(21, 83, 2, 0.16, false, 0.0), 
(8, 15, 2, 0.18, false, 0.0), 
(40, 32, 1, 0.19, false, 0.0), 
(49, 38, 1, 0.15, false, 0.0), 
(41, 13, 2, 0.06, false, 0.0), 
(36, 59, 1, 0.1, false, 0.0), 
(14, 46, 2, 0.14, false, 0.0), 
(30, 77, 2, 0.19, false, 0.0), 
(12, 78, 2, 0.18, false, 0.0), 
(5, 21, 1, 0.18, false, 0.0), 
(10, 13, 1, 0.09, false, 0.0), 
(39, 9, 2, 0.2, false, 0.0), 
(46, 51, 2, 0.13, false, 0.0), 
(47, 98, 1, 0.15, false, 0.0), 
(25, 83, 2, 0.09, false, 0.0), 
(36, 56, 2, 0.12, false, 0.0), 
(18, 8, 2, 0.12, false, 0.0), 
(35, 17, 1, 0.14, false, 0.0), 
(41, 70, 1, 0.14, false, 0.0), 
(9, 21, 1, 0.07, false, 0.0), 
(42, 46, 1, 0.09, false, 0.0), 
(18, 74, 1, 0.1, false, 0.0), 
(25, 14, 1, 0.16, false, 0.0), 
(44, 57, 1, 0.13, false, 0.0), 
(2, 84, 2, 0.06, false, 0.0), 
(18, 68, 2, 0.08, false, 0.0), 
(35, 64, 2, 0.16, false, 0.0), 
(49, 79, 1, 0.07, false, 0.0), 
(7, 3, 2, 0.14, false, 0.0), 
(42, 40, 2, 0.15, false, 0.0), 
(8, 48, 2, 0.18, false, 0.0), 
(27, 82, 2, 0.08, false, 0.0), 
(21, 63, 1, 0.1, false, 0.0), 
(42, 21, 2, 0.08, false, 0.0), 
(31, 23, 2, 0.18, false, 0.0), 
(29, 7, 1, 0.11, false, 0.0), 
(48, 29, 2, 0.14, false, 0.0), 
(15, 49, 2, 0.15, false, 0.0), 
(34, 37, 1, 0.16, false, 0.0), 
(22, 35, 1, 0.19, false, 0.0), 
(22, 29, 2, 0.11, false, 0.0), 
(38, 92, 2, 0.08, false, 0.0), 
(21, 11, 2, 0.17, false, 0.0), 
(13, 72, 1, 0.09, false, 0.0), 
(12, 7, 1, 0.17, false, 0.0), 
(41, 11, 2, 0.13, false, 0.0), 
(22, 26, 2, 0.09, false, 0.0), 
(43, 91, 1, 0.13, false, 0.0), 
(33, 60, 1, 0.1, false, 0.0), 
(39, 82, 2, 0.2, false, 0.0), 
(27, 72, 2, 0.17, false, 0.0), 
(10, 79, 2, 0.12, false, 0.0), 
(41, 78, 2, 0.15, false, 0.0), 
(11, 43, 1, 0.05, false, 0.0), 
(29, 76, 1, 0.08, false, 0.0), 
(25, 60, 1, 0.15, false, 0.0), 
(15, 83, 2, 0.09, false, 0.0), 
(7, 46, 1, 0.07, false, 0.0), 
(26, 24, 2, 0.1, false, 0.0), 
(43, 22, 2, 0.08, false, 0.0), 
(47, 99, 1, 0.06, false, 0.0), 
(29, 26, 1, 0.12, false, 0.0), 
(36, 36, 2, 0.06, false, 0.0), 
(41, 15, 1, 0.08, false, 0.0), 
(12, 47, 2, 0.15, false, 0.0), 
(38, 17, 1, 0.05, false, 0.0), 
(22, 32, 2, 0.13, false, 0.0), 
(12, 99, 2, 0.11, false, 0.0), 
(30, 27, 2, 0.15, false, 0.0), 
(38, 40, 1, 0.15, false, 0.0), 
(22, 36, 1, 0.09, false, 0.0), 
(14, 55, 2, 0.07, false, 0.0), 
(1, 69, 1, 0.07, false, 0.0), 
(47, 88, 1, 0.1, false, 0.0), 
(7, 72, 2, 0.07, false, 0.0), 
(46, 13, 1, 0.18, false, 0.0), 
(9, 10, 1, 0.15, false, 0.0), 
(35, 40, 1, 0.13, false, 0.0), 
(15, 82, 2, 0.07, false, 0.0), 
(47, 34, 1, 0.14, false, 0.0), 
(10, 53, 1, 0.08, false, 0.0), 
(49, 34, 2, 0.06, false, 0.0), 
(13, 43, 1, 0.19, false, 0.0), 
(6, 67, 1, 0.08, false, 0.0), 
(21, 11, 1, 0.12, false, 0.0), 
(26, 94, 1, 0.13, false, 0.0), 
(38, 66, 1, 0.19, false, 0.0), 
(40, 68, 2, 0.16, false, 0.0), 
(25, 84, 1, 0.18, false, 0.0), 
(11, 28, 1, 0.18, false, 0.0), 
(48, 20, 1, 0.12, false, 0.0), 
(26, 3, 1, 0.12, false, 0.0), 
(1, 75, 1, 0.19, false, 0.0), 
(6, 58, 1, 0.12, false, 0.0), 
(33, 43, 2, 0.11, false, 0.0), 
(15, 70, 1, 0.15, false, 0.0), 
(41, 72, 2, 0.14, false, 0.0), 
(8, 77, 2, 0.18, false, 0.0), 
(36, 85, 2, 0.18, false, 0.0), 
(42, 57, 2, 0.18, false, 0.0), 
(27, 71, 1, 0.19, false, 0.0), 
(20, 40, 1, 0.18, false, 0.0), 
(14, 23, 2, 0.16, false, 0.0), 
(15, 73, 1, 0.12, false, 0.0), 
(25, 60, 1, 0.12, false, 0.0), 
(30, 10, 2, 0.11, false, 0.0), 
(18, 90, 2, 0.09, false, 0.0), 
(17, 6, 2, 0.13, false, 0.0), 
(43, 17, 1, 0.08, false, 0.0), 
(20, 33, 2, 0.11, false, 0.0), 
(1, 94, 2, 0.1, false, 0.0), 
(49, 22, 2, 0.09, false, 0.0), 
(1, 55, 2, 0.1, false, 0.0), 
(24, 59, 1, 0.14, false, 0.0), 
(19, 45, 1, 0.17, false, 0.0), 
(13, 80, 2, 0.1, false, 0.0), 
(17, 50, 1, 0.08, false, 0.0), 
(45, 3, 2, 0.13, false, 0.0), 
(6, 92, 2, 0.19, false, 0.0), 
(25, 4, 1, 0.08, false, 0.0), 
(47, 81, 1, 0.16, false, 0.0), 
(39, 39, 2, 0.17, false, 0.0), 
(47, 79, 1, 0.12, false, 0.0), 
(6, 8, 1, 0.17, false, 0.0), 
(15, 60, 2, 0.11, false, 0.0), 
(49, 66, 1, 0.15, false, 0.0), 
(34, 44, 2, 0.09, false, 0.0), 
(20, 10, 1, 0.1, false, 0.0), 
(13, 35, 1, 0.12, false, 0.0), 
(10, 43, 1, 0.13, false, 0.0), 
(24, 51, 2, 0.09, false, 0.0), 
(11, 42, 2, 0.14, false, 0.0), 
(20, 54, 1, 0.17, false, 0.0), 
(42, 35, 1, 0.1, false, 0.0), 
(1, 47, 2, 0.17, false, 0.0), 
(35, 98, 1, 0.11, false, 0.0), 
(14, 25, 1, 0.18, false, 0.0), 
(23, 41, 2, 0.13, false, 0.0), 
(4, 74, 2, 0.15, false, 0.0), 
(32, 47, 2, 0.11, false, 0.0), 
(49, 72, 2, 0.17, false, 0.0), 
(37, 59, 2, 0.11, false, 0.0), 
(43, 98, 1, 0.16, false, 0.0), 
(26, 28, 1, 0.15, false, 0.0), 
(16, 87, 1, 0.16, false, 0.0), 
(6, 49, 2, 0.07, false, 0.0), 
(6, 14, 2, 0.2, false, 0.0), 
(27, 88, 1, 0.19, false, 0.0), 
(37, 38, 1, 0.13, false, 0.0), 
(44, 8, 1, 0.18, false, 0.0), 
(49, 13, 1, 0.11, false, 0.0), 
(30, 61, 2, 0.09, false, 0.0), 
(33, 45, 2, 0.09, false, 0.0), 
(24, 70, 2, 0.05, false, 0.0), 
(42, 49, 2, 0.14, false, 0.0), 
(43, 83, 1, 0.16, false, 0.0), 
(39, 77, 2, 0.12, false, 0.0), 
(1, 65, 1, 0.19, false, 0.0), 
(42, 77, 1, 0.1, false, 0.0), 
(2, 37, 2, 0.11, false, 0.0), 
(24, 59, 2, 0.07, false, 0.0), 
(42, 88, 1, 0.17, false, 0.0), 
(45, 21, 1, 0.18, false, 0.0), 
(10, 75, 2, 0.05, false, 0.0), 
(15, 9, 2, 0.15, false, 0.0), 
(24, 82, 2, 0.09, false, 0.0), 
(30, 87, 1, 0.15, false, 0.0), 
(22, 57, 1, 0.19, false, 0.0);

select * from sales_person; 

----------------------------------------------------------
-------------------------
/*
for multiline comments 
will keep comment texts until u end it with 
*/

select * from sales_item
where discount > 0.15; 

--this is inclusive however best to use with date datatype 
select time_order_taken
from sales_order
where time_order_taken between '2018-12-01' and '2018-12-31'; 

--with timestamp data type best to use this to include the full 2 days considering the time too
select time_order_taken
from sales_order
where time_order_taken >= '2018-12-01' and time_order_taken < '2019-01-01'; 

-- put name together and get phone number and state where its just TX
select state, concat(first_name, ' ', last_name), phone
from customer 
where state = 'TX'; 

--total name of business shoes we have  
select name, type_id 
from product 
where type_id in (select id 
from product_type 
where name = 'Business'); 

--sum of price of business shoes
select product_id, sum(price) as total
from item 
where product_id in (select id 
from product_type 
where name = 'Business')
group by product_id; 

--another way to do it knowing business shoes refer to product id 1
--sum of price of business shoes
select product_id, sum(price) as total
from item 
where product_id = 1
group by product_id; 


--distinct 
select distinct state 
from customer 
where state in ('CA', 'TX')
ORDER BY state desc;

--join 3 tables get orders, quantity, and total sale
select sales_order.id, sales_item.quantity, item.price, (sales_item.quantity*item.price) as total
from sales_order  
join sales_item on sales_item.sales_order_id = sales_order.id
join item on item.id = sales_item.item_id
order by sales_order.id; 

--Let's say we want to send birthday cards to all customers and sales persons for the month of December
--SELECT first_name, last_name, street, city, zip, birth_date

SELECT first_name, last_name, street, city, zip, birth_date, 1 as sort_order
from customer 
where Extract(month from birth_date)=12
union 
SELECT first_name, last_name, street, city, zip, birth_date, 2
from sales_person
where Extract(month from birth_date)=12
order by sort_order; 

--REGEXP is used to search for complex patterns using regular expressions. Match 1st name that starts with Ma using the match operator
--^ means starts with
SELECT first_name, last_name
FROM customer
WHERE first_name ~ '^Ma';

-- or use this: 
SELECT first_name, last_name
FROM customer
WHERE first_name like 'Ma%';

--match last names that end with ez or son
SELECT first_name, last_name
FROM customer
WHERE last_name like '%ez' or last_name like '%son';

--same as above but with regex
--$ at end means ends with 
SELECT first_name, last_name
FROM customer
WHERE last_name ~ 'ez$' or last_name ~ 'son$';

--or this way
SELECT first_name, last_name
FROM customer
WHERE last_name ~ 'ez|son';

--Last names that contain w, x, y, or z
SELECT first_name, last_name
FROM customer
WHERE last_name ~ '[w-z]';

--How many customers have birthdays in certain months
select extract(month from birth_date) as birth_month, count(*) customer_birthdays
from customer
group by birth_month
order by birth_month desc; 

--Let's only get months if more than 1 person has a birthday that month
select extract(month from birth_date) as birth_month, count(*) customer_birthdays
from customer
group by birth_month
having count(*) > 1
order by birth_month asc; 


--WORKING WITH VIEWS
/*NOTE total agg fn and concat and union and distinct, group by, having cannot use in view cuzdoes not 
update in the view table if tables are updated, rest update automatically */ 
create view purchase_order_overview_2 as 
select sales_order.purchase_order_number, customer.company, sales_item.quantity, 
	product.supplier, product.name, item.price, 
	(sales_person.first_name || ' ' || sales_person.last_name) as SalesPerson
From sales_order 
Join sales_item on sales_item.sales_order_id = sales_order.id
Join item on item.id = sales_item.item_id
Join customer on sales_order.cust_id = customer.id
join product on product.id = item.product_id
join sales_person on sales_person.id = sales_order.sales_person_id
order by purchase_order_number; 

select * 
from purchase_order_overview;

--Recalculate Total
--If we removed total above from purchase_order_overview so it could be updated we can just calculate with total like this
SELECT *, (quantity * price) AS Total
FROM purchase_order_overview_2;

--Drop View
DROP VIEW purchase_order_overview;


--creating a function 
Create or replace function fn_add_ints(int, int)
returns int as 
'
Select $1 + $2; 
'
Language SQL

select fn_add_ints(9,1);
select fn_add_ints(4,5);

--does every sales person have state assigned, if not then add pensylvania 
Create or replace function fn_update_employee_state()
returns void as 
$body$
	UPDATE sales_person
	SET state = 'PA'
	where state is null
$body$
Language SQL

select fn_update_employee_state();


Create or replace function fn_max_product_price()
returns numeric as 
$body$
	Select max (price)
	from item
$body$
Language SQL

select fn_max_product_price();


-----
with cte as (
select extract (month from time_order_taken) as month, count(*) as total_orders
from sales_order
group by month
order by month)
select month, 
	case 
	when total_orders < 1 then (total_orders || ': ' || 'Doing Terrible')
	when total_orders >1 and total_orders < 5 then (total_orders || ': ' || 'Doing bad')
	when total_orders > 5 then (total_orders || ': ' || 'Doing Great')
	else (total_orders || ': ' || 'On target')
end as Performance  
from cte 
;

--seperatign total orders and performance this month
with cte as (
select extract (month from time_order_taken) as month, count(*) as total_orders
from sales_order
group by month
order by month)
select *, 
	case 
	when total_orders < 1 then 'Doing Terrible'
	when total_orders >1 and total_orders < 5 then 'Doing bad'
	when total_orders > 5 then 'Doing Great'
	else 'On target'
end as Performance_this_month  
from cte 
;

--transpose it 
WITH cte AS (
    SELECT 
        EXTRACT(MONTH FROM time_order_taken) AS month, 
        COUNT(*) AS total_orders
    FROM sales_order
    GROUP BY month
)
SELECT 
    month, 
    SUM(CASE WHEN total_orders < 1 THEN total_orders ELSE 0 END) AS Doing_Terrible,
    SUM(CASE WHEN total_orders > 1 AND total_orders < 5 THEN total_orders ELSE 0 END) AS Doing_Bad, 
    SUM(CASE WHEN total_orders > 5 THEN total_orders ELSE 0 END) AS Doing_Great, 
    SUM(CASE WHEN total_orders = 5 THEN total_orders ELSE 0 END) AS On_Target 
FROM cte 
GROUP BY month
ORDER BY month;

--filtering, cuz i dont want to show 0s  
WITH cte AS (
    SELECT 
        EXTRACT(MONTH FROM time_order_taken) AS month, 
        COUNT(*) AS total_orders
    FROM sales_order
    GROUP BY month
)
SELECT 
    month, 
    SUM(total_orders) FILTER (WHERE total_orders < 1) AS Doing_Terrible,
    SUM(total_orders) FILTER (WHERE total_orders > 1 AND total_orders < 5) AS Doing_Bad, 
    SUM(total_orders) FILTER (WHERE total_orders > 5) AS Doing_Great, 
    SUM(total_orders) FILTER (WHERE total_orders = 5) AS On_Target 
FROM cte 
GROUP BY month
ORDER BY month;

--time/date

select * from customer; 

--finding age of customer based on sex and name 
select first_name, sex, age(date_entered)
from customer
order by sex; 

--extract customers in 2016 between Jan to March and plus interval of another 3 months and day of week they were entered and exactly how long ago they were entered
SELECT first_name, date_entered, Extract(dow from date_entered) AS dayofweek, AGE(date_entered) 
FROM customer
WHERE date_entered BETWEEN CAST('2016-01-01' AS date) AND CAST('2016-03-31' AS date) + interval '90 days';

----

SELECT 
  first_name || ' ' || last_name AS customer_name, date_entered, 
  EXTRACT(dow FROM date_entered) AS dayofweek,
  AGE(date_entered) AS customer_joinDate, state,
  CASE 
    WHEN DATE_TRUNC('year', AGE(date_entered)) > AGE(date_entered) THEN TRUE 
    ELSE FALSE 
  END AS is_new_customer
FROM customer 
WHERE date_entered BETWEEN CAST('2018-01-01' AS DATE) AND CAST('2018-03-31' AS DATE) + INTERVAL '30 day'
order by date_entered, state;

/*the case when boolean: 
helps in quickly identifying whether a customer is new (joined within the last year). 
This can be useful for special onboarding campaigns, welcome offers, and understanding the proportion of 
new vs. long-term customers.

Customer Join Date (AGE(date_entered) AS customer_joinDate): 
provides the duration since each customer joined. It can help in cohort analysis to understand customer 
retention and loyalty. Additionally, it can be used to target specific campaigns to customers based on how 
long they have been with the company.

day fo week: helping to identify which days of the week are most popular for new customer entries. 
This information can be valuable for marketing campaigns, promotions, and resource allocation.

state: 
help in identifying key markets, regional trends, and areas for potential growth. */


--2 differetn ways of extracting month : 
select extract(month from now()); 
select date_part('month', now()); 

--dow and actual day extraction
select extract(dow from date_entered) as day_integer, to_char(date_entered, 'day') as day, count(*) as customers_entered
from customer
group by extract(dow from date_entered), to_char(date_entered, 'day')
order by day_integer; 

--how many customers entered each month of the year 2018--should add up to 6
with month_series as(
select generate_series('2018-01-01','2018-12-31', '1 month'::interval) as months)
select months, count(date_entered)
from month_series
left join customer
on months = date_trunc('month', date_entered)
group by months
order by months asc; 


--generate series with upper and lower bins in 2018 and count customers entered that year, should add up to 6 also
with generated_series as (
select generate_series('2018-01-01', '2018-10-01', ' 3 months':: interval)::date as lower, 
	generate_series('2018-04-01', '2019-01-01', ' 3 months':: interval)::date as upper)
select lower, upper, count(date_entered)
from generated_series
left join customer
on date_entered >=lower
	and date_entered < upper 
group by lower, upper
order by lower; 

--if i want to general series considering last day of each month
select generate_series('2018-02-01', '2019-01-01', '1 month':: interval) - '1 day'::interval

select * from customer; 

--lag/lead
select date_entered, lag(date_entered) over (order by date_entered), 
	lead (date_entered) over (order by date_entered)
from customer; 

--time gap between 1 customer entry and another (I just took out the 1 customer entered in 2024)
select avg(gap)
from(
select date_entered - lag(date_entered) over (order by date_entered) AS Gap
from customer
limit 19); 


--change in 2018 each month in count of customers entered between 1 month and the next
with generated_series as (
	select generate_series('2018-01-01','2018-12-31', '1 month'::interval)::date as months_gs ),
cte as (
select date_trunc('month', date_entered)::date as month, count(*) as customer_count
from customer
where extract (year from date_entered)= '2018'
group by date_trunc('month', date_entered)) 
select months_gs, coalesce(customer_count,0) as customer_count, 
	lag(coalesce(customer_count,0))over(order by months_gs) as prev_customer_count, 
	coalesce(customer_count,0)- lag(coalesce(customer_count,0))over(order by months_gs) as change
from generated_series
left join cte
on months_gs = month
order by months_gs; 


------------------------------------------------STRINGS:------------------------------------------- 
select concat(first_name,' ', last_name) AS customer_name
from customer; 

--rpad and lpad same as concat 
--for r pad adds space or +1 to the right to seperate both names
--in l pad adds the space at beggining to the left
select  concat(first_name,' ', last_name) AS customer_name, 
	rpad(first_name, LENGTH(first_name)+1) || last_name AS full_name, 
	first_name || lpad(last_name, LENGTH(last_name)+1) AS full_name
from customer; 


--concat string and non string together
select initcap(first_name || ' ' || last_name || ': ' || id) AS customer_name, lower(initcap(first_name || ' ' || last_name || ': ' || id))
from customer; 

--upper, lower, only first letters
select upper(email), lower(email), initcap(email)
from customer; 

select * from product; 

--replacing in the description 
select replace(description, 'Leather upper, manmade sole', 'A leather upper, and manmade sole') as description, initcap(description)
from product; 

--reverse
select supplier, reverse(supplier) 
from product;
 
--length 
select name, length(name) --or char_length(name)  [BOTH SAME RESULTS]
from product; 


--position, tells u wehre @ is located (BOTH CORRECT AND SAME RESULT)
select email, position('@' in email), strpos(email, '@') from customer;  

--extract n characters from the right 
select description, right(description, 10) from product; 

--extracts n characters from the left 
select description, left(description, 10) from product; 

--substring
select description, substring(description, 10, 50) from product; 

--to get the name before email
-- Extract from 1st character up to the position of the @ symbol minus one character to exclude the @ itself.
--for means : up to 
select email, substring (email from 1 for position('@'in email)-1) as person
from customer ;

--to get name after email 

select email, substring (email from position ('@'in email)+1) as company_name 
from customer; 

select street from customer; 

--select only name without number of street 
select street, substring(street from position (' ' in street)+1) as street_name
from customer;

--select only number without name of street (Im saying from first character up to the space)
select street, substring(street from 1 for position(' ' in street)-1) as street_number
from customer;


--rpad and substring 
SELECT 
	rpad(first_name, LENGTH(first_name)+1) 
    || rpad(last_name, LENGTH(last_name)+2, ' <') 
    || rpad(email, LENGTH(email)+1, '>') AS full_email, substring (email from position ('@' in email)+1) as domain
FROM customer; 


/*get name of product and description together and 
Truncate the description to the first 50 characters and make sure there is no leading or trailing whitespace 
after truncating*/
select concat(upper(name), ': ', description) as name_desc , trim(left(description, 50)) as prod_desc
from product; 


--more advanced full text search 
select description from product 
where to_tsvector(description) @@ to_tsquery('sole');

--full text search for 2 key words  
select description from product 
where to_tsvector(description) @@ to_tsquery('sole & leather');

--like and ilike do not consider stemming, ranking, and other advanced features: so does nto consider that running and runner are same as run for example if youre searching for anything for ex that is referrign to run 
select description from product 
where description ilike '%texture%'; 

select trim ('woooow!!', 'ww!');

select trim ('Woooow!!', 'ww!'); --notice that trim is case sensitive, only removed lower case w


---check properties of table either with this code or right click properties on table
SELECT * 
 FROM INFORMATION_SCHEMA.COLUMNS
 WHERE table_name = 'product'; 

select column_name, data_type 
from INFORMATION_SCHEMA.COLUMNS
where table_name = 'product'; 

--filter by certain column 
select column_name, data_type, udt_name
from INFORMATION_SCHEMA.COLUMNS
where table_name = 'product' AND column_name= 'name'

-------User defined functions -------------

create function squared(i integer) returns integer as $$
	BEGIN 
		Return i*i; 
	END; 
$$ Language plpgsql; 

select squared (10);


create type dayofweek as enum (
'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'	
); 

select typname
from pg_type
where typname = 'dayofweek'; 


CREATE TYPE compass_position AS enum (
  	-- Use the four cardinal directions
  	'North', 
  	'South',
  	'East', 
  	'West'
);

SELECT typname
FROM pg_type
WHERE typname='compass_position';


-----Extensions in pg SQL 

Create extension if not exists fuzzystrmatch; 

--show all extensions 
select extname from pg_extension; 

select levenshtein('Gumbo', 'Gumbol'); 

select similarity('Gumbo', 'Gumbol'); 

select * from pg_extension;

--this extension is what enables the similarity function to work 
Create extension if not exists pg_trgm; 


select name, description, similarity(name, description)
from product; 
/*indicates that the name and description columns are not very similar based on the low number returned 
for most of the results.*/

--makese sense here that first row would be 50% cuz its 4 words and 2 of them are leather sole
select name, description, similarity(description, 'leather  & sole')
from product
order by similarity(description, 'leather  & sole') desc ;

select name, description, levenshtein(name, description)
from product; 


select name, description
from product; 

--using left and case statement & concat 
SELECT 
    CASE 
        WHEN length(description) > 50 THEN left(description, 50) || '...'
        ELSE description
    END as description
FROM product
ORDER BY description;

select supplier 
from product ; 

--step 1: Create temp table
create temp table supplier_fix as 
select distinct supplier as original, supplier as standardized
from product; 

select * from supplier_fix

--step 2: UPDATE

update supplier_fix 
set standardized = trim(lower(original))

--step 3: JOIN 

select distinct standardized, count (*)
from product 
left join supplier_fix
on product.supplier = supplier_fix.original
group by standardized; 


/*when to do this: when lets say u have 2 categories banana and apple but u have severla rows, one is Banana,
the other is bananna and so on and so if you count this and group it will group bananna as one thing 
and Bannana as another so do the steps above to standardize the data*/


