## Merging Summary Data with Temperature Data


#creating and setting working directories 
wd=paste("C:/Users/jennm/Dropbox/PROJECTS/Channel_Islands_Kelp")
setwd(wd)

data_dir=paste(wd,"/data",sep="")
scripts_dir=paste(wd,"/scripts",sep="")
plots_dir=paste(wd,"/plots",sep="")

#bringing in data
setwd(data_dir)
sst=read.csv("SST_TS.csv")
sst_kelp=subset(sst,sst$Notes=="from Jenn")
comparison=read.csv("Unique_Pixel_Compare_DF_georef_Aug26_distMPA_lessthan5km_EW_index.csv")


dim(sst_kelp)
names(sst_kelp)

sst_kelp_annual=sst_kelp %>%
  select(site_id,SST,YEAR)%>%
  group_by(site_id,YEAR)%>%
  summarise(annual_SST=mean(SST))

write.csv(sst_kelp_annual,"mean_annual_sst_byMPA.csv")




sum=read.csv("Summary_Table_Channel_Island_Kelp_19842011_LT3000km_SST.csv")


### Change in Delta Kelp
library(dplyr)
library(ggplot2)
sum %>% 
  select(SST,Change_in_Delta)%>%
  ggplot(aes(SST,Change_in_Delta))+geom_point()

fit=lm((Change_in_Delta)~SST,sum)
fit  
summary(fit)

### Change in slope of relationship between average kelp biomass per pixel and the  distance from the MPA
library(dplyr)
library(ggplot2)
sum %>% 
  select(SST,Distance_Slope_Post,Distance_Slope_Pre)%>%
  mutate(delta_slope_distance=Distance_Slope_Post-Distance_Slope_Pre)%>%
  ggplot(aes(SST,delta_slope_distance))+geom_point()

fit=lm((Distance_Slope_Post-Distance_Slope_Pre)~SST,sum)
fit  
summary(fit)


### Change in slope of relationship between average kelp biomass per pixel and the degree of protection recieved
library(dplyr)
library(ggplot2)
sum %>% 
  select(SST,Protection_Slope_Post,Protection_Slope_Pre)%>%
  mutate(delta_slope_protection=Protection_Slope_Post - Protection_Slope_Pre)%>%
  ggplot(aes(SST,delta_slope_protection))+geom_point()

fit=lm((Protection_Slope_Post-Protection_Slope_Pre)~SST,sum)
fit  
summary(fit)
