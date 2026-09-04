SELECT
    SUM(age_17_44) AS total_17_44,
    SUM(age_45_64) AS total_45_64,
    SUM(age_65_older) AS total_65_older,
    ROUND(SUM(age_17_44)::numeric / NULLIF(SUM(total_recipients), 0) * 100, 1) AS pct_17_44,
    ROUND(SUM(age_45_64)::numeric / NULLIF(SUM(total_recipients), 0) * 100, 1) AS pct_45_64,
    ROUND(SUM(age_65_older)::numeric / NULLIF(SUM(total_recipients), 0) * 100, 1) AS pct_65_older
FROM veterans_disability;