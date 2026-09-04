SELECT state,
       SUM(scd_100) AS total_100_percent,
       SUM(total_recipients) AS total_recipients,
       ROUND(SUM(scd_100)::numeric / NULLIF(SUM(total_recipients), 0) * 100, 2) AS pct_100_rated
FROM veterans_disability
GROUP BY state
ORDER BY pct_100_rated DESC
LIMIT 10;