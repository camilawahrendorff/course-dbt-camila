# WEEK 1 
# Questions
## How many users do we have?
```
dbt=# select count(distinct user_id) from dbt_camila_dw.stg_users;
 count 
-------
   130
(1 row)
```
## On average, how many orders do we receive per hour?
```
dbt=# with time as (
dbt(# select date_part('hour',created_at) as receive_at,
dbt(# count(distinct order_id) as n_orders
dbt(# from orders group by 1)
dbt-# select avg(n_orders) from time;
         avg         
---------------------
 16.0000000000000000
```
## On average, how long does an order take from being placed to being delivered?
```
dbt=# with diff as (
dbt(# select date_part('day',  delivered_at -  created_at) * 24 + date_part('hour', delivered_at - created_at) as time_to_deliver
dbt(# from public.orders)  
dbt-# 
dbt-# select ROUND(avg(time_to_deliver)) as avg_time_to_deliver_in_hours
dbt-# from diff;
 avg_time_to_deliver_in_hours 
------------------------------
                           94
(1 row)
```
## How many users have only made one purchase? Two purchases? Three+ purchases?
```
dbt=# with amount as (
dbt(# select 
dbt(# user_id, 
dbt(# count(distinct order_id) as amount_of_orders
dbt(# from orders 
dbt(# group by 1)
dbt-# select 
dbt-# sum(case when amount_of_orders = 1 then 1 else 0 end) as c_1_purchase,
dbt-# sum(case when amount_of_orders = 2 then 1 else 0 end) as c_2_purchases,
dbt-# sum(case when amount_of_orders >= 3 then 1 else 0 end) as more_than_3_purchases
dbt-# from amount;
 c_1_purchase | c_2_purchases | more_than_3_purchases 
--------------+---------------+-----------------------
           25 |            22 |                    81
(1 row)
```
## On average, how many unique sessions do we have per hour?
```
dbt=# with sessions_per_hour as (
dbt(# select  
dbt(# date_part('hour',created_at) as hour_of_event, 
dbt(# count(distinct session_id) as amount_of_sessions 
dbt(# from events group by 1)
dbt-# 
dbt-# select avg(amount_of_sessions) as avg_sessions_per_hour
dbt-# from sessions_per_hour;
 avg_sessions_per_hour 
-----------------------
  120.5600000000000000
(1 row)
```

# Week two 
# Questions 
## What is our user repeat rate?
```
dbt=# select sum(case when number_of_orders > 1 then 1 else 0 end)/sum(case when number_of_orders > 0 then 1 else 0 end)::decimal(32,2)*100 from dbt_camila_dw.users_purchase;
        ?column?         
-------------------------
 80.46875000000000000000
(1 row)

```
## What are good indicators of a user who will likely purchase again? What about indicators of users who are likely NOT to purchase again? If you had more data, what features would you want to look into to answer this question?

. Average time between purchases 
. Frequency of purchase
. Website engagement 

## Explain the marts models you added. Why did you organize the models in the way you did?

. Core: Models that are useful for the entire company 
. Marketing: Models that are useful mainly for marketing
. Product:  Models that are useful mainly for product

![dbt-dag](https://user-images.githubusercontent.com/94656689/144169369-1a7b685a-61dd-4cd7-8bd3-785ea307abbb.png)
