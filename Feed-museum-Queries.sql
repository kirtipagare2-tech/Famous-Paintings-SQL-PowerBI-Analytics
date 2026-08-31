-- Artist table
CREATE TABLE artist(
	artist_id INT PRIMARY KEY,
	full_name VARCHAR(255),
	first_name VARCHAR(80),
	middle_name VARCHAR (80),
	last_name VARCHAR (70),
	nationality VARCHAR (100),
	style VARCHAR(100),
	birth INT ,
	death INT
);

-- canvas size table 
CREATE TABLE canvas_size(
	size_id INT PRIMARY KEY,
	width INT,
	height INT,
	lable VARCHAR(100)
);

--museum table
CREATE TABLE museum(
	museum_id INT PRIMARY KEY,
	name VARCHAR (255),
	address VARCHAR(255),
	city VARCHAR(100),
	state VARCHAR (100),
	postal VARCHAR(50),
	country VARCHAR(100),
	phone VARCHAR (50),
	url VARCHAR (300)
);

--museum hours table
CREATE TABLE museum_hours(
	museum_id INT,
	day VARCHAR(50),
	open TIME,
	close TIME ,
	PRIMARY KEY(museum_id,day)
);


--subject table
CREATE TABLE subject(
	work_id INT ,
	subject VARCHAR(100),
	PRIMARY KEY (work_id, subject)
);

--work table
CREATE TABLE work(
	work_id INT PRIMARY KEY,
	name VARCHAR (255),
	artist_id INT,
	style VARCHAR(100),
	museum_id INT 
);


--image link table 
CREATE TABLE image_link (
	work_id INT PRIMARY KEY,
	url TEXT,
	thumbnail_small_url TEXT,
	thumnail_large_url TEXT
	
);



SELECT COUNT(*) FROM artist;
SELECT COUNT(*) FROM work;
SELECT COUNT(*) FROM museum ;

SELECT * FROM canvas_size;

UPDATE artist
SET full_name = TRIM(full_name),
	first_name = TRIM(first_name),
	last_name = TRIM(last_name);

UPDATE artist
SET middle_names = 'N/A'
WHERE middle_names IS NULL OR middle_names ='';

UPDATE canvas_size
SET height = '0'
WHERE height IS NULL;

SELECT * FROM canvas_size
ORDER BY size_id ASC;

SELECT *FROM museum;

UPDATE museum 
SET state = 'Not Mentioned'
WHERE state IS NULL OR state = '';

UPDATE museum 
SET phone = TRIM(phone);

UPDATE museum 
SET postal = 'Unknown '
WHERE postal IS NULL OR postal='';

UPDATE museum 
SET name= TRIM(name),
	address=TRIM(address);
	
SELECT * FROM museum
ORDER BY museum_id ASC;

SELECT * FROM product_size;

UPDATE product_size
SET sale_price = regular_price
WHERE sale_price > regular_price;

UPDATE product_size 
SET sale_price=0
WHERE sale_price IS NULL;

UPDATE product_size
SET regular_price=0
WHERE regular_price IS NULL;

UPDATE product_size
SET size_id =TRIM(size_id);

SELECT * FROM museum_hours;

ALTER TABLE museum_hours
ALTER COLUMN open TYPE TIME USING TO_TIMESTAMP(open,'HH12:MI:AM')::time;

ALTER TABLE museum_hours
ALTER COLUMN close TYPE TIME USING TO_TIMESTAMP(close,'HH12:MI:AM')::time;

SELECT *FROM museum;

UPDATE museum SET city='Paris' WHERE city='75001';
UPDATE museum SET city='Grenoble' WHERE city='38000';
UPDATE museum SET city='Essen' WHERE city='45128';
UPDATE museum SET city='Tuxtla Gutierrez' WHERE city='29000';
UPDATE museum SET city='St.Petersburg ' WHERE city='2';


SELECT * FROM work;

UPDATE work 
SET style='Unknown'
WHERE style IS NULL ;
OR style ='' OR style='null';

UPDATE work 
SET museum_id=0
WHERE museum_id IS NULL;



