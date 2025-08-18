```plsql
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

set serveroutout on;
declare 
	msg varchar2(20):='Good morning';
	dept varchar2(10):='computer';
	desg varchar2(10):='HR';
	salary number(8,2):= 980000.89;

begin 
	dbms_output.put_line(
    		            msg || ' ' || desg || ' from dept ' || dept || ' with salary of ' || salary || chr(10) || 'How are you?'
			);

	
end;	


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

set serveroutout on;
declare 
	num1 integer:=24;
	num2 integer:=56;
	num3 real;
	num4 integer;

begin 
	num4 := num1+num2 ;
	num3 := 8798.999/56.3445;
	dbms_output.put_line(
				'num4 is :- ' || ' ' || num4
			);
       dbms_output.put_line(
				'num3 is :- ' || ' ' || num3
			);
			
end;	

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

set serveroutout on;
declare 
	var_salary number(6):=679869;
	empid number(3):=101;
	
begin 
	select salary into var_salary from emp where emp_id = empid;
	dbms_output.put_line(
				'Employee with id ' || empid || ' has salary of ' || var_salary);
			);
      
			
end;	

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

set serveroutput on;
declare  -- global
	num1 integer:=24;
	num2 integer:=56;
	num3 real;
	num4 integer;

begin 
	num4 := num1+num2 ;
	num3 := 8798.999/56.3445;
	dbms_output.put_line(
				'num4 is :- ' || ' ' || num4
			);
       dbms_output.put_line(
				'num3 is :- ' || ' ' || num3
			);
			

	declare  -- local
			num1 integer:=27;
			num2 integer:=50;
			num3 real;
			num4 integer;

	begin 
			num4 := num1+num2 ;
			num3 := 88.999/56.45;
			dbms_output.put_line(
				'num4 is :- ' || ' ' || num4
			);
       			dbms_output.put_line(
				'num3 is :- ' || ' ' || num3
			);
			
	end;	

end;	

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

set serveroutout on;
declare 
	pi constant number:=3.141592654;
	dia number(4,2);
	area number;
	rad number(4,2);
	circum number;

begin 
	dia:= 56.89;
	rad:=35.90;
	area:= 2*pi*rad*rad;
	circum:= pi*dia;
	dbms_output.put_line(
				'area is :- ' || ' ' || area
			);
       dbms_output.put_line(
				'circumference is :- ' || ' ' || circum
			);
			
end;	

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

set serveroutput on;
declare 
	a number(3):=557;

begin 
	if(23<a and a<78)
		then dbms_output.put_line('a is smaller than 78');
        ELSIF(150>a and a>78)
        	then dbms_output.put_line('a is smaller than 150');
	else
		dbms_output.put_line('a is greater than 150');
	end if;
end;	

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

set serveroutput on;
declare 
	grade char(1):='F';

begin 
	case grade
		when 'A' then dbms_output.put_line('Hurrah');
        	when 'B' then dbms_output.put_line('Not bad');
		when 'C' then dbms_output.put_line('Nice');
		else dbms_output.put_line('FAILED');
	end case;
end;	

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

set serveroutput on;

create or replace procedure marksheet(grade IN char(1) , marks OUT number(3) , credits IN OUT number(2))
	is
	
	begin 
		case grade
			when 'A' then marks:=500;
        		when 'B' then marks:=300;
			when 'C' then marks:=100;
			else marks:=50;
		end case;
		
		case marks
			when 500 then credits:=credits+44;
        		when 300 then credits:=credits+30;
			when 100 then credits:=credits+10;
			else credits:=credits+0;
		end case;
		
		dbms_output.put_line('Grade is '||grade);
		dbms_output.put_line('Marks are '||marks);
		dbms_output.put_line('credits are now '||credits);
	end;	
	
	
declare
	marks1 number(3);
	cred1 number(2):=44;
	marks2 number(3);
	cred2 number(2):=44;
	marks3 number(3);
	cred3 number(2):=44;
	marks4 number(3);
	cred4 number(2):=44;
begin 
	marksheet('F',marks1,cred1);
	marksheet('A',marks2,cred2);
	marksheet('B',marks3,cred3);
	marksheet('C',marks4,cred4);
end;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

set serveroutput on;


declare 
	rowss number;
begin 
	update emp set branch='Pune' where empid = 100;
	if sql%found 
	   then
		rowss:=sql%rowcount;
	        dbms_output.put_line('Successs in '||rowss||' rows');
	end if;
	if sql%notfound
		then dbms_output.put_line('not success');
	end if;
	
end;	

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

set serveroutput on;


declare 
	c_id cust.id%type;
	c_name cust.name%type;
	c_city cust.city%type;
	cursor custm is select id,name,city from cust;
	
begin 
	open custm;
	
	loop 
		fetch custm into c_id,c_name,c_city;
		exit when custm%notfound;
		dbms_output.put_line(c_id || ' ' || c_name || ' ' || c_city);
	end loop;
	close custm;
end;	

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

set serveroutput on;


declare 
	c_x cust%rowtype;
	cursor custm(no number) is select id,name,city from cust where id=no;
	
begin 
	open custm(5);
	
	loop
	 
		fetch custm into c_x;
		exit when custm%notfound;
		dbms_output.put_line(c_id || ' ' || c_name || ' ' || c_city);
	end loop;
	close custm;
end;	

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

create or replace trigger tgr 
	before
	insert on emp
	for each row
	
begin
	:new.ename := upper(:new.ename);
end;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

create or replace trigger tgr2 
	after 
	update of emp_id on emp
	for each statement
	referencing old as o new as n
begin
	dbms_output.put_line('IMPPPPP ID HAS BEEN CHANGED');
end;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

create or replace trigger tgr2 
	instead of 
	update of emp_id on emp
	for each row
	referencing old as o new as n
begin
	dbms_output.put_line('IMPPPPP ID HAS BEEN CHANGED');

end;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

```
