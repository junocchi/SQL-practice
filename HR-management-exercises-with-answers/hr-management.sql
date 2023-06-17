CREATE DATABASE TechCompany;

USE TechCompany;

CREATE TABLE Countries (
	Country_ID CHAR(2) NOT NULL,
    Country_Name VARCHAR(40),
    Region_ID INT,
    CONSTRAINT PK_Countries PRIMARY KEY (Country_ID)
    );

INSERT INTO Countries
VALUES ("US", "United States", 2),
	("IT", "Italy", 1),
    ("BR", "Brazil", 3),
    ("UK", "United Kingdom", 4);
    
SELECT *
FROM Countries

CREATE TABLE Locations (
	Location_ID INT NOT NULL,
    Street_Address VARCHAR(40),
    Postal_Code VARCHAR(12),
    City VARCHAR(30) NOT NULL,
    State_Province VARCHAR(25),
    Country_ID CHAR(2),
    CONSTRAINT PK_Locations PRIMARY KEY (Location_ID),
    CONSTRAINT FK_Locations_Countries FOREIGN KEY (Country_ID)
        REFERENCES Countries (Country_ID)
    );

INSERT INTO Locations
VALUES (10, "123 Main Street", "NW12345", "New York", "New York", "US"),
	(20, "456 Elm Avenue", "SW67890", "Los Angeles", "California", "US"),
    (30, "234 Rua das Abobrinhas", "179-8787", "Niteroi", "Rio de Janeiro", "BR"),
    (40, "223 Oxford Street", "SW1A 0AA", "London", "Greater London", "UK");
    
SELECT *
FROM Locations

CREATE TABLE Departments (
	Department_ID INT NOT NULL,
    Department_Name VARCHAR(30),
    Manager_ID INT,
    Location_ID INT,
    CONSTRAINT PK_Departments PRIMARY KEY (Department_ID),
    CONSTRAINT FK_Departments_Locations FOREIGN KEY (Location_ID)
        REFERENCES Locations (Location_ID)
    );

INSERT INTO Departments
VALUES (1, "Finance", 1, 10),
	(2, "HR", 2, 20),
    (3, "IT", 3, 30),
    (4, "Sales", 3, 40),
    (5, "Marketing", 2, 40);
    
SELECT *
FROM Departments

CREATE TABLE Jobs (
	Job_ID VARCHAR(10) NOT NULL,
    Job_Title VARCHAR(35) NOT NULL,
    Min_Salary INT,
    Max_Salary INT,
    CONSTRAINT PK_Jobs PRIMARY KEY (Job_ID)
    );
    
INSERT INTO Jobs
VALUES
    ('J001-IT', 'Software Engineer', 50000, 100000),
	('J002-MK', 'Marketing Specialist', 40000, 80000),
	('J003-FN', 'Accountant', 45000, 90000),
	('J004-SL', 'Project Manager', 60000, 120000),
	('J005-MK', 'Graphic Designer', 35000, 70000),
	('J006-SL', 'Sales Representative', 30000, 60000),
	('J007-HR', 'Human Resources Manager', 55000, 110000),
	('J008-FN', 'Financial Analyst', 48000, 96000),
	('J009-SL', 'Operations Manager', 60000, 120000),
	('J010-SL', 'Customer Service Representative', 25000, 50000);

SELECT *
FROM Jobs

-- to allow updates
SET SQL_SAFE_UPDATES=0;

-- update salary example
UPDATE Jobs
SET Max_Salary = 24000
WHERE Max_Salary = 22000;


CREATE TABLE Employee (
	Employee_ID INT NOT NULL,
    First_Name VARCHAR(20),
    Last_Name VARCHAR(25) NOT NULL,
    Email VARCHAR(20) NOT NULL,
    Phone_Number VARCHAR(20),
    Hire_Date DATE NOT NULL,
    Job_ID VARCHAR(10) NOT NULL,
    Salary DOUBLE,
    Commission_PCT DOUBLE,
    Manager_ID INT,
    Department_ID INT NOT NULL,
    CONSTRAINT PK_Employee PRIMARY KEY (Employee_ID),
    CONSTRAINT FK_Employee_Departments FOREIGN KEY (Department_ID)
        REFERENCES Departments (Department_ID),
	CONSTRAINT FK_Employee_Jobs FOREIGN KEY (Job_ID)
        REFERENCES Jobs (Job_ID)
    );
    
-- example to update salary
UPDATE Employee
SET Salary = 60400.00
WHERE Salary = 20500.00;

