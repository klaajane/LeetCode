-------------------------------------------- SOLUTION -------------------------------------------
WITH surveylog_metrics AS (SELECT
                                question_id,
                                COUNT(*) FILTER (WHERE action = 'show') AS show_count,
                                COUNT(*) FILTER (WHERE action = 'answer') AS answer_count
                                --AVG(CASE WHEN action = 'answer' THEN 1 ELSE 0
                                    ---END) AS "pct"
                            FROM
                                SurveyLog
                            GROUP BY 
                                1),
answer_rate AS (SELECT
                    question_id,
                    answer_count * 1.0 / show_count AS "answer_rate"
                FROM
                    surveylog_metrics)
SELECT
    question_id AS "survey_log"
FROM
    answer_rate
ORDER BY
    answer_rate DESC,
    question_id ASC
LIMIT 1
---------------------------------------------- NOTES --------------------------------------------
--> answer rate: # of answers / # question shown by user
--> report user with highest answer rate
--> tie ==> question with smallest question_id
-------------------------------------------------------------------------------------------------