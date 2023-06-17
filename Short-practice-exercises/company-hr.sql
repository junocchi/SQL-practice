CREATE DATABASE wileydi004;

USE wileydi004;

CREATE TABLE Countries (
	Country_ID CHAR(2) NOT NULL,
    Country_Name VARCHAR(40),
    Region_ID INT,
    CONSTRAINT PK_Countries PRIMARY KEY (Country_ID)
    );

INSERT INTO Countries
VALUES ("US", "United States", 2),
	("IT", "Italy", 1),
    ("BR", "Brazil", 3);
    
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
VALUES (001, "123 Main Street", "NW12345", "New York", "New York", "US"),
	(002, "456 Elm Avenue", "SW67890", "Los Angeles", "California", "US"),
    (003, "234 Rua das Abobrinhas", "179-8787", "Niteroi", "Rio de Janeiro", "BR");
    
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
VALUES (022, "Finance", 001, 001),
	(047, "HR", 007, 002),
    (075, "IT", 008, 003);
    
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
VALUES ("IT_DEV", "Junior Developer", 24000, 40),
	("MKT_SR_MG", "Senior Manager", 70000, 120),
    ("HR_INT", "Intern", 18, 22000);

-- to allow updates
SET SQL_SAFE_UPDATES=0;

-- to update salary
UPDATE Jobs
SET Max_Salary = 22000
WHERE Max_Salary = 22;


SELECT *
FROM Jobs

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
    
-- to update salary
UPDATE Employee
SET Salary = 20400.00
WHERE Salary = 20.400;

-- fix value of Employee_ID: I added them as string and they are int.
INSERT INTO Employee
VALUES (1234, "Raul", "Smith", "hj@gmail.com", "07909080707", "2018-11-11", "IT_DEV", 24500.00, 250.00, 008, 075),
	(0834, "Lila", "Wilko", "lw@gmail.com", "07406080799", "2020-06-10", "MKT_SR_MG", 65500.00, 500.50, 007, 022),
    (0434, "Alan", "Sugar", "as@gmail.com", "07579080788", "2023-12-04", "HR_INT", 20400.00, 150.90, 001, 075);
    
SELECT Last_Name, Salary
FROM Employee
WHERE Salary > 21000;

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
VALUES (1234, "2018-11-11", "2005-03-03", "IT_DEV", 075),
	(0834, "2020-06-10", "2003-04-04", "MKT_SR_MG", 022),
    (0434, "2023-12-04", "2023-12-09", "HR_INT", 075);
    
SELECT *
FROM Job_History;

SELECT
Employee_ID, 
Last_Name, 
Job_ID, 
Hire_Date "STARTDATE" 
FROM Employee;
