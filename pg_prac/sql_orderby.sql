CREATE TABLE people (
id INT PRIMARY KEY,
first_name TEXT NOT NULL,
last_name TEXT NOT NULL,
age INT,
price NUMERIC(10,2),
quantity INT,
status TEXT,
category TEXT,
created_at TIMESTAMPTZ NOT NULL
);


INSERT INTO people (id, first_name, last_name, age, price, quantity, status, category, created_at) VALUES
(1, 'Alice', 'Zimmer', 30, 19.99, 2, 'normal', 'A', '2024-01-01T09:00:00Z'),
(2, 'alice', 'zimmer', 22, 19.99, 5, 'high', 'A', '2024-01-02T10:00:00Z'),
(3, 'Álvaro', 'Núñez', 35, 5.00, 20,'urgent', 'B', '2024-01-03T11:00:00Z'),
(4, 'Bob', 'Anderson', 40, NULL, NULL, NULL, 'B', '2024-01-04T12:00:00Z'),
(5, 'BOB', 'anderson', NULL,29.95, 1, 'normal','B', '2024-01-05T13:00:00Z'),
(6, 'Chloé', 'Brontë', 28, 10.00, 10,'high', 'C', '2024-01-06T14:00:00Z'),
(7, 'Chloe', 'Bronte', 28, 10.00, 10,'urgent', 'C', '2024-01-07T15:00:00Z'),
(8, 'Dmitri', 'Ivanov', 31, 100.00, 0, 'normal','C', '2024-01-08T16:00:00Z'),
(9, 'Émile', 'Zola', 52, 1.00, 100,'high', 'D', '2024-01-09T17:00:00Z'),
(10, 'Emile', 'Zola', 52, 1.00, 90, 'normal','D', '2024-01-10T18:00:00Z'),
(11, 'Fatima', 'al-Zahra', 26, 7.77, 13, 'urgent','D', '2024-01-11T19:00:00Z'),
(12, 'George', 'O’Malley', 33, 15.50, 3, NULL, 'E', '2024-01-12T20:00:00Z'),
(13, 'Hélène', 'D’Arcy', NULL,50.00, 2, 'high', 'E', '2024-01-13T21:00:00Z'),
(14, 'Helene', 'DArcy', 29, 50.00, 2, 'normal','E', '2024-01-14T22:00:00Z'),
(15, 'Ivan', 'Petrov', 41, 99.99, 1, 'urgent','F', '2024-01-15T23:00:00Z'),
(16, 'Ivy', 'petrov', 41, 0.00, 100,'normal','F', '2024-01-16T09:00:00Z'),
(17, 'José', 'García', 34, 12.34, 4, 'high', 'F', '2024-01-17T09:30:00Z'),
(18, 'Jose', 'Garcia', 34, 12.34, 4, NULL, 'G', '2024-01-18T10:00:00Z'),
(19, 'Lars', 'Ångström', NULL,8.88, 11, 'normal','G', '2024-01-19T11:00:00Z'),
(20, 'Márta', 'Németh', 25, 3.33, NULL,'urgent','G', '2024-01-20T12:00:00Z'),
(21, 'Marta', 'Nemeth', 25, 3.33, 1, 'high', 'H', '2024-01-21T13:00:00Z'),
(22, 'Zoë', 'Quinn', 19, 200.00, 1, 'normal','H', '2024-01-22T14:00:00Z');




select * from people;

