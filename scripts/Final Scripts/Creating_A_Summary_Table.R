## Extracting summary table inforamtion

## this script was created by Jenn McHenry
## Last updated: August 25th 2017


## Things to put together
# 1)      Index column.  Just a number that lets us sort the MPAs from west to east
# 2)      MPA name
# 3)      in out before. The average difference in kelp abundance over the period between 1995 through 2002 inclusive.
# 4)      In out after. The average difference in kelp abundance over the period between 2004 through 2011 inclusive
# 5)      change after minus before, column four minus column three
# 6)      pre-MPA spill-out.  The slope of the relationship between distance from the MPA edge and average kelp biomass, calculated only for pixels which are outside the MPA but nearby to the mpa (1km? 2km?) for the period between 1995 to 2002 inclusive. 
# 7)      pre-MPA spill-out.  The slope of the relationship between distance from the MPA edge and average kelp biomass, calculated only for pixels which are outside the MPA but nearby to the mpa (1km? 2km?) for the period between 2004 to 2011 inclusive.
# 8)      Change in spill-out.  Col 7 - col 6
# 9)      pre-MPA spill-in.  The slope of the relationship between proportion of protection and average kelp biomass, calculated only for pixels which are INSIDE the MPA but nearby to the mpa (1km? 2km?) for the period between 1995 to 2002 inclusive. 
# 10)   pre-MPA spill-in.  The slope of the relationship between Proportion of protection from the MPA edge and average kelp biomass, calculated only for pixels which are INSIDE the MPA but nearby to the mpa (1km? 2km?) for the period between 2004 to 2011 inclusive.
# 11)   Change in spill-in. col 10-col 9



#reading in used libraries
library(sp)
library(rgdal)
library(rgeos)
library(maptools)
library(raster)
library(tools)
library(Imap)
library(plyr)
library(reshape2)

#Setting working coordinate system
WGS84=CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs")
NAD83=CRS("+proj=longlat +ellps=GRS80 +datum=NAD83 +no_defs")
NAD83_proj=CRS("+proj=utm +zone=10 +ellps=GRS80 +datum=NAD83 +units=m")
WGS84_proj=CRS("+proj=utm +zone=10 +ellps=WGS84 +datum=WGS84 +units=m +no_defs")
Teales=CRS("+proj=aea +lat_1=34 +lat_2=40.5 +lat_0=0 +lon_0=-120+x_0=0 +y_0=-4000000 +ellps=GRS80 +datum=NAD83 +units=m +no_defs")



#Setting the working directory
data_dir<-"C:/Users/jennm/Dropbox/PROJECTS/Channel_Island_Kelp_MPAs_working/data"
plot_dir<-c("C:/Users/jennm/Dropbox/PROJECTS/Channel_Island_Kelp_MPAs_working/plots")
scripts_dir<-"C:/Users/jennm/Dropbox/PROJECTS/Channel_Island_Kelp_MPAs_working/scripts"
functions_dir<-"C:/Users/jennm/Dropbox/PROJECTS/Channel_Island_Kelp_MPAs_working/functions"
kelp_raw_dir<-"C:/Users/jennm/Dropbox/PROJECTS/Channel_Island_Kelp_MPAs_working/data/Kelp_Raw"
kelp_raster_dir<-"C:/Users/jennm/Dropbox/PROJECTS/Channel_Island_Kelp_MPAs_working/data/Kelp_Raster"
temp_plot_dir<-"C:/Users/jennm/Dropbox/PROJECTS/Channel_Island_Kelp_MPAs_working/plots/Temp_plot_dir"


#bringing in functions
source(paste(functions_dir,"/Summary_SE_Function.R",sep=""))

## Joining the East West Id Inforamtion
# Load shapefile of the MPAs for E-W ranking info
setwd(data_dir)
MPAs_proj<- readShapePoly(paste(data_dir,"/MPAs_WGS_proj.shp",sep=""), verbose=TRUE, proj4string=WGS84_proj)
names(MPAs_proj)
MPAs_proj$Name
MPAs_proj$Type

Summary_DF<-as.data.frame(MPAs_proj)
head(Summary_DF)

# Determining the average delta kelp before MPAs placement and after 
DF_ALL<-read.csv("Unique_Pixel_Compare_DF_georef_July27_distMPA_lessthan5km.csv")
head(DF_ALL)


##adding name inforatmion consistent with previous analysis
nm<-unique(Summary_DF[c(1:3)]);nm
nm<-paste("MPA_Shape",nm$Id,nm$type,nm$Name,sep="_")
nm<-as.data.frame(cbind(nm,unique(Summary_DF[c(1)])));nm

