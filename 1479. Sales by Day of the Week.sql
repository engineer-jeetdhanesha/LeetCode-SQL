with item_catg_count as (
select 
    I.item_category, 
    dayname(O.order_date) as week_day, 
    sum(O.quantity) as qty
from Items I 
left join Orders O 
on I.item_id = O.item_id 
group by I.item_category, dayname(O.order_date)
)

select 
    item_category as CATEGORY, 
    sum(case when week_day = 'Monday' then qty else 0 end) as MONDAY,
    sum(case when week_day = 'Tuesday' then qty else 0 end) as TUESDAY,
    sum(case when week_day = 'Wednesday' then qty else 0 end) as WEDNESDAY,
    sum(case when week_day = 'Thursday' then qty else 0 end) as THURSDAY,
    sum(case when week_day = 'Friday' then qty else 0 end) as FRIDAY,
    sum(case when week_day = 'Saturday' then qty else 0 end) as SATURDAY,
    sum(case when week_day = 'Sunday' then qty else 0 end) as SUNDAY
from item_catg_count 
group by item_category
order by item_category ASC
