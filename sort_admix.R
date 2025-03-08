# Load required libraries
library(RColorBrewer)
library(tidyr)
library(dplyr)
library(ggplot2)

# Manually set input files (for RStudio usage)
setwd("/project/dthavar/dilthavar/ssalari/Chickpea_Minerals_analysis/plink/ADMIX_Min")
FILENAME <- "log8.out"  # Set the path to your admixture log output file (log8.out)
LINE_NAMES_FILE <- "samples.txt"  # Set the path to your sample names file (samples.txt)

# Or, if you're running the script from the command line, use:
# args <- commandArgs(trailingOnly=TRUE)
# FILENAME <- args[1]  # Input file (log8.out)
# LINE_NAMES_FILE <- args[2]  # Sample names file (samples.txt)

# Check if correct number of arguments is provided (for command-line use)
if (is.na(FILENAME) | is.na(LINE_NAMES_FILE)){
  print("ERROR: No file included.")
  print("Usage: Rscript sort_admix.R log8.out samples.txt")
  quit("no")
}

# READ DATA
df <- read.table(FILENAME, header=FALSE, fill=TRUE, na.strings="NA", sep=" ")  # Read admixture output (log8.out)
head(df)
samples <- read.table(LINE_NAMES_FILE, header=FALSE) #(get a row in samples.txt)
if (nrow(df) != length(samples$V1)) {
  stop("The number of rows in the admixture output does not match the number of sample names.")
}
samples <- read.table(LINE_NAMES_FILE, header=FALSE)  # Read sample names (samples.txt)
rownames(df) <- samples$V1  # Assign sample names as row names

# Function to sort data frame by column
sort_admixture <- function(df, col){
  return(df[order(df[col], decreasing=T),])
}

# Sort the dataframe
dimensions <- c(dim(df)[1])
columns <- colnames(df)
sorted_df <- data.frame()

# Grouping data and sorting by proportions
group_numbers <- c()
for (column in 1:length(columns)){
  df <- sort_admixture(df, column)
  if (column != length(columns)){
    cut_df <- df[df[column] < 0.5000001,]  # Apply cutoff to split populations
    dimensions <- c(dimensions, dim(cut_df)[1])
    slice_df <- df[1:(dimensions[column] - dimensions[column + 1]),]
    group_numbers <- c(group_numbers, rep(column, nrow(slice_df)))
    sorted_df <- rbind(sorted_df, slice_df) 
    df <- cut_df
  } else {
    group_numbers <- c(group_numbers, rep(column, dim(samples)[1] - length(group_numbers)))
  }
}

# Append remaining rows
sorted_df <- rbind(sorted_df, df)

# Create and save plot
pdf("admixture.pdf")
barplot(t(as.matrix(sorted_df)), 
        col=brewer.pal(n=length(columns), name="Set1"),
        xlab="Individual #", 
        ylab="Ancestry", 
        border=NA,
        space = 0
)
dev.off()

# Add group information and save CSV files
sorted_df$group <- group_numbers
write.csv(sorted_df[, c(1, ncol(sorted_df))], "admix.plot_data.csv")  # Save grouped data
write.csv(sorted_df, "all_admix.csv")  # Save all data
