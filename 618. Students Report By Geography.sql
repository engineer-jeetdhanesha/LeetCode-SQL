with students_america as (
    select 
        name, 
        row_number() over(order by name asc) as rnk
    from Student 
    where continent = 'America' 
), students_asia as (
    select 
        name, 
        row_number() over(order by name asc) as rnk
    from Student 
    where continent = 'Asia' 
), students_europe as (
    select 
        name, 
        row_number() over(order by name asc) as rnk
    from Student 
    where continent = 'Europe' 
)


select 
    america.name as America, 
    asia.name as Asia, 
    europe.name as Europe
from students_america america 
left join students_asia asia 
on america.rnk = asia.rnk 
left join students_europe europe 
on america.rnk = europe.rnk