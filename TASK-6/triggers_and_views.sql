-- Task 6: Automated Logging using Triggers & Views

-- Base table
CREATE TABLE IF NOT EXISTS employees (
    emp_id INT PRIMARY KEY AUTO_INCREMENT,
    emp_name VARCHAR(100) NOT NULL,
    department VARCHAR(50),
    salary DECIMAL(10, 2),
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Audit log table
CREATE TABLE IF NOT EXISTS audit_log (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    table_name VARCHAR(50),
    operation VARCHAR(10),
    record_id INT,
    changed_by VARCHAR(100) DEFAULT USER(),
    change_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    old_values TEXT,
    new_values TEXT
);

-- Trigger: Log every INSERT on employees
DELIMITER $$

CREATE TRIGGER trg_after_insert_employee
AFTER INSERT ON employees
FOR EACH ROW
BEGIN
    INSERT INTO audit_log (table_name, operation, record_id, new_values)
    VALUES (
        'employees',
        'INSERT',
        NEW.emp_id,
        CONCAT('Name: ', NEW.emp_name, ', Dept: ', NEW.department, ', Salary: ', NEW.salary)
    );
END$$

-- Trigger: Log every UPDATE on employees
CREATE TRIGGER trg_after_update_employee
AFTER UPDATE ON employees
FOR EACH ROW
BEGIN
    INSERT INTO audit_log (table_name, operation, record_id, old_values, new_values)
    VALUES (
        'employees',
        'UPDATE',
        NEW.emp_id,
        CONCAT('Name: ', OLD.emp_name, ', Dept: ', OLD.department, ', Salary: ', OLD.salary),
        CONCAT('Name: ', NEW.emp_name, ', Dept: ', NEW.department, ', Salary: ', NEW.salary)
    );
END$$

DELIMITER ;

-- View: Daily activity report
CREATE OR REPLACE VIEW daily_activity_report AS
SELECT
    DATE(change_time) AS activity_date,
    operation,
    COUNT(*) AS total_changes,
    GROUP_CONCAT(record_id ORDER BY change_time) AS affected_records
FROM audit_log
GROUP BY DATE(change_time), operation
ORDER BY activity_date DESC, operation;

-- Test data
INSERT INTO employees (emp_name, department, salary) VALUES ('Alice Johnson', 'HR', 55000.00);
INSERT INTO employees (emp_name, department, salary) VALUES ('Bob Smith', 'IT', 75000.00);
INSERT INTO employees (emp_name, department, salary) VALUES ('Carol White', 'Finance', 65000.00);

UPDATE employees SET salary = 80000.00 WHERE emp_name = 'Bob Smith';
UPDATE employees SET department = 'Operations' WHERE emp_name = 'Alice Johnson';

-- View audit log
SELECT * FROM audit_log;

-- View daily activity report
SELECT * FROM daily_activity_report;
