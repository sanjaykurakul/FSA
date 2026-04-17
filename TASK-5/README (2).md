# Task 5: Transaction-Based Payment Simulation

## Objective
Simulate an online payment process using SQL Transactions (COMMIT / ROLLBACK).

## Concepts Used
- SQL Transactions (`START TRANSACTION`, `COMMIT`, `ROLLBACK`)
- Stored Procedures
- Exception Handling in SQL
- `FOR UPDATE` row locking

## How It Works
1. Checks sender's account balance
2. If sufficient → deducts from sender, credits merchant → `COMMIT`
3. If insufficient → raises error → `ROLLBACK`
4. All attempts are logged in `transactions_log`

## Real-Time Usage
Banking and digital payment applications (UPI, net banking, e-wallets).

## How to Run
```sql
SOURCE payment_simulation.sql;
```
