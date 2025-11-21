----------------------Join Qustions----------------

---Find customers who have NEVER placed any order.

select * from customers_join c
left join orders_join o on c.CustomerID = o.CustomerID
where o.CustomerID is null

---- Find the total sales per city but only for delivered orders.

select City,SUM(Amount) as total_sale from orders_join o
left join customers_join c on o.CustomerID = c.CustomerID
where Status = 'Delivered'
group by City

----Find customers with more than 1 delivered order.

select CustomerName,count(OrderID) as Total_orders from customers_join c
join orders_join o on c.CustomerID = o.CustomerID
group by CustomerName
having count(OrderID) > 1 

-----Find the latest order for each customer.

select CustomerName,MAX(OrderDate) as latest_date from customers_join c
join orders_join o on c.CustomerID = o.CustomerID
group by CustomerName

----Show customers with their order count and total amount spent.

select CustomerName,count(OrderID) as Total_orders,SUM(Amount) as Total_Sale from orders_join o 
join customers_join c on o.CustomerID =c.CustomerID
where o.Status = 'Delivered'
group by CustomerName

-------Find customers who placed orders ONLY in January and no other month.
select DISTINCT c.CustomerName from orders_join o 
join customers_join c on o.CustomerID = c.CustomerID
where MONTH(OrderDate) = 1

----List customers whose highest order amount is greater than the average order amount of ALL customers.

select CustomerName,MAX(Amount) as HIghest_amount from customers_join c 
join orders_join o on c.CustomerID = o.CustomerID
group by CustomerName
having MAX(Amount) > (select avg(Amount) from orders_join where Status = 'Delivered')

--Find the city with the highest total sales amount.

select top 1 City,sum(Amount) as HIghest_amount from customers_join c 
join orders_join o on c.CustomerID = o.CustomerID
group by City
order by sum(Amount) desc

--Show customers who placed at least 1 order after a cancelled order.

SELECT 
    c.CustomerName
FROM customers_join c
JOIN orders_join o 
    ON c.CustomerID = o.CustomerID
GROUP BY 
    c.CustomerName
HAVING 
    MAX(CASE WHEN o.Status = 'Cancelled' THEN o.OrderDate END) 
        < 
    MAX(CASE WHEN o.Status <> 'Cancelled' THEN o.OrderDate END);

------Show a customer summary table with:

-----Total orders
-----
-----Delivered orders
-----
-----Cancelled orders
-----
-----Pending orders
-----
-----Total sales

select CustomerName,
sum(Case when Status = 'Cancelled' then 1 else 0 end) as cancelled_orders,
sum(Case when Status = 'Delivered' then 1 else 0 end) as deliverd_orders,
sum(Case when Status = 'Pending' then 1 else 0 end) as Pending_orders,
sum(Case when Status = 'Delivered' then Amount else 0 end) as deliverd_orders
from customers_join c
join orders_join o on o.CustomerID = c.CustomerID
group by CustomerName





