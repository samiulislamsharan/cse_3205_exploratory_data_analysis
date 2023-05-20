# Install required packages
install.packages("DataExplorer")
install.packages("dplyr")

# Load in libraries
library(DataExplorer)
library(dplyr)
library(rmarkdown)

# View the Column Specifications
spec(transplant_dataframe)

# Get a glimpse of the data
glimpse(transplant_dataframe)

# Return a list of objects and their structure
str(transplant_dataframe)

# Set working directory
print(getwd())
setwd("J:/My Drive/CUB/SPRING - 2023/CSE-3205-Applied Statistics and Queuing Theory/Assignment")

# Rename multiple columns using rename()
transplant_dataframe_dataframe = read.csv("transplant.csv")
transplant_dataframe_dataframe <- transplant_dataframe_dataframe %>% 
  rename(
         "Serial_No."        = "X",
         "Age"               = "age",
         "Sex"               = "sex",
         "Blood Group"       = "abo",
         "Year"              = "year",
         "Time"              = "futime",
         "Final_Disposition" = "event")

glimpse(transplant_dataframe)

# Quickly visualize the structure of all
plot_str(transplant_dataframe)

# To get introduced to dataset
introduce(transplant_dataframe)

# To visualize the table above (with some light analysis)
plot_intro(
            transplant_dataframe,
            title = "Basic information about the dataset",
            # geom_label_args = c(hjust = "inward")
          )

# plot missing values plot
plot_missing(transplant_dataframe)

# Plot each continuous column
plot_histogram(
                transplant_dataframe,
                ncol = 2L)


# plot a boxplot by species of penguins
plot_boxplot(
              transplant_dataframe,
              by = "Age",
              ncol = 2L
            )

# Plot each discrete column
plot_bar(
          transplant_dataframe, 
          order_bar = TRUE
        )

# plot correlation matrix for all features
plot_correlation(
                  transplant_dataframe,
                  type = "discreet")


create_report(
                transplant_dataframe,
                output_file = "transplant_dataframe_report.html",
                output_dir = getwd(),
                config = configure_report(),
                report_title = "Data Report On: Liver Transplant Waiting List"
              )

system.file("rmd_template/report.Rmd", package = "DataExplorer")

