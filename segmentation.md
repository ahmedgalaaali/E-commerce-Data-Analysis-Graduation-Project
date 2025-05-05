
# 🧠 RFM Customer Segmentation (Part of E-commerce Analysis Project)

## 📌 Project Context

This notebook is a **component of a larger E-commerce Data Analysis Project**.  
It focuses on segmenting customers based on their **RFM (Recency, Frequency, Monetary)** metrics and applying **KMeans clustering** to derive actionable customer groups.

This segmentation helps improve marketing, customer retention, and loyalty programs.

---

## 📊 RFM Explanation

| Metric   | Meaning                             | Calculation                                                  |
|----------|-------------------------------------|--------------------------------------------------------------|
| Recency  | How recently the customer purchased | Days since the last purchase                                 |
| Frequency| How often the customer purchased    | Total number of transactions per customer                    |
| Monetary | How much the customer spent         | Sum of all transaction values per customer                   |

---

## 🧮 Steps Followed

### 1. Data Preparation
- Merged transactional data with time data using `time_key`.

### 2. RFM Metrics Calculation
```python
recency = df.groupby('customer_key')['date'].max()
frequency = df.groupby('customer_key')['payment_key'].count()
monetary = df.groupby('customer_key')['total_price'].sum()
```

### 3. Construct RFM Table
Combined Recency, Frequency, and Monetary into a single DataFrame `rfm_df`.

---

## 🔁 Customer Clustering

### Clustering with KMeans
- Used `StandardScaler` for normalization.
- Applied **Elbow Method** to determine the best number of clusters.
- Used **KMeans** to segment customers.

```python
from sklearn.cluster import KMeans
kmeans = KMeans(n_clusters=4, random_state=42)
rfm_df['Cluster'] = kmeans.fit_predict(rfm_scaled)
```

---

## 📈 Visualizations

- **2D Seaborn Plots**: Recency vs Frequency & Frequency vs Monetary
- **3D Plotly Visualization**: Recency vs Frequency vs Monetary

These plots help visually understand customer clusters and patterns.

---

## 🔍 Insights from Clustering

- **Cluster 3**: High-Value Customers → Low Recency, High Frequency, High Monetary
- **Cluster 0**: At-Risk Customers → High Recency, Medium Frequency
- **Cluster 1**: New or Low-Spend Customers → High Recency, Low Frequency

These insights can support marketing segmentation and campaign design.

---




## 🧠 Tools & Libraries

- Python, Pandas, NumPy
- Scikit-learn, Plotly, Seaborn, Matplotlib
- Jupyter Notebook

---
