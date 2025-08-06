
create table test_int(
    id int primary key auto_increment ,
    active tinyint not null,
    ageid smallint zerofill default 0,
    days mediumint,
    rankk bigint
) auto_increment = 10 ;
set @auto_increment_increment =  1;

desc test_int;

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

select * from test_int;

update test_int
    set days = case
        when id = 10 then ageid*365
        WHEN id = 11 THEN ageid * 365
        WHEN id = 12 THEN ageid * 365
        WHEN id = 13 THEN ageid * 365
        else days
    end
where id < 14;

update test_int
    set days = ageid*365
    where id between 14 and 29;

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


delete from test_int where id between 11 and 32;

-- test float ---------------------------------------------------------------------------------------------------------------------------------


create table test_float(
                         id int primary key auto_increment ,
                         salary decimal(7,4) not null,
                         litre float(5),
                         pi double
) auto_increment = 10 ;
set @auto_increment_increment =  1; -- affects ALL TABLES

desc test_float;

-- INSERT INTO test_float (salary, litre, pi) VALUES
                                               -- (1234.5678, 10.5, 3.14159265),
                                               -- (2345.6789, 20.2, 3.14), (3456.7890, 15.75, 3.1415),
-- [22001][1264] Data truncation: Out of range value for column 'salary' at row 1 .. total = 7 digits , points 4

alter table test_float
    modify salary decimal(10,4);

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
INSERT INTO test_float (salary, litre, pi)
    VALUES (123.4567, 12.3, 3.141592653589793238462643383279);
-- inserted BUT TRUNCATED
INSERT INTO test_float (salary, litre, pi)
    VALUES (123.4567, 12.3, 3.1415926535897932384625555555555555555555555555555555555555555555643383279);
-- inserted BUT TRUNCATED

-- test_text ----------------------------------------------------------------------------------------------------------------------------------

create table test_text(
    id int primary key,
    desp tinytext,
    name varchar(120),
    article text,
    synopsys mediumtext,
    book longtext
);


-- Step 2: Insert large content using REPEAT()
INSERT INTO test_text (id, desp, name, article, synopsys, book)
VALUES (
           4,
           REPEAT('A', 255),           -- max TINYTEXT
           'Example Book',
           REPEAT('B', 65535),         -- max TEXT (64 KB)
           REPEAT('C', 16777215),      -- max MEDIUMTEXT (16 MB)
           REPEAT('D', 1000000)        -- 1 MB of LONGTEXT (for demo; can go up to 4GB)
       );

select * from test_text;

-- test binary ---------------------------------------------------------------------------------------------------
create table test_blob(
    id int primary key auto_increment,
    img tinyblob,
    file blob,
    vid mediumblob,
    lec longblob
);

INSERT INTO test_blob (img, file, vid, lec)
VALUES (
           LOAD_FILE('/home/sahil/SQL_scripts/Practice/1046720.jpg'),
           LOAD_FILE('/home/sahil/binLL.c'),
           LOAD_FILE('/home/sahil/.cache/.fr-5HYES2/System/Resources/Komorebi/aerial_mountain_and_ocean/video.mp4'),
           LOAD_FILE('/home/sahil/ai_nexus_classes/classes/AWS - O - 29.01.2025 - Class (15).mp4')
       );
select * from test_blob;
select img from test_blob where id = 1;
-- select convert (file using utf8) from test_blob where id = 1;
select length(img) from test_blob;

-- LIKE ----------------------------------------------------------------------------------------------------------

select * from AI_models;
select * FROM AI_models where name like '%n%';
select * from AI_models where desp like '%less%';
select * from AI_models where desp like '%more%';
select * from AI_models where desp like 'Meta%';
-- not right way select desp from AI_models where desp like 'Meta's%';

SELECT "test", "'test'", "''test''", "te""st";
SELECT 'test', '"test"', '""test""', 'te''st';
SELECT "They've found this tutorial to be helpful";
SELECT 'They\'ve found this tutorial to be helpful';
SELECT 'They\'ve responded, "We found this tutorial helpful"'; --  a string containing this ' will recognize the backslash as an instruction to cancel out the single quote’s syntactical meaning and instead insert it into the string as an apostrophe.

SELECT HEX(desp), desp FROM AI_models where ai_id in (359,364); -- BINARY LEVEL INSPECTION
-- Your MySQL `LIKE` query failed because it searched for a straight ASCII apostrophe (`'`), but the actual data in the `desp` column uses a Unicode curly apostrophe (`’`), so the pattern didn't match—`'Meta's%'` ≠ `'Meta’s%'` due to the character encoding difference between the two apostrophes.
-- Make sure you are using the correct curly apostrophe ’ (U+2019), not the straight ASCII one '.
SELECT * FROM AI_models
WHERE REPLACE(desp, '’', '''') LIKE '%Meta''s%';
SELECT * FROM AI_models
WHERE REPLACE(desp, '’', '''') LIKE '%Meta\'s%';
select * from AI_models where desp like 'Meta\'s%'; -- not saved

