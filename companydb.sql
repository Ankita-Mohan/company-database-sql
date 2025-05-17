CREATE TABLE employee(
    emp_id INT PRIMARY KEY,
    first_name VARCHAR(20),
    last_name VARCHAR(20),
    birth_date DATE,
    sex VARCHAR(1),
    salary INT,
    super_id INT,
    branch_id INT
);

CREATE TABLE branch(
    branch_id INT PRIMARY KEY,
    brnahc_name VARCHAR(20),
    mgr_id INT,
    mgr_start_date DATE,
    FOREIGN KEY(mgr_id) REFERENCES employee(emp_id) ON DELETE SET NULL
);

ALTER TABLE employee
ADD FOREIGN KEY(branch_id) 
REFERENCES Branch(branch_id) 
ON DELETE SET NULL;


ALTER TABLE employee
ADD FOREIGN KEY(super_id) REFERENCES employee(emp_id)
ON DELETE SET NULL;


CREATE TABLE client(
    client_id INT PRIMARY KEY,
    client_name VARCHAR(20),
    branch_id INT,
    FOREIGN KEY(branch_id) REFERENCES branch(branch_id) 
    ON DELETE SET NULL
);

--composite key
CREATE TABLE works_with(
    emp_id INT,
    client_id INT,
    total_sales INT,
    PRIMARY KEY(emp_id,client_id),
    FOREIGN KEY(emp_id) REFERENCES employee(emp_id) 
    ON DELETE CASCADE,
    FOREIGN KEY(client_id) REFERENCES client(client_id) 
    ON DELETE CASCADE
); --as we have set the emp_id and client_id as pk so we can't set iT NULL

CREATE TABLE barnch_supplier(
    branch_id INT,
    supplier_name VARCHAR(20),
    supply_name VARCHAR(20),
    PRIMARY KEY(branch_id, supplier_name),
    FOREIGN KEY(branch_id) REFERENCES branch(branch_id) 
    ON DELETE CASCADE
);

RENAME TABLE barnch_supplier TO branch_supplier;

--ALTER TABLE employee MODIFY COLUMN first_name VARCHAR(30);
ALTER TABLE branch RENAME COLUMN brnahc_name TO branch_name;
--inserting the values
INSERT INTO employee VALUES(100,'David','Wallace','1967-11-17','M',250000, NULL, NULL);
INSERT INTO employee VALUES(101,'Jan','Levinson','1961-05-11','F',110000, 100, NULL);
INSERT INTO employee VALUES(102,'Michael','Scott','1964-03-15','M',75000, 100, NULL);
INSERT INTO employee VALUES(103,'Angela','Martin','1971-06-25','F',63000, 102, NULL);
INSERT INTO employee VALUES(104,'Kelly','Kapoor','1980-02-05','F',55000, 102, NULL);
INSERT INTO employee VALUES(105,'Stanley','Hudson','1958-02-19','M',69000, 102, NULL);
INSERT INTO employee VALUES(106,'Josh','Porter','1969-09-05','M',78000, 100, NULL);
INSERT INTO employee VALUES(107,'Andy','Bernard','1973-07-22','M',65000, 106, NULL);
INSERT INTO employee VALUES(108,'Jim','Halpert','1978-10-01','M',71000, 106, NULL);

SELECT * FROM employee;

INSERT INTO branch VALUES(1,'Corporate',100,'2006-02-09');
INSERT INTO branch VALUES(2,'Scranton',102,'1992-04-06');
INSERT INTO branch VALUES(3,'Stamford',106,'1998-02-13');

--updating the foreign key values
UPDATE employee
SET branch_id=1
WHERE emp_id=100 OR emp_id=101;

UPDATE employee
SET branch_id=2
WHERE emp_id BETWEEN 102 AND 105;

UPDATE employee
SET branch_id=3
WHERE emp_id IN(106,107,108);

SELECT * FROM branch;

INSERT INTO client VALUES(400,'Dunmore Hghschool',2);
INSERT INTO client VALUES(401,'Lackawana Country', 2);
INSERT INTO client VALUES(402,'FedEx',3);
INSERT INTO client VALUES(403,'John Daly Law, LLC',3);
INSERT INTO client VALUES(404,'Scranton Whitepages',2);
INSERT INTO client VALUES(405,'Tomes Newspaper',3);
INSERT INTO client VALUES(406,'FedEx',2);

