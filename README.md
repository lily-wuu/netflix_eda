# 🎬 Netflix Content Explorer  
**STAT 302: Data Visualization | Northwestern University**

This project is an interactive **R Shiny application** designed to explore the Netflix content library. Using a dataset of over **5,000 titles**, the app allows users to analyze trends in audience ratings (IMDb) and runtimes to find high-quality content efficiently.

---

## 🚀 What the App Does

The dashboard is organized into four easy-to-navigate sections:

### 📌 Overview  
Provides a high-level summary, including:
- Total count of works (5,283)  
- Average IMDb score (6.53)

### 📈 Visuals  
Features a dynamic histogram where users can switch between:
- **IMDb Score**
- **Runtime**

### 📚 Library  
A searchable database where users can find:
- Movie / TV show titles  
- Descriptions  
- Release years  

### 📖 References  
Contains data sources and project documentation.

---

## 🛠️ Key Interactive Features

- **Live Filtering**  
  Sidebar controls allow users to filter by *Movie* or *TV Show* and adjust the IMDb score range from **1.5 to 9.6**.

- **Visual Comparisons**  
  The *Visuals* tab includes **average and median reference lines** to help users compare individual titles against the rest of the library.

- **Search Tool**  
  A built-in search bar enables instant lookup of specific titles.

---

## 💻 Technical Stack

- **Language:** R  
- **Framework:** Shiny (Reactive Programming)  
- **Visualization:** ggplot2 (Dynamic Histograms and Bar Charts)  
- **Data Tools:** Tidyverse (Data cleaning and wrangling)

---

## 📊 Project Methodology

### Objective  
This tool was created to practice data visualization skills from STAT 302 and help users discover highly-rated Netflix content more efficiently.

### Data Source  
The dataset comes from the **Netflix TV Shows and Movies** repository on GitHub, reflecting the U.S. library as of May 2022:

👉 https://github.com/victorsoeiro/netflix-tv-shows-and-movies

Created by Victor Soeiro.

### Transparency  
Generative AI was used as a coding aid for debugging and researching specific Shiny functions. All AI-assisted code chunks are clearly commented within the R script.

---

## ⚖️ License

The Dataset is under [CC0: Public Domain Dedication.](https://creativecommons.org/publicdomain/zero/1.0/) and all the credits goes to Victor Soeiro creator of this [dataset in Kaggle](https://www.kaggle.com/datasets/victorsoeiro/netflix-tv-shows-and-movies) 

---
