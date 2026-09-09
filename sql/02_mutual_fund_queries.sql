-- =========================================================
-- Mutual Fund Analytics & Screening Dashboard
-- SQL Analysis
-- =========================================================

USE mutual_fund_analytics;


-- =========================================================
-- Q1. What are the top 10 funds by Overall Score?
-- =========================================================

SELECT
    Overall_Rank,
    Scheme,
    Category,
    Overall_Score,
    Performance_Score,
    Cost_Score,
    Consistency_Score
FROM fund_analysis
ORDER BY Overall_Score DESC
LIMIT 10;


-- =========================================================
-- Q2. Which categories have the highest average 3Y CAGR?
-- =========================================================

SELECT
    Category,
    COUNT(*) AS Fund_Count,
    ROUND(AVG(`CAGR% 3 Year`), 2) AS Avg_3Y_CAGR
FROM fund_analysis
GROUP BY Category
ORDER BY Avg_3Y_CAGR DESC;


-- =========================================================
-- Q3. What are the top 3 funds within each category?
-- =========================================================

WITH ranked_funds AS (
    SELECT
        Category,
        Scheme,
        Overall_Score,
        Overall_Rank,
        RANK() OVER (
            PARTITION BY Category
            ORDER BY Overall_Score DESC
        ) AS Category_Rank_SQL
    FROM fund_analysis
)

SELECT
    Category,
    Scheme,
    Overall_Score,
    Overall_Rank,
    Category_Rank_SQL
FROM ranked_funds
WHERE Category_Rank_SQL <= 3
ORDER BY Category, Category_Rank_SQL;


-- =========================================================
-- Q4. Which funds have above-average 3Y returns
--     and below-average expense ratios?
-- =========================================================

WITH averages AS (
    SELECT
        AVG(`CAGR% 3 Year`) AS avg_3y_return,
        AVG(`Exp. Ratio(%)`) AS avg_expense
    FROM fund_analysis
)

SELECT
    f.Scheme,
    f.Category,
    f.`CAGR% 3 Year`,
    f.`Exp. Ratio(%)`,
    f.Overall_Score
FROM fund_analysis f
CROSS JOIN averages a
WHERE f.`CAGR% 3 Year` > a.avg_3y_return
  AND f.`Exp. Ratio(%)` < a.avg_expense
ORDER BY f.Overall_Score DESC;


-- =========================================================
-- Q5. Which funds outperform their category average
--     the most?
-- =========================================================

SELECT
    Scheme,
    Category,
    `CAGR% 3 Year`,
    Category_Avg_3Y,
    `3Y_vs_Category`,
    Overall_Score
FROM fund_analysis
WHERE `3Y_vs_Category` > 0
ORDER BY `3Y_vs_Category` DESC
LIMIT 10;


-- =========================================================
-- Q6. Which highly ranked funds have a low minimum SIP?
-- =========================================================

SELECT
    Scheme,
    Category,
    `SIP Min. Inv.(Rs.)`,
    Overall_Score,
    Overall_Rank
FROM fund_analysis
WHERE `SIP Min. Inv.(Rs.)` <= 1000
ORDER BY Overall_Score DESC
LIMIT 15;


-- =========================================================
-- Q7. How do categories compare across key metrics?
-- =========================================================

SELECT
    Category,
    COUNT(*) AS Fund_Count,
    ROUND(AVG(`CAGR% 3 Year`), 2) AS Avg_3Y_CAGR,
    ROUND(AVG(`Exp. Ratio(%)`), 2) AS Avg_Expense_Ratio,
    ROUND(AVG(Overall_Score), 2) AS Avg_Overall_Score
FROM fund_analysis
GROUP BY Category
ORDER BY Avg_Overall_Score DESC;


-- =========================================================
-- Q8. Which highly ranked funds have relatively
--     high expense ratios?
-- =========================================================

SELECT
    Scheme,
    Category,
    Overall_Score,
    `Exp. Ratio(%)`,
    `CAGR% 3 Year`,
    Performance_Score,
    Cost_Score
FROM fund_analysis
WHERE Overall_Score >= (
    SELECT AVG(Overall_Score)
    FROM fund_analysis
)
AND `Exp. Ratio(%)` > (
    SELECT AVG(`Exp. Ratio(%)`)
    FROM fund_analysis
)
ORDER BY Overall_Score DESC
LIMIT 15;