MySQL Shell 8.0.46

Copyright (c) 2016, 2026, Oracle and/or its affiliates.
Oracle is a registered trademark of Oracle Corporation and/or its affiliates.
Other names may be trademarks of their respective owners.

Type '\help' or '\?' for help; '\quit' to exit.
 MySQL  JS > \connect root@localhost:3306
Creating a session to 'root@localhost:3306'
Fetching schema names for auto-completion... Press ^C to stop.
Your MySQL connection id is 18
Server version: 8.0.46 MySQL Community Server - GPL
No default schema selected; type \use <schema> to set one.
 MySQL  localhost:3306 ssl  JS > \sql
Switching to SQL mode... Commands end with ;
Fetching global names for auto-completion... Press ^C to stop.
 MySQL  localhost:3306 ssl  SQL > CREATE DATABASE bank_management_2;
Query OK, 1 row affected (0.0343 sec)
 MySQL  localhost:3306 ssl  SQL > USE bank_management;
MySQL Error 1049: Unknown database 'bank_management'
 MySQL  localhost:3306 ssl  SQL > USE bank_management;
MySQL Error 1049: Unknown database 'bank_management'
 MySQL  localhost:3306 ssl  SQL > USE bank_management_2;
Default schema set to `bank_management_2`.
Fetching global names, object names from `bank_management_2` for auto-completion... Press ^C to stop.
 MySQL  localhost:3306 ssl  bank_management_2  SQL >
 MySQL  localhost:3306 ssl  bank_management_2  SQL > CREATE TABLE branches (
                                                  ->     branch_id INT PRIMARY KEY AUTO_INCREMENT,
                                                  ->     branch_name VARCHAR(100) NOT NULL,
                                                  ->     city VARCHAR(100) NOT NULL,
                                                  ->     ifsc_code VARCHAR(20) UNIQUE NOT NULL
                                                  -> );
Query OK, 0 rows affected (0.0624 sec)
 MySQL  localhost:3306 ssl  bank_management_2  SQL > discribe  branches ;
ERROR: 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'discribe  branches' at line 1
 MySQL  localhost:3306 ssl  bank_management_2  SQL >
 MySQL  localhost:3306 ssl  bank_management_2  SQL > CREATE TABLE customers (
                                                  ->     customer_id INT PRIMARY KEY AUTO_INCREMENT,
                                                  ->     customer_name VARCHAR(100) NOT NULL,
                                                  ->     email VARCHAR(100) UNIQUE,
                                                  ->     phone VARCHAR(15) UNIQUE,
                                                  ->     address VARCHAR(255),
                                                  ->     branch_id INT,
                                                  ->
                                                  ->     FOREIGN KEY (branch_id)
                                                  ->     REFERENCES branches(branch_id)
                                                  -> );
Query OK, 0 rows affected (0.0439 sec)
 MySQL  localhost:3306 ssl  bank_management_2  SQL >
 MySQL  localhost:3306 ssl  bank_management_2  SQL > CREATE TABLE accounts (
                                                  ->     account_id BIGINT PRIMARY KEY,
                                                  ->     customer_id INT NOT NULL,
                                                  ->     account_type ENUM('Savings','Current') NOT NULL,
                                                  ->     balance DECIMAL(15,2) NOT NULL DEFAULT 0.00,
                                                  ->     opening_date DATE NOT NULL,
                                                  ->     status ENUM('Active','Inactive','Blocked')
                                                  ->     DEFAULT 'Active',
                                                  ->
                                                  ->     CONSTRAINT chk_balance CHECK (balance >= 0),
                                                  ->
                                                  ->     FOREIGN KEY (customer_id)
                                                  ->     REFERENCES customers(customer_id)
                                                  -> );
Query OK, 0 rows affected (0.0389 sec)
 MySQL  localhost:3306 ssl  bank_management_2  SQL >
 MySQL  localhost:3306 ssl  bank_management_2  SQL > CREATE TABLE transactions (
                                                  ->     transaction_id BIGINT PRIMARY KEY AUTO_INCREMENT,
                                                  ->     account_id BIGINT NOT NULL,
                                                  ->     transaction_type ENUM('Deposit','Withdrawal','Transfer')
                                                  ->     NOT NULL,
                                                  ->     amount DECIMAL(15,2) NOT NULL,
                                                  ->     transaction_date DATETIME DEFAULT CURRENT_TIMESTAMP,
                                                  ->     description VARCHAR(255),
                                                  ->
                                                  ->     CHECK (amount > 0),
                                                  ->
                                                  ->     FOREIGN KEY (account_id)
                                                  ->     REFERENCES accounts(account_id)
                                                  -> );
