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

## What assumptions are you making about each model? (i.e. why are you adding each test?)

1- Unique 
2- Not null
## Did you find any “bad” data as you added and ran tests on your models? How did you go about either cleaning the data in the dbt model or adjusting your assumptions/tests?

1- Some order items are null 

# Week Three
# Questions
## What is our overall conversion rate?
```
dbt=# with base as (select count(distinct CASE WHEN is_converted then session_id end) as converted, count(distinct session_id) as total_sessions from dbt_camila_dw_marts.fct_conversion) select converted/total_sessions::decimal(32,2)*100 from base;
        ?column?         
-------------------------
 36.10108303249097472900
(1 row)
```
## What is our conversion rate by product?
```
dbt=# with base as (select product_name, count(distinct CASE WHEN is_converted='t' then session_id end) as converted, count(distinct session_id) as total_sessions from dbt_camila_dw_marts.fct_page_engagement group by 1) select product_name, (converted/total_sessions::decimal(32,2)*100) as conv_rate from base;
    product_name     |        conv_rate        
---------------------+-------------------------
 Alocasia Polly      | 32.86384976525821596200
 Aloe Vera           | 35.90604026845637583900
 Angel Wings Begonia | 35.96059113300492610800
 Arrow Head          | 35.44303797468354430400
 Bamboo              | 35.56149732620320855600
 Bird of Paradise    | 35.19163763066202090600
 Birds Nest Fern     | 34.12462908011869436200
 Boston Fern         | 34.67741935483870967700
 Cactus              | 35.31250000000000000000
 Calathea Makoyana   | 35.34482758620689655200
 Devil's Ivy         | 35.74144486692015209100
 Dragon Tree         | 35.23809523809523809500
 Ficus               | 35.33123028391167192400
 Fiddle Leaf Fig     | 35.60606060606060606100
 Jade Plant          | 35.00000000000000000000
 Majesty Palm        | 35.17241379310344827600
 Money Tree          | 34.79853479853479853500
 Monstera            | 35.85657370517928286900
 Orchid              | 34.29394812680115273800
 Peace Lily          | 34.26294820717131474100
 Philodendron        | 37.17472118959107806700
 Pilea Peperomioides | 36.02693602693602693600
 Pink Anthurium      | 35.15625000000000000000
 Ponytail Palm       | 34.47098976109215017100
 Pothos              | 35.62753036437246963600
 Rubber Plant        | 35.61643835616438356200
 Snake Plant         | 37.45318352059925093600
 Spider Plant        | 36.19402985074626865700
 String of pearls    | 36.88524590163934426200
 ZZ Plant            | 36.07594936708860759500
                     | 34.35754189944134078200
(31 rows)
```