use DBMS;

CREATE TABLE 
AI_models( ai_id int PRIMARY KEY AUTO_INCREMENT , 
		   name varchar(20) , 
           paramters varchar(3) , 
           error decimal(4,3) , 
           release_date DATE , 
           desp TEXT) 
AUTO_INCREMENT = 351;

desc AI_models;

CREATE VIEW top_ai as 
			SELECT ai_id , name , parameters , desp 
            FROM AI_models WHERE ai_id <= 355;
            
INSERT INTO AI_models (name, parameters, error, release_date, desp) VALUES
('GPT-4o',       '1.8', 0.011, '2024-05-13', 'OpenAI’s flagship model with vision, audio, text. Widely used globally.'),
('Gemini 1.5',   '1.5', 0.015, '2024-03-01', 'Google DeepMind’s top model. UK-based DeepMind lab.'),
('Claude 3',     '1.2', 0.014, '2024-04-05', 'Anthropic’s trusted AI assistant. Popular in enterprise and research.'),
('DeepSeek R1',  '2.0', 0.012, '2024-06-10', 'Chinese open-weight transformer model known for reasoning and open-source capability.'),
('Mistral 7B',   '7B',  0.025, '2023-09-27', 'France-origin open-source model. Highly adopted in UK/Europe.'),
('Grok-1',       '1.0', 0.030, '2023-11-04', 'X.ai model by Elon Musk. Popular on social platforms.'),
('AlphaFold',    '0.3', 0.002, '2021-07-15', 'DeepMind’s breakthrough in protein folding. Scientific milestone.'),
('Bard',         '1.0', 0.018, '2023-02-06', 'Google’s conversational AI, UK-adopted by many orgs.'),
('LLaMA 3',      '8B',  0.020, '2024-04-18', 'Meta’s open model. Widely used in UK academic research.'),
('GatorTron',    '0.5', 0.016, '2021-12-01', 'Medical AI model used by NHS and UK hospitals.'),
('RetNet',       '6B',  0.028, '2023-12-10', 'AI with recurrence. Academic interest in UK universities.');

INSERT INTO AI_models (name, parameters, error, release_date, desp) VALUES
('AlphaFold', '0.3', 0.002, '2021-07-15', 'DeepMind’s breakthrough in protein folding. Scientific milestone.'),
('Bard',      '1.0', 0.018, '2023-02-06', 'Google’s conversational AI, UK-adopted by many orgs.'),
('LLaMA 3',   '8B', 0.020, '2024-04-18', 'Meta’s open model. Widely used in UK academic research.'),
('GatorTron', '0.5', 0.016, '2021-12-01', 'Medical AI model used by NHS and UK hospitals.'),
('RetNet',    '6B', 0.028, '2023-12-10', 'AI with recurrence. Academic interest in UK universities.');

select * from top_ai;

select * from AI_models;

CREATE INDEX ai_index
    on AI_models(ai_id , name, parameters);

CREATE UNIQUE INDEX id
    on AI_models(ai_id);

ALTER TABLE
    AI_models add column country varchar(10) NOT NULL;

ALTER TABLE
    AI_models
    add column ratings int;

UPDATE AI_models
    set ratings = 4.5
    where ai_id <= 355;

 UPDATE AI_models
    AI_models 
	set ratings = 3.5
    where ai_id between 356 and 363;

UPDATE AI_models
     AI_models 
     set ratings = 3
     where ai_id >= 364;

select * from AI_models;