Query OK, 0 rows affected (0.0355 sec)
 MySQL  localhost:3306 ssl  bank_management_2  SQL >
 MySQL  localhost:3306 ssl  bank_management_2  SQL > INSERT INTO branches
                                                  -> (branch_name, city, ifsc_code)
                                                  -> VALUES
                                                  -> ('Kolkata Main Branch', 'Kolkata', 'BANK0001001'),
                                                  -> ('Howrah Branch', 'Howrah', 'BANK0001002'),
                                                  -> ('Durgapur Branch', 'Durgapur', 'BANK0001003');
Query OK, 3 rows affected (0.0214 sec)

Records: 3  Duplicates: 0  Warnings: 0
 MySQL  localhost:3306 ssl  bank_management_2  SQL > select * from branches ;
+-----------+---------------------+----------+-------------+
| branch_id | branch_name         | city     | ifsc_code   |
+-----------+---------------------+----------+-------------+
|         1 | Kolkata Main Branch | Kolkata  | BANK0001001 |
|         2 | Howrah Branch       | Howrah   | BANK0001002 |
|         3 | Durgapur Branch     | Durgapur | BANK0001003 |
+-----------+---------------------+----------+-------------+
3 rows in set (0.0019 sec)
 MySQL  localhost:3306 ssl  bank_management_2  SQL >
 MySQL  localhost:3306 ssl  bank_management_2  SQL > INSERT INTO customers
                                                  -> (customer_name, email, phone, address, branch_id)
                                                  -> VALUES
                                                  -> ('Rahul Das', 'rahul@gmail.com', '9876543210', 'Kolkata', 1),
                                                  -> ('Priya Sharma', 'priya@gmail.com', '9876543211', 'Howrah', 2),
                                                  -> ('Amit Roy', 'amit@gmail.com', '9876543212', 'Durgapur', 3),
                                                  -> ('Sneha Paul', 'sneha@gmail.com', '9876543213', 'Kolkata', 1),
                                                  -> ('Arjun Sen', 'arjun@gmail.com', '9876543214', 'Howrah', 2);
Query OK, 5 rows affected (0.0130 sec)

Records: 5  Duplicates: 0  Warnings: 0
 MySQL  localhost:3306 ssl  bank_management_2  SQL > select * from  customers ;
+-------------+---------------+-----------------+------------+----------+-----------+
| customer_id | customer_name | email           | phone      | address  | branch_id |
+-------------+---------------+-----------------+------------+----------+-----------+
|           1 | Rahul Das     | rahul@gmail.com | 9876543210 | Kolkata  |         1 |
|           2 | Priya Sharma  | priya@gmail.com | 9876543211 | Howrah   |         2 |
|           3 | Amit Roy      | amit@gmail.com  | 9876543212 | Durgapur |         3 |
|           4 | Sneha Paul    | sneha@gmail.com | 9876543213 | Kolkata  |         1 |
|           5 | Arjun Sen     | arjun@gmail.com | 9876543214 | Howrah   |         2 |
+-------------+---------------+-----------------+------------+----------+-----------+
5 rows in set (0.0016 sec)
 MySQL  localhost:3306 ssl  bank_management_2  SQL >
 MySQL  localhost:3306 ssl  bank_management_2  SQL > INSERT INTO accounts
                                                  -> (account_id, customer_id, account_type, balance, opening_date)
                                                  -> VALUES
                                                  -> (100001, 1, 'Savings', 25000, '2026-01-01'),
                                                  -> (100002, 2, 'Savings', 40000, '2026-01-05'),
                                                  -> (100003, 3, 'Current', 60000, '2026-01-10'),
                                                  -> (100004, 4, 'Savings', 15000, '2026-01-15'),
                                                  -> (100005, 5, 'Savings', 80000, '2026-01-20');
Query OK, 5 rows affected (0.0084 sec)

Records: 5  Duplicates: 0  Warnings: 0
 MySQL  localhost:3306 ssl  bank_management_2  SQL > select * from  accounts;
