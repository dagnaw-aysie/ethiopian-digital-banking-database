-- ==========================================================
-- Ethiopian Digital Banking & Financial Analytics Database
-- Built with PostgreSQL
-- Author: Dagnaw Aysie
-- ==========================================================

-- 1. Create Tables (Schema)
CREATE TABLE branches (
    branch_id SERIAL PRIMARY KEY,
    branch_name VARCHAR(100) NOT NULL,
    city VARCHAR(50) NOT NULL,
    branch_code VARCHAR(10) UNIQUE NOT NULL
);

CREATE TABLE bank_customers (
    customer_id SERIAL PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    national_id VARCHAR(20) UNIQUE NOT NULL,
    phone_number VARCHAR(20) UNIQUE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE accounts (
    account_id SERIAL PRIMARY KEY,
    account_number VARCHAR(20) UNIQUE NOT NULL,
    customer_id INT NOT NULL REFERENCES bank_customers(customer_id),
    branch_id INT NOT NULL REFERENCES branches(branch_id),
    account_type VARCHAR(20) CHECK (account_type IN ('Saving', 'Current', 'Diaspora')),
    balance_etb DECIMAL(15, 2) DEFAULT 0.00 CHECK (balance_etb >= 0),
    status VARCHAR(15) DEFAULT 'Active'
);

CREATE TABLE transactions (
    transaction_id SERIAL PRIMARY KEY,
    account_id INT NOT NULL REFERENCES accounts(account_id),
    transaction_type VARCHAR(20) CHECK (transaction_type IN ('Deposit', 'Withdrawal', 'Transfer')),
    amount_etb DECIMAL(15, 2) CHECK (amount_etb > 0),
    transaction_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    description TEXT
);

-- 2. Insert Sample Data
INSERT INTO branches (branch_name, city, branch_code) VALUES
('Finfinne Main Branch', 'Addis Ababa', 'ET001'),
('Wolaita Sodo Branch', 'Wolaita Sodo', 'ET002'),
('Adama Branch', 'Adama', 'ET003');

INSERT INTO bank_customers (full_name, national_id, phone_number) VALUES
('Dagnaw Aysie', 'ETH100200300', '+251911223344'),
('Selamawit Bekele', 'ETH100200301', '+251922334455'),
('Bereket Tadesse', 'ETH100200302', '+251933445566');

INSERT INTO accounts (account_number, customer_id, branch_id, account_type, balance_etb) VALUES
('1000123456789', 1, 2, 'Saving', 85000.00),
('1000987654321', 2, 1, 'Diaspora', 250000.00),
('1000456789123', 3, 3, 'Current', 42000.00);

INSERT INTO transactions (account_id, transaction_type, amount_etb, description) VALUES
(1, 'Deposit', 50000.00, 'Salary Deposit'),
(1, 'Withdrawal', 5000.00, 'ATM Cash Withdrawal'),
(2, 'Deposit', 100000.00, 'International Remittance'),
(3, 'Transfer', 12000.00, 'Supplier Payment');

-- 3. Financial Analytics Query (Branch Deposits Summary)
SELECT 
    b.branch_name,
    b.city,
    COUNT(a.account_id) AS total_accounts,
    SUM(a.balance_etb) AS total_deposits_etb
FROM branches b
LEFT JOIN accounts a ON b.branch_id = a.branch_id
GROUP BY b.branch_name, b.city
ORDER BY total_deposits_etb DESC;
