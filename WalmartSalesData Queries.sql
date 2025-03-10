 Select * from `walmartsalesdata.csv`;

-- Rename table walmartsalesdata.csv to Walmart_salesdata
 Rename table `walmartsalesdata.csv` to Walmart_salesdata;

 -- Rename columns
 
 -- Rename column Invoice ID to Invoice_ID
 Alter table Walmart_salesdata
Rename column `Invoice ID` to Invoice_ID;

-- Rename column Customer Type to Customer_Type
 Alter table Walmart_salesdata
Rename column `Customer Type` to Customer_Type;

-- Rename column Product line to Prodduct_Line
 Alter table Walmart_salesdata
Rename column `Product Line` to Product_Line;

-- Rename column Unit Price to Unit_Price
 Alter table Walmart_salesdata
Rename column `Unit Price` to Unit_Price;

-- Rename column Invoice ID to Invoice_ID
 Alter table Walmart_salesdata
Rename column `Invoice ID` to Invoice_ID;

-- Rename column Tax 5% to Tax
 Alter table Walmart_salesdata
Rename column `Tax 5%` to Tax;

-- Rename column gross margin percentage to gross_margin_percentage
 Alter table Walmart_salesdata
Rename column `gross margin percentage` to gross_margin_percentage;

-- Rename column gross Income to gross_Income
 Alter table Walmart_salesdata
Rename column `gross Income` to gross_Income;

-- Change Date column Data type
Alter table Walmart_salesdata
Modify column Date date;

 Select * from Walmart_salesdata;
 
-- 1. How many unique cities does the data have?
Select count(distinct City) as count from Walmart_Salesdata;

-- 2. In which city is each branch?
select distinct city, Branch from walmart_salesdata;

-- Product
-- 1. How many unique product lines does the data have?
Select count(distinct Product_line) as count from Walmart_salesdata;

-- 2.	What is the most common payment method?
Select Payment, Count(payment) as Payment_count from Walmart_salesdata
Group by payment
Order by Payment_count desc
limit 1;

-- 3. What is the most selling product line?
Select product_line, Sum(Quantity) as Total_Quantity from walmart_salesdata
Group by Product_line
Order by Total_Quantity desc
Limit 1;

-- 4. What is the total revenue by month?
Select Monthname(Date) as Month_name, Month(Date) as Monthnumber,Round(Sum(Total),2) as Total_revenue from Walmart_salesdata
Group by Month_name, Monthnumber
Order by monthnumber, Total_revenue;

-- 5. What month had the largest COGS?
Select Monthname(Date) as Month_name, round(sum(COGS),2) as Total_COGS from walmart_salesdata
Group by Month_name
Order by Total_COGS desc
Limit 1;

-- 6. What product line had the largest revenue?
Select product_line, round(sum(Total),2) as Total_revenue from walmart_salesdata
Group by Product_line
Order by Total_revenue desc
Limit 1;

-- 7. What is the city with the largest revenue?
Select City, Round(Sum(total),2) as Total_revenue from walmart_salesdata
group by city
order by Total_revenue desc
limit 1;

-- 8. What product line had the largest VAT?
Select Product_line, round(Sum(Tax),2) as Total_VAT from Walmart_salesdata
group by product_line
order by Total_VAT desc
limit 1;

-- 9. Fetch each product line and add a column to those product line showing "Good", "Bad". Good if its greater than average sales
Select Product_line, round(avg(COGS),2) as  Avg_COGS,
Case when Avg(COGS) > (select avg(COGS) from walmart_salesdata) then "Good" else "Bad"
end as Product_line_rating from walmart_salesdata
group by Product_Line;
 

-- 10. Which branch sold more products than average product sold?
Select branch, round(Avg(quantity),2) as Avg_quantity from walmart_salesdata
group by branch
Having Avg_quantity > (select avg(quantity) from walmart_salesdata);

-- 11. What is the most common product line by gender?
Select Gender, Product_line, count(Product_line) as Most_common_product_line from Walmart_salesdata
Group by Gender, Product_line
Order by Most_common_product_line desc
Limit 1;

-- 12. What is the average rating of each product line?
Select Product_line, Round(Avg(rating),2) as Average_Rating from Walmart_salesdata
Group by Product_line;


-- Sales
-- 1. Number of sales made in each time of the day per weekday
Alter table walmart_salesdata
Add column Time_category text;
Set SQL_SAFE_UPDATES =0;
Update walmart_salesdata
Set time_category = case when time between "00:00:00" and "12:00:00" then "Morning"
when time between "12:00:00" and "16:00:00" then "Afternoon"
else "Evening" end;

Select time_category, sum(quantity) from walmart_salesdata
where not dayname(date) in ("Saturday","Sunday")
group by time_category;


Select time_CATEGORY from walmart_salesdata;

-- 2. Which of the customer types brings the most revenue?
Select customer_type, round(sum(Total),2)as Total_revenue from walmart_salesdata
group by customer_type 
order by Total_revenue desc
limit 1;

-- 3. Which city has the largest tax percent/ VAT (Value Added Tax)?
Select city, round(sum(Tax),2)as Total_VAT from walmart_salesdata
group by city 
order by Total_VAT desc
limit 1;

-- 4. Which customer type pays the most in VAT?
Select customer_type, round(sum(tax),2)as Total_VAT from walmart_salesdata
group by customer_type 
order by Total_VAT desc
limit 1;

-- Customer
-- 1. How many unique customer types does the data have?
Select count(distinct Customer_Type) as count from Walmart_Salesdata;

-- 2. How many unique payment methods does the data have?
Select count(Distinct Payment) as count from Walmart_salesdata;

-- 3. What is the most common customer type?
Select customer_Type, count(customer_Type) as count_Customer_Type from Walmart_salesdata
group by Customer_Type
order by Count_Customer_Type desc
Limit 1;

-- 4. Which customer type buys the most?
Select customer_type, Round(sum(quantity),2) as Total_quantity from Walmart_salesdata 
Group by Customer_type
order by Total_quantity desc
Limit 1;

-- 5. What is the gender of most of the customers?
Select Gender, Count(Invoice_ID) as Customer_gender_count from walmart_salesdata
group by Gender
order by Customer_gender_count desc
limit 1;

-- 6. What is the gender distribution per branch?

Select gender, Branch, count(gender) as gender_distribution from Walmart_salesdata
Group by gender, branch;

-- 7. Which time of the day do customers give most ratings?
Select time_category, round(sum(rating),2) as Total_rating from walmart_salesdata
group by time_category
order by Total_rating desc
limit 1;

-- 8. Which time of the day do customers give most ratings per branch?
Select Branch, time_category, round(sum(rating),2) as Total_rating from walmart_salesdata
group by Branch, time_category
order by Total_rating desc
limit 1;

-- 9. Which day of the week has the best avg ratings?
Select dayname(date) as Day_name, round(Avg(rating),2) as Avg_rating from Walmart_salesdata
group by Day_name
order by avg_rating desc
limit 1;

-- 10. Which day of the week has the best average ratings per branch?
Select Branch, dayname(date) as Day_name, round(Avg(rating),2) as Avg_rating from Walmart_salesdata
group by branch, Day_name
order by avg_rating desc
limit 1;

