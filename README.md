# FundScope Analytics

An end-to-end mutual fund analytics and screening project that combines Python, MySQL, and Excel to clean, analyze, rank, and compare mutual fund schemes using historical performance, cost, consistency, and accessibility-related metrics.

---

## 📌 Project Overview

FundScope Analytics analyzes a dataset of Indian mutual fund schemes and transforms raw fund data into an interactive analytics and screening tool.

The project follows a complete data analytics workflow:

**Raw Data → Python Data Preparation → Scoring & Ranking → MySQL Analysis → Excel Dashboard**

The objective is to make it easier to explore a large mutual fund universe, identify high-performing and cost-efficient funds, compare schemes, and understand how funds perform relative to their category.

> **Important:** The scores and rankings in this project are analytical measures created from the available historical dataset. They are not predictions, investment recommendations, or guarantees of future performance.

---

## 🎯 Business Problem

When analyzing a large number of mutual fund schemes, comparing funds manually across historical returns, expense ratios, investment requirements, and category performance can be difficult.

This project addresses the problem by creating a structured analytical framework that allows users to:

- Identify funds with stronger historical performance
- Compare funds based on historical returns and costs
- Evaluate consistency across multiple return periods
- Compare funds against their category average
- Find highly ranked funds with lower investment requirements
- Explore and compare individual funds interactively

---

## 📊 Dataset

The original dataset contains **2,556 mutual fund schemes** and includes information such as:

- Scheme name
- Category
- Fund type
- Benchmark
- Net Asset Value (NAV)
- 6-month CAGR
- 1-year CAGR
- 3-year CAGR
- Minimum investment
- Expense ratio
- SIP minimum investment

After data cleaning and handling missing values, **1,608 funds** had sufficient data across the required return and expense metrics to participate in the scoring framework.

Missing historical return values were not artificially imputed because longer-term return data may not be available for newer funds.

---

## 🛠️ Tools & Technologies

| Tool | Purpose |
|---|---|
| Python | Data cleaning, exploratory analysis, scoring and ranking |
| Pandas | Data manipulation and transformation |
| NumPy | Numerical calculations |
| Jupyter Notebook | Analysis workflow and documentation |
| MySQL | Business-oriented SQL analysis |
| Excel | Interactive dashboard, fund exploration and comparison |
| Git & GitHub | Version control and project management |

---

## 🔄 Project Workflow

```text
                    ┌─────────────────────┐
                    │   Raw Fund Dataset  │
                    │     2,556 Funds     │
                    └──────────┬──────────┘
                               │
                               ▼
                    ┌─────────────────────┐
                    │  Python Cleaning &  │
                    │   Data Preparation  │
                    └──────────┬──────────┘
                               │
                               ▼
                    ┌─────────────────────┐
                    │ Scoring & Ranking   │
                    │    1,608 Funds      │
                    └───────┬───────┬─────┘
                            │       │
                  ┌─────────┘       └─────────┐
                  ▼                           ▼
        ┌─────────────────┐         ┌─────────────────┐
        │      MySQL      │         │      Excel      │
        │ Business Query  │         │ Interactive     │
        │    Analysis     │         │   Dashboard     │
        └─────────────────┘         └─────────────────┘
```

---

## 🧹 Data Cleaning & Preparation

The Python workflow was used to prepare the raw dataset for analysis.

### Main Cleaning Steps

- Removed unnecessary index columns
- Cleaned leading and trailing spaces
- Standardized missing-value placeholders
- Converted relevant fields to numeric data types
- Identified missing values across return and cost metrics
- Checked for duplicate records
- Preserved missing historical return values instead of imputing them
- Created a scoring-eligible dataset containing funds with complete values for the required scoring metrics

### Data Quality Observations

| Metric | Result |
|---|---:|
| Original records | 2,556 |
| Duplicate records | 0 |
| Scoring-eligible funds | 1,608 |
| Fund categories | 57 |
| Fund types | 2 |

---

## 📈 Scoring Methodology

FundScope Analytics creates a composite score to provide a consistent framework for comparing funds.

The scoring model uses three main dimensions:

### 1. Performance Score — 50%

Historical returns over:

- 6-month CAGR
- 1-year CAGR
- 3-year CAGR

Each return period is scaled to a **0–100 score** using Min-Max scaling.

The three return scores are then combined into the Performance Score.

### 2. Cost Score — 25%

The Expense Ratio is converted into a 0–100 score where:

**Lower expense ratio → Higher Cost Score**

This rewards funds with relatively lower costs.

### 3. Consistency Score — 25%

Consistency is based on the variation between the three return-period scores.

A fund with more consistent performance across the available periods receives a higher consistency score.

### Overall Score

The final score is calculated as:

```text
Overall Score =
    50% × Performance Score
  + 25% × Cost Score
  + 25% × Consistency Score
```

The resulting Overall Score is used to rank funds within the scoring-eligible universe.

---

## 🏷️ Category Comparison

Fund performance can vary significantly between different types of funds.

To provide category context, the project calculates:

### Category Average 3Y CAGR

The average 3-year CAGR of funds within the same category.

### 3Y vs Category Average

```text
3Y vs Category Average =
Fund 3Y CAGR − Category Average 3Y CAGR
```

A positive value indicates that the fund's historical 3-year CAGR was above its category average in the dataset.

The project also calculates:

- Overall Rank
- Category Rank

This allows a fund to be evaluated both against the complete scoring universe and against funds within its own category.

---

