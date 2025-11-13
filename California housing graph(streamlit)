import streamlit as st
import pandas as pd
import matplotlib.pyplot as plt
import numpy as np

st.title("California Housing: Visual Comparison (1990 vs Updated)")

# Load cleaned data sets
cl_data_1990 = pd.read_csv('cleaned_california_housing_1990.csv')
cl_data_updated = pd.read_csv('cleaned_california_housing_updated.csv')

# Show summaries (similar to MATLAB summary)
st.subheader("Summary – 1990 Data")
st.write(cl_data_1990.describe(include='all'))

st.subheader("Summary – Updated Data")
st.write(cl_data_updated.describe(include='all'))


# -----------------------------
# Pie Charts for ocean_proximity
# -----------------------------
st.subheader("Ocean Proximity Distribution")

fig, axes = plt.subplots(1, 2, figsize=(10, 5))

# 1990 data pie
counts_1990 = cl_data_1990['ocean_proximity'].value_counts()
axes[0].pie(counts_1990.values, labels=counts_1990.index, autopct='%1.1f%%')
axes[0].set_title('Ocean Proximity - 1990 Data')

# Updated data pie
counts_updated = cl_data_updated['ocean_proximity'].value_counts()
axes[1].pie(counts_updated.values, labels=counts_updated.index, autopct='%1.1f%%')
axes[1].set_title('Ocean Proximity - Updated Data')

st.pyplot(fig)


# ----------------------------------------
# Grouped Bar: Median House Value by Age Bin
# ----------------------------------------
st.subheader("Median House Value by Housing Age Range")

# Same age bin edges and labels as MATLAB
edges = [0, 10, 20, 30, 40, 50, 60, 70, 80, 100]
xlabels = ['0-9', '10-19', '20-29', '30-39', '40-49',
           '50-59', '60-69', '70-79', '80+']

# Bin ages
age_bins_1990 = pd.cut(
    cl_data_1990['housing_median_age'],
    bins=edges,
    labels=xlabels,
    right=False,
    include_lowest=True
)

age_bins_updated = pd.cut(
    cl_data_updated['average_house_age'],
    bins=edges,
    labels=xlabels,
    right=False,
    include_lowest=True
)

# Compute mean median_house_value per bin
mean_value_1990 = cl_data_1990.groupby(age_bins_1990)['median_house_value'].mean()
mean_value_updated = cl_data_updated.groupby(age_bins_updated)['median_house_value'].mean()

# Align both on the same labels (like MATLAB's len = min(...))
index = mean_value_1990.index.union(mean_value_updated.index)
mean_value_1990 = mean_value_1990.reindex(index)
mean_value_updated = mean_value_updated.reindex(index)

fig, ax = plt.subplots(figsize=(10, 5))
x = np.arange(len(index))
width = 0.35

ax.bar(x - width/2, mean_value_1990.values, width, label='1990 Data')
ax.bar(x + width/2, mean_value_updated.values, width, label='Updated Data')

ax.set_xticks(x)
ax.set_xticklabels(index)
ax.set_xlabel('Housing Age Range')
ax.set_ylabel('Average Median House Value ($)')
ax.set_title('Comparison of Housing Median Age and Value')
ax.legend(loc='upper right')
ax.grid(axis='y')

st.pyplot(fig)


# ------------------------------------------------
# Grouped Bar: Median House Value by Ocean Proximity
# ------------------------------------------------
st.subheader("Median House Value by Ocean Proximity")

categories_1990 = cl_data_1990['ocean_proximity'].astype('category').cat.categories
categories_updated = cl_data_updated['ocean_proximity'].astype('category').cat.categories

# Merge categories
all_categories = sorted(set(categories_1990).union(set(categories_updated)))

mean_value_1990_op = []
mean_value_updated_op = []

for cat in all_categories:
    # 1990
    mask_1990 = cl_data_1990['ocean_proximity'] == cat
    if mask_1990.any():
        mean_value_1990_op.append(cl_data_1990.loc[mask_1990, 'median_house_value'].mean())
    else:
        mean_value_1990_op.append(np.nan)

    # Updated
    mask_updated = cl_data_updated['ocean_proximity'] == cat
    if mask_updated.any():
        mean_value_updated_op.append(cl_data_updated.loc[mask_updated, 'median_house_value'].mean())
    else:
        mean_value_updated_op.append(np.nan)

fig, ax = plt.subplots(figsize=(10, 5))
x = np.arange(len(all_categories))
width = 0.35

ax.bar(x - width/2, mean_value_1990_op, width, label='1990 Data')
ax.bar(x + width/2, mean_value_updated_op, width, label='Updated Data')

ax.set_xticks(x)
ax.set_xticklabels(all_categories, rotation=15)
ax.set_xlabel('Ocean Proximity')
ax.set_ylabel('Average Median House Value ($)')
ax.set_title('Comparison of Median House Value by Ocean Proximity')
ax.legend(loc='upper right')
ax.grid(axis='y')

st.pyplot(fig)


# -----------------------------
# Box Plot: Distribution Compare
# -----------------------------
st.subheader("Distribution of Median House Values")

combined_values = pd.concat([
    pd.DataFrame({'median_house_value': cl_data_1990['median_house_value'],
                  'Dataset': '1990'}),
    pd.DataFrame({'median_house_value': cl_data_updated['median_house_value'],
                  'Dataset': 'Updated'})
])

fig, ax = plt.subplots(figsize=(6, 5))
combined_values.boxplot(column='median_house_value', by='Dataset', ax=ax)
plt.suptitle("")  # remove default pandas boxplot title
ax.set_title('Comparison of Median House Value Distributions')
ax.set_ylabel('Median House Value ($)')

st.pyplot(fig)
