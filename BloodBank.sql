DROP DATABASE IF EXISTS BloodBank;
CREATE DATABASE BloodBank;
USE BloodBank;

DROP TABLE IF EXISTS person;
CREATE TABLE person (
	id INT(8) NOT NULL AUTO_INCREMENT UNIQUE PRIMARY KEY,
    first_name VARCHAR(36) NOT NULL,
    last_name VARCHAR(36) NOT NULL,
    gender CHAR(1) NOT NULL,
    age INT NOT NULL
);

DROP TABLE IF EXISTS admin;
CREATE TABLE admin(
	id INT(8) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(36) NOT NULL,
    last_name VARCHAR(36) NOT NULL,
    age INT NOT NULL,
    gender CHAR(1) NOT NULL,
    password VARCHAR(36) NOT NULL
);
INSERT INTO admin(first_name,last_name,age,gender,password)
VALUES('Admin','Test',42,'M','password');

DROP TABLE IF EXISTS inventory;
CREATE TABLE inventory (
	bag_id INT(8) NOT NULL AUTO_INCREMENT PRIMARY KEY,
	donor_id INT(8) NOT NULL REFERENCES donor2(id),
    employee_id INT(8) NOT NULL REFERENCES employee(id),
    blood_type VARCHAR(3) NOT NULL,
    quantity INT(8) NOT NULL,
    expiration DATE NOT NULL
);
INSERT INTO inventory(donor_id,employee_id,blood_type,quantity,expiration) VALUES(11,23,'AB+',500,'2022-08-01');

DROP TABLE IF EXISTS donor;
CREATE TABLE donor (
	id INT(8) NOT NULL PRIMARY KEY REFERENCES person(id),
    blood_type VARCHAR(3) NOT NULL,
    heightIN INT NOT NULL,
    weightLB INT NOT NULL,
    donationEligibility DATE,
    username VARCHAR(36) NOT NULL UNIQUE,
    password VARCHAR(36) NOT NULL
);

CREATE TABLE donor2 (
	id INT(8) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(36) NOT NULL,
    last_name VARCHAR(36) NOT NULL,
    gender CHAR(1) NOT NULL,
    age INT NOT NULL,
    blood_type VARCHAR(3) NOT NULL,
    heightIN INT NOT NULL,
    weightLB INT NOT NULL,
    username VARCHAR(36) NOT NULL UNIQUE,
    password VARCHAR(36) NOT NULL
);
INSERT INTO donor2(first_name,last_name,gender,age,blood_type,heightIN,WeightLB,username,password)
VALUES('First','Test','M',23,'AB+',70,210,'test','test');

DROP TABLE IF EXISTS patient;
CREATE TABLE patient (
	id INT(8) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(36) NOT NULL,
    last_name VARCHAR(36) NOT NULL,
    blood_type VARCHAR(3) NOT NULL,
    username VARCHAR(36) NOT NULL UNIQUE,
    password VARCHAR(36) NOT NULL
);

INSERT INTO patient(first_name,last_name,blood_type,username,password)
VALUES('Patient','Zero','O-','pz','pz');

DROP TABLE IF EXISTS employee;
CREATE TABLE employee (
	id INT(8) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(36) NOT NULL REFERENCES person(first_name),
    last_name VARCHAR(36) NOT NULL REFERENCES person(last_name),
    age INT NOT NULL REFERENCES person(age),
    gender CHAR(1) NOT NULL,
    password VARCHAR(36) NOT NULL
);

DROP TABLE IF EXISTS donation;
CREATE TABLE donation (
	donation_id INT(8) NOT NULL AUTO_INCREMENT UNIQUE PRIMARY KEY,
    donor_id INT(8) NOT NULL REFERENCES donor(id),
    employee_id INT(8) NOT NULL REFERENCES employee(id),
    amount_donated DECIMAL(5, 2) NOT NULL,
    donation_type VARCHAR(36) NOT NULL
);


DROP TABLE IF EXISTS transfusion;
CREATE TABLE transfusion (
	transfusion_id INT(8) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    patient_id INT(8) NOT NULL REFERENCES patient(id),
    employee_id INT(8) NOT NULL REFERENCES employee(id),
    amount_received DECIMAL(5, 2) NOT NULL
);

