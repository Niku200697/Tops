create database market_co;

use market_co;

-- 1) Statement to create the Contact table
CREATE TABLE Contact (
    ContactID INT PRIMARY KEY,
    CompanyID INT,
    FirstName VARCHAR(45),
    LastName VARCHAR(45),
    Street VARCHAR(45),
    City VARCHAR(45),
    State VARCHAR(2),
    Zip VARCHAR(10),
    IsMain BOOLEAN,
    Email VARCHAR(45),
    Phone VARCHAR(12)
);

-- 2) Statement to create the Employee table
CREATE TABLE Employee (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(45),
    LastName VARCHAR(45),
    Salary DECIMAL(10,2),
    HireDate DATE,
    JobTitle VARCHAR(25),
    Email VARCHAR(45),
    Phone VARCHAR(12)
);

-- 3) Statement to create the ContactEmployee table
CREATE TABLE ContactEmployee (
    ContactEmployeeID INT PRIMARY KEY,
    ContactID INT,
    EmployeeID INT,
    ContactDate DATE,
    Description VARCHAR(100)
);

-- 4) In the Employee table, the statement that changes Lesley Bland’s phone number to 215-555-8800

update employee
set phone = '215-555-8800'
where firstname = 'Lesley' and lastname = 'Bland';

-- 5) In the Company table, the statement that changes the name of “Urban Outfitters, Inc.” to “Urban Outfitters”.

update company
set companyname = 'Urban Outfitters'
where companyname = 'Urban Outfitters Inc.';

-- 6) In ContactEmployee table, the statement that removes Dianne Connor’s contact
-- event with Jack Lee (one statement).
-- HINT: Use the primary key of the ContactEmployee table to specify the correct record to remove.

-- Not Applicable 

-- 7) Write the SQL SELECT query that displays the names of the employees that
-- have contacted Toll Brothers (one statement). Run the SQL SELECT query in
-- MySQL Workbench. Copy the results below as well.

-- Not Applicable 

-- 8) What is the significance of “%” and “_” operators in the LIKE statement?

-- "%" Matches zero or more characters & "_"  Matches exactly one or specific characters

-- 9) Explain normalization in the context of databases.

-- Normalization aims to reduce data redundancy and dependency by dividing a database into two or more tables and 
-- defining relationships between them. 

-- 10) What does a join in MySQL mean?

-- A JOIN clause is used to combine rows from two or more tables, based on a related column between them.

-- 11) What do you understand about DDL, DCL, and DML in MySQL?

-- DDL:- Data Defination langauge.

--  It's used to defined the structure like database, tables. 

-- 1. Create: It's used create to a new table/database
-- 2. Alter: It changes a table structure (to add a new column)
-- 3. Drop: It used for delete table/database permanently
-- 4. Truncate: It used for all the data inside the table(but keeps the table)

-- DML:- Data Manipulation language.

-- Data Manipulation Language (DML) statements are used to modify the contents of a table instead of its structure.

-- 1. Insert:- It is used to new values/data add in a table(rows)
-- 2. Update:- It is used to existing values/data to change
-- 3. Delete:- It is used to particular row of data delete based on condition true

-- DCL:- Data Control language 

-- Data Control language are used to control the access of data.

-- 1. Grant:- Gives a user permission to do something
-- 2. Revoke:- Take back that permission

-- 12) What is the role of the MySQL JOIN clause in a query, and what are some common types of joins?

-- A JOIN clause is used to combine rows from two or more tables, based on a related column between them.

-- Role of the MySQL JOIN Clause:-
-- A MySQL JOIN is a method to combine data from two or more tables in a database based on a related column between them.
-- JOINs allow us to retrieve related data from multiple tables in a single query, avoiding the need for numerous separate queries.
-- JOINs help maintain referential integrity by ensuring that relationships between tables are respected and data consistency is preserved.
        
-- There are five common types of JOINS Clause:-
-- INNER JOIN: Returns records that have matching values in both tables
-- LEFT JOIN: Returns all records from the left table, and the matched records from the right table
-- RIGHT JOIN: Returns all records from the right table, and the matched records from the left table
-- FULL JOIN: Returns all records when there is a match in either left or right table
-- CROSS JOIN: Returns all records where produce cross product of records of two or more joined tables.