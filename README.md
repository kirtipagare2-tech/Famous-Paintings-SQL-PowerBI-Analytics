# 🎨 Famous Paintings & Museum Analytics (End-to-End Data Analytics Project)

An end-to-end data analytics project built to explore, clean, and visualize a comprehensive dataset of famous paintings, world-renowned museums, and prolific artists. This project utilizes an advanced tech stack including *Python* for automated data loading, *PostgreSQL* for relational database management and data cleaning, and *Power BI* for interactive data modeling and business dashboarding.

<img width="1340" height="742" alt="dashboard" src="https://github.com/user-attachments/assets/a8abaaa0-eff0-489a-8b7d-79d5a2b14db0" />


---

## 🛠️ Tech Stack & Architecture
* *Data Source:* Kaggle (Famous Paintings Dataset containing 8 relational CSV files)
* *Data Loading:* Python (Pandas & SQLAlchemy)
* *Database Management:* PostgreSQL (pgAdmin 4)
* *Data Visualization & Modeling:* Power BI Desktop

---

## 🚀 Project Workflow

### 1. Advanced Data Loading via Python
The dataset consisted of 8 relational CSV files. Due to complex text fields and embedded special characters (such as museum URLs and art style descriptions), traditional SQL import wizards faced parsing errors (extra data after last expected column). 
To overcome this obstacle, a custom *Python script* was written using pandas and sqlalchemy to seamlessly parse, process, and automatically structure the tables directly into the local PostgreSQL server without any loss of data.

python
import pandas as pd
from sqlalchemy import create_engine
import os

# Database Connection
'''python
engine = create_engine('postgresql://postgres:YOUR_PASSWORD@localhost:5432/museum_db')
folder_path = r'C:\Your_Project_Folder_Path'
files_to_load = ['artist', 'canvas_size', 'museum', 'museum_hours', 'product_size', 'subject', 'work', 'image_link']

for file_name in files_to_load:
    full_path = os.path.join(folder_path, f"{file_name}.csv")
    df = pd.read_csv(full_path, on_bad_lines='skip', encoding='utf-8')
    df.to_sql(file_name, engine, if_exists='replace', index=False)
'''


### 2. Rigorous Data Cleaning & Standardization (PostgreSQL)
Once the raw tables were safely loaded into PostgreSQL, extensive data cleaning was performed to ensure 100% data integrity before pushing it to the visualization layer:
* *Handling Text Nulls:* Replaced missing categorical records in artist (like missing middle names) and work (like missing artistic styles) with standard 'Unknown' tags.
* *Fixing Structural Layout Errors:* Fixed foreign key alignment issues in the museum table where international postal codes (e.g., 75001, 29000) were mistakenly populated in the city column. These were updated to their actual city names (e.g., 'Paris', 'Tuxtla Gutierrez').
* *Enforcing Business Logic Restrictions:* Standardized financial fields in product_size ensuring that discounted sale_price never exceeds its baseline regular_price.
* *String Adjustments:* Cleaned up hidden trailing spaces across descriptive columns using the TRIM() function.
* *Data Type Modifications:* Transformed time variables in museum_hours from unstructured text columns into accurate, operational TIME data types to allow scheduling metrics.

---

## 🔎 Key Business Queries Solved (SQL Analytics)

The following high-level business questions were solved natively inside PostgreSQL using complex *Joins, Aggregations, and Window Functions*:

#### Q1: Identify all the museums that remain open on Sundays.
sql
SELECT m.name AS museum_name, m.city, m.country, mh.day
FROM museum m
JOIN museum_hours mh ON m.museum_id = mh.museum_id
WHERE TRIM(mh.day) = 'Sunday';


#### Q2: Find the top 5 artists who have created the highest number of paintings.
sql
SELECT a.full_name AS artist_name, COUNT(w.work_id) AS total_paintings
FROM artist a
JOIN work w ON a.artist_id = w.artist_id
GROUP BY a.full_name
ORDER BY total_paintings DESC
LIMIT 5;


#### Q3: Identify the most expensive painting, its sale price, and the name of the museum where it is located.
sql
SELECT w.name AS painting_name, m.name AS museum_name, ps.sale_price
FROM work w
JOIN museum m ON w.museum_id = m.museum_id
JOIN product_size ps ON w.work_id = ps.work_id
ORDER BY ps.sale_price DESC
LIMIT 1;


#### Q4: Find the total number of museums located in each country and display them in descending order.
sql
SELECT country, COUNT(museum_id) AS total_museums
FROM museum
GROUP BY country
ORDER BY total_museums DESC;


#### Q5: Display the top 3 most expensive paintings for each artistic style using a window function.
sql
SELECT style, painting_name, sale_price, painting_rank
FROM (
    SELECT w.style, w.name AS painting_name, ps.sale_price,
           DENSE_RANK() OVER(PARTITION BY w.style ORDER BY ps.sale_price DESC) AS painting_rank
    FROM work w
    JOIN product_size ps ON w.work_id = ps.work_id
) AS ranked_table
WHERE painting_rank <= 3;


---

## 📊 Interactive Power BI Dashboard & Data Modeling

The fully cleaned PostgreSQL relational tables were imported into *Power BI Desktop* using an efficient *Import Connectivity Mode*.

### 🕸️ Data Modeling (Star Schema)
Designed a centralized relational ecosystem within the Model View. The public_work table was established as the focal Fact table, linked harmoniously via robust *One-to-Many (1:) relationships** and optimized cross-filtering with supporting Dimension tables (artist, museum, product_size, etc.).

### 🎨 Visual Layout & Key Metrics Delivered
* *KPI Metrics:* Showcased a major executive high-utility KPI card locking down the absolute peak premium asset valuation fixed securely at *$1,115 (USD)* using customized interaction matrices.
*  *Volume Analytics:* Tracked and aggregated total paintings in the ecosystem (*14.78K items*).
* *Geographical Spread:* Displayed the density distribution of global galleries showing *USA* holding the absolute market lead.
* *Market Segmentation:* Mapped out categorical market share allocations across distinct creative genres using an immersive *Donut Chart* with exact integer distribution labels.
* *Dynamic Slicers:* Enabled a global country-level interactive filter allowing stakeholders to instantly isolate localized regional patterns across the entire canvas panel.

---

## 📈 Key Insights & Conclusions
1. *USA* leads the global landscape with the highest concentration of museums, making it a critical hub for historical art tracking.
2. The highest-priced painting listed in the collection sits at a value of *$1,115 (USD)*, providing clarity on peak asset values within world galleries.
3. Incorporating *Python data loading pipeline* saved valuable engineering hours by seamlessly passing complex dataset strings that natively failed under pure SQL import scripts.