DROP TABLE IF EXISTS location;
CREATE TABLE location (
	location_id INT(8) NOT NULL AUTO_INCREMENT UNIQUE PRIMARY KEY,
    location_name VARCHAR(36) NOT NULL,
    city VARCHAR(36) NOT NULL
);

DROP TABLE IF EXISTS appointment;
CREATE TABLE appointment (
	appointment_id INT(8) NOT NULL AUTO_INCREMENT UNIQUE PRIMARY KEY,
    first_name VARCHAR(36) NOT NULL,
    last_name VARCHAR(36) NOT NULL,
    appointment_date DATE NOT NULL,
    time TIME NOT NULL
);


DROP TABLE IF EXISTS request;
CREATE TABLE request (
	request_id INT(8) NOT NULL AUTO_INCREMENT UNIQUE PRIMARY KEY REFERENCES person(id),
    request_location CHAR(36) NOT NULL REFERENCES location(location_id),
    date_request DATE NOT NULL,
    blood_type_requested CHAR(36) NOT NULL,
    quantity_requested DECIMAL(5,2) NOT NULL
    
);

DROP TABLE IF EXISTs receives;
CREATE TABLE receives (
	receives_id INT(8) NOT NULL AUTO_INCREMENT UNIQUE PRIMARY KEY REFERENCES person(id),
    transfusion_id INT(8) NOT NULL REFERENCES transfusion(transfusion_id),
    patient_id INT (8) NOT NULL REFERENCES patient(id),
    nurse_id INT(8) NOT NULL REFERENCES person(id),
    amount_received DECIMAL(5, 2) NOT NULL
);

DROP TABLE IF EXISTS donates;
CREATE TABLE donates (
	donates_id INT(8) NOT NULL AUTO_INCREMENT UNIQUE PRIMARY KEY REFERENCES person(id),
	donation_id INT(8) NOT NULL REFERENCES person(id),
    donor_id INT(8) NOT NULL REFERENCES person(id),
    nurse_id INT(8) NOT NULL REFERENCES person(id),
    amount_donated DECIMAL(5, 2) NOT NULL
);

DROP TABLE IF EXISTS bloodBag;
CREATE TABLE bloodbag (
	bloodbag_id INT(8) NOT NULL AUTO_INCREMENT UNIQUE PRIMARY KEY,
	quantity INT(8) NOT NULL,
    blood_type CHAR(36)
);

DROP TABLE IF EXISTS blood_inventory;
CREATE TABLE blood_inventory (
	bag_id INT(8) NOT NULL AUTO_INCREMENT UNIQUE PRIMARY KEY,
    location_id INT(8) NOT NULL REFERENCES location(location_id)
);

DROP TABLE IF EXISTS has_bloodbag;
CREATE TABLE has_bloodbag (
	bag_id INT(8) NOT NULL REFERENCES bloodbag(bloodbag_id),
    bloodbag_id INT(8) NOT NULL REFERENCES bloodbag(bloodbag_id) 
);

DROP TABLE IF EXISTS located_at;
CREATE TABLE located_at (
	location_id INT(8) NOT NULL REFERENCES location(location_id),
    bag_id INT(8) NOT NULL REFERENCES blood_inventory(bag_id)
);

DROP TABLE IF EXISTS manages;
CREATE TABLE manages (
	 bag_id INT(8) NOT NULL REFERENCES blood_inventory(bag_id),
     manages_id INT(8) NOT NULL REFERENCES person(id)
);

INSERT INTO manages(bag_id, manages_id) VALUES
	(1, 9),
    (2, 8),
    (3, 7),
    (4, 6),
    (5, 5),
    (6, 4),
    (7, 3),
    (8, 2);

INSERT INTO located_at( location_id, bag_id) VALUES
	(1, 1),
    (2, 2),
    (3, 3),
    (4, 4),
    (5, 5),
    (6, 6),
    (7, 7),
    (8, 8);
