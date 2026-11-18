# Ethiopian Digital Banking & Financial Analytics Database

A secure, normalized relational database system designed for **Ethiopian Digital Banking** operations using **PostgreSQL**. This project models multi-branch banking, customer onboarding, multi-currency/diaspora account management, and real-time financial reporting.

## Database Architecture (Schema)
The system is structured across four interconnected tables:
* **`branches`**: Tracks regional banking branches and unique branch codes across Ethiopia.
* **`bank_customers`**: Stores verified customer identities using National IDs and contact details.
* **`accounts`**: Manages `Saving`, `Current`, and `Diaspora` accounts with strict balance validation rules.
* **`transactions`**: Logs deposits, withdrawals, and transfers with timestamps and descriptions.

## Advanced SQL & Security Features
* **Financial Data Integrity**: Implemented `CHECK (balance_etb >= 0)` and `CHECK (amount_etb > 0)` constraints to prevent overdraft anomalies and invalid transactions.
* **Branch-Level Financial Analytics**: Built aggregation queries using `LEFT JOIN`, `COUNT`, `SUM`, and `GROUP BY` to calculate total deposits per branch.
* **Live Interactive Demo**: Tested and verified on PostgreSQL. [View Live Banking Database on DB Fiddle](https://www.db-fiddle.com/f/tXrwsz4P9wifEnHMA8mcqx/2)

## How to Run
1. Open [`banking_database.sql`](./banking_database.sql) in this repository.
2. Execute the script in PostgreSQL (pgAdmin, DBeaver, or DB Fiddle).

---
**Author:** Dagnaw Aysie  
**GitHub:** [@
