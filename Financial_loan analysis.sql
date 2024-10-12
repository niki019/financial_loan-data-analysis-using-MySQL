use ethor;
SELECT * FROM ethor.financial_loan;

/* 1. Count the top 3 states with highest number of customers*/
select count(*) as no_of_customers, address_state
from financial_loan
group by address_state
order by no_of_customers desc
limit 3;

/* 2. Rate of the number of customers who are charged off  */
with t1 as
(select case when loan_status='Charged Off' then 1
else 0 end as stat 
from financial_loan)
select sum(stat)/count(stat)*100 as rate
from t1;

/*3. How many customer's loan was charged off who owned a home  */
select count(*) as total_own_home
from financial_loan
where loan_status='Charged Off' and home_ownership= 'OWN';

/*4. List of customers who have an anuual income more than 100000 and have loan status declared as charged off */
select id, loan_status, annual_income
from financial_loan
where annual_income>= 100000 and loan_status='Charged Off';

/*5. Which emp_length group has the maximum number of customers with charged off loan status */
select emp_length, count(*) as cnt
from financial_loan
where loan_status='Charged Off'
group by emp_length
order by cnt desc;

/*6. Total due amount for the company */
select -sum(loan_amount-total_payment) as total
from financial_loan;

/*7. Total charged off money value */ 
select sum(loan_amount-total_payment) as total
from financial_loan
where loan_status='Charged Off';

/* 8. What is the term of payment for the highest annual_income earning person  */
select term, annual_income
from financial_loan
where annual_income=(Select max(distinct annual_income) from financial_loan);