+------------+-------------+--------------+----------+--------------+--------+
| account_id | customer_id | account_type | balance  | opening_date | status |
+------------+-------------+--------------+----------+--------------+--------+
|     100001 |           1 | Savings      | 25000.00 | 2026-01-01   | Active |
|     100002 |           2 | Savings      | 40000.00 | 2026-01-05   | Active |
|     100003 |           3 | Current      | 60000.00 | 2026-01-10   | Active |
|     100004 |           4 | Savings      | 15000.00 | 2026-01-15   | Active |
|     100005 |           5 | Savings      | 80000.00 | 2026-01-20   | Active |
+------------+-------------+--------------+----------+--------------+--------+
5 rows in set (0.0019 sec)
 MySQL  localhost:3306 ssl  bank_management_2  SQL >
 MySQL  localhost:3306 ssl  bank_management_2  SQL > ALTER TABLE transactions
                                                  -> MODIFY transaction_type
                                                  -> ENUM(
                                                  ->     'Deposit',
                                                  ->     'Withdrawal',
                                                  ->     'Transfer_Out',
                                                  ->     'Transfer_In'
                                                  -> ) NOT NULL;
Query OK, 0 rows affected (0.0794 sec)

Records: 0  Duplicates: 0  Warnings: 0
 MySQL  localhost:3306 ssl  bank_management_2  SQL >
 MySQL  localhost:3306 ssl  bank_management_2  SQL > ALTER TABLE transactions
                                                  -> ADD COLUMN transfer_ref VARCHAR(36) NULL;
Query OK, 0 rows affected (0.1947 sec)

Records: 0  Duplicates: 0  Warnings: 0
 MySQL  localhost:3306 ssl  bank_management_2  SQL >
 MySQL  localhost:3306 ssl  bank_management_2  SQL > DELIMITER //
 MySQL  localhost:3306 ssl  bank_management_2  SQL >
 MySQL  localhost:3306 ssl  bank_management_2  SQL > CREATE TRIGGER before_transaction_insert
                                                  -> BEFORE INSERT ON transactions
                                                  -> FOR EACH ROW
                                                  -> BEGIN
                                                  ->     DECLARE current_balance DECIMAL(15,2);
                                                  ->     DECLARE account_status VARCHAR(20);
                                                  ->
                                                  ->     SELECT balance, status
                                                  ->     INTO current_balance, account_status
                                                  ->     FROM accounts
                                                  ->     WHERE account_id = NEW.account_id
                                                  ->     FOR UPDATE;
                                                  ->
                                                  ->     IF account_status <> 'Active' THEN
                                                  ->         SIGNAL SQLSTATE '45000'
                                                  ->         SET MESSAGE_TEXT = 'Account is not active';
                                                  ->     END IF;
                                                  ->
                                                  ->     IF NEW.amount <= 0 THEN
                                                  ->         SIGNAL SQLSTATE '45000'
                                                  ->         SET MESSAGE_TEXT = 'Amount must be positive';
                                                  ->     END IF;
                                                  ->
                                                  ->     IF NEW.transaction_type IN
                                                  ->        ('Withdrawal', 'Transfer_Out')
                                                  ->        AND NEW.amount > current_balance THEN
                                                  ->
                                                  ->         SIGNAL SQLSTATE '45000'
                                                  ->         SET MESSAGE_TEXT = 'Insufficient account balance';
                                                  ->
                                                  ->     END IF;
                                                  -> END //
Query OK, 0 rows affected (0.0290 sec)
 MySQL  localhost:3306 ssl  bank_management_2  SQL >
 MySQL  localhost:3306 ssl  bank_management_2  SQL > DELIMITER ;
 MySQL  localhost:3306 ssl  bank_management_2  SQL >
 MySQL  localhost:3306 ssl  bank_management_2  SQL > DELIMITER //
 MySQL  localhost:3306 ssl  bank_management_2  SQL >
 MySQL  localhost:3306 ssl  bank_management_2  SQL > CREATE TRIGGER after_transaction_insert
                                                  -> AFTER INSERT ON transactions
                                                  -> FOR EACH ROW
                                                  -> BEGIN
                                                  ->
                                                  ->     IF NEW.transaction_type = 'Deposit'
                                                  ->        OR NEW.transaction_type = 'Transfer_In' THEN
                                                  ->
                                                  ->         UPDATE accounts
                                                  ->         SET balance = balance + NEW.amount
                                                  ->         WHERE account_id = NEW.account_id;
                                                  ->
                                                  ->     ELSEIF NEW.transaction_type = 'Withdrawal'
                                                  ->        OR NEW.transaction_type = 'Transfer_Out' THEN
                                                  ->
                                                  ->         UPDATE accounts
                                                  ->         SET balance = balance - NEW.amount
                                                  ->         WHERE account_id = NEW.account_id;
                                                  ->
                                                  ->     END IF;
                                                  ->
                                                  -> END //
