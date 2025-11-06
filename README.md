# SQL_Covid19_Data_Exploration
SQL Data Exploration project analyzing global COVID-19 data using MySQL

# SQL Data Exploration Project-COVID-19 Dataset

## 📌 Project Overview
This project focuses on exploring and analyzing COVID-19 data using **MySQL**.  
The goal is to practice SQL querying techniques while uncovering insights about global infection and vaccination trends.

---

## 🧰 Tools & Skills Used
- **Database:** MySQL  
- **Concepts:** Filtering, Aggregation, Joins, CTEs, Window Functions, Temporary Tables, Views  
- **Dataset:** [Our World in Data - COVID-19](https://ourworldindata.org/covid-deaths)  
- **Tables:** `coviddeaths`, `covidvaccinations`

---

## 📊 Key SQL Tasks

### 1. Data Preparation
- Cleaned dataset (set empty `continent` values to NULL)
- Verified data types and table structures using `SHOW TABLES` and `SHOW COLUMNS`

### 2. Data Exploration Queries
- **Total Cases vs Total Deaths:** Calculated death percentages by country.  
- **Total Cases vs Population:** Determined infection rates by population.  
- **Highest Infection Rate:** Found countries with the highest infection ratio.  
- **Highest Death Count:** Listed countries and continents with the largest total deaths.  
- **Global Numbers:** Computed global totals for cases, deaths, and death percentage.

### 3. Advanced Analysis
- **Joins:** Combined death and vaccination tables.  
- **CTE (Common Table Expression):** Calculated cumulative vaccination count per country.  
- **Temporary Table:** Stored rolling vaccination data for further exploration.  
- **View Creation:** Created a view `PercentPopulationVaccinated` for easy future visualization.

---

## 📈 Example Insights
- Some countries show over **30% population infection rate**.  
- Vaccination trends vary widely by continent.  
- Global death rate (deaths/cases) provides insight into pandemic severity.  

---

## 🌟 Key Takeaways
This project demonstrates:
- Strong understanding of **SQL fundamentals** and **data exploration techniques**.  
- Ability to handle **real-world datasets** (85k+ rows).  
- Skills in **data cleaning, joining, and aggregation**essential for data analyst roles.