## 🗄️ MySQL Analysis

The scored dataset is loaded into MySQL for business-oriented analysis.

The SQL analysis answers questions such as:

1. Which funds have the highest Overall Scores?
2. Which categories have the highest average 3-year CAGR?
3. What are the top 3 funds within each category?
4. Which funds have above-average 3-year returns while maintaining below-average expense ratios?
5. Which funds have the highest 3-year outperformance relative to their category?
6. Which highly ranked funds have SIP minimum investments of ₹1,000 or less?
7. How do selected categories compare based on historical performance?
8. Which highly ranked funds have above-average expense ratios?

The SQL work also demonstrates the use of:

- Aggregations
- `GROUP BY`
- Common Table Expressions (CTEs)
- Subqueries
- Window functions
- `RANK()`
- Filtering and sorting
- Category-level comparisons

---

## 📊 Excel Analytics Dashboard

The final Excel workbook provides an interactive interface for exploring the processed and scored dataset.

### Dashboard

The Dashboard provides:

- Total number of scoring-eligible funds
- Average 3-year CAGR
- Average expense ratio
- Highest Overall Score
- Top 10 funds by Overall Score
- Top categories by average 3-year CAGR
- Category slicer
- 3-year return vs expense ratio scatter plot

### Fund Explorer

The Fund Explorer allows the user to select an individual fund and dynamically view:

- Fund profile
- Category
- Type
- Benchmark
- NAV
- Minimum investment
- SIP minimum investment
- Expense ratio
- Historical CAGR metrics
- Performance Score
- Cost Score
- Consistency Score
- Overall Score
- Overall Rank
- Category Rank
- 3Y performance relative to category average

### Fund Comparison

The Fund Comparison sheet allows two funds to be selected and compared side-by-side across important metrics.

Conditional formatting highlights the stronger value for key comparison metrics such as:

- 6M CAGR
- 1Y CAGR
- 3Y CAGR
- Expense Ratio
- Overall Score

For Expense Ratio, a lower value is treated as better.

---

## 🔎 Key Findings

The analysis produced several observations from the dataset.

### Overall Scoring

The Overall Score across the scoring-eligible funds ranged from approximately **21.07 to 72.99**.

The average Overall Score was approximately **52.91**.

### Historical Performance

The average 3-year CAGR across the scoring-eligible funds was approximately **7.16%**.

### Category Performance

Some categories showed substantially higher average historical 3-year CAGR than others.

For example, the **Technology** category had one of the highest average 3-year CAGR values in the dataset.

Category-level results should be interpreted carefully when a category contains relatively few funds.

### Cost and Performance

The scoring framework demonstrates that a fund's final ranking is not based solely on historical return.

Performance, cost, and consistency are combined to produce the Overall Score.

---

## ⚠️ Limitations

This project is intended as a data analytics and screening exercise rather than an investment advisory system.

### Important Limitations

- The analysis is based on historical dataset values.
- Historical returns do not guarantee future performance.
- The scoring weights are analytical choices made for this project and are not an industry-standard rating methodology.
- The scoring model does not include all factors that may affect investment decisions.
- Risk measures such as volatility, Sharpe ratio, beta, drawdown, and maximum drawdown are not included.
- Fund expense ratios and other characteristics may change over time.
- Missing historical return values were excluded from scoring rather than estimated.
- Category averages can be influenced by the number of funds available within a category.
- The project does not provide investment recommendations.

---

## 📁 Project Structure

```text
FundScope-Analytics/
│
├── data/
│   ├── raw/
│   │   └── Mutual_Funds.csv
│   │
│   └── processed/
│       ├── Mutual_Funds_Cleaned.csv
│       ├── Mutual_Funds_Scored.csv
│       └── Mutual_Funds_Scored_MySQL.csv
│
├── excel/
│   └── Mutual_Fund_Analytics.xlsx
│
├── images/
│
├── notebooks/
│   └── mutual_fund_analysis.ipynb
│
├── sql/
│   ├── 01_setup_database.sql
│   └── 02_mutual_fund_queries.sql
│
├── .gitignore
├── README.md
└── requirements.txt
```

---

## ▶️ How to Use the Project

### 1. Clone the Repository

```bash
git clone <https://github.com/HawkEye2610/FundScope-Analytics.git>
cd FundScope-Analytics
```

### 2. Install Python Dependencies

```bash
pip install -r requirements.txt
```

### 3. Run the Python Analysis

Open:

```text
notebooks/mutual_fund_analysis.ipynb
```

and run the notebook to reproduce the data preparation, scoring and ranking workflow.

### 4. Run the MySQL Analysis

Execute:

```text
sql/01_setup_database.sql
```

to create the database and table.

Then use:

```text
sql/02_mutual_fund_queries.sql
```

to run the analytical queries.

### 5. Explore the Excel Dashboard

Open:

```text
excel/Mutual_Fund_Analytics.xlsx
```

Use the Dashboard, Fund Explorer and Fund Comparison sheets to interact with the analysis.

---

## 🚀 Future Improvements

Potential future improvements could include:

- Adding more recent fund data
- Incorporating additional historical periods
- Adding risk and drawdown metrics
- Automating dataset updates
- Expanding category-level analysis
- Adding more advanced portfolio-level analysis

---

## 📌 Disclaimer

This project is created for educational and analytical purposes. The rankings, scores, historical returns and comparisons shown in FundScope Analytics should not be interpreted as financial advice or recommendations to buy or sell any mutual fund.
