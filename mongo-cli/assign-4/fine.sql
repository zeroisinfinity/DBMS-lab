create table Borrower(
	roll_no int,
	i_name varchar2(255),
	i_book varchar2(255),
	i_date date,
	stat varchar2(1),
	Primary key(roll_no)
);

create table Fine(
	roll_no int,
	r_date date,
	amt int,
	foreign key(roll_no) references Borrower(roll_no)
);

insert into Borrower(roll_no , i_name , i_book , i_date , stat) values( 41 , 'Sahil' , 'C++' , TO_DATE('12-11-2025','DD-MM-YYYY') , 'I' ),
								      ( 42 , 'Eyana' , 'TOC' , TO_DATE('09-10-2025','DD-MM-YYYY') , 'I' ),
								      ( 43 , 'Aarushi' , 'HTML' , TO_DATE('13-09-2025','DD-MM-YYYY') , 'I' ),
								      ( 44 , 'Priya' , 'JS' , TO_DATE('11-11-2025','DD-MM-YYYY') , 'I' );


set serveroutput on;
DECLARE
	p_roll int:=41 ;
	p_book varchar2(255):='C++';
	p_date date;
	p_amt int;
	p_totaldays int;
	nodata EXCEPTION;
	
BEGIN 
		if p_roll is null or p_roll <= 0 then 
			raise nodata;
		end if;

		select i_date into p_date from Borrower where roll_no = p_roll and i_book = p_book;

		select TRUNC(SYSDATE) - p_date into totaldays from dual;

		if totaldays > 30 then
			p_amt := totaldays * 50;
		elsif totaldays between 15 and 30 then
			p_amt := totaldays * 15;
		else 
			p_amt := 0;
		end if;

		if p_amt > 0 then
			dbms_output.putline('Roll no ' || p_roll || ' has been charged ' || p_amt || ' due to ' || totaldays || ' days late submission of books.');
			insert into Fine values(p_roll , SYSDATE , p_amt);
		else
			DBMS_OUTPUT.PUT_LINE('Roll no. ' || p_roll || ' does not have to pay any fine.');
		end if;

		update Borrower set stat = 'R' where roll_no = p_roll and i_book = p_book;

EXCEPTION
		when nodata then
    			DBMS_OUTPUT.PUT_LINE('Roll number' || p_roll || ' not found.');
		when OTHERS then
			DBMS_OUTPUT.PUT_LINE('An error occured. Error: ' || SQLERRM);

END;
/








