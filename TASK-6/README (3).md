# Task 6: Automated Logging using Triggers & Views

## Objective
Automatically log database changes and generate daily activity reports.

## Concepts Used
- SQL Triggers (`AFTER INSERT`, `AFTER UPDATE`)
- SQL Views (`CREATE VIEW`)
- Audit logging pattern
- `GROUP_CONCAT`, `DATE()` aggregate functions

## Features
- Trigger fires on every `INSERT` or `UPDATE` to `employees` table
- Logs old and new values to `audit_log`
- `daily_activity_report` view summarizes changes grouped by date and operation type

## Real-Time Usage
Audit logging in enterprise databases, compliance tracking, change history for HR/payroll systems.

## How to Run
```sql
SOURCE triggers_and_views.sql;
```
