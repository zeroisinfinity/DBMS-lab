show databases;
show tables;
use DDL;
with cte as (select passing,passing+100 as new_passing from exam) select new_passing from cte where new_passing > 112;
select marks , marks - 10000 as marks from exam;
create table emp_details(empid int,empname varchar(20),empdept varchar(20),sal float,joining date,shift time,project datetime);
INSERT INTO emp_details (empid, empname, empdept, sal, joining, shift, project)
VALUES 
(1, 'John Doe', 'IT', 55000.50, '2023-01-15', '09:00:00', '2023-01-15 09:00:00'),
(2, 'Jane Smith', 'HR', 60000.75, '2023-02-10', '10:00:00', '2023-02-10 10:00:00'),
(3, 'Alice Johnson', 'Finance', 70000.00, '2022-07-20', '08:30:00', '2022-07-20 08:30:00'),
(4, 'Bob Brown', 'Marketing', 65000.25, '2023-03-05', '09:30:00', '2023-03-05 09:30:00'),
(5, 'Charlie Davis', 'Operations', 72000.10, '2022-08-12', '11:00:00', '2022-08-12 11:00:00'),
(6, 'David Lee', 'IT', 58000.40, '2023-01-20', '08:00:00', '2023-01-20 08:00:00'),
(7, 'Eve Parker', 'HR', 62000.55, '2022-10-18', '10:30:00', '2022-10-18 10:30:00'),
(8, 'Frank King', 'Finance', 71000.30, '2022-05-22', '09:15:00', '2022-05-22 09:15:00'),
(9, 'Grace Hall', 'Marketing', 68000.75, '2023-02-15', '07:45:00', '2023-02-15 07:45:00'),
(10, 'Hank Scott', 'Operations', 75000.80, '2022-12-05', '06:30:00', '2022-12-05 06:30:00'),
(11, 'Ivy Adams', 'IT', 53000.25, '2023-03-10', '08:00:00', '2023-03-10 08:00:00'),
(12, 'Jackie Mills', 'HR', 65000.40, '2023-01-25', '10:15:00', '2023-01-25 10:15:00'),
(13, 'Liam White', 'Finance', 69000.50, '2022-11-18', '09:30:00', '2022-11-18 09:30:00'),
(14, 'Mona Green', 'Marketing', 67000.60, '2023-02-20', '07:00:00', '2023-02-20 07:00:00'),
(15, 'Nina Black', 'Operations', 74000.90, '2022-08-17', '11:30:00', '2022-08-17 11:30:00'),
(16, 'Oscar Brown', 'IT', 56000.20, '2023-02-01', '09:00:00', '2023-02-01 09:00:00'),
(17, 'Paula Grey', 'HR', 62000.65, '2022-06-13', '10:00:00', '2022-06-13 10:00:00'),
(18, 'Quincy Red', 'Finance', 70000.10, '2023-03-07', '08:30:00', '2023-03-07 08:30:00'),
(19, 'Rachel Blue', 'Marketing', 69000.00, '2023-01-30', '09:15:00', '2023-01-30 09:15:00'),
(20, 'Steve Yellow', 'Operations', 72000.55, '2022-12-25', '10:45:00', '2022-12-25 10:45:00');

        
select * from null_test;
select * from null_test where Manager is not null;

create table cognizant(id int,name varchar(30),role varchar(20),sal float,joining datetime);
insert into cognizant(id,sal)
	values(101,234565),
    (102,1234569),
    (103,09876543);
desc cognizant;
select * from cognizant;
select * from cognizant where sal>334567 and name is null;













