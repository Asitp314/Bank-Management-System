# Bank-Management-System
Advanced MySQL Bank Accounts and Fund Transfer Management System


# Bank Accounts and Fund Transfer Management System

## Project Overview
An Advanced MySQL Database Project designed to manage banking operations such as branches, customers, accounts, deposits, withdrawals, and fund transfers.

## Technologies Used
- MySQL 8.0
- MySQL Workbench
- SQL

## Database Tables
1. Branches
2. Customers
3. Accounts
4. Transactions

## Key Features
- Customer and bank account management
- Deposit and withdrawal operations
- Automatic balance updates using SQL Triggers
- Fund transfer using Stored Procedures
- Transaction management using COMMIT and ROLLBACK
- Mini statement using SQL Views
- Branch-wise deposit reports
- Highest balance customer reports
- CSV import and export
- Indexes for query optimization

## SQL Concepts
- Primary Key and Foreign Key
- JOIN
- GROUP BY
- Aggregate Functions
- Triggers
- Stored Procedures
- Views
- Transactions
- COMMIT and ROLLBACK
- Indexes

## Fund Transfer Example

```sql
CALL fund_transfer(100001, 100002, 5000);
```

This procedure transfers ₹5,000 from account 100001 to account 100002.

## Project Learning Outcomes
This project demonstrates relational database design, SQL automation, transaction management, data integrity, and financial reporting.

## Auther 
Asit Paria,  

## Project Type
Advanced MySQL Database Project
