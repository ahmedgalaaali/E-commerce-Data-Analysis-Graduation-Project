/*
This SQL file contains the schema of Ecommerce database,
all the code that exists is related to PostgrSQL database
*/;

----------------------------------------------------------------------------------------------

-- Customer Table

CREATE TABLE customer(
                    customer_key VARCHAR(25) PRIMARY KEY,
                    name VARCHAR(50),
                    contact_no VARCHAR,
                    nid VARCHAR);
COPY customer(customer_key,name,contact_no,nid)
FROM 'C:\Mine\My Projects\E-commerce database\CSV\customer.csv'
DELIMITER ','
CSV HEADER;

----------------------------------------------------------------------------------------------

-- Items Table

CREATE TABLE item(
                item_key VARCHAR PRIMARY KEY,
                item_name VARCHAR,
                description VARCHAR,
                unit_price FLOAT,
                man_country VARCHAR,
                supplier VARCHAR,
                unit VARCHAR
);

COPY item(item_key,item_name,description,unit_price,man_country,supplier,unit)
FROM 'C:\Mine\My Projects\E-commerce database\CSV\item.csv'
DELIMITER ','
CSV HEADER;

----------------------------------------------------------------------------------------------

-- Stroe Table
CREATE TABLE store(
                store_key VARCHAR(25) PRIMARY KEY,
                division varchar(25),
                district VARCHAR(25),
                upazila varchar(50)
);
COPY store(store_key,division,district,upazila)
FROM 'C:\Mine\My Projects\E-commerce database\CSV\store.csv'
DELIMITER ','
CSV HEADER;

----------------------------------------------------------------------------------------------

-- Time Table

CREATE TABLE time(
                time_key VARCHAR(25) PRIMARY KEY,
                datetime TIMESTAMP);

COPY time(time_key,datetime)
FROM 'C:\Mine\My Projects\E-commerce database\CSV\time.csv'
DELIMITER ','
CSV HEADER;

----------------------------------------------------------------------------------------------

-- Fact Table
CREATE TABLE fact(
                    payment_key VARCHAR(25),
                    customer_key VARCHAR(25),
                    time_key VARCHAR(25),
                    item_key VARCHAR(25),
                    store_key VARCHAR(25),
                    quantity INT,
                    unit VARCHAR(15),
                    unit_price FLOAT,
                    total_price FLOAT
);

COPY fact(payment_key,customer_key,time_key,item_key,store_key,quantity,unit,unit_price,total_price)
FROM 'C:\Mine\My Projects\E-commerce database\CSV\fact.csv'
DELIMITER ','
CSV HEADER;

----------------------------------------------------------------------------------------------

-- Transactions Table
CREATE TABLE trans(
            payment_key VARCHAR PRIMARY KEY,
            trans_type VARCHAR,
            bank_name VARCHAR
);

COPY trans(payment_key,trans_type,bank_name)
FROM 'C:\Mine\My Projects\E-commerce database\CSV\trans.csv'
DELIMITER ','
CSV HEADER;

----------------------------------------------------------------------------------------------


-- Identifying Foreign Keys

ALTER TABLE fact
ADD CONSTRAINT fk_payment FOREIGN KEY (payment_key) REFERENCES trans(payment_key),
ADD CONSTRAINT fk_customer FOREIGN KEY (customer_key) REFERENCES customer(customer_key),
ADD CONSTRAINT fk_time FOREIGN KEY (time_key) REFERENCES time(time_key),
ADD CONSTRAINT fk_item FOREIGN KEY (item_key) REFERENCES item(item_key),
ADD CONSTRAINT fk_store FOREIGN KEY (store_key) REFERENCES store(store_key);

---------------------------------------------------------------------------------------------

UPDATE trans
SET bank_name = 'Cash Payment'
WHERE bank_name = 'Unknown'

---------------------------------------------------------------------------------------------

ALTER TABLE item
ADD COLUMN category VARCHAR
GENERATED ALWAYS AS (
    CASE
        WHEN description LIKE '%Beverage%' THEN 'Beverage'
        WHEN description LIKE '%Coffee%' THEN 'Coffee Supplies'
        WHEN description LIKE '%Dishware%' THEN 'Dishware'
        WHEN description LIKE '%Food%' THEN 'Food'
        WHEN description LIKE '%Gum%' THEN 'Gum'
        WHEN description LIKE '%Kitchen Supplies%' THEN 'Kitchen Supplies'
        WHEN description LIKE '%Medicine%' THEN 'Medicine'
        ELSE NULL
    END
) STORED;

---------------------------------------------------------------------------------------------

UPDATE item
SET unit = CASE 
    WHEN unit IN('ct','ct.', 'Ct') THEN 'count'
    WHEN unit IN('oz','oz.') THEN 'ounce'
    WHEN unit = 'pk' THEN 'pack'
    WHEN unit = 'botlltes' THEN 'bottles'
    WHEN unit = 'lb' THEN 'pounds'
    ELSE unit
END;