# joining together EW index info to main data frame
Summary_DF<-join(Summary_DF,nm,by="Id")
head(Summary_DF)


Summary_DF_ALL<-join(DF_ALL,Summary_DF,by="nm")
head(Summary_DF_ALL)

# write.csv(Summary_DF_ALL,"Unique_Pixel_Compare_DF_georef_Aug26_distMPA_lessthan5km_EW_index.csv")


Summary_DF_ALL$Time_Period<-ifelse(Summary_DF_ALL$YEAR>=2004,"Post-MPA",2003)
Summary_DF_ALL$Time_Period<-ifelse(Summary_DF_ALL$YEAR<=2002,"Pre-MPA",Summary_DF_ALL$Time_Period)
Summary_DF_ALL$Time_Period<-ifelse(Summary_DF_ALL$YEAR<=1994,NA,Summary_DF_ALL$Time_Period)
summary(Summary_DF_ALL)

Summary_DF_ALL<-subset(Summary_DF_ALL,Summary_DF_ALL$Pixel_B_distMPA<=3000)


names(Summary_DF_ALL);summary(Summary_DF_ALL)


Summary_DF_IO<-subset(Summary_DF_ALL,Summary_DF_ALL$comparison_id=="1-0")
names(Summary_DF_IO);head(Summary_DF_IO);summary(Summary_DF_IO)
Delta_Kelp_DF<-Summary_DF_IO[c(19,23:26)];names(Delta_Kelp_DF);summary(Delta_Kelp_DF)

Delta_Kelp_DF<-summarySE(Delta_Kelp_DF,measurevar = c("Delta_Kelp"),groupvars = c("E_W","Name","type","Time_Period"))
head(Delta_Kelp_DF);summary(Delta_Kelp_DF)

Delta_Kelp_DF$Time_Period <- factor(Delta_Kelp_DF$Time_Period, levels = c("Pre-MPA","2003","Post-MPA"))

library(ggplot2)
## plotting average delta by MPA
p<-ggplot(data=Delta_Kelp_DF, aes(x=as.factor(E_W), y=Delta_Kelp,fill=Time_Period)) +
  geom_bar(stat="identity",position="dodge",colour="black", size=.3) +
  theme_minimal() +ggtitle("Average Difference Between Kelp Biomass Inside Verses Outside of MPAs") +
  xlab("Proportion of Protection") + ylab("Delta Kelp Biomass") + 
  scale_x_discrete(labels = c("2" = "Judith Rock","3" = "Harris Point","4" = "South Point",
                              "5" = "Carrington Point","6" = "Skunk Point","8"="Gull Rock","9"="Scorpion Rock",
                              "10"="Anacapa Island","11"="Anacapa Island SMR","12"="Santa Barbara Island")) +
  geom_errorbar(aes(ymin=Delta_Kelp-se, ymax=Delta_Kelp+se), position=position_dodge(.9), width=.5)
p
setwd(plot_dir)
ggsave("Mean_Delta_by_Timeperiod.tiff",width = 12,height = 6)

setwd(data_dir)

#reshaping dataframe into the format that Rass requested.
names(Delta_Kelp_DF)
library(reshape2)
require(stats)
DF_1<-reshape(data = Delta_Kelp_DF[c(1:4,6,8)],
             idvar = c("E_W","Name","type"),
             v.names = c("Delta_Kelp","se"),
             timevar = "Time_Period",
             direction = "wide")

DF_OUT<-join(Summary_DF[c(4,2:3)],DF_1)


#making a change in delta column
DF_OUT$Change_in_Delta<-DF_OUT$`Delta_Kelp.Pre-MPA`-DF_OUT$`Delta_Kelp.Post-MPA`




#extracting before and after slopes
DF_TimePeriod<-read.csv("FINAL_Kelp_19842011_Dataframe_07_12_2017.csv")


head(DF_TimePeriod)
summary(DF_TimePeriod)


DF_TimePeriod<-subset(DF_TimePeriod,DF_TimePeriod$distMPA<=3000)

DF_TimePeriod<-DF_TimePeriod[complete.cases(DF_TimePeriod),]
names(DF_TimePeriod)


Attributes<-DF_TimePeriod[c(37:38,41,5:7)];head(Attributes)

# hist(DF_TimePeriod$distMPA)
# far_points<-subset(DF_TimePeriod,DF_TimePeriod$distMPA>=15000)
# coordinates(far_points)<-~X+Y
# plot(DF_TimePeriod_melted_MSE_Attributes)
# plot(Channel_Islands_proj,add=TRUE)
# plot(far_points,add=TRUE,col="red")



DF_TimePeriod<-DF_TimePeriod[c(37:38,8:35)];head(DF_TimePeriod)

