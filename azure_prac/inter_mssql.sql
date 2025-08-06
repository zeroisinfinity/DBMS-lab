
create table test_int(id int primary key identity(10,5),
    active TINYINT NOT NULL,
    ageid SMALLINT DEFAULT 0,
    days INT,       -- No MEDIUMINT, use INT
    rankk BIGINT
);

exec sp_help 'test_int';

INSERT INTO test_int (active, ageid, rankk) VALUES
(1, 10, 1001),
(0, 11, 1002),
(1, 12, 1003),
(0, 13, 1004),
(1, 14, 1005),
(1, 15, 1006),
(0, 16, 1007),
(1, 17, 1008),
(0, 18, 1009),
(1, 19, 1010),
(1, 20, 1011),
(0, 21, 1012),
(1, 22, 1013),
(0, 23, 1014),
(1, 24, 1015),
(1, 25, 1016),
(0, 26, 1017),
(1, 27, 1018),
(0, 28, 1019),
(1, 29, 1020);

UPDATE test_int
SET days = CASE 
    WHEN id = 10 THEN ageid * 365
    WHEN id = 11 THEN ageid * 365
    WHEN id = 12 THEN ageid * 365
    WHEN id = 13 THEN ageid * 365
    ELSE days
END;

declare @i int = 10;
while @i <= 29*5
    begin
    update test_int set days = ageid * 365 where id = @i;
    set  @i = @i+1;
end;

select * from test_int;


INSERT INTO test_int (active, ageid, days,  rankk) VALUES
                                                (0, 199, 3680 , 1001);
-- fine


-- INSERT INTO test_int (active, ageid, days,  rankk) VALUES (0896, 199, 3680 , 1001);
-- [22001][1264] Data truncation: Out of range value for column 'active' at row 1

-- INSERT INTO test_int (active, ageid, days,  rankk) VALUES (0, 1996577 , 3680 , 1001);
-- [22001][1264] Data truncation: Out of range value for column 'active' at row 1

-- INSERT INTO test_int (active, ageid, days,  rankk) VALUES (0, 19 , 3687557775670 , 1001);
-- [22001][1264] Data truncation: Out of range value for column 'active' at row 1

INSERT INTO test_int (active, ageid, days,  rankk) VALUES (0, 19 , 36875 , 1065756578541);
-- fine

-- INSERT INTO test_int (active, ageid, days,  rankk) VALUES (0, 19 , 36875 , 10657565785756875741);
-- [22001][1264] Data truncation: Out of range value for column 'active' at row 1

declare @j int = 60;
while @j <= 115
begin 
delete from test_int where id = @j;
set @j = @j + 1;
end;

select * from test_int;

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------

CREATE TABLE test_float (
    id INT IDENTITY(1,5) PRIMARY KEY,
    salary DECIMAL(7,4) NOT NULL,
    litre FLOAT,            -- or REAL if you want lower precision
    pi FLOAT                -- use FLOAT instead of DOUBLE
);


-- INSERT INTO test_float (salary, litre, pi) VALUES (1234.5678, 10.5, 3.14159265);
-- Msg 8115, Level 16, State 8, Line 2 Arithmetic overflow error converting numeric to data type numeric.

alter table test_float 
    alter column salary decimal(10,4);

INSERT INTO test_float (salary, litre, pi) VALUES
                                               (1234.5678, 10.5, 3.14159265),
                                               (2345.6789, 20.2, 3.14),
                                               (3456.7890, 15.75, 3.1415),
                                               (4567.8901, 12.3, 3.14159),
                                               (5678.9012, 18.6, 3.1416),
                                               (6789.0123, 11.1, 3.141),
                                               (7890.1234, 16.4, 3.142),
                                               (8901.2345, 19.9, 3.14),
                                               (9012.3456, 14.7, 3.13),
                                               (10123.4567, 13.8, 3.15);
select * from test_float;

-- String literals and escaping
SELECT 'test', '"test"', '""test""', 'te''st';
SELECT 'They''ve found this tutorial to be helpful';
SELECT 'They''ve responded, "We found this tutorial helpful"';