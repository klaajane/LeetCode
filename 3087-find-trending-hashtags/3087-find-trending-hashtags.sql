-------------------------------------------- SOLUTION -------------------------------------------
-- extract the hashtags from the strings
SELECT
    --SUBSTRING(tweet, POSITION('#' IN tweet)) AS "hashtag"
    REGEXP_SUBSTR(tweet, '#[^ ]*') AS "hashtag"
    ,COUNT(REGEXP_SUBSTR(tweet, '#[^ ]*')) AS "hashtag_count" 
FROM
    tweets
WHERE
    tweet_date BETWEEN '2024-02-01' AND '2024-02-29'
GROUP BY
    hashtag
ORDER BY 
    hashtag_count DESC, hashtag DESC
LIMIT 3
---------------------------------------------- NOTES --------------------------------------------
--> find top 3 trending hashtags in Feb 24
--> order by count of hashtag, hashtag DESC
-------------------------------------------------------------------------------------------------