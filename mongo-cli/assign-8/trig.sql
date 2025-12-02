
CREATE TABLE Library(
    id NUMBER(12),
    title VARCHAR(255),
    dateofissue DATE,
    author VARCHAR(255)
);
CREATE TABLE Library_Audit(
    id NUMBER(12),
    title VARCHAR(255),
    dateofaction DATE,
    author VARCHAR(255),
    status VARCHAR(255)
);
INSERT INTO Library VALUES (1, 'Berserk', TO_DATE('2024-07-28','YYYY-MM-DD'), 'Prashant');
INSERT INTO Library VALUES (2, 'Dark', TO_DATE('2024-07-15','YYYY-MM-DD'), 'Rajendra');
INSERT INTO Library VALUES (3, 'Hannibal', TO_DATE('2024-07-20','YYYY-MM-DD'), 'Manoj');
INSERT INTO Library VALUES (4, 'AOT', TO_DATE('2024-07-30','YYYY-MM-DD'), 'Rajesh');
INSERT INTO Library VALUES (5, 'GOT', TO_DATE('2024-07-19','YYYY-MM-DD'), 'Anil');

create or replace trigger lib_action 
	after insert or update or delete on Library
	for each row
		BEGIN
			if inserting then 
				insert into Library_Audit(id,title,dateofaction,author,status) values (
					:NEW.id,:NEW.title,current_timestamp,:NEW.author,'Insert');
			ELSIF UPDATING THEN
        INSERT INTO Library_Audit (id, title, dateofaction, author, status) VALUES (:OLD.id, :OLD.title, current_timestamp, :OLD.author, 'Update');
	ELSIF DELETING THEN
        INSERT INTO Library_Audit (id, title, dateofaction, author, status) VALUES (:OLD.id, :OLD.title, current_timestamp, :OLD.author, 'Delete');
	END IF;
END;
/	

INSERT INTO Library VALUES (15, 'CREW', TO_DATE('2024-07-22','YYYY-MM-DD'), 'Ramesh');
INSERT INTO Library VALUES (14, 'Ninteen Eighty Four', TO_DATE('2024-07-01','YYYY-MM-DD'), 'Omkar');

SELECT * FROM Library;
SELECT * FROM Library_Audit;

UPDATE Library SET id = 6, title = 'Sherlock', author = 'Deepak' where id = 3;
UPDATE Library SET id = 7, title = 'MR. ROBOT', author = 'Varad' where id = 4;

SELECT * FROM Library;
SELECT * FROM Library_Audit;
DELETE FROM Library WHERE id = 1;
DELETE FROM Library WHERE id = 5;

SELECT * FROM Library;
SELECT * FROM Library_Audit;
