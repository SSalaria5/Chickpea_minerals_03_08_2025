library(GAPIT)

# Set working directory for phenotypic data
setwd('/project/dthavar/dilthavar/ssalari/Chickpea_Minerals_analysis')

# Load phenotypic data
myY <- read.csv("ChickpeaMin_bayesianblups_Model1_Interaction_NoOutliers.csv", header = TRUE, sep = ",")

# Set working directory for genotypic data
setwd('/project/dthavar/dilthavar/ssalari/Chickpea_Minerals_analysis')

# Load genotypic data
myG <- read.delim(file="CP.final.hapmap.hmp.txt", header = FALSE, sep = "\t")

# Set working directory for analysis
setwd('/project/dthavar/dilthavar/ssalari/Chickpea_Minerals_analysis/GWAS_Batch_effects/Model1_GWAS_HighMAF/Zn')

# Run GAPIT GWAS analysis
myGAPIT <- GAPIT(
  Y = myY[, c("ID", "Zn")],  # Select ID and Ca columns for phenotypic data
  G = myG,  # Genotypic data
  PCA.total = 5,  # Number of principal components to use
  model = c("GLM", "MLM", "Blink", "FarmCPU"),  # Models to use
  SNP.MAF = 0.078125,
  SNP.FDR = 0.05  # False discovery rate threshold for SNP significance
   )


###### Script used above this line########
###### Ask Nathan about error in for loop here #########
for (i in seq(3:11))
  myGAPIT=GAPIT(
    Y=myY[,c("ID",i)], #fist column is ID
    G=myG,
    PCA.total=5,
    model=c("GLM","MLM", "Blink", "FarmCPU"),
    SNP.MAF=0.05,
    SNP.FDR=0.05)