library(readr)
library(RColorBrewer)
library(ggplot2)
# I had a dataframe (GAPIT.Genotype.origin.PCA.csv) with the following columns: AccessionID, PCA1, PCA2, group
# "group" was the admixture group of the accession.
# You will also have a column with country of origin

#### GGPLOT Admixture Plot ####
# sorted_df was converted to 4 columns in excel
# columns: order, taxa, percent, group

setwd("/project/dthavar/dilthavar/ssalari/Chickpea_Minerals_analysis/GWAS_Batch_effects/PCA")
PCA <- read.csv("GAPIT.Genotype.PCA_Chickpea_MIN.csv")

#PCA Origin
head(PCA)
PCA$subpopulation <- as.factor(PCA$Origin)
ggplot(PCA, aes(PC1, PC2, color=Origin)) +
  geom_point(size=2, show.legend = TRUE) +
  scale_color_brewer(palette="Dark2")+
  #scale_color_okabe_ito(order = 1:6) +
  theme_bw() +
  theme(panel.grid.minor = element_blank())

#PCA Type
PCA$subpopulation <- as.factor(PCA$Type)
ggplot(PCA, aes(PC1, PC2, color=Type)) +
  geom_point(size=2, show.legend = TRUE) +
  scale_color_brewer(palette="Set1")+
  #scale_color_okabe_ito(order = 1:2) +
  theme_bw() +
  theme(panel.grid.minor = element_blank())


#PCA Admix
# Clean the data (if needed)
PCA_clean <- na.omit(PCA)

# Plot with manually specified shapes and color
ggplot(PCA_clean, aes(PC1, PC2, shape = Subpopulation, color = Subpopulation)) +
  geom_point(size = 2, show.legend = TRUE) +
  scale_color_brewer(palette = "Set1") +
  scale_shape_manual (values = c(11, 20, 1, 8, 15, 16, 17, 22, 6)) +  # Specify shapes for 9 subpopulations
  theme_bw() +
  theme(panel.grid.minor = element_blank())





RColorBrewer::brewer.pal.info

