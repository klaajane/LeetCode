-------------------------------------------- SOLUTION -------------------------------------------
-- extract the hashtags from the strings
WITH hashtags AS (
    SELECT
        --SUBSTRING(tweet, POSITION('#' IN tweet)) AS "hashtag"
        REGEXP_SUBSTR(tweet, '#[^ ]*') AS "hashtag"
    FROM
        tweets
    WHERE
        tweet_date BETWEEN '2024-02-01' AND '2024-02-29')

SELECT
    hashtag
    ,COUNT(*) AS hashtag_count
FROM
    hashtags
GROUP BY
    hashtag
ORDER BY 
    hashtag_count DESC, hashtag DESC
LIMIT 3
---------------------------------------------- NOTES --------------------------------------------
--> find top 3 trending hashtags in Feb 24
--> order by count of hashtag, hashtag DESC
-------------------------------------------------------------------------------------------------