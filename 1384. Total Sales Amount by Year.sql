with all_years as (
    select 2018 as year
    union all 
    select 2019 as year
    union all
    select 2020 as year
), 

sales_flattened as (

select 
    S.product_id,
    P.product_name,
    S.period_start,
    S.period_end,
    year as current_year, 
    cast( concat(year, '-01-01') as date ) as current_year_start_date, 
    cast( concat(year, '-12-31') as date ) as current_year_end_date, 
    S.average_daily_sales 
from Sales S 
inner join all_years Y 
on Y.year >= year(S.period_start) and Y.year <= year(S.period_end)
inner join Product P 
on S.product_id = P.product_id
), sales_falttened_yearwise as (
select 
    *, 
    greatest(current_year_start_date, period_start) as year_start_date, 
    least(current_year_end_date, period_end) as year_end_date, 
    datediff(
        least(current_year_end_date, period_end), 
        greatest(current_year_start_date, period_start) 
    ) + 1 as num_of_days
from sales_flattened 


)

select 
    product_id, 
    product_name, 
    cast(current_year as char) as report_year, 
    sum(num_of_days * average_daily_sales) as total_amount 
from sales_falttened_yearwise 
group by 
    product_id, 
    product_name, 
    current_year
order by product_id, current_year



