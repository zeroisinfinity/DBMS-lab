create table stud(
	roll int,
	name varchar2(255),
	marks int,
	primary key(roll)
);

create table result(
	roll int,
	name varchar2(255),
	grade varchar2(255),
	foreign key(roll) references stud(roll)
);


INSERT INTO stud VALUES (1, 'Kshitij', 1200);  -- Distinction (990-1500)
INSERT INTO stud VALUES (2, 'Kalas',    950);  -- First Class (900-989)
INSERT INTO stud VALUES (3, 'Himanshu', 860);  -- Higher Second Class (825-899)
INSERT INTO stud VALUES (4, 'MEPA',     700);  -- Fail
INSERT INTO stud VALUES (5, 'Macho',   1000);  -- Distinction (borderline)
-- (then)
-- COMMIT;   -- optional, see policy below
set serveroutput on;

CREATE OR REPLACE FUNCTION cal_grade(f_roll in int)
	return varchar2
	as

	f_grade varchar2(255);
	f_marks int;

	BEGIN
		select marks into f_marks from stud where roll = f_roll;

		if f_marks between 990 and 1500 then
			f_grade := 'DISTINCTION';
		elsif f_marks between 900 and 989 then
			f_grade := 'FIRST CLASS';
		elsif f_marks between 825 and 899 then
			f_grade := 'HIGHER SECOND CLASS';
		else 
			f_grade := 'FAIL';
		end if;

		return f_grade;

	EXCEPTION 

		when NO_DATA_FOUND THEN
			return null;
		when OTHERS THEN
			return null;
	END cal_grade;
	/

CREATE OR REPLACE PROCEDURE cat(p_roll in int)
	AS
	p_grade varchar2(255);
	p_name varchar2(255);
	nodata EXCEPTION;
	no_grade EXCEPTION;

	BEGIN
		if p_roll is null or p_roll <= 0 then
			raise nodata;
		end if;

		p_grade := cal_grade(p_roll);

		if p_grade is null then
			raise no_grade;
		end if;

		select name into p_name from stud where roll = p_roll;

		insert into result(roll , name , grade) 
			values (p_roll , p_name , p_grade);
		commit;

	EXCEPTION 

		when nodata then
			DBMS_OUTPUT.PUT_LINE('no data');
		when no_grade then
			DBMS_OUTPUT.PUT_LINE('no grade');
		when OTHERS then
			DBMS_OUTPUT.PUT_LINE(SQLERRM);
			rollback;
	END cat;
	/

select cal_grade(1) from dual;
EXEC cat(1);
EXEC cat(2);
EXEC cat(3);
EXEC cat(4);
EXEC cat(5);
select * from result order by roll;



	




	
