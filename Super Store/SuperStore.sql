SELECT Customer_Name, Customer_Segment 
FROM superstores.cust_dimen;

SELECT Customer_Name, Province, Region, Customer_Segment, Cust_id AS Cust_Information 
FROM superstores.cust_dimen 
ORDER BY Cust_Information DESC;

SELECT Order_ID, Order_Date 
FROM superstores.orders_dimen;

SELECT SUM(Sales) AS Total_Sales, avg(Sales) AS Avg_Sales 
FROM superstores.market_fact;

SELECT MIN(Sales) AS MIN_Sales, MAX(Sales) AS Max_Sales 
FROM superstores.market_fact;

SELECT Region, COUNT(*) AS No_of_Customers 
FROM superstores.cust_dimen 
GROUP BY Region 
ORDER BY No_of_Customers DESC;

SELECT Region, COUNT(*) AS No_of_Customers 
FROM superstores.cust_dimen 
GROUP BY Region 
ORDER BY No_of_Customers DESC LIMIT 1;

Select Customer_Name, Sum(Order_Quantity) as Total_of_Table_Purchase 
from superstores.market_fact M, superstores.cust_dimen C, superstores.prod_dimen P 
where M.Cust_id = C.Cust_id and M.Prod_id = P.Prod_id and P.Product_Sub_Category = 'TABLES' and C.Region= 'ATLANTIC' 
group by Customer_Name;

Select Customer_Name, COUNT(Customer_Segment) as No_of_Small_Business_Owners 
from superstores.cust_dimen C 
where C.Customer_Segment = 'SMALL BUSINESS' and C.Province= 'ONTARIO' 
group by Customer_Name;

SELECT Prod_id, SUM(Order_Quantity) No_of_Product_Sold 
from superstores.market_fact M 
where M.Prod_id <> M.Order_Quantity 
group by Prod_id 
Order By No_of_Product_Sold DESC;

SELECT Prod_id, Product_Sub_Category 
from superstores.prod_dimen P 
where P.Product_Category = 'FURNITURE' or 'TECHNOLOGY' 
group by Prod_id;

Select Product_Category, SUM(Profit) 
from superstores.prod_dimen P, superstores.market_fact M 
where P.Prod_id=M.Prod_id 
group by Product_Category 
order by Product_Category DESC;

SELECT Product_Category, Product_Sub_Category, SUM(Profit) 
from superstores.prod_dimen P, superstores.market_fact M 
where P.Prod_id=M.Prod_id 
group by Product_Category, Product_Sub_Category;

SELECT Order_Date, Order_Quantity, Count(Sales) 
from superstores.orders_dimen O, superstores.market_fact M 
Where O.Order_id<>O.Order_Date<>M.Sales 
group by Order_Date 
order by Order_Date;

Select Customer_Name 
from superstores.cust_dimen 
where Customer_Name 
Like '_R%' or '____D%';

SELECT Customer_Name, Region, Sum(Sales) 
from superstores.cust_dimen C, superstores.market_fact M 
where Sales 
between 1000 and 5000 
group by Region;

Select Max(Sales) as 3rd_Highest_sale 
from superstores.market_fact 
where Sales < (Select Max(Sales) 
from superstores.market_fact 
where Sales <> (Select Max(Sales) 
from superstores.market_fact));

select Region, count(*) as no_of_shipments, sum(Profit) as profit_in_each_Region 
from superstores.market_fact M, superstores.cust_dimen C, superstores.prod_dimen P 
where M.Cust_id = C.Cust_id and M.Prod_id = P.Prod_id and P.Product_Sub_Category = 'TABLES' 
group by Region 
order by profit_in_each_Region desc;