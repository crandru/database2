/* Problem 1 */
SELECT team, college, PlayerAmt 
FROM
	(SELECT team, college, COUNT(college) AS PlayerAmt 
	 FROM nfl.players 
     GROUP BY team, college)	
WHERE PlayerAmt IN 
	(SELECT MAX(PlayerAmt) 
	 FROM 
		(SELECT team, college, COUNT(college) AS PlayerAmt
		 FROM nfl.players 
		 GROUP BY team, college));

/* Problem 2 */
SELECT team, conference
FROM nfl.teams
NATURAL INNER JOIN
	(SELECT conference, AVG(rushingyards) AS AVGYDS
	 FROM nfl.teams 
	 GROUP BY conference)
WHERE rushingyards > AVGYDS;

/* Problem 3 */
SELECT distinct games.hometeam, (NVL(homeWins,0) + NVL(awayWins,0)) AS Wins, (NVL(homeLosses,0) + NVL(awayLosses,0)) AS Losses, (NVL(homeTies,0) + NVL(awayTies,0)) AS Ties
FROM nfl.games games
LEFT JOIN
	(SELECT hometeam, COUNT(hometeam) AS homeWins
	 FROM nfl.games
	 WHERE homepoints > visitorpoints
	 GROUP BY hometeam) T1
ON games.hometeam = T1.hometeam
LEFT JOIN
	(SELECT visitor, COUNT(visitor) AS awayWins
	 FROM nfl.games
	 WHERE visitorpoints > homepoints
	 GROUP BY visitor) T2
ON games.hometeam = T2.visitor
LEFT JOIN
	(SELECT visitor, COUNT(visitor) AS awayLosses
	 FROM nfl.games
	 WHERE visitorpoints < homepoints
	 GROUP BY visitor) T3
ON games.hometeam = T3.visitor 
LEFT JOIN
	(SELECT hometeam, COUNT(hometeam) AS homeLosses
	 FROM nfl.games
	 WHERE homepoints < visitorpoints
	 GROUP BY hometeam) T4
ON games.hometeam = T4.hometeam
LEFT JOIN
	(SELECT hometeam, COUNT(hometeam) as homeTies
	 FROM nfl.games
	 WHERE homepoints = visitorpoints
	 GROUP BY hometeam) T5
ON games.hometeam = T5.hometeam
LEFT JOIN
	(SELECT visitor, COUNT(visitor) as awayTies
	 FROM nfl.games
	 WHERE homepoints = visitorpoints
	 GROUP BY visitor) T6
ON games.hometeam = T6.visitor;

/* Problem 4 */
SELECT team
FROM
	(SELECT team, division FROM nfl.teams
	 NATURAL INNER JOIN
	(SELECT division, AVG(wins) AS AVGWINS FROM nfl.teams GROUP BY division)
	 NATURAL INNER JOIN
	(SELECT division, AVG(penaltyyards) AS AVGYDS FROM nfl.teams GROUP BY division)
	 WHERE wins > AVGWINS AND penaltyyards > AVGYDS);