UPDATE AI_models SET country = 'USA'    WHERE ai_id = 351;  -- GPT-4o  
UPDATE AI_models SET country = 'UK'     WHERE ai_id = 352;  -- Gemini 1.5  
UPDATE AI_models SET country = 'USA'    WHERE ai_id = 353;  -- Claude 3  
UPDATE AI_models SET country = 'China'  WHERE ai_id = 354;  -- DeepSeek R1  
UPDATE AI_models SET country = 'France' WHERE ai_id = 355;  -- Mistral 7B  
UPDATE AI_models SET country = 'USA'    WHERE ai_id = 356;  -- Grok-1  
UPDATE AI_models SET country = 'UK'     WHERE ai_id = 357;  -- AlphaFold  
UPDATE AI_models SET country = 'UK'     WHERE ai_id = 358;  -- Bard  
UPDATE AI_models SET country = 'USA'    WHERE ai_id = 359;  -- LLaMA 3  
UPDATE AI_models SET country = 'UK'     WHERE ai_id = 360;  -- GatorTron  
UPDATE AI_models SET country = 'UK'     WHERE ai_id = 361;  -- RetNet  
UPDATE AI_models SET country = 'UK'     WHERE ai_id = 362;  -- AlphaFold (duplicate)  
UPDATE AI_models SET country = 'UK'     WHERE ai_id = 363;  -- Bard (duplicate)  
UPDATE AI_models SET country = 'USA'    WHERE ai_id = 364;  -- LLaMA 3 (duplicate)  
UPDATE AI_models SET country = 'UK'     WHERE ai_id = 365;  -- GatorTron (duplicate)  
UPDATE AI_models SET country = 'UK'     WHERE ai_id = 366;  -- RetNet (duplicate)  


-- UPDATE AI_models
-- SET country = CASE
--     WHEN ai_id = 351 THEN 'USA'       -- GPT-4o
--     WHEN ai_id = 352 THEN 'UK'        -- Gemini 1.5
--     WHEN ai_id = 353 THEN 'USA'       -- Claude 3
--     WHEN ai_id = 354 THEN 'China'     -- DeepSeek R1
--     WHEN ai_id = 355 THEN 'France'    -- Mistral 7B
--     WHEN ai_id = 356 THEN 'USA'       -- Grok-1
--     WHEN ai_id = 357 THEN 'UK'        -- AlphaFold
--     WHEN ai_id = 358 THEN 'UK'        -- Bard
--     WHEN ai_id = 359 THEN 'USA'       -- LLaMA 3
--     WHEN ai_id = 360 THEN 'UK'        -- GatorTron
--     WHEN ai_id = 361 THEN 'UK'        -- RetNet
--     WHEN ai_id = 362 THEN 'UK'        -- AlphaFold (duplicate)
--     WHEN ai_id = 363 THEN 'UK'        -- Bard (duplicate)
--     WHEN ai_id = 364 THEN 'USA'       -- LLaMA 3 (duplicate)
--     WHEN ai_id = 365 THEN 'UK'        -- GatorTron (duplicate)
--     WHEN ai_id = 366 THEN 'UK'        -- RetNet (duplicate)
--     ELSE country
-- END;

UPDATE top_ai
SET parameters = CASE
    WHEN ai_id = 351 THEN '8B'
    WHEN ai_id = 352 THEN '7B'
    WHEN ai_id = 353 THEN '5B'
    WHEN ai_id = 354 THEN '6B'
    WHEN ai_id = 356 THEN '5B'
    WHEN ai_id = 357 THEN '5B'
    WHEN ai_id = 358 THEN '4B'
    WHEN ai_id = 360 THEN '6B'
    WHEN ai_id = 362 THEN '3B'
    WHEN ai_id = 363 THEN '3B'
    WHEN ai_id = 365 THEN '2B'
    ELSE parameters
END;

show index from AI_models;

SHOW INDEX FROM AI_models WHERE Non_unique = 0;

SELECT * FROM top_ai;

SELECT name,parameters FROM AI_models order by error desc;

SELECT count(*) as AI_from_country,country FROM AI_models group by country;

select count(*) as top_ai_parameters , parameters from top_ai group by parameters;

SELECT * FROM AI_models
    where release_date > '2022-09-07';

SELECT name,
	   YEAR(release_date) as year,
       MONTH(release_date) as month,
       DAY(release_date) as day
	FROM AI_models;

-- Step 1: Add column if not exists (skip if already added)
ALTER TABLE AI_models ADD COLUMN days_since_release INT;

-- Step 2: Ensure the column is of type INT (to avoid incorrect type errors)
ALTER TABLE AI_models MODIFY COLUMN days_since_release INT;

-- Step 3: Update the column using the date difference between today and release_date
UPDATE AI_models
SET days_since_release = DATEDIFF(CURDATE(), release_date);

-- Step 4: View results
SELECT * FROM AI_models;
SELECT * FROM top_ai;
