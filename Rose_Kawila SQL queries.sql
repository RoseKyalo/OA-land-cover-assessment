-- Question 1 : Finding the total number of rows in each of the accounts table 

select count(*) from accounts;

-- The total number of rows in each of the accounts table is 351

-- Question 2 : Find the total dollar amount of sales using the total_amt_usd in the orders table.

select * from orders

select sum(total_amt_usd) from orders;

-- The total dollar amount of sales is 23141511.83

-- Question 3 : When was the earliest order ever placed?
-- You only need to return the date using the occurred_at column in the orders table.

select min(occurred_at) from orders;

-- The earliest order occurred on 2013-12-04 at 04:22:44

-- Question 4: Pull only the account name from the account table and the dates in which 
-- that account placed an order in the orders, but none of the other columns.

select * from accounts

select * from orders

-- common columns are id in accounts table and account_id in orders table. join the tables on these columns

select a.name AS account_name, o.occurred_at AS order_date
from accounts a
join orders o on a.id = o.account_id
order by o.occurred_at ASC;