Query OK, 0 rows affected (0.0180 sec)
 MySQL  localhost:3306 ssl  bank_management_2  SQL >
 MySQL  localhost:3306 ssl  bank_management_2  SQL > DELIMITER ;
 MySQL  localhost:3306 ssl  bank_management_2  SQL >
 MySQL  localhost:3306 ssl  bank_management_2  SQL > INSERT INTO transactions
                                                  -> (account_id, transaction_type, amount, description)
                                                  -> VALUES
                                                  -> (100001, 'Deposit', 5000, 'Cash deposit');
Query OK, 1 row affected (0.0117 sec)
 MySQL  localhost:3306 ssl  bank_management_2  SQL >
 MySQL  localhost:3306 ssl  bank_management_2  SQL > INSERT INTO transactions
                                                  -> (account_id, transaction_type, amount, description)
                                                  -> VALUES
                                                  -> (100001, 'Withdrawal', 2000, 'ATM withdrawal');
Query OK, 1 row affected (0.0099 sec)
 MySQL  localhost:3306 ssl  bank_management_2  SQL >
 MySQL  localhost:3306 ssl  bank_management_2  SQL > INSERT INTO transactions
                                                  -> (account_id, transaction_type, amount, description)
                                                  -> VALUES
                                                  -> (100001, 'Withdrawal', 50000, 'Test withdrawal');
