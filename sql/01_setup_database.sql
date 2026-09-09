-- =========================================================
-- Mutual Fund Analytics & Screening Dashboard
-- MySQL Database Setup
-- =========================================================

CREATE DATABASE IF NOT EXISTS mutual_fund_analytics;

USE mutual_fund_analytics;


-- Create the analysis table
CREATE TABLE IF NOT EXISTS fund_analysis (
    Scheme VARCHAR(255),
    Category VARCHAR(150),

    `CAGR% 6 Months` DECIMAL(10,4),
    `CAGR% 1 Year` DECIMAL(10,4),
    `CAGR% 3 Year` DECIMAL(10,4),
    `Exp. Ratio(%)` DECIMAL(10,4),

    `6M_Score` DECIMAL(10,4),
    `1Y_Score` DECIMAL(10,4),
    `3Y_Score` DECIMAL(10,4),

    Performance_Score DECIMAL(10,4),
    Cost_Score DECIMAL(10,4),
    Return_Std DECIMAL(10,4),
    Consistency_Score DECIMAL(10,4),
    Overall_Score DECIMAL(10,4),

    Category_Avg_3Y DECIMAL(10,4),
    `3Y_vs_Category` DECIMAL(10,4),

    Overall_Rank INT,
    Category_Rank INT,

    Type VARCHAR(50),
    Benchmark VARCHAR(255),
    `Min. Invest(Rs.)` DECIMAL(12,2),
    `SIP Min. Inv.(Rs.)` DECIMAL(12,2)
);