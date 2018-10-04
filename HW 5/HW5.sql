/* Query 1 */
SELECT location, team, division, wins, losses, rushingyards
FROM
	(SELECT location, team, division, wins, losses, rushingyards, 
	 RANK() over (ORDER BY rushingyards DESC) AS ydsrank
	 FROM nfl.teams)
WHERE ydsrank <= 5;

/* Query 2 */
SELECT location, team, division, wins, losses, rushingyards
FROM
	(SELECT location, team, division, wins, losses, rushingyards, 
	 RANK() over (PARTITION BY division ORDER BY rushingyards DESC) AS ydsrank
	 FROM nfl.teams)
WHERE ydsrank <= 2;

/* Query 3 */
SELECT gamedate, homeaway, pointsscored, pointsagainst,
	SUM(pointsscored) OVER (ORDER BY gamedate) AS cumpointsscored,
	SUM(pointsagainst) OVER (ORDER BY gamedate) AS cumpointsagainst
FROM RavensGames;

/* This was way too easy :) */