ERROR: 1644 (45000): Insufficient account balance
 MySQL  localhost:3306 ssl  bank_management_2  SQL >
 MySQL  localhost:3306 ssl  bank_management_2  SQL > DELIMITER //
 MySQL  localhost:3306 ssl  bank_management_2  SQL >
 MySQL  localhost:3306 ssl  bank_management_2  SQL > CREATE PROCEDURE fund_transfer(
                                                  ->     IN p_from_account BIGINT,
                                                  ->     IN p_to_account BIGINT,
                                                  ->     IN p_amount DECIMAL(15,2)
                                                  -> )
                                                  -> BEGIN
                                                  ->     DECLARE v_from_balance DECIMAL(15,2);
                                                  ->     DECLARE v_to_balance DECIMAL(15,2);
                                                  ->     DECLARE v_from_status VARCHAR(20);
                                                  ->     DECLARE v_to_status VARCHAR(20);
                                                  ->     DECLARE v_transfer_ref VARCHAR(36);
                                                  ->
                                                  ->     DECLARE EXIT HANDLER FOR SQLEXCEPTION
                                                  ->     BEGIN
                                                  ->         ROLLBACK;
                                                  ->         RESIGNAL;
                                                  ->     END;
                                                  ->
                                                  ->     IF p_from_account = p_to_account THEN
                                                  ->         SIGNAL SQLSTATE '45000'
                                                  ->         SET MESSAGE_TEXT = 'Cannot transfer to same account';
                                                  ->     END IF;
                                                  ->
                                                  ->     IF p_amount <= 0 THEN
                                                  ->         SIGNAL SQLSTATE '45000'
                                                  ->         SET MESSAGE_TEXT = 'Invalid transfer amount';
                                                  ->     END IF;
                                                  ->
                                                  ->     START TRANSACTION;
                                                  ->
                                                  ->     -- Lock both accounts in consistent order
                                                  ->     IF p_from_account < p_to_account THEN
                                                  ->
                                                  ->         SELECT balance, status
                                                  ->         INTO v_from_balance, v_from_status
                                                  ->         FROM accounts
                                                  ->         WHERE account_id = p_from_account
                                                  ->         FOR UPDATE;
                                                  ->
                                                  ->         SELECT balance, status
                                                  ->         INTO v_to_balance, v_to_status
                                                  ->         FROM accounts
                                                  ->         WHERE account_id = p_to_account
                                                  ->         FOR UPDATE;
                                                  ->
                                                  ->     ELSE
                                                  ->
                                                  ->         SELECT balance, status
                                                  ->         INTO v_to_balance, v_to_status
                                                  ->         FROM accounts
                                                  ->         WHERE account_id = p_to_account
                                                  ->         FOR UPDATE;
                                                  ->
                                                  ->         SELECT balance, status
                                                  ->         INTO v_from_balance, v_from_status
                                                  ->         FROM accounts
                                                  ->         WHERE account_id = p_from_account
                                                  ->         FOR UPDATE;
                                                  ->
                                                  ->     END IF;
                                                  ->
                                                  ->     IF v_from_balance IS NULL OR v_to_balance IS NULL THEN
                                                  ->         SIGNAL SQLSTATE '45000'
                                                  ->         SET MESSAGE_TEXT = 'Account not found';
                                                  ->     END IF;
                                                  ->
                                                  ->     IF v_from_status <> 'Active'
                                                  ->        OR v_to_status <> 'Active' THEN
                                                  ->         SIGNAL SQLSTATE '45000'
                                                  ->         SET MESSAGE_TEXT = 'Both accounts must be active';
                                                  ->     END IF;
                                                  ->
                                                  ->     IF v_from_balance < p_amount THEN
                                                  ->         SIGNAL SQLSTATE '45000'
                                                  ->         SET MESSAGE_TEXT = 'Insufficient balance';
                                                  ->     END IF;
                                                  ->
                                                  ->     SET v_transfer_ref = UUID();
                                                  ->
                                                  ->     -- Debit sender
                                                  ->     INSERT INTO transactions
                                                  ->     (account_id, transaction_type, amount,
                                                  ->      description, transfer_ref)
                                                  ->     VALUES
                                                  ->     (p_from_account, 'Transfer_Out', p_amount,
                                                  ->      'Fund transfer sent', v_transfer_ref);
                                                  ->
                                                  ->     -- Credit receiver
                                                  ->     INSERT INTO transactions
                                                  ->     (account_id, transaction_type, amount,
                                                  ->      description, transfer_ref)
                                                  ->     VALUES
                                                  ->     (p_to_account, 'Transfer_In', p_amount,
                                                  ->      'Fund transfer received', v_transfer_ref);
                                                  ->
                                                  ->     COMMIT;
                                                  ->
                                                  ->     SELECT 'Transfer Successful' AS message,
                                                  ->            v_transfer_ref AS reference_number;
                                                  ->
                                                  -> END //
Query OK, 0 rows affected (0.0643 sec)
 MySQL  localhost:3306 ssl  bank_management_2  SQL >
 MySQL  localhost:3306 ssl  bank_management_2  SQL > DELIMITER ;
 MySQL  localhost:3306 ssl  bank_management_2  SQL >
 MySQL  localhost:3306 ssl  bank_management_2  SQL > CALL fund_transfer(100001, 100002, 5000);
+---------------------+--------------------------------------+
| message             | reference_number                     |
+---------------------+--------------------------------------+
| Transfer Successful | 98244aa2-e248-11f1-96e9-d493903e4ce0 |
+---------------------+--------------------------------------+
1 row in set (0.0316 sec)

Query OK, 0 rows affected (0.0316 sec)
 MySQL  localhost:3306 ssl  bank_management_2  SQL >
 MySQL  localhost:3306 ssl  bank_management_2  SQL > CREATE VIEW mini_statement AS
                                                  -> SELECT
                                                  ->     t.transaction_id,
                                                  ->     a.account_id,
                                                  ->     c.customer_name,
                                                  ->     t.transaction_type,
                                                  ->     t.amount,
                                                  ->     t.transaction_date,
                                                  ->     t.description,
                                                  ->     t.transfer_ref
                                                  -> FROM transactions t
                                                  -> JOIN accounts a
                                                  ->     ON t.account_id = a.account_id
                                                  -> JOIN customers c
                                                  ->     ON a.customer_id = c.customer_id;
Query OK, 0 rows affected (0.0110 sec)
 MySQL  localhost:3306 ssl  bank_management_2  SQL >
 MySQL  localhost:3306 ssl  bank_management_2  SQL > SELECT *
                                                  -> FROM mini_statement
                                                  -> WHERE account_id = 100001
                                                  -> ORDER BY transaction_date DESC;
