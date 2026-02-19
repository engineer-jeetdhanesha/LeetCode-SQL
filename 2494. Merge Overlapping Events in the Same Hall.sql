with cte as (
    select 
        *, 
        max(end_day) over(
            partition by hall_id 
            order by start_day asc 
            rows between unbounded preceding and 1 preceding
        ) as max_end_day
    from HallEvents 
), cte2 as (
select 
    *, 
    sum(case when start_day > max_end_day then 1 else 0 end) over(partition by hall_id order by start_day asc) as grp_id
from cte
)   

select 
    hall_id, 
    -- grp_id, 
    min(start_day) as start_day, 
    max(end_day) as end_day
from cte2 
group by hall_id, grp_id