SELECT * FROM located_at;

 
INSERT INTO has_bloodbag( bag_id, bloodbag_id) VALUES
	(1, 1),
    (2, 2),
    (3, 3),
    (4, 4),
    (5, 5),
    (6, 6),
    (7, 7),
    (8, 8);
SELECT * FROM has_bloodbag;


INSERT INTO blood_inventory(bag_id, location_id) VALUES
	(1, 1),
    (2, 2),
    (3, 3),
    (4, 4),
    (5, 5),
    (6, 6),
    (7, 7),
    (8, 8),
    (9, 9),
    (10, 10);
SELECT * FROM blood_inventory;


INSERT INTO bloodbag(quantity, blood_type) VALUES
	('415.47', 'O'),
    ('617.46', 'A+'),
    ('454.24', 'B+'),
    ('245.32', 'A'),
    ('322.11', 'O+');
SELECT * FROM bloodbag;


INSERT INTO donates(donation_id, donor_id, nurse_id, amount_donated) VALUES
	(1, 1, 1, '471.35'),
    (2, 2, 2, '324.67'),
    (3, 3, 3, '599.61'),
    (4, 4, 4, '222.54'),
    (5, 5, 5, '612.53'),
    (6, 6, 6, '432.78');
SELECT * FROM donates;


INSERT INTO receives(receives_id, transfusion_id, patient_id, nurse_id, amount_received) VALUES
	(1, 1, 1, 1, '355.78'),
    (2, 2, 2, 2, '634.65'),
    (3, 3, 3, 3, '246.24'),
    (4, 4, 4, 4, '635.15'),
    (5, 5, 5 ,5, '745.15');
SELECT * FROM receives;

INSERT INTO request(request_id, request_location, date_request, blood_type_requested, quantity_requested) VALUES
	(1, 'San Jose', '2022-07-10', 'O+', '533.86'),
    (2, 'Palo Alto', '2022-01-18', 'B+', '613.27'),
    (3, 'Fremont', '2022-03-11', 'A+', '345.34'),
    (4, 'Neward', '2022-04-09', 'AB+', '419.39'),
    (5, 'Sacramento', '2022-07-21', 'B', '711.21'),
    (6, 'Reno', '2022-07-22', 'A', '234.61'),
    (7, 'Gilroy', '2022-07-23', 'O', '545.32');
SELECT * FROM request;



/*INSERT INTO person(first_name, last_name, gender, age) VALUES
	('JOHN', 'DOE', 'M', 22),
    ('JANE', 'DUNCAN', 'F', 21),
    ('JEREMIAH', 'REDMOND', 'M', 36),
    ('KAYLA', 'WEAVER', 'F', 41),
    ('JORDAN', 'STEELE', 'M', 29),
    ('HAROLD', 'SMITH', 'M', 45),
    ('KEVIN', 'YANG', 'M', 35),
    ('CONSTANCE', 'ESPINOZA', 'F', 32),
    ('MIKE', 'TYSON', 'M', 20),
    ('MIMI', 'CARTER', 'F', 27),
    ('MADELINE', 'STEWART', 'F', 24),
    ('HANA', 'WHEELER', 'F', 26),
    ('FRANKLIN', 'FORSTER', 'M', 29),
    ('AZRA', 'PEARSON', 'M', 31),
    ('LESLEY', 'WARNER', 'F', 32),
    ('ABIGAIL', 'HAYES', 'F', 27),
    ('CLAIRE', 'MORIN', 'F', 36),
    ('KEVIN', 'GARLAND', 'M', 37),
    ('JOHN', 'CENA', 'M', 25),
    ('ARTHUR', 'ARCHER', 'M', 24),
    ('BERNICE', 'NASH', 'F', 28),
    ('DANIELLA', 'VASZUEZ', 'F', 34);
SELECT * FROM person;
*/
INSERT INTO donor VALUES
	(1, 'O+', 70, 175, NOW(),'deerjohn','test'),
    (2, 'AB-', 62, 125, NOW(),'jduncan','password'),
    (3, 'A+', 72, 175, NOW(),'test','pie'),
    (5, 'B+', 69, 170, NOW(),'steele','superman'),
    (8, 'A-', 61, 135, NOW(),'conste','root');