INSERT INTO people (id, first_name, last_name, age, price, quantity, status, category, created_at) VALUES
(1001,'Alice','Zimmer',NULL,25.00, NULL,'high', 'B','2024-02-01T09:00:00Z'),
(1002,'alice','zimmer',27, NULL, 3, NULL, 'C','2024-02-02T10:10:00Z'),
(1003,'Álvaro','Núñez',NULL,7.50, 5, 'normal', 'A','2024-02-03T11:20:00Z'),
(1004,'Bob','Anderson',38, 12.00, NULL,'urgent','C','2024-02-04T12:30:00Z'),
(1005,'BOB','anderson',42, NULL, 2, 'high', 'D','2024-02-05T13:40:00Z'),
(1006,'Chloé','Brontë',NULL, 9.99, 1, 'normal', 'E','2024-02-06T14:50:00Z'),
(1007,'Chloe','Bronte',31, NULL, NULL,'high', 'E','2024-02-07T15:55:00Z'),
(1008,'Dmitri','Ivanov',NULL,120.00,2, NULL, 'F','2024-02-08T16:05:00Z'),
(1009,'Émile','Zola', 50, NULL, 80, 'urgent', 'A','2024-02-09T17:15:00Z'),
(1010,'Emile','Zola', NULL, 2.00, NULL,'high', 'B','2024-02-10T18:25:00Z'),
(1011,'Fatima','al-Zahra',NULL,6.66, 10, 'normal', 'G','2024-02-11T19:35:00Z'),
(1012,'George','O’Malley',35, NULL, 4, 'urgent','H','2024-02-12T20:45:00Z'),
(1013,'Hélène','D’Arcy',27, NULL, NULL,'normal','A','2024-02-13T21:55:00Z'),
(1014,'Helene','DArcy', NULL, 55.00, 3, NULL, 'C','2024-02-14T22:05:00Z'),
(1015,'Ivan','Petrov', 39, NULL, 2, 'high', 'D','2024-02-15T23:15:00Z'),
(1016,'Ivy','petrov', NULL, 1.00, NULL,'urgent','E','2024-02-16T09:05:00Z'),
(1017,'José','García', NULL, 14.00, 6, NULL, 'F','2024-02-17T09:35:00Z'),
(1018,'Jose','Garcia', 36, NULL, 5, 'normal','G','2024-02-18T10:10:00Z'),
(1019,'Lars','Ångström',35, 9.99, NULL,'high', 'H','2024-02-19T11:20:00Z'),
(1020,'Márta','Németh', NULL, NULL, 2, 'normal','A','2024-02-20T12:30:00Z'),
(1021,'Marta','Nemeth', 26, 4.44, NULL,'urgent','B','2024-02-21T13:40:00Z');

create index sort_indx on people(price desc nulls last , first_name desc nulls last , last_name desc nulls last , quantity desc nulls last); 
-- same btree can be trav for/back so no asc needed ( btree datastruct used for indexing) 

select * from people;

select price,quantity,first_name from people order by price;
select people.first_name,people.last_name , price from people order by last_name ,price desc; -- case insent & accent insent
select people.last_name, people.first_name from people order by last_name , first_name desc;

SELECT first_name, last_name, age, price, quantity, status, category, created_at
FROM people
WHERE last_name IN ('Anderson','anderson')
ORDER BY last_name, first_name DESC;

SELECT first_name, last_name, age, price, quantity, status, category, created_at
FROM people
WHERE last_name IN ('Anderson','anderson')
ORDER BY last_name; -- SAME AS ABOVE

-- case insent & accent insent so price becomes sole sorting identity
-- How to keep the “name grouping” stable and still sort by price
-- Add a stable, final tiebreaker (id). This makes results deterministic:
-- ORDER BY last_name DESC, first_name DESC, price DESC, id ASC
select first_name , last_name , price , id from people order by 2 desc ;
select first_name , last_name , price , id from people order by 2 desc ,  1 desc ;
select first_name , last_name , price , id from people order by 2 desc ,  1 desc , 3 desc ;
select first_name , last_name , price , id from people order by 2 desc ,  1 desc , 3 desc , 4 ;
select first_name , last_name , price , id from people order by 2 desc ,  1 desc , 3 desc , 4 desc;


select price*quantity as total_cost , first_name , last_name , price , id from people order by total_cost desc;
select first_name , last_name , price , id from people order by price*quantity desc;


select price , quantity from people order by quantity desc nulls last;
select price , quantity from people order by quantity desc nulls first;


select * from pg_collation;
select first_name from people order by first_name;
select first_name from people order by first_name collate "en_AG" desc ;

SHOW lc_collate;   -- collation
SHOW lc_ctype;     -- character classification

select first_name from people order by first_name collate "C";

select * from 
		( select price , first_name from people
		order by price desc 
		nulls last fetch first 6 rows only) 
as top_prod order by first_name;

SELECT id, first_name
FROM people
ORDER BY first_name desc
fetch first 10 rows only OFFSET 5;

SELECT id, first_name
FROM people
ORDER BY first_name desc
fetch first 20 rows only;


select * from people order by random();

select first_name , last_name ,status from people
    order by case status
    when 'urgent' then 1
    when 'high' then 2
    when 'normal' then 3
    else 4
end;

select first_name , last_name , status 
	from people 
order by array_position(array['urgent','high','normal'],status); 


select first_name , last_name , status 
	from people 
order by array_position(array['urgent','high','normal'],status) nulls first; 


