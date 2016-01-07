## Introduction

This is my solution for the first programming assignment in "Exploratory Data Analysis", offered January 2016 on Coursera.org. It uses data from the UC Irvine Machine Learning Repository, which can be separately downloaded from either the course website or UC Irvine. I am not including the raw data in this repository, as it is >100MB, and including it here is a significant bandwidth burden.

The general strategy was to load in only the date column, search through that for valid indices, and only load the data for the appropriate date range in. In this manner I reduce the memory required and increase the speed of data loading.

Please see the files "plot1.R", "plot2.R", "plot3.R", and "plot4.R" for the code that generated the corresponding figures.

