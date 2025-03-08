#BayesianBlups Minerals chickpea

library(rstanarm)
library(bayesplot)
library(shinystan)
options(mc.cores = parallel::detectCores())

setwd('/project/dthavar/dilthavar/ssalari/Chickpea Minerals analysis')

#For all minerals(Fe with outliers; so Fe is not considered)
df<- read.csv ("Mineraldata_noOutliers_Final.csv") 

head(df)


factors <- c(1:8)
Min_DATA[,factors] <- lapply(Min_DATA[,factors] , factor)
str(Min_DATA)

numbers <- c(9:17)
Min_DATA[,numbers] <- lapply(Min_DATA[,numbers] , as.numeric)
str(Min_DATA)

df <- Min_DATA

df[,1:8] <- lapply(df[,1:8], function(x) as.factor(x))
head(df)
numbers <- c(9:17)
df[,numbers] <- lapply(df[,numbers] , as.numeric)
str(df)
#Model1: (1|GenotypeNum) + (1|Rep) + (1|Site) + (1|Batch) 
Chickpea_Min_bayesianblups_Model2_NoOutliers <- unique(df[,c(8),drop=F])
str(Chickpea_Min_bayesianblups_Model2)
trait <- colnames(df)[9:17]

df[,1:8] <- lapply(df[,1:8], function(x) as.factor(x))
head(df)
Chickpea_Min_bayesianblups_Model1_NoOutliers <- df[,c(4,6)]
for (trait in c("Ca","Cu","Fe","K", "Mg", "Mn", "P", "Se", "Zn")){
  stan.model <- stan_lmer(paste0(trait, 
                                 " ~ (1|GenotypeNum) +(1|Site) + (1|Batch) + (1|Rep) "), 
                          data=df, adapt_delta = 0.99, seed=324)
  blups <- ranef(stan.model)$GenotypeNum
  blups$GenotypeNum <- rownames(blups)
  colnames(blups) <- c(trait, "GenotypeNum")
  Chickpea_Min_bayesianblups_Model1_NoOutliers <- merge(Chickpea_Min_bayesianblups_Model1_NoOutliers, blups, by="GenotypeNum")
}
write.csv(unique(Chickpea_Min_bayesianblups_Model2), " Chickpea_Min_bayesianblups_Model1_NoOutliers.csv", row.names = F, quote=F
          
          