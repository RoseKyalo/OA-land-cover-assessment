# Oath Path Assessment

**Name:** Rose Kawila Kyalo  
**Date:** 25th March 2026  
**Position:** GeoSpatial Analyst Internship

## Overview

This repository contains my submission for the Oath Path GeoSpatial Analyst Internship assessment. The assessment consists of two projects completed within a 3-hour window. Project 1 focuses on land cover classification using satellite imagery and machine learning, and Project 2 covers SQL querying.

## Project 1 : Land Cover Classification, South-Western province of Rwanda

### What the Project Does

The goal was to build a machine learning model that classifies land use and land cover across a region in the South-Western province of Rwanda using a multispectral Sentinel-2 satellite image. The target classes are:

- Forest
- Tea
- Water
- Other
- Buildings *(see note below)*

### Data

| File | Description |
|---|---|
| `S2_srw.tif` | Sentinel-2 multispectral image (11 bands, 881 × 654 pixels, EPSG:4326) |
| `train_val.shp` | Training and validation points (200 samples per class) |

### Approach

**1. Data Understanding**  
The satellite image was loaded and inspected. It contains 11 bands (B2–B12) in reverse order, with the coordinate reference system EPSG:4326. The training shapefile was also explored, all four available classes are balanced at 200 samples each.

**2. Feature Engineering**  
Three spectral indices were computed from the raw bands to improve the model's ability to distinguish land cover types:

- **NDVI** (Normalized Difference Vegetation Index) : highlights vegetation such as forest and tea
- **NDWI** (Normalized Difference Water Index) : highlights water bodies
- **NDBI** (Normalized Difference Built-up Index) : highlights built-up areas

The final feature set combines all 11 raw bands with the 3 computed indices, giving 14 features per pixel.

**3. Model Training**  
A Random Forest Classifier was trained using Stratified 5-Fold Cross-Validation as specified in the assessment brief. This approach is more reliable than a single train-test split because every sample is tested at least once across the 5 folds.

**4. Model Evaluation**  
The model was evaluated using a normalized confusion matrix and a full classification report. Normalization converts raw prediction counts to percentages, allowing fair comparison across classes regardless of sample size.

**5. Prediction and Visualization**  
The trained model was applied to every pixel in the satellite image to produce a full land cover map of the study area, saved as a GeoTiff file.

### Results

| Metric | Value |
|---|---|
| Cross-validation accuracy | 91% |
| Mean accuracy (5 folds) | 0.9100 |
| Standard deviation | 0.0140 |
| Training accuracy | 100% |

The cross-validation accuracy of 91% is the more reliable indicator of real-world performance. The 100% training accuracy suggests some level of overfitting on the training data, which is expected when evaluating on the same data used for training.

All four classes achieved F1-scores close to or equal to 1.00. Water was perfectly classified with no misclassifications, which is consistent with its distinct NDWI signature. Forest and tea showed very minor confusion (around 0.005), which is expected given their spectral similarity as vegetation classes.

### Note on the Buildings Class

The provided training dataset did not include the buildings class. Ideally, this would have been added manually using QGIS before modeling. However, due to network connectivity issues, QGIS could not be downloaded and installed within the allocated time. Alternative approaches such as OpenStreetMap extraction were also not feasible under the time constraints.

As a result, the model was trained on four classes. The notebook includes a detailed step-by-step walkthrough of how the buildings class would have been added using QGIS, including digitizing building points from the satellite image and merging them with the original training shapefile.

## Project 2 : SQL Queries

### What the Project Does

A provided PostgreSQL database (`postgresql_18.sql`) was loaded into a local PostgreSQL instance and queried using Python. Results were saved as CSV files.

### Queries Performed

| Query | Description | Output File |
|---|---|---|
| 1 | Total number of rows in the accounts table | `total_rows_accounts.csv` |
| 2 | Total dollar amount of sales from orders | `total_sales_usd.csv` |
| 3 | Earliest order ever placed | `earliest_order.csv` |
| 4 | Account names and their order dates | `account_order_dates.csv` |

### Setup

```bash
# Connect to the database
Host    : localhost
Port    : 5432
Database: Project 2 Assessment DB
```

## How to Run

### Requirements

```bash
pip install numpy pandas matplotlib seaborn scikit-learn rasterio geopandas shapely fiona notebook psycopg2-binary sqlalchemy
```

### Project 1

```bash
# Open the notebook
jupyter notebook Rose_Kawila_Assessment_notebook_file.ipynb
```

Make sure `S2_srw.tif` and `train_val_SW_rwanda.shp` are in the same directory as the notebook before running.

### Project 2

```bash
# Load the SQL file into PostgreSQL via pgAdmin
# Then run the SQL file
```

---

## Repository Structure

```
OA_test/
│
├── Rose_Kawila_Assessment_notebook_file.ipynb   # Project 1 — main notebook
├── train_val.shp                      # Training points shapefile
├── SQL csv files/                               # Project 2 CSV outputs
│   ├── total_rows_accounts.csv
│   ├── total_sales_usd.csv
│   ├── earliest_order.csv
│   └── account_order_dates.csv
└── README.md
```

## Environment

```
Python        : 3.11.13
Kernel        : cmuenv
Key libraries : rasterio, geopandas, scikit-learn, numpy, pandas, matplotlib
```