create table debit_credit(Customer_ID	varchar(100)	,
Customer_Name	 varchar(100)	,
Account_Number	varchar(100)	,
Transaction_Date	date	,
Transaction_Type	varchar(100)	,
Amount	Double precision	,
Balance	Double precision	,
Description	varchar(100)	,
Branch	varchar(100)	,
Transaction_Method	varchar(100)	,
Currency	varchar(100)	,
Bank_Name	varchar(100)	
);
select * from debit_credit;
select count(Customer_id) from debit_credit;

-- 1-Total Credit Amount:
select sum(amount) from debit_credit where transaction_type='Credit';

-- 2-Total Debit Amount:
select sum(amount) from debit_credit where transaction_type='Debit';

-- 3-Credit to Debit Ratio:
select 
Round(
(sum(case when transaction_type='Credit' then amount else 0 end)::NUMERIC /
nullif(sum(case when transaction_type='Debit' then amount else 0 end ) ,0)::NUMERIC ),2)|| '%' AS Ratio
from debit_credit;

-- 4-Net Transaction Amount:
select sum(case when transaction_type='Credit' Then  amount else 0 End)-
sum(case when transaction_type='Debit' Then  amount else 0 End)
from Debit_credit;

-- 5-Account Activity Ratio:
select sum(amount)/count(amount) as  Transactions 
from debit_credit;

-- 6-Transactions per Day/Week/Month:

select extract(month from transaction_date) as months,
extract(dow from transaction_date)  as week_from_day,
Extract(day from transaction_date) as days, count(transaction_date) as Transactions
from debit_credit group by transaction_date;

-- 7-Total Transaction Amount by Branch:
select * from debit_credit ;
select branch,sum(amount) as amount 
from Debit_credit group by branch;

-- 8-Transaction Volume by Bank:

select bank_name, sum(amount) as amount 
from debit_credit
group by bank_name;

-- 9-Transaction Method Distribution:
select transaction_method,count(transaction_method)
from debit_credit 
group by transaction_method;

-- 10-Branch Transaction Growth:
select    branch ,transaction_date ,avg(amount) as amount 
from debit_credit 
group by branch,transaction_date;

--  11-High-Risk Transaction Flag:

select transaction_type,amount,  case when  transaction_type='Debit' and amount>2000 then 'large withdrawal'
when transaction_type='Credit' and amount>2000 then 'Large deposit'
else ' average' end as Transaction_flag
from debit_credit;

-- 12-Suspicious Transaction Frequency:

select transaction_date ,transaction_type,amount,  case when  transaction_type='Debit' and amount>2000 then 'large withdrawal'
when transaction_type='Credit' and amount>2000 then 'Large deposit'
else ' average' end as Transaction_flag
from debit_credit;
