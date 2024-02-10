create table transaction (
  transaction_id integer primary key
  ,product_id integer
  ,customer_id integer 
  ,transaction_date varchar(30)
  ,online_order varchar(30)
  ,order_status varchar(30)
  ,brand varchar(30)
  ,product_line varchar(30)
  ,product_class varchar(30)
  ,product_size varchar(30)
  ,list_price float(4) 
  ,standard_cost float(4)
);

create table  customer( 
  customer_id integer primary key
  ,first_name varchar(50) 
  ,last_name varchar(50)
  ,gender varchar(30)  
  ,DOB varchar(50)
  ,job_title varchar(50)
  ,job_industry_category varchar(50)
  ,wealth_segment varchar(50)
  ,deceased_indicator varchar(50)
  ,owns_car varchar(30)
  ,address varchar(50)
  ,postcode varchar(50)
  ,state varchar(30)
  ,country varchar(30)
  ,property_valuation integer
); 

alter table transaction
add column tran_date DATE;

update transaction
set tran_date = TO_DATE(transaction_date, 'DD/MM/YY');

alter table transaction
drop column transaction_date;

alter table transaction
rename column tran_date TO transaction_date;

select distinct brand from transaction
where standard_cost > 1500;

select transaction_id from transaction 
where transaction_date between '2017-04-01' and '2017-04-09' and order_status = 'Approved';

select distinct job_title, job_industry_category from customer 
Where (job_industry_category = 'IT' or job_industry_category = 'Financial Services') and job_title like 'Senior%';

select distinct brand from transaction 
where customer_id in (
    select customer_id from customer
    where job_industry_category = 'Financial Services'
);

select online_order, brand from transaction
where online_order = 'True' and (brand = 'Giant Bicycles' or brand = 'Norco Bicycles' or brand = 'Trek Bicycles')
limit 10;

select customer.* from customer
left join transaction on customer.customer_id = transaction.customer_id
where transaction.customer_id is null;

select customer.* from customer
join transaction on customer.customer_id = transaction.customer_id
where customer.job_industry_category = 'IT' and transaction.standard_cost = (
    select standard_cost from transaction
    where standard_cost is not null
    order by standard_cost desc
    limit 1
  );

select distinct customer.* from customer
join transaction on customer.customer_id = transaction.customer_id
where (customer.job_industry_category = 'IT' or customer.job_industry_category = 'Health') 
and transaction.order_status = 'Approved' 
and  transaction.transaction_date between '2017-07-07' and '2017-07-17';


