------------------------------------- SOLUTION ----------------------------------
SELECT
    season_id,
    team_id,
    team_name,
    
    -- 1/ collapse the wins, draws, losses columns into one column "points"
    3 * wins + draws + losses * 0 AS points,

    -- 2/ calculate the goal_difference
    goals_for - goals_against AS goal_difference,

    -- 3/ DENSE_RANK() to derive the position column
    DENSE_RANK() OVER (
        PARTITION BY season_id
        ORDER BY
            3 * wins + draws + losses * 0 DESC,
            goals_for - goals_against DESC,
            team_name
    ) AS position

FROM SeasonStats
ORDER BY season_id, position, team_name
---------------------------------------- NOTES ----------------------------------
--> GOAL:
    --> calculate the points, goal difference, and position in EACH SEASON.

--> RANKING LOGIC
        --> total points DESC
        --> goal difference DESC
        --> team name ASC

--> POINTS LOGIC:
    --> wins = 3
    --> draw = 1
    --> loss = 0

--> ORDER BY:
    --> season ASC
    --> position ASC
    --> team_name ASC
---------------------------------------------------------------------------------