SELECT * FROM donor;
SELECT * FROM person NATURAL JOIN donor;

/*INSERT INTO patient VAlUES
	(4, 'B-', 63, 145),
    (6, 'O-', 65, 160),
    (7, 'B+', 67, 160),
    (9, 'A-', 70, 195),
    (10, 'AB+', 63, 150);
SELECT * FROM patient;
SELECT * FROM person NATURAL JOIN patient;
*/
INSERT INTO employee VALUES
	(11, 'MADELINE', 'STEWART', 24, 'F','Stew'),
    (12, 'HANA', 'WHEELER', 26,'F','password'),
    (13, 'FRANKLIN', 'FORSTER', 29,'M','tree'),
    (14, 'AZRA', 'PEARSON', 31,'M','book'),
    (15, 'LESLEY', 'WARNER', 32,'F','les'),
    (16, 'ABIGAIL', 'HAYES', 27,'F','pie314'),
    (17, 'CLAIRE', 'MORIN', 36,'F','password1234'),
    (18, 'KEVIN', 'GARLAND', 37,'M','kgar'),
    (19, 'JOHN', 'CENA', 25,'M','trumpet'),
    (20, 'ARTHUR', 'ARCHER', 24,'M','bea'),
    (21, 'BERNICE', 'NASH', 28,'F','nice'),
    (22, 'DANIELLA', 'VASZUEZ', 34,'F','test');
SELECT * FROM employee;
SELECT * FROM person NATURAL JOIN employee;

INSERT INTO donation(donor_id, employee_id, amount_donated, donation_type) VALUES
	(1, 13, 471.35, "Red Cells"),
    (2, 11, 527.21, "Plasma"),
    (3, 15, 405.48, "Platelets"),
    (5, 21, 622.91, "Whole Blood"),
	(6, 17, 580.64, "Red Cells");
SELECT donation_id, donor_id, employee_id, amount_donated AS "amount_donated(cc)", donation_type FROM donation;

-- This query selects the donor who was helped by the employee
SELECT d.donation_id, d.donor_id, p.first_name, p.last_name, d.employee_id, e.first_name, e.last_name, d.amount_donated AS "amount_donated(cc)", d.donation_type
FROM donation d, person p, employee e WHERE d.donor_id = p.id AND d.employee_id = e.id;

INSERT INTO transfusion(patient_id, employee_id, amount_received) VALUES
	(4, 22, 600.25),
    (6, 16, 567.39),
    (7, 12, 429.78),
    (9, 19, 356.27),
    (10, 14, 732.18);
SELECT transfusion_id, patient_id, employee_id, amount_received AS "amount_received(cc)" FROM transfusion;

-- This query selects the donor who was helped by the employee
SELECT t.transfusion_id, t.patient_id, p.first_name, p.last_name, t.employee_id, e.first_name, e.last_name, t.amount_received AS "amount_received(cc)"
FROM transfusion t, person p, employee e WHERE t.patient_id = p.id AND t.employee_id = e.id;

INSERT INTO location(location_name, city) VALUES
	('Stanford Blood Center', 'Campbell'),
    ('San Jose Blood Donation Center', 'San Jose'),
    ('Newark Blood Donation Center', 'Newark'),
    ('Stanford Blood Center', 'Mountain View'),
    ('Stanford Blood Center', 'Menlo Park'),
    ('San Francisco Downtown Center', 'San Francisco');
SELECT * FROM location;

INSERT INTO appointment(first_name, last_name, appointment_date, time) VALUES
	('Anderson', 'Pamela', '2000-10-21', '9:00'),
    ('Arcand', 'Denys', '1995-06-04', '10:30'),
    ('Carey', 'Jim', '1997-07-15', '11:00'),
    ('Pearson', 'Lester', '1999-09-30', '3:00'),
    ('Orr', 'Robert', '1990-10-12', '2:00'),
    ('Ronaldo', 'Cristiano', '1990-10-12', '4:30'),
    ('Neymar', 'Jr', '1992-02-05', '5:00');
SELECT * FROM appointment;