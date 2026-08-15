-- Write your PostgreSQL query statement below


-- I'm thinking of using split function to split words, capitalize letter
-- then group them back together, let's see it this works: 

SELECT
    content_id,
    content_text AS original_text,
    INITCAP(content_text) AS converted_text
FROM user_content