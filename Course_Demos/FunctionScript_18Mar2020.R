# --------------------------------------
# Illustrate the use of functions and structured programming
# 18 Mar 2020
# NJG
# --------------------------------------
# All functions must be included at the top
# of the program before they are called
# --------------------------------------
# load libraries --------------------------------------
library(ggplot2)

# source files --------------------------------------
source("Course_Demos/MyFunctions.R")

# global variables --------------------------------------
ant_file <- "Course_Demos/antcountydata.csv"
x_col <- 7 # column 7, latitude center of each county
y_col <- 5 # column 5, number of ant species
########################################

# read in data
temp1 <- get_data(file_name=ant_file)

x <- temp1[,x_col] # extract predictor variable
y <- temp1[,y_col] # extract response variable

# fit regression model
temp2 <- calculate_stuff(x_var=x, y_var=y)

# extract residuals
temp3 <- summarize_output(z=temp2)

# create graph
graph_results(x_var=x, y_var=y)

print(temp3) # show residuals
print(temp2) # show model summary