SELECT *FROM client;

UPDATE client 
SET client_name='Dunmore Highschool'
Where client_id=400;

INSERT INTO works_with VALUES(105,400,55000);
INSERT INTO works_with VALUES(102,401,267000);
INSERT INTO works_with VALUES(108,402,22500);
INSERT INTO works_with VALUES(107,403,5000);
INSERT INTO works_with VALUES(108,403,12000);
INSERT INTO works_with VALUES(105,404,33000);
INSERT INTO works_with VALUES(107,405,26000);
INSERT INTO works_with VALUES(102,406,15000);
INSERT INTO works_with VALUES(105,406,130000);

SELECT * FROM works_with;

INSERT INTO branch_supplier VALUES(2,'Hammer Mill','Paper');
INSERT INTO branch_supplier VALUES(2,'Uni-ball','Writinh Utensils');
INSERT INTO branch_supplier VALUES(3,'Patriot Paper','Paper');
INSERT INTO branch_supplier VALUES(2,'J.T. Forms & Labels','Custom Forms');
INSERT INTO branch_supplier VALUES(3,'Uni-ball','Writing Utensils');
INSERT INTO branch_supplier VALUES(3,'Hammer Mill','Paper');
INSERT INTO branch_supplier VALUES(3,'Stamford Lables','Custom Forms');

SELECT *FROM branch_supplier;

--find all the employees
SELECT * FROM employee;

--find all the clients
SELECT *FROM client;

--find all employees ordered by salary
SELECT *FROM employee
ORDER BY salary;

--find all employees ordered by salary desc
SELECT *FROM employee
ORDER BY salary DESC;

--find all the employees ordered by sex then name
SELECT *FROM employee
ORDER BY sex,first_name,last_name;

--find the first 5 employees in the table
SELECT *FROM employee
LIMIT 5;
--or
SELECT *FROM employee
WHERE emp_id IN(100,101,102,103,104);

--find the first and last name of all the employees
SELECT first_name,last_name FROM employee;

--find the forename and surname of all the employees
SELECT first_name AS forename, last_name AS surname
FROM employee;

--find all the different genders of employees
SELECT DISTINCT sex FROM employee;

--find all the different branch_id of employees
SELECT DISTINCT branch_id FROM employee;

-------------------------------------------------------------------
--FUNCTIONS
--find the number of employees
SELECT COUNT(emp_id) FROM employee;

--how many employees have super_id
SELECT COUNT(super_id) FROM employee; --as one value of 100 emp_id is NULL

--find the number of the female employees born after 1970
SELECT COUNT(emp_id) FROM employee
WHERE sex='F' AND birth_date>'1970-01-01';

--find the average of all the male employees's salaries
SELECT AVG(salary) FROM employee WHERE sex='M';

--find the sum of all the employees
SELECT SUM(salary) FROM employee;

--find the number of males and females 
SELECT COUNT(sex),sex
FROM employee
GROUP BY sex;

--find the total sales of each salesman
SELECT emp_id, SUM(total_sales)
FROM works_with 
GROUP BY emp_id;

--find the total money spend by each client
SELECT client_id, SUM(total_sales)
FROM works_with
GROUP BY client_id;

--find the avg salaries of males and females
SELECT sex, AVG(salary)
FROM employee
GROUP BY sex;
----------------------------------------------------------------------
--WILDCARDS
-- % means any # characters and _ means one character
--used with LIKE keyword
--[bcd]=b,c,d and [a-f] means a,b,c,d,e,f

--find any clients who are an LLC
SELECT *FROM client
WHERE client_name LIKE '%LLC';

--find any branch suppliers who are in the label or lable business
SELECT *FROM branch_supplier
WHERE supplier_name LIKE '%Labels%' OR supplier_name LIKE '%Lables%';

--find the employee with first name starting from D
SELECT * FROM employee
WHERE first_name LIKE 'D%';