+----------------+------------+---------------+------------------+---------+---------------------+--------------------+--------------------------------------+
| transaction_id | account_id | customer_name | transaction_type | amount  | transaction_date    | description        | transfer_ref |
+----------------+------------+---------------+------------------+---------+---------------------+--------------------+--------------------------------------+
|              3 |     100001 | Rahul Das     | Transfer_Out     | 5000.00 | 2026-11-17 11:04:44 | Fund transfer sent | 98244aa2-e248-11f1-96e9-d493903e4ce0 |
|              2 |     100001 | Rahul Das     | Withdrawal       | 2000.00 | 2026-11-17 11:01:42 | ATM withdrawal     | NULL |
|              1 |     100001 | Rahul Das     | Deposit          | 5000.00 | 2026-11-17 11:00:45 | Cash deposit       | NULL |
+----------------+------------+---------------+------------------+---------+---------------------+--------------------+--------------------------------------+
3 rows in set (0.0019 sec)
 MySQL  localhost:3306 ssl  bank_management_2  SQL >
 MySQL  localhost:3306 ssl  bank_management_2  SQL > SELECT
                                                  ->     b.branch_name,
                                                  ->     SUM(t.amount) AS total_deposits
                                                  -> FROM branches b
                                                  -> JOIN customers c
                                                  ->     ON b.branch_id = c.branch_id
                                                  -> JOIN accounts a
                                                  ->     ON c.customer_id = a.customer_id
                                                  -> JOIN transactions t
                                                  ->     ON a.account_id = t.account_id
                                                  -> WHERE t.transaction_type IN ('Deposit', 'Transfer_In')
                                                  -> GROUP BY b.branch_id, b.branch_name
                                                  -> ORDER BY total_deposits DESC;
+---------------------+----------------+
| branch_name         | total_deposits |
+---------------------+----------------+
| Kolkata Main Branch |        5000.00 |
| Howrah Branch       |        5000.00 |
+---------------------+----------------+
2 rows in set (0.0085 sec)
 MySQL  localhost:3306 ssl  bank_management_2  SQL >
 MySQL  localhost:3306 ssl  bank_management_2  SQL > SELECT
                                                  ->     c.customer_name,
                                                  ->     a.account_id,
                                                  ->     a.account_type,
                                                  ->     a.balance
                                                  -> FROM customers c
                                                  -> JOIN accounts a
                                                  ->     ON c.customer_id = a.customer_id
                                                  -> ORDER BY a.balance DESC
                                                  -> LIMIT 5;
+---------------+------------+--------------+----------+
| customer_name | account_id | account_type | balance  |
+---------------+------------+--------------+----------+
| Arjun Sen     |     100005 | Savings      | 80000.00 |
| Amit Roy      |     100003 | Current      | 60000.00 |
| Priya Sharma  |     100002 | Savings      | 45000.00 |
| Rahul Das     |     100001 | Savings      | 23000.00 |
| Sneha Paul    |     100004 | Savings      | 15000.00 |
+---------------+------------+--------------+----------+
5 rows in set (0.0015 sec)
 MySQL  localhost:3306 ssl  bank_management_2  SQL >
 MySQL  localhost:3306 ssl  bank_management_2  SQL > SELECT
                                                  ->     SUM(CASE
                                                  ->         WHEN transaction_type = 'Deposit'
                                                  ->         THEN amount ELSE 0
                                                  ->     END) AS total_deposits,
                                                  ->
                                                  ->     SUM(CASE
                                                  ->         WHEN transaction_type = 'Withdrawal'
                                                  ->         THEN amount ELSE 0
                                                  ->     END) AS total_withdrawals
                                                  -> FROM transactions;
+----------------+-------------------+
| total_deposits | total_withdrawals |
+----------------+-------------------+
|        5000.00 |           2000.00 |
+----------------+-------------------+
1 row in set (0.0053 sec)
 MySQL  localhost:3306 ssl  bank_management_2  SQL >
 MySQL  localhost:3306 ssl  bank_management_2  SQL > SELECT
                                                  ->     account_id,
                                                  ->     COUNT(*) AS total_transactions,
                                                  ->     SUM(amount) AS total_transaction_amount
                                                  -> FROM transactions
                                                  -> GROUP BY account_id;
