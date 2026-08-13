drop database learning_platform;
create database learning_platform;
use learning_platform;

create table learnears(
learnears_id int primary key,
learnears_name varchar(100) not null,
country_name varchar(100)
);

create table courses(
courses_id int primary key,
courses_name varchar(100) not null,
category varchar(100),
unit_price decimal(10,2)
);

create table purchases(
purchases_id int primary key,
learnears_id int, 
courses_id int,
quantity int,
purchases_date date,

foreign key (learnears_id) references learnears(learnears_id),
foreign key (courses_id) references courses(courses_id)
);

insert into learnears values
(01,'anith','INDIA'),
(02,'arun','USA'),
(03,'kavya','INDIA'),
(04,'john','LONDAN'),
(05,'anu','INDIA');


insert into courses values
(001,'digital marketing','marketing',5999),
(002,'full stack course','programming',9999),
(003,'power bi quary','data analytics',6999),
(004,'python','programming',9999),
(005,'excel advanced','productivity',3999),
(006,'sql advanced','data analytics',5999);


insert into purchases values
(1001,01,001,1,'2025-02-12'),
(1002,01,002,1,'2025-02-11'),
(1003,02,003,1,'2025-02-17'),
(1004,02,005,1,'2025-02-19'),
(1005,03,004,1,'2025-02-25'),
(1006,04,005,1,'2025-02-26'),
(1007,05,005,0,'2025-03-01'),
(1008,05,001,1,'2025-03-03');
select * from learnears;
select * from courses;
select * from purchases;
select
l.learnears_id,
c.courses_id,
p.purchases_id,
p.quantity,
p.purchases_date,
format (p.quantity * c.unit_price,2) as total_price
from learnears l
inner join purchases p
on l.learnears_id= p.learnears_id
inner join courses c
on c.courses_id= p.courses_id
order by (p.quantity * c.unit_price) desc;

select
l.learnears_id,
c.courses_id,
p.purchases_id,
p.quantity,
p.purchases_date,
format(p.quantity * c.unit_price,2) as total_price
from learnears l
left join purchases p
on l.learnears_id = p.learnears_id
left join courses c
on c.courses_id = p.courses_id
order by (p.quantity * c.unit_price) desc;

select
l.learnears_id,
c.courses_id,
p.purchases_id,
p.quantity,
p.purchases_date,
format(p.quantity * c.unit_price,2) as total_price
from learnears l
right join purchases p
on l.learnears_id = p.learnears_id
right join courses c
on c.courses_id = p.courses_id
order by (p.quantity * c.unit_price) desc;

select
l.learnears_id,
l.learnears_name,
l.country_name,
format(sum(p.quantity * c.unit_price) ,2) as total_spending
from learnears l
inner join purchases p
on l.learnears_id=p.learnears_id
inner join courses c
on c.courses_id= p.courses_id
group by
l.learnears_id,
l.learnears_name,
l.country_name
order by total_spending desc;

select
c.courses_id,
c.courses_name,
sum(p.quantity ) as total_quantity
from courses c
inner join purchases p
on c.courses_id= p.courses_id
group by
c.courses_id,
c.courses_name
order by total_quantity desc
limit 3;


select
c.category,
format(sum(p.quantity * c.unit_price), 2) as total_revenue,
count(distinct(p.learnears_id)) as unique_learnears
from courses c
inner join purchases p
on c.courses_id =p.courses_id
group by c.category
order by(sum(p.quantity * c.unit_price)) desc;


select
l.learnears_id,
l.learnears_name
from learnears l
inner join purchases p
on l.learnears_id= p.learnears_id
inner join courses c
on p.courses_id= c.courses_id
group by
l.learnears_id,l.learnears_name
having count(distinct c.courses_id)>1;

select
c.courses_id,
c.courses_name,
c.category
from courses c
inner join purchases p
on c.courses_id= p.courses_id
where p.courses_id is null;

select 
l.learnears_id,
l.learnears_name,
SUM(p.quantity * c.unit_price) AS total_spending
from learnears l
join purchases p 
on l.learnears_id = p.learnears_id
join courses c 
on p.courses_id = c.courses_id
group by l.learnears_id, l.learnears_name
having sun(p.quantity * c.unit_price) > (
select avg(total_spending)
from
(
select sum(p2.quantity * c2.unit_price) AS total_spending
from purchases p2
join courses c2 
on p2.courses_id = c2.courses_id
group by p2.learnears_id
) as learnears_spending
);

select *
from courses
where unit_price > any (
select unit_price
from  courses
where category ='beginners'
);

select 
    l.learnears_id,
    l.learnears_name,
    l.country_name,
    SUM(p.quantity * c.unit_price) AS total_spending
from learnears l
join purchases p
    on l.learnears_id = p.learnears_id
join courses c
    ON p.courses_id = c.courses_id
group by l.learnears_id, l.learnears_name, l.country_name
having SUM(p.quantity * c.unit_price) > (
    select avg(country_spending)
    from(
        select
            l2.learnears_id,
            l2.country_name,
            sum(p2.quantity * c2.unit_price) AS country_spending
        from learnears l2
        join purchases p2
            on l2.learnears_id = p2.learnears_id
        join courses c2
            on p2.courses_id = c2.courses_id
        where l2.country_name = l.country_name
        group byl2.learnears_id, l2.country_name
    ) as country_avg
);

with learnears_spending as(
select 
l.learnears_name,
l.learnears_id,
sum(p.quantity * c.unit_price) as total_spending
from learnears l
join purchases p
on l.learnears_id =p.learnears_id
join courses c
on c.courses_id= p.courses_id
group by
learnears_id,
learnears_name
)
select
learnears_id,
learnears_name,
total_spending
from learnears_spending
where total_spending >10000;

WITH learnears_spending AS (
    SELECT
        l.learnears_id,
        l.learnears_name,
        SUM(p.quantity * c.unit_price) AS total_spending
    FROM learnears l
    JOIN purchases p
        ON l.learnears_id = p.learnears_id
    JOIN courses c
        ON p.courses_id = c.courses_id
    GROUP BY
        l.learnears_id,
        l.learnears_name
)
SELECT
    learnears_id,
    learnears_name,
    total_spending,
    CASE
        WHEN total_spending > 15000 THEN 'High Value'
        WHEN total_spending BETWEEN 8000 AND 15000 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS learner_category
FROM learnears_spending;

select
    c.courses_id,
    c.courses_name,
    ifnull(count(p.purchases_id), 0) AS purchase_count
from courses c
left join purchases p
    ON c.courses_id = p.courses_id
group by
    c.courses_id,
    c.courses_name;
    
create view category_performance_view AS
select
    c.category,
    SUM(p.quantity * c.unit_price) AS total_revenue,
    COUNT(p.purchases_id) AS number_of_purchases,
    AVG(p.quantity * c.unit_price) AS average_revenue_per_purchase
from courses c
join purchases p
    ON c.courses_id = p.courses_id
group by c.category;
select * from category_performance_view;