-- fix value of Employee_ID: I added them as string and they are int.
-- Employee_ID, First_Name, Last_Name, Email, Phone_Number, Hire_Date,
-- Job_ID, Salary, Commission_PCT, Manager_ID(1,2,3), Department_ID (22, 44, 66, 88)
INSERT INTO Employee
VALUES 
	(1, 'Meryl', 'Streep', 'meryl.s@ex.com', '123-456-7890', '2020-01-01', 'J001-IT', 51000.00, NULL, NULL, 1),
	(2, 'Cate', 'Blanchett', 'cate.b@ex.com', '987-654-3210', '2019-05-15', 'J002-MK', 63000.00, 0.05, 1, 2),
	(3, 'Julianne', 'Moore', 'julianne.m@ex.com', '555-555-5555', '2022-03-10', 'J003-FN', 75000.00, NULL, 1, 1),
	(4, 'Jennifer', 'Lawrence', 'jennifer.l@ex.com', '111-222-3333', '2021-09-30', 'J004-SL', 65000.00, NULL, 2, 2),
	(5, 'Emma', 'Stone', 'emma.s@ex.com', '444-444-4444', '2023-01-05', 'J004-SL', 80000.00, 0.08, 3, 1),
	(6, 'Natalie', 'Portman', 'natalie.p@ex.com', '777-888-9999', '2022-07-20', 'J002-MK', 60000.00, 0.03, 3, 3),
	(7, 'Frances', 'McDormand', 'frances.m@ex.com', '666-666-6666', '2023-03-01', 'J002-MK', 70000.00, NULL, 2, 2),
	(8, 'Anne', 'Hathaway', 'anne.h@ex.com', '999-999-9999', '2021-11-11', 'J004-SL', 105000.00, 0.02, 3, 3),
	(9, 'Viola', 'Davis', 'viola.d@ex.com', '222-333-4444', '2023-12-04', 'J002-MK', 50400.00, 150.90, 3, 5),
	(10, 'Lila', 'Love', 'lila.l@ex.com', '07406080799', '2020-06-10', 'J004-SL', 65500.00, 500.50, 2, 4);
    
SELECT *
FROM Employee


CREATE TABLE Job_History (
	Employee_ID INT NOT NULL,
    Start_Date DATE NOT NULL,
    End_Date DATE NOT NULL,
    Job_ID VARCHAR(10) NOT NULL,
    Department_ID INT,
    CONSTRAINT FK_JH_Employee FOREIGN KEY (Employee_ID)
		REFERENCES Employee (Employee_ID),
    CONSTRAINT FK_JH_Departments FOREIGN KEY (Department_ID)
        REFERENCES Departments (Department_ID),
	CONSTRAINT FK_JH_Jobs FOREIGN KEY (Job_ID)
        REFERENCES Jobs (Job_ID),
	CONSTRAINT PK_Job_History PRIMARY KEY (Employee_ID, Job_ID, Department_ID)
    );

INSERT INTO Job_History
VALUES (1, '2020-01-01', '2005-03-03', 'J001-IT', 1),
	(4, '2021-09-30', '2022-09-30', 'J002-MK', 5),
    (6, '2022-07-20', '2022-12-09', 'J002-MK', 3),
    (8, '2021-11-11', '2022-08-01', 'J004-SL', 3);
    
SELECT *
FROM Job_History;

 -- task 1   
SELECT
Employee_ID, 
Last_Name, 
Job_ID, 
Hire_Date "STARTDATE" 
FROM Employee;

-- task 2
SELECT
Last_Name "Employee", 
Job_ID "Job", 
Hire_Date "Hire Date" 
FROM Employee;

-- task 3
SELECT
CONCAT ("The employee " , Last_Name , " works as " , Job_ID) "Employee and Title"
FROM Employee;

-- task 4
SELECT
CONCAT (Employee_ID , ", " , First_Name , ", " ,
    Last_Name , ", " , Email , ", " , Phone_Number , ", " ,
    Hire_Date , ", " , Job_ID , ", " ,
    Salary , ", " , Commission_PCT , ", " ,
    Manager_ID , ", " , Department_ID) "THE_OUTPUT"
FROM Employee;

-- task 5
SELECT Last_Name, Salary
FROM Employee
WHERE Salary > 21000;

-- task 6
SELECT Last_Name, Department_ID
FROM Employee
WHERE Employee_ID = 6;

-- task 7
SELECT Last_Name, Job_ID, Hire_Date 'Start_Date'
FROM Employee
WHERE Last_Name = 'Blanchett' AND Last_Name = 'Moore';

-- task 8
SELECT Last_Name, Department_ID
FROM Employee
WHERE Department_ID = 1 OR Department_ID = 3;

