# Restaurant Order Management Database

An academic **Oracle SQL** project that models restaurant customers, orders, staff, products, customer phone numbers, and payments. It demonstrates relational schema design, sample-data insertion, and SQL queries.

## Database tables

| Table | Purpose |
| --- | --- |
| `Customer` | Customer details |
| `Cus_order` | Orders linked to customers |
| `Staff` | Staff records linked to orders |
| `Product` | Products linked to orders |
| `CustomerPhone` | Customer phone numbers |
| `Payment` | Payments linked to orders and customers |

## SQL concepts
- Primary and foreign keys
- `NOT NULL`, `UNIQUE`, and `CHECK` constraints
- `CREATE TABLE`, `INSERT INTO`, and `SELECT`
- Filtering with `WHERE`, `AND`, and `BETWEEN`
- Aggregation with `COUNT` and `GROUP BY`
- Table relationships with `JOIN`

## How to run
1. Open an Oracle Database connection using SQL Developer or a compatible SQL client.
2. Open `restaurant_order_management.sql`.
3. **Important:** The script starts with `DROP TABLE` statements and will delete tables with matching names, including their data. Use a disposable development schema, not a production database.
4. Run the script to create six tables, insert sample records, and execute example queries.

## Notes
- Sample customer and staff details are fictional.
- The `DROP TABLE` statements were reordered to remove dependent tables before parent tables.
- The script has not been executed against a live Oracle database in this review.

## Technology
**Oracle Database · SQL · Relational Database Design**
