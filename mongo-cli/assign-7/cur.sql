create table div_a(
	roll int,
	name varchar2(255),
	class varchar2(255)
);

create table div_b(
	roll int,
	name varchar2(255),
	class varchar2(255)
);
INSERT INTO div_b VALUES(1, 'Alice',  'Comp 1');
INSERT INTO div_b VALUES(2, 'Bob',    'Comp 2');
INSERT INTO div_b VALUES(3, 'Carol',  'Comp 3');
INSERT INTO div_b VALUES(4, 'Dina',   'Comp 1');
INSERT INTO div_b VALUES(5, 'Eve',    'Comp 2');
INSERT INTO div_b VALUES(6, 'Gundeti','Comp 3');
INSERT INTO div_b VALUES(7, 'Kalas',  'Comp 2');

-- div_a starts with subset
INSERT INTO div_a VALUES(1, 'Alice', 'Comp 1');
INSERT INTO div_a VALUES(2, 'Bob',   'Comp 2');
INSERT INTO div_a VALUES(3, 'Carol', 'Comp 3');
INSERT INTO div_a VALUES(4, 'Dina',  'Comp 1');
INSERT INTO div_a VALUES(5, 'Eve',   'Comp 2');
-- EXPLICIT
commit;
DECLARE 
	p_roll int;
	p_name varchar2(255);
	p_class varchar2(255);
	cursor cc1 is select * from div_b where roll not in (select roll from div_a);

	BEGIN 
		open cc1;
			loop
				fetch cc1 into p_roll , p_name , p_class;
				exit when cc1%notfound;
				insert into div_a values(p_roll , p_name , p_class);
				DBMS_OUTPUT.PUT_LINE(p_name || ' ' || p_rollno || ' ' || p_class);
			end loop;
		close cc1;
		commit;
	END;
	/


DECLARE 
	p_roll int;
	p_name varchar2(255);
	p_class varchar2(255);
	cursor cc1(roll1 int) is select * from div_a where roll > roll1;

	BEGIN 
		open cc1(3);
			loop
				fetch cc1 into p_roll , p_name , p_class;
				exit when cc1%notfound;
				DBMS_OUTPUT.PUT_LINE(p_name || ' ' || p_rollno || ' ' || p_class);
			end loop;
		close cc1;
	END;
	/



DECLARE 
	totalrows int;
	BEGIN 

			
				update div_a set roll = roll + 1;
				if sql%found then
					DBMS_OUTPUT.PUT_LINE(p_name || ' ' || p_rollno || ' ' || p_class);
					totalrows := sql%rowcount;
					DBMS_OUTPUT.PUT_LINE(totalrows);
				elsif sql%notfound then
					DBMS_OUTPUT.PUT_LINE('NTG FOUND');
				end if;
			
	
	END;
	/



DECLARE 
	cursor cc1 is select roll , name , class from div_a;

	BEGIN 
		
				for rec in cc1 
					loop
						DBMS_OUTPUT.PUT_LINE(rec.name || ' ' || rec.rollno || ' ' || rec.class);
					end loop;
		
	END;
	/

merge into div_b tgt
using (select roll , name , class from div_a) src
on tgt.roll = src.roll
when matched then
	update set tgt.class = src.class , tgt.name = src.name
when not matched then
	insert into div_b values(src.roll,src.name,src.class);
commit;

select * from div_a;
select * from div_b;

