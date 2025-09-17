create table Stud_Marks(name nvarchar(20) , total_marks number(4,2));
create table Result(roll number(3) , name nvarchar(20) , class varchar(30));
insert into Stud_Marks(name,total_marks) 
	values('Sahil' , 900) ,
	('David' , 1300),
	('Priya' , 1500),
	('Krishna' , 800);


set serveroutput on;

create procedure proc_Grade(p_roll IN number(3),
			     p_name in nvarchar(20)
			     p_total in number(4,2))
		
as 
	p_class varchar2(20);
	
BEGIN 
	IF p_total between 1500 and 990
		then p_class:='Distinction Class';
	ELSIF p_total between 989 and 900
		then p_class:='First Class';
	ELSIF p_total between 899 and 825
		then p_class:='Higher-Second Class';
	ELSE p_class:='No Class';
	END IF;
	
	INSERT INTO Result(roll,name,class) 
		values(p_roll , p_name , p_class);
END;

declare
	v_roll:=101
begin
	for rec in (select name,total from Stud_Marks)
		proc_Grade(v_roll,rec.name,rec.total)
		v_roll:=v_roll+1;
	END loop;
	
	select * from Result;
END;


	
  
