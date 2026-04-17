-- Task 5: Transaction-Based Payment Simulation
-- Simulate an online payment process using SQL Transactions

-- Create tables
CREATE TABLE IF NOT EXISTS accounts (
    account_id INT PRIMARY KEY AUTO_INCREMENT,
    account_holder VARCHAR(100) NOT NULL,
    balance DECIMAL(10, 2) NOT NULL DEFAULT 0.00
);

CREATE TABLE IF NOT EXISTS transactions_log (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    sender_id INT,
    receiver_id INT,
    amount DECIMAL(10, 2),
    status VARCHAR(20),
    transaction_time DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Insert sample data
INSERT INTO accounts (account_holder, balance) VALUES ('User Account', 5000.00);
INSERT INTO accounts (account_holder, balance) VALUES ('Merchant Account', 1000.00);

-- Payment Transaction Procedure
DELIMITER $$

CREATE PROCEDURE simulate_payment(
    IN p_sender_id INT,
    IN p_receiver_id INT,
    IN p_amount DECIMAL(10, 2)
)
BEGIN
    DECLARE sender_balance DECIMAL(10, 2);
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        INSERT INTO transactions_log (sender_id, receiver_id, amount, status)
        VALUES (p_sender_id, p_receiver_id, p_amount, 'FAILED');
        SELECT 'Transaction Failed and Rolled Back' AS message;
    END;

    START TRANSACTION;

    -- Check sender balance
    SELECT balance INTO sender_balance
    FROM accounts
    WHERE account_id = p_sender_id
    FOR UPDATE;

    IF sender_balance < p_amount THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Insufficient balance';
    END IF;

    -- Deduct from sender
    UPDATE accounts
    SET balance = balance - p_amount
    WHERE account_id = p_sender_id;

    -- Add to receiver (merchant)
    UPDATE accounts
    SET balance = balance + p_amount
    WHERE account_id = p_receiver_id;

    -- Log successful transaction
    INSERT INTO transactions_log (sender_id, receiver_id, amount, status)
    VALUES (p_sender_id, p_receiver_id, p_amount, 'SUCCESS');

    COMMIT;
    SELECT 'Payment Successful' AS message;
END$$

DELIMITER ;

-- Test: Successful payment
CALL simulate_payment(1, 2, 500.00);

-- Test: Failed payment (insufficient balance)
CALL simulate_payment(1, 2, 99999.00);

-- View updated balances
SELECT * FROM accounts;

-- View transaction log
SELECT * FROM transactions_log;
