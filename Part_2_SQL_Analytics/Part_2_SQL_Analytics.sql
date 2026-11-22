
USE careloop_clinics;

SELECT
    c.clinic_id,
    c.clinic_name,
    c.city,
    COUNT(a.appointment_id) AS total_appointments,

    SUM(CASE
        WHEN a.no_show = 0 THEN 1
        ELSE 0
    END) AS attended_appointments,

    SUM(CASE
        WHEN a.no_show = 1 THEN 1
        ELSE 0
    END) AS no_show_appointments,

    ROUND(
        SUM(CASE WHEN a.no_show = 1 THEN 1 ELSE 0 END)
        * 100.0 / COUNT(a.appointment_id),
        2
    ) AS no_show_rate

FROM appointments a
INNER JOIN clinics c
    ON a.clinic_id = c.clinic_id

GROUP BY
    c.clinic_id,
    c.clinic_name,
    c.city

HAVING COUNT(a.appointment_id) > 0

ORDER BY no_show_rate DESC;

USE careloop_clinics;

-- LEAD-TIME BAND ANALYSIS

SELECT
    CASE
        WHEN lead_days BETWEEN 1 AND 3 THEN '1-3 Days'
        WHEN lead_days BETWEEN 4 AND 7 THEN '4-7 Days'
        WHEN lead_days BETWEEN 8 AND 14 THEN '8-14 Days'
        WHEN lead_days BETWEEN 15 AND 30 THEN '15-30 Days'
        ELSE '31-45 Days'
    END AS lead_time_band,

    COUNT(*) AS total_appointments,

    SUM(CASE
        WHEN no_show = 1 THEN 1
        ELSE 0
    END) AS no_show_appointments,

    ROUND(
        AVG(no_show) * 100,
        2
    ) AS no_show_rate

FROM appointments

GROUP BY lead_time_band

ORDER BY MIN(lead_days);

USE careloop_clinics;

-- MONTHLY NO-SHOW TREND ANALYSIS

WITH monthly_data AS (
    SELECT
        DATE_FORMAT(appt_date, '%Y-%m') AS appointment_month,
        COUNT(*) AS total_appointments,
        SUM(no_show) AS no_show_appointments,
        ROUND(AVG(no_show) * 100, 2) AS no_show_rate
    FROM appointments
    GROUP BY DATE_FORMAT(appt_date, '%Y-%m')
),

monthly_comparison AS (
    SELECT
        appointment_month,
        total_appointments,
        no_show_appointments,
        no_show_rate,

        LAG(no_show_rate) OVER (
            ORDER BY appointment_month
        ) AS previous_month_rate

    FROM monthly_data
)

SELECT
    appointment_month,
    total_appointments,
    no_show_appointments,
    no_show_rate,
    previous_month_rate,

    ROUND(
        no_show_rate - previous_month_rate,
        2
    ) AS month_over_month_change

FROM monthly_comparison
ORDER BY appointment_month;
USE careloop_clinics;

-- DATABASE VERIFICATION
-- Your COUNT query here


-- TASK 2.1: CLINIC-WISE NO-SHOW ANALYSIS
-- Completed query here


-- TASK 2.2: LEAD-TIME ANALYSIS
-- Completed query here


-- TASK 2.3: MONTHLY NO-SHOW TRENDS
-- Monthly query here

USE careloop_clinics;

-- TASK: CLINIC RANKING WITHIN EACH CITY

WITH clinic_stats AS (
    SELECT
        c.clinic_id,
        c.clinic_name,
        c.city,
        COUNT(a.appointment_id) AS total_appointments,
        SUM(a.no_show) AS no_show_appointments,
        ROUND(AVG(a.no_show) * 100, 2) AS no_show_rate

    FROM clinics c

    INNER JOIN appointments a
        ON c.clinic_id = a.clinic_id

    GROUP BY
        c.clinic_id,
        c.clinic_name,
        c.city
)

SELECT
    clinic_id,
    clinic_name,
    city,
    total_appointments,
    no_show_appointments,
    no_show_rate,

    RANK() OVER (
        PARTITION BY city
        ORDER BY no_show_rate DESC
    ) AS city_rank

FROM clinic_stats

ORDER BY city, city_rank;
