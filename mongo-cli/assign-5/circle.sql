create table areas(
	radius number(4,3),
	area number(4,3)
);


set serveroutput on;


DECLARE 

	p_radius number(4,3):=6.145;
	p_area number(8,3);
	nodata EXCEPTION;
	pserr EXCEPTION;

BEGIN

	if p_radius is null then
		raise nodata;
	elsif p_radius not between 5 and 9 then
		raise pserr;
	end if;

	p_area := 3.14 * p_radius * p_radius;

	insert into areas(radius,area) values(p_radius , p_area);

	DBMS_OUTPUT.PUT_LINE('Area of ' || p_radius || ' radius is ' || p_area);

EXCEPTION 

	when nodata then
		DBMS_OUTPUT.PUT_LINE('NO DATA GIVEN');
	when pserr then
		DBMS_OUTPUT.PUT_LINE('RADIUS NOT BETWEEN 5 & 9');
	when OTHERS then DBMS_OUTPUT.PUT_LINE('UNEXPECTED DATA ' || SQLERRM);

END;
/

select * from areas;
		


