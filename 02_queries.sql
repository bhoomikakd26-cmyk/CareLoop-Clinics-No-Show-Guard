USE noshowguard;
SHOW TABLES;

SELECT COUNT(*) AS clinics_count FROM clinics;
SELECT COUNT(*) AS appointments_count FROM appointments;

SELECT SUM(no_show) AS total_no_shows
FROM appointments;


USE noshowguard;

-- TASK 2.2: No-show rate by clinic
SELECT
    c.clinic_name,
    c.city,
    COUNT(*) AS appointments,
    SUM(a.no_show) AS no_shows,
    ROUND(100.0 * SUM(a.no_show) / COUNT(*), 1) AS no_show_pct
FROM appointments a
JOIN clinics c ON a.clinic_id = c.clinic_id
GROUP BY c.clinic_id, c.clinic_name, c.city
HAVING COUNT(*) >= 95
ORDER BY no_show_pct DESC;


-- TASK 2.3: No-show rate by lead-time band
SELECT
    CASE
        WHEN lead_days BETWEEN 1 AND 7 THEN '1-7 days'
        WHEN lead_days BETWEEN 8 AND 14 THEN '8-14 days'
        WHEN lead_days BETWEEN 15 AND 30 THEN '15-30 days'
        ELSE '31+ days'
    END AS lead_band,
    COUNT(*) AS appointments,
    SUM(no_show) AS no_shows,
    ROUND(100.0 * SUM(no_show) / COUNT(*), 1) AS no_show_pct
FROM appointments
GROUP BY lead_band
ORDER BY MIN(lead_days);


-- TASK 2.4: Monthly trend using CTE and LAG
WITH monthly AS (
    SELECT
        DATE_FORMAT(appt_date, '%Y-%m') AS month,
        COUNT(*) AS appointments,
        ROUND(100.0 * SUM(no_show) / COUNT(*), 1) AS no_show_pct
    FROM appointments
    GROUP BY DATE_FORMAT(appt_date, '%Y-%m')
)
SELECT
    month,
    appointments,
    no_show_pct,
    ROUND(
        no_show_pct - LAG(no_show_pct) OVER (ORDER BY month),
        1
    ) AS change_pp
FROM monthly
ORDER BY month;


-- TASK 2.5: Rank clinics within each city
WITH clinic_rates AS (
    SELECT
        c.clinic_name,
        c.city,
        100.0 * SUM(a.no_show) / COUNT(*) AS no_show_pct
    FROM clinics c
    JOIN appointments a ON c.clinic_id = a.clinic_id
    GROUP BY c.clinic_id, c.clinic_name, c.city
),
ranked AS (
    SELECT
        clinic_name,
        city,
        ROUND(no_show_pct, 1) AS no_show_pct,
        RANK() OVER (
            PARTITION BY city
            ORDER BY no_show_pct DESC
        ) AS rank_in_city,
        CASE
            WHEN no_show_pct >
                (SELECT 100.0 * SUM(no_show) / COUNT(*) FROM appointments)
                THEN 'above'
            WHEN no_show_pct <
                (SELECT 100.0 * SUM(no_show) / COUNT(*) FROM appointments)
                THEN 'below'
            ELSE 'equal'
        END AS vs_overall
    FROM clinic_rates
)
SELECT *
FROM ranked
ORDER BY city, rank_in_city;