-- task 9
SELECT Last_Name, Salary
FROM Employee
WHERE Salary BETWEEN 40000.00 AND 80000.00;

-- task 10
SELECT Last_Name, Hire_Date
FROM Employee
WHERE Hire_Date BETWEEN '2020-01-01' AND '2020-12-31';

-- task 11
SELECT Last_Name, Job_ID
FROM Employee
WHERE Manager_ID IS NULL;

-- task 12
SELECT Last_Name, Salary, Commission_PCT
FROM Employee
WHERE Commission_PCT IS NOT NULL;

-- task 13 (count num emp in IT department)
SELECT COUNT(*)
FROM Employee
WHERE Department_ID = 3;

-- task 14
SELECT min(Salary)
FROM Employee
WHERE Department_ID = 3;

-- task 15
SELECT Department_ID, Job_ID, COUNT(*)
FROM Employee
GROUP BY Department_ID, Job_ID;

-- task 16
SELECT max(Salary) "Maximum",min(Salary) "Minimum",sum(Salary) "Sum", AVG(Salary) "Average"
FROM Employee

-- task 17
SELECT Department_ID "Department", max(Salary) "Maximum",min(Salary) "Minimum",sum(Salary) "Sum", AVG(Salary) "Average"
FROM Employee
GROUP BY Department_ID;

-- task 18
SELECT Job_ID, COUNT(*) "Employees with the same job" 
FROM Employee
GROUP BY Job_ID;

-- task 19
SELECT COUNT(DISTINCT Manager_ID) "Num of Managers"
FROM Employee
WHERE manager_id is not null;

-- task 20
SELECT (max(Salary) - min(Salary)) as Difference
FROM Employee;

-- task 21 (display top 2 paid employees)
SELECT * FROM Employee
ORDER BY Salary DESC
LIMIT 2;

-- Joints exercises
-- task 22 
-- Write a query for the HR department to produce the addresses 
-- of all the departments. Use the LOCATIONS and COUNTRIES tables. 
-- Show the location ID, street address, city, state or province, 
-- and country in the output.

SELECT Department_Name, D.Location_ID, Street_Address, City, State_Province, C.Country_Name 
FROM Departments D
INNER JOIN Locations L
ON D.Location_ID = L.Location_ID
INNER JOIN Countries C
ON L.Country_ID = C.Country_ID;

-- task 23
-- Write a query to display the last name, department number, 
-- and department name for all employees.
SELECT Last_Name, E.Department_ID, D.Department_Name
FROM Employee E
INNER JOIN Departments D
ON E.Department_ID = D.Department_ID
ORDER BY Department_Name;

-- task 24 
-- Display the last name, job, department number, and department name 
-- for all employees who work in London
SELECT Last_Name, Job_ID, D.Department_ID, D.Department_Name
FROM Employee E
INNER JOIN Departments D
on E.Department_ID = D.Department_ID
INNER JOIN Locations L
on D.Location_ID = L.Location_ID
WHERE L.City = "London";


-- task 25
SELECT Employee_ID, Last_Name
FROM Employee
WHERE Department_ID = 1 -- specify which department
	AND Department_ID IN (
    SELECT Department_ID 
    FROM Employee 
    WHERE Last_Name LIKE "%e%"
    );
    
-- option without specifying the department
SELECT Employee_ID, Last_Name
FROM Employee
WHERE Department_ID IN (
    SELECT Department_ID 
    FROM Employee 
    WHERE Last_Name LIKE "%e%"
    );
    
-- task 26
SELECT Last_Name, Department_ID, Job_ID
FROM Employee
WHERE Department_ID IN (
	SELECT Department_ID
    FROM Departments
    WHERE Location_ID = 10
    );

-- task 27 
SELECT Last_Name, Salary
FROM Employee 
WHERE Manager_ID = 2;

-- task 28
SELECT Employee_ID, Last_Name, Salary
FROM employee
WHERE Salary > (
	SELECT AVG(Salary)
    FROM Employee
    )
	ORDER BY Salary ASC;
    
-- task 29
-- view called EMPLOYEE_VU with Employee_ID, Employee name,
-- and Department_ID. Heading for the employee name to be EMPLOYEE.
CREATE VIEW EMPLOYEE_VU
AS
SELECT Employee_ID, First_Name "Employee" , Department_ID
FROM Employee;

-- task 30
SELECT * FROM EMPLOYEE_VU

-- task 31
SELECT Employee, Department_ID
FROM EMPLOYEE_VU;

-- task 32
CREATE VIEW DEPT1 
AS
SELECT Employee_ID "EmpNo", First_Name "Employee", Department_ID "DeptNo"
FROM EMPLOYEE_VU