+------------+--------------------+--------------------------+
| account_id | total_transactions | total_transaction_amount |
+------------+--------------------+--------------------------+
|     100001 |                  3 |                 12000.00 |
|     100002 |                  1 |                  5000.00 |
+------------+--------------------+--------------------------+
2 rows in set (0.0022 sec)
 MySQL  localhost:3306 ssl  bank_management_2  SQL >
 MySQL  localhost:3306 ssl  bank_management_2  SQL > SELECT
                                                  ->     DATE_FORMAT(transaction_date, '%Y-%m')
                                                  ->     AS transaction_month,
                                                  ->
                                                  ->     transaction_type,
                                                  ->     COUNT(*) AS total_transactions,
                                                  ->     SUM(amount) AS total_amount
                                                  ->
                                                  -> FROM transactions
                                                  ->
                                                  -> GROUP BY
                                                  ->     DATE_FORMAT(transaction_date, '%Y-%m'),
                                                  ->     transaction_type
                                                  ->
                                                  -> ORDER BY transaction_month;
+-------------------+------------------+--------------------+--------------+
| transaction_month | transaction_type | total_transactions | total_amount |
+-------------------+------------------+--------------------+--------------+
| 2026-11           | Deposit          |                  1 |      5000.00 |
| 2026-11           | Withdrawal       |                  1 |      2000.00 |
| 2026-11           | Transfer_Out     |                  1 |      5000.00 |
| 2026-11           | Transfer_In      |                  1 |      5000.00 |
+-------------------+------------------+--------------------+--------------+
4 rows in set (0.0047 sec)
 MySQL  localhost:3306 ssl  bank_management_2  SQL >
 MySQL  localhost:3306 ssl  bank_management_2  SQL > SELECT
                                                  ->     transaction_id,
                                                  ->     account_id,
                                                  ->     transaction_type,
                                                  ->     amount,
                                                  ->     transaction_date,
                                                  ->     description
                                                  ->
                                                  -> FROM transactions
                                                  ->
                                                  -> WHERE transaction_date >= '2026-11-01'
                                                  -> AND transaction_date < '2026-12-01'
                                                  ->
                                                  -> INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/november_statement.csv'
                                                  ->
                                                  -> FIELDS TERMINATED BY ','
                                                  -> OPTIONALLY ENCLOSED BY '"'
                                                  -> LINES TERMINATED BY '\n';
Query OK, 4 rows affected (0.0076 sec)
 MySQL  localhost:3306 ssl  bank_management_2  SQL >
 MySQL  localhost:3306 ssl  bank_management_2  SQL > CREATE TABLE opening_balance_import (
                                                  ->     account_id BIGINT,
                                                  ->     opening_balance DECIMAL(15,2)
                                                  -> );
Query OK, 0 rows affected (0.0246 sec)
 MySQL  localhost:3306 ssl  bank_management_2  SQL >
 MySQL  localhost:3306 ssl  bank_management_2  SQL > LOAD DATA LOCAL INFILE
                                                  -> 'C:/bank_project/opening_balances.csv'
                                                  ->
                                                  -> INTO TABLE opening_balance_import
                                                  ->
                                                  -> FIELDS TERMINATED BY ','
                                                  -> OPTIONALLY ENCLOSED BY '"'
                                                  ->
                                                  -> LINES TERMINATED BY '\n'
                                                  ->
                                                  -> IGNORE 1 ROWS;
ERROR: 3948 (42000): Loading local data is disabled; this must be enabled on both the client and server sides
 MySQL  localhost:3306 ssl  bank_management_2  SQL >  LOAD DATA LOCAL INFILE
                                                  -> 'C:\Users\ASIT\Downloads\opening_balances.csv'
                                                  -> INTO TABLE opening_balance_import
                                                  ->
                                                  -> FIELDS TERMINATED BY ','
                                                  -> OPTIONALLY ENCLOSED BY '"'
                                                  ->
                                                  -> LINES TERMINATED BY '\n'
                                                  ->
                                                  -> IGNORE 1 ROWS;
ERROR: 3948 (42000): Loading local data is disabled; this must be enabled on both the client and server sides
 MySQL  localhost:3306 ssl  bank_management_2  SQL >