--find the employees with a in the first name
SELECT * FROM employee
WHERE first_name LIKE '%a%' OR first_name LIKE '%A%';

--find the employee born in october
SELECT * FROM employee
WHERE birth_date LIKE '____-10-__';

--find the clients who are in schools
SELECT * 
FROM client
WHERE client_name LIKE '%school%';

-----------------------------------------------------------------------
--UNIONS
--combines two or more SELECT statements together by UNION 
--must have same no of columns in both SELECT statements with same datatype

--find the list of employee and branch names
SELECT first_name FROM employee
UNION
SELECT branch_name FROM branch;

--find the list of last_name of employees, branch_name, client_name and supplier_name
SELECT last_name AS company_names FROM employee
UNION
SELECT branch_name FROM branch
UNION
SELECT client_name FROM client
UNION
SELECT supplier_name FROM branch_supplier;

--find the list of all the money spent and earned by the company
SELECT salary FROM employee
UNION
SELECT total_sales FROM works_with;

--find the total money earned and spend by the company
SELECT SUM(salary) AS MONEY FROM employee
UNION
SELECT SUM(total_sales) FROM works_with;

--------------------------------------------------------------------------
--JOINS
--combines 2 or more tables together

--find all the branches and the names of their managers
SELECT employee.emp_id, employee.first_name, branch.branch_name
FROM employee
JOIN branch
ON employee.emp_id=branch.mgr_id;

---------------------------------------------------------------------------
--NESTED QUERY
--needs the result of one select statement into another

--find the names of all the employees who have sold over 30,000 
--to a single client
SELECT first_name, last_name FROM employee
WHERE emp_id IN(
SELECT emp_id FROM works_with
WHERE total_sales>30000
);

--find all the clients who are handled by the branch
--that Michael SCott manages
--Assume you know Michael's ID
SELECT client_name FROM client
WHERE branch_id =(
SELECT branch_id FROM branch
WHERE mgr_id=102
LIMIT 1
);

-----------------------------------------------------------------------------
--ON DELETE
--ON DELETE SET NULL
--ON DELETE CASCADE
--used with Foreign Keys

-------------------------------------------------------------------------------
--TRIGGERS
--alert which are called on backend when some particular action is taken on the database
CREATE TABLE trigger_tes(
    message VARCHAR(100)
);

CREATE TRIGGER trigger_test1
BEFORE INSERT ON employee
FOR EACH ROW 
BEGIN
INSERT INTO trigger_tes VALUES('added new employee');
END;

INSERT INTO employee VALUES(1,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
SELECT * FROM trigger_tes;

DELETE FROM employee 
WHERE emp_id=1;

CREATE TRIGGER trigger_test_gender
BEFORE INSERT ON employee
FOR EACH ROW
BEGIN
    IF NEW.sex ='M' THEN
    INSERT INTO trigger_tes VALUES('Male employee is added');
    ELSEIF NEW.sex='F' then
    INSERT INTO trigger_tes VALUES('Female employee is added');
    ELSE
    INSERT INTO trigger_tes VALUES('added other employee');
    END IF;
END;

INSERT INTO employee VALUES(1,'Kevin','Malone','1978-02-19','M',69000,106,3);
INSERT INTO employee VALUES(2,'Alina','Makrone','1989-02-20','F',69000,106,3);

DELETE FROM employee WHERE emp_id=1;
DELETE FROM employee WHERE emp_id=2;

CREATE TRIGGER trigger_test_gendernew
BEFORE INSERT ON employee
FOR EACH ROW
BEGIN
    IF NEW.sex ='M' THEN
    INSERT INTO trigger_tes VALUES(CONCAT('Male employee is added ',NEW.first_name));
    ELSEIF NEW.sex='F' then
    INSERT INTO trigger_tes VALUES(CONCAT('Female employee is added ',NEW.first_name));
    ELSE
    INSERT INTO trigger_tes VALUES('added other employee');
    END IF;
END;

DELETE FROM employee WHERE emp_id=1;
DELETE FROM employee WHERE emp_id=2;

--deleting triggers
DROP TRIGGER trigger_test1;
DROP TRIGGER trigger_test_gender;
DROP TRIGGER IF EXISTS trigger_test_gendernew;
