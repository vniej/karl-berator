
## Project Overview
The aim of this project is to investigate the effect of a new treatment on the growth factor of gene expression. The data was provided by Dr Karl Berator, a research assistant at the Institute of -omics. The outcomes included plots, a sample size calculation and an IMRaD report that has a predictive model for gene expression.

## Data Cleaning
The provided data is in the folder raw-data. The cleaned dataset was manually formatted from the multiple sheets provided such that there is one CSV file with the following five columns:

- gene_expression: A 6 character code starting with GL- that specifies the gene line, 
- concentration: an integer between 0 and 10, measured in $\mu g/ml$,
- growth_factor: a number indicating the growth of each gene line,
- cell_type: each gene line was classified as Wild-type or Cell-type 101 and,
- treatment: the new treatment, activating factor 42, was compared with a placebo.

The 2023_03_21-gene_expression.csv is the final dataset used in the project.

## Data Analysis Tasks
The code was developed in R and is in the folder R.
The code is ordered by A1-A4, which corresponds to the order the tasks were given. These are detailed below and in the R scripts.

### Exploratory Data Analysis (EDA)

A1 provides an initial EDA consisting of some stats and plots of the relationship between gene expression and treatment to feature in a powerpoint presentation. The figures are in the figs folder and the powerpoint is in the folder presentations. The data table in the powerpoint was produced by reading the stats off the box plots by producing a function.

### Plot 

A2 is the reproduction of a provided gene plot so that the font is Times New Roman and the file format is a 500dpi tiff. The provided plot is in the folder resources. The font Times New Roman is available in the folder figs. The final plot is not uploaded to Github due to file size. This plot can be accessed [here](https://drive.google.com/file/d/1kPGf-NA2w1EzNAIo1YzWQnGgZrNmteIz/view?usp=sharing).

### Sample Size Calculation

A3 is the sample size calculation for the number needed for the experiment with a power of 90% and a significance of 5%. The F-statistic to exlain the significance of the regression model is $$F=\frac{\frac{R^2}{k}}{\frac{1-R^2}{n-k-1}}$$ where $n$ is the total observations, $R^2$ is the coefficient of determination and $k$ is the number of regressors. The process to calculate the sample size is explained in A3.R with the help of this [tutorial](https://data-se.netlify.app/2018/07/24/power-calculation-for-the-general-linear-model/).

### Predictive Model and IMRaD Report

A4.qmd is the IMRaD report of a predictive model for gene expression. A4.R is an initial calculation for the random mixed effects model. This file can be ignored as the full process is in A4.qmd. The submitted IMRaD report is as a pdf in the presentations folder.
