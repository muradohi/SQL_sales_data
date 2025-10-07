create database retail_sales;
use retail_sales;

-- Create TABLE
DROP TABLE IF EXISTS retail_sales;
CREATE TABLE if not exists retail_sales
            (
                transaction_id INT PRIMARY KEY,	
                sale_date DATE,	 
                sale_time TIME,	
                customer_id	INT,
                gender	VARCHAR(15),
                age	INT,
                category VARCHAR(15),	
                quantity	INT,
                price_per_unit FLOAT,	
                cogs	FLOAT,
                total_sale FLOAT
            );

SELECT * FROM retail_sales
limit 10;

-- total records
select count(rs.Customer_ID) from retail_sales as rs;

-- data cleaning
select * from retail_sales
where Transaction_ID is null;

select * from retail_sales
where Transaction_ID is not null;

select * from retail_sales
where Transaction_ID is null
	or
	Date is null
	or
	Customer_ID is null 
	or
	Age is null
	or
	Product_Category is null
	or
	Quantity is null
	or
	Price_per_Unit is null
	or
	Total_Amount is null;

delete from retail_sales
where 
	Transaction_ID is null
	or
	Date is null
	or
	Customer_ID is null 
	or
	Age is null
	or
	Product_Category is null
	or
	Quantity is null
	or
	Price_per_Unit is null
	or
	Total_Amount is null;

-- how much sales we have 
select * from retail_sales;
select sum(Total_Amount) from retail_sales;
select count(*) from retail_sales;
select count(*) as total_sales from retail_sales;

-- How many uniuque customers we have ?
select * from retail_sales;
select count(distinct Customer_ID) as uniuque_customers from retail_sales;

SELECT DISTINCT Product_Category FROM retail_sales;

-- Data Analysis & Business Key Problems & Answers
 -- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05'

select * from retail_sales
	where Date = '2023-11-26';
		
-- Q.2 Write a SQL query to retrieve all transactions where the category is 
-- 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022
select * from retail_sales
limit 5;

alter table retail_sales
change column Date date DATE;

select * from retail_sales
	where
		Product_Category = 'Clothing' 
        and
        Quantity >=4
		and
        year(date) = '2023' and month(date) = 11;

-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.

select * from retail_sales;
select distinct Product_Category as Distinct_Category from retail_sales;

select Product_Category as Category, sum(Total_Amount) as Total_sales from retail_sales
group by Product_Category
order by Total_sales;

-- Q.4 Write a SQL query to find the average age of customers who purchased
-- items from the 'Beauty' category.
select * from retail_sales;
select avg(Age) Avg_Age,Product_Category  from retail_sales
	where
		Product_Category = 'Beauty';

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
select * from retail_sales;
select Transaction_ID from retail_sales
	where Total_Amount > 1000;


-- Q.6 Write a SQL query to find the total number of transactions 
-- (transaction_id) made by each gender in each category.
select * from retail_sales;

select count(Transaction_ID),Product_Category, Gender from retail_sales
	group by Product_Category, Gender
    order by 3
;

-- Q.7 Write a SQL query to calculate the average sale for each month. 
-- Find out best selling month in each year
select * from retail_sales;

select month(date) as months , year(date) as years, avg(Total_Amount) avg_total_sales,
rank() over( partition by year(date)  order by avg(Total_Amount) desc) from retail_sales
	group by years, months
    order by avg_total_sales desc
;

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
select * from retail_sales;

select Customer_ID, sum(Total_Amount) as total from retail_sales
group by 1
order by 2 desc
limit 5

 ;

-- Q.9 Write a SQL query to find the number of unique customers 
-- who purchased items from each category.
select * from retail_sales;

select count( distinct Customer_ID), Product_Category from retail_sales
	where
    Product_Category = 'Beauty'
    and 'Clothing' and 'Electronics' 
    group by Product_Category
;

select count( distinct Customer_ID), Product_Category from retail_sales
    group by Product_Category
;

select count(Customer_ID) from retail_sales
	where
    Customer_ID = 'CUST002'
;

-- Q.10 Write a SQL query to create each shift and number of orders 
-- (Example Morning <12, Afternoon Between 12 & 17, Evening >17)
select * from retail_sales;

-- Q.10 Write a SQL query to create each shift and number of orders 

select *, 
	case 
		when month(date) between 1 and 3 then 'q1'
        when month(date) between 4 and 6 then 'q2'
        when month(date) between 7 and 9 then 'q3'
        else 'q4'
        
	end as quarter
    from retail_sales;


-- End of project

