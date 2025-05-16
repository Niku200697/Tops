Create DATABASE try;
USE try;
CREATE TABLE employees (
Employee_id INT AUTO_INCREMENT PRIMARY KEY, name VARCHAR (100),
position VARCHAR (100), salary DECIMAL (10, 2), hire_date DATE
);
CREATE TABLE employee_audit (
audit_id INT AUTO_INCREMENT PRIMARY KEY,
employee_id INT,
name VARCHAR
(100),
position VARCHAR (100), salary DECIMAL (10, 2), hire_date DATE,
action_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
INSERT INTO employees (name, position, salary, hire_date) VALUES ('John Doe',
'Software Engineer', 80000.00, '2022-01-15'),
('Jane Smith', 'Project Manager', 90000.00, '2021-05-22'),
('Alice Johnson', 'UX Designer', 75000.00, '2023-03-01');

-- create a Trigger that will insert a record into the employee_audit table every time a new employee is added to the employee’s table:

DELIMITER $$

CREATE TRIGGER New_employee_insert
AFTER INSERT ON employees
FOR EACH ROW
BEGIN
    INSERT INTO employee_audit (
        employee_id,
        name,
        position,
        salary,
        hire_date
    )
    VALUES (
        NEW.Employee_id,
        NEW.name,
        NEW.position,
        NEW.salary,
        NEW.hire_date
    );
END $$

DELIMITER ;

INSERT INTO employees (name, position, salary, hire_date)
VALUES ('Robert White', 'QA Engineer', 70000.00, '2024-02-10');

Select * from employees;

-- We have an employee’s table, and we want to create a stored procedure to add a new employee and automatically log this action in an
-- employee_audit table.
    
DELIMITER $$

CREATE PROCEDURE add_employee (
    IN emp_name VARCHAR(100),
    IN emp_position VARCHAR(100),
    IN emp_salary DECIMAL(10, 2),
    IN emp_hire_date DATE
)
BEGIN
    INSERT INTO employees (name, position, salary, hire_date)
    VALUES (emp_name, emp_position, emp_salary, emp_hire_date);
    
    INSERT INTO employee_audit (employee_id, name, position, salary, hire_date)
    VALUES (LAST_INSERT_ID(), emp_name, emp_position, emp_salary, emp_hire_date);
END $$

DELIMITER ;

CALL add_employee('Robert White', 'QA Engineer', 70000.00, '2024-02-10');
