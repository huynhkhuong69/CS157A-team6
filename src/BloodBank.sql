DROP DATABASE IF EXISTS BloodBank;
CREATE DATABASE BloodBank;
USE BloodBank;

DROP TABLE IF EXISTS person;
CREATE TABLE person (
	id INT(8) NOT NULL AUTO_INCREMENT UNIQUE PRIMARY KEY,
    first_name CHAR(36) NOT NULL,
    last_name CHAR(36) NOT NULL,
    gender CHAR(1) NOT NULL,
    age INT NOT NULL
);

DROP TABLE IF EXISTS donor;
CREATE TABLE donor (
	id INT(8) NOT NULL PRIMARY KEY REFERENCES person(id),
    blood_type CHAR(3) NOT NULL,
    heightIN INT NOT NULL,
    weightLB INT NOT NULL,
    donationEligibility DATE
);

DROP TABLE IF EXISTS patient;
CREATE TABLE patient (
	id INT(8) NOT NULL PRIMARY KEY REFERENCES person(id),
    blood_type CHAR(3) NOT NULL,
    heightIN INT NOT NULL,
    weightLB INT NOT NULL
);

DROP TABLE IF EXISTS employee;
CREATE TABLE employee (
	id INT(8) NOT NULL PRIMARY KEY REFERENCES person(id),
    first_name CHAR(36) NOT NULL REFERENCES person(first_name),
    last_name CHAR(36) NOT NULL REFERENCES person(last_name),
    age INT NOT NULL REFERENCES person(age)
);

DROP TABLE IF EXISTS donation;
CREATE TABLE donation (
	donation_id INT(8) NOT NULL AUTO_INCREMENT UNIQUE PRIMARY KEY,
    donor_id INT(8) NOT NULL REFERENCES donor(id),
    employee_id INT(8) NOT NULL REFERENCES employee(id),
    amount_donated DECIMAL(5, 2) NOT NULL,
    donation_type CHAR(36) NOT NULL
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
    location_name CHAR(36) NOT NULL,
    city CHAR(36) NOT NULL
);

INSERT INTO person(first_name, last_name, gender, age) VALUES
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

INSERT INTO donor VALUES
	(1, 'O+', 70, 175, NOW()),
    (2, 'AB-', 62, 125, NOW()),
    (3, 'A+', 72, 175, NOW()),
    (5, 'B+', 69, 170, NOW()),
    (8, 'A-', 61, 135, NOW());
SELECT * FROM donor;
SELECT * FROM person NATURAL JOIN donor;

INSERT INTO patient VAlUES
	(4, 'B-', 63, 145),
    (6, 'O-', 65, 160),
    (7, 'B+', 67, 160),
    (9, 'A-', 70, 195),
    (10, 'AB+', 63, 150);
SELECT * FROM patient;
SELECT * FROM person NATURAL JOIN patient;

INSERT INTO employee VALUES
	  (11, 'MADELINE', 'STEWART', 24),
    (12, 'HANA', 'WHEELER', 26),
    (13, 'FRANKLIN', 'FORSTER', 29),
    (14, 'AZRA', 'PEARSON', 31),
    (15, 'LESLEY', 'WARNER', 32),
    (16, 'ABIGAIL', 'HAYES', 27),
    (17, 'CLAIRE', 'MORIN', 36),
    (18, 'KEVIN', 'GARLAND', 37),
    (19, 'JOHN', 'CENA', 25),
    (20, 'ARTHUR', 'ARCHER', 24),
    (21, 'BERNICE', 'NASH', 28),
    (22, 'DANIELLA', 'VASZUEZ', 34);
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
    
