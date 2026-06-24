Q1./* Top 10 Run Scorers*/
SELECT Name,
       Runs
FROM batsmen_2025
ORDER BY Runs DESC
LIMIT 10;

Q2./* Top 10 Wicket Takers */
SELECT Name,
       Wickets
FROM bowler_2025
ORDER BY Wickets DESC
LIMIT 10;

Q3./* Combined Runs Across Two Seasons */
SELECT Name,
       Runs,
       '2025' AS Season
FROM batsmen_2025
UNION ALL
SELECT Name,
       Runs,
       '2026' AS Season
FROM batsmen_2026;

Q4. /* Total Career Runs Across Both Seasons*/
WITH all_runs AS
(
    SELECT Name, Runs
    FROM batsmen_2025
    UNION ALL
    SELECT Name, Runs
    FROM batsmen_2026
)
SELECT Name,
       SUM(Runs) AS Total_Runs
FROM all_runs
GROUP BY Name
ORDER BY Total_Runs DESC;

Q5. /* Top 5 Batsmen */
WITH batting_rank AS
(
    SELECT Name,
           Runs,
           DENSE_RANK() OVER(ORDER BY Runs DESC) AS rnk
    FROM batsmen_2026
)
SELECT *
FROM batting_rank
WHERE rnk <= 5;

Q6. /* Top 5 Bowlers */
SELECT Name,
       Wickets,
       ROW_NUMBER() OVER(ORDER BY Wickets DESC) AS Rank_No
FROM bowler_2026;

Q7. /* Players With Above Average Runs */
SELECT Name,
       Runs
FROM batsmen_2025
WHERE Runs >
(
    SELECT AVG(Runs)
    FROM batsmen_2025
);

Q8. /* Compare Runs Against Season Average */
SELECT Name,
       Runs,
       AVG(Runs) OVER() AS Season_Average
FROM batsmen_2026;

Q9. /* Best Batting Average */
SELECT Name,
       `Bat Avg`
FROM batsmen_2026
WHERE Matches >= 10
ORDER BY `Bat Avg` DESC
LIMIT 10;

Q10. /* All-Rounders */
SELECT b.Name,
       b.Runs,
       bw.Wickets
FROM batsmen_2026 b
INNER JOIN bowler_2026 bw
ON b.Name = bw.Name
ORDER BY b.Runs DESC;

Q11. /* Top All-Rounders */
SELECT b.Name,
       b.Runs,
       bw.Wickets
FROM batsmen_2026 b
INNER JOIN bowler_2026 bw
ON b.Name = bw.Name
WHERE b.Runs > 200
  AND bw.Wickets > 10
ORDER BY b.Runs DESC;