DF_TimePeriod_melted<-melt(DF_TimePeriod, id.vars=c("name","cell_id"))

DF_TimePeriod_melted$YEAR<-gsub("X","",DF_TimePeriod_melted$variable)
DF_TimePeriod_melted$YEAR<-as.numeric(DF_TimePeriod_melted$YEAR)
DF_TimePeriod_melted$Time_Period<-ifelse(DF_TimePeriod_melted$YEAR>=2004,"Post-MPA",NA)
DF_TimePeriod_melted$Time_Period<-ifelse(DF_TimePeriod_melted$YEAR<=2002,"Pre-MPA",DF_TimePeriod_melted$Time_Period)
DF_TimePeriod_melted$Time_Period<-ifelse(DF_TimePeriod_melted$YEAR<=1994,NA,DF_TimePeriod_melted$Time_Period)


DF_TimePeriod_melted_Attributes<-join(DF_TimePeriod_melted,Attributes,by="cell_id")

mpalist_2<-as.data.frame(unique(DF_TimePeriod_melted_Attributes$name));mpalist_2

DF_2<-data.frame(NULL)
##Getting the slope by time period based on the proportion of protection
for (i in 1:nrow(mpalist_2)){
  m=mpalist_2[i,]
  DF_sub<-subset(DF_TimePeriod_melted_Attributes,DF_TimePeriod_melted_Attributes$name==m)
  nm<-as.character(DF_sub$name[1])
  DF_sub<-subset(DF_sub,DF_sub$prop_overlap>0)
  length<-nrow(DF_sub)
  if (length>0){
    #Plotting average deltas by year
    fit_pre<-lm(value~prop_overlap,data=subset(DF_sub,DF_sub$Time_Period=="Pre-MPA"))
    summary(fit_pre)
    fit_post<-lm(value~prop_overlap,data=subset(DF_sub,DF_sub$Time_Period=="Post-MPA"))
    out<-as.data.frame(nm);
    out<-cbind(out,fit_pre$coefficients[2],fit_post$coefficients[2]);rownames(out)<-NULL;colnames(out)<-c("nm","Protection_Slope_Pre","Protection_Slope_Post")
    DF_2<-rbind(DF_2,out)
  }
  if (length<=0){
    out<-cbind(nm,0,0);rownames(out)<-NULL;colnames(out)<-c("nm","Protection_Slope_Pre","Protection_Slope_Post")
    DF_3<-rbind(DF_3,out)
  }
}

library(plyr)
DF_2<-join(Summary_DF,DF_2,by="nm")
names(DF_2)
head(DF_2)

DF_2<-DF_2[c(4,6:7)]

DF_OUT<-join(DF_OUT,DF_2,by="E_W")
names(DF_OUT)


i=1
DF_3<-data.frame(NULL)
##Getting the slope by time period based on the distance from the MPA
for (i in 1:nrow(mpalist_2)){
  m=mpalist_2[i,]
  DF_sub<-subset(DF_TimePeriod_melted_Attributes,DF_TimePeriod_melted_Attributes$name==m)
  nm<-as.character(DF_sub$name[1])
  DF_sub<-subset(DF_sub,DF_sub$distMPA>0)
  length<-nrow(DF_sub)
  if (length>0){
    #Plotting average deltas by year
    fit_pre<-lm(value~distMPA,data=subset(DF_sub,DF_sub$Time_Period=="Pre-MPA"))
    summary(fit_pre)
    fit_post<-lm(value~distMPA,data=subset(DF_sub,DF_sub$Time_Period=="Post-MPA"))
    summary(fit_post)
    out<-as.data.frame(nm);
    out<-cbind(out,fit_pre$coefficients[2],fit_post$coefficients[2]);rownames(out)<-NULL;colnames(out)<-c("nm","Distance_Slope_Pre","Distance_Slope_Post")
    DF_3<-rbind(DF_3,out)
  }
  if (length<=0){
    out<-cbind(nm,0,0);rownames(out)<-NULL;colnames(out)<-c("nm","Distance_Slope_Pre","Distance_Slope_Post")
    DF_3<-rbind(DF_3,out)
  }
}



DF_3<-join(Summary_DF,DF_3,by="nm")
names(DF_3)
head(DF_3)

DF_3<-DF_3[c(4,6:7)]

DF_OUT<-join(DF_OUT,DF_3,by="E_W")
names(DF_OUT)
head(DF_OUT)


DF_OUT<-DF_OUT[c(1:3,8,6,12:16)]
head(DF_OUT)

write.csv(DF_OUT,"Summary_Table_Channel_Island_Kelp_19842011_LT3000km.csv")

