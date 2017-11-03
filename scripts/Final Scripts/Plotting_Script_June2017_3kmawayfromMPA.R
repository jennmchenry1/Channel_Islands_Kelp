## Plotting Pixel Comparison Output

## Working with Pixel Comparison OUtput June 2017

#Setting the working directory
data_dir<-"C:/Users/jennm/Dropbox/PROJECTS/Channel_Island_Kelp_MPAs_working/data"
plot_dir<-c("C:/Users/jennm/Dropbox/Channel_Island_Kelp_MPAs_working/plots")
scripts_dir<-"C:/Users/jennm/Dropbox/Channel_Island_Kelp_MPAs_working/scripts"
functions_dir<-"C:/Users/jennm/Dropbox/PROJECTS/Channel_Island_Kelp_MPAs_working/functions"
kelp_raw_dir<-"C:/Users/jennm/Dropbox/PROJECTS/Channel_Island_Kelp_MPAs_working/data/Kelp_Raw"
kelp_raster_dir<-"C:/Users/jennm/Dropbox/PROJECTS/Channel_Island_Kelp_MPAs_working/data/Kelp_Raster"
temp_plot_dir<-"C:/Users/jennm/Dropbox/PROJECTS/Channel_Island_Kelp_MPAs_working/plots/Temp_plot_dir"

setwd(data_dir)

library(plyr)
library(ggplot2)
library(ggthemes)
library(cowplot)
library(gridExtra)
library(reshape2)

source(paste(functions_dir,"/Summary_SE_Function.R",sep=""))
source(paste(functions_dir,"/Publication Theme GGPLOT2 Functions.R",sep=""))
source(paste(functions_dir,"/Multiplot_Function.R",sep=""))
source(paste(functions_dir,"/Grid_Arrange_Shared_Legend.R",sep=""))

windowsFonts(Arial=windowsFont("TT Arial")) 


setwd(data_dir)
# FULL<-read.csv("FINAL_Kelp_19842011_Dataframe_07_05_2017.csv")
# FULL<-FULL[c(-1)]
# FULL<-FULL[c(-39)]
# # 
# names(FULL)
# head(FULL)
# ids_A<-FULL[c(37,39,5:6)];names(ids_A)<-c("Pixel_A_id","Pixel_A_prop_overlap","X_A","Y_A")
# ids_B<-FULL[c(37,39,5:6)];names(ids_B)<-c("Pixel_B_id","Pixel_B_prop_overlap","X_B","Y_B")
# # 
# Comparison<-read.csv("Unique_Pixel_Compare_DF_June27.csv")
# names(Comparison)
# # 
# Comparison_Join<-join(Comparison,ids_A,by="Pixel_A_id")
# 
# Comparison_Join<-join(Comparison_Join,ids_B,by="Pixel_B_id")
# 
# write.csv(Comparison_Join,"Unique_Pixel_Compare_DF_georef_July6.csv")



# DF<-read.csv("Unique_Pixel_Compare_DF_georef_July6.csv")
# DF$Delta_Kelp<-DF$Pixel_A-DF$Pixel_B
# 
# 
# #Plotting deltas over time 
# mpalist<-as.data.frame(unique(DF$nm));mpalist
# 
# DF$YEAR<-gsub("X","",DF$Year)
# DF$YEAR<-as.numeric(DF$YEAR)
# 
# 
# #joining distance from MPA data to pixel comparison
# DF_TimePeriod<-read.csv("FINAL_Kelp_19842011_Dataframe_07_12_2017.csv")
# Attributes<-DF_TimePeriod[c(37:38,41,5:7)];head(Attributes)
# Pixel_B_distMPA<-Attributes[c(2,4)];colnames(Pixel_B_distMPA)<-c("Pixel_B_id","Pixel_B_distMPA")
# 
# 
# DF_joined<-join(DF,Pixel_B_distMPA,by="Pixel_B_id")
# rm(DF)
# 
# DF_II<-subset(DF_joined,DF_joined$comparison_id==c("1-1"))
# DF_OO<-subset(DF_joined,DF_joined$comparison_id==c("0-0"))
# DF_IO<-subset(DF_joined,DF_joined$comparison_id==c("1-0"))
# 
# DF_IO<-subset(DF_IO,DF_IO$Pixel_B_distMPA<5000)
# 
# DF_ALL<-rbind(DF_II,DF_OO,DF_IO)
# write.csv(DF_ALL,"Unique_Pixel_Compare_DF_georef_July27_distMPA_lessthan5km.csv")

DF_ALL<-read.csv("Unique_Pixel_Compare_DF_georef_July27_distMPA_lessthan5km.csv")
head(DF_ALL)

DF_SE_ALL<-summarySE(DF_ALL,measurevar = "Delta_Kelp",groupvars = c("nm","comparison_id","YEAR"))

mpalist<-as.data.frame(unique(DF_ALL$nm));mpalist

head(DF_SE_ALL)


summary(DF_SE_ALL)
#

setwd(temp_plot_dir)

#Delta Kelp Averaged by Year
#With Legend
for (i in 1:nrow(mpalist)){
  m=mpalist[i,]
  DF_sub<-subset(DF_SE_ALL,DF_SE_ALL$nm==m)
  nm<-as.character(DF_sub$nm[1])
  nm_split<-as.data.frame(strsplit(nm,"_"))
  nm_split2<-paste(nm_split[5,],nm_split[4,])
  #Plotting average deltas by year
  fn=paste("Plot ",nm_split2,sep="")
  p=ggplot(DF_sub, aes(x=YEAR, y=Delta_Kelp, colour=factor(comparison_id,labels=c("Outside v Outside","Inside v Outside","Inside v Inside")))) + 
    geom_errorbar(aes(ymin=Delta_Kelp - se, ymax=Delta_Kelp + se)) +
    geom_point(size=2.5) + geom_smooth(method = "loess",se=TRUE) + ylab("Delta Kelp") +
    xlab("Year") + ggtitle(nm_split2) + geom_vline(xintercept = 2003) +
    labs(colour=c("Comparison Type"))
  assign(paste("Plot_",i,sep=""),p)
}



tiff(filename = paste("Yearly_Kelp_Difference_Between_Pixels_Smoothed_lessthan_5km_distMPA.tiff",sep=""),width = 15,height = 6,units = "in",res = 300)
grid_arrange_shared_legend(Plot_4,Plot_5,Plot_9,Plot_2,Plot_10,Plot_1,Plot_7,Plot_6,Plot_8,Plot_3,nrow = 2,ncol = 5)
dev.off()




### Kelp Biomass by proportion of protection
DF_TimePeriod<-read.csv("FINAL_Kelp_19842011_Dataframe_07_12_2017.csv")

summary(DF_TimePeriod)
DF_TimePeriod<-subset(DF_TimePeriod,DF_TimePeriod$distMPA<3000)

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
# DF_TimePeriod_melted$Time_Period<-ifelse(DF_TimePeriod_melted$YEAR>=2003,"Post-MPA","Pre-MPA")
DF_TimePeriod_melted$Time_Period<-ifelse(DF_TimePeriod_melted$YEAR>=2004,"Post-MPA",NA)
DF_TimePeriod_melted$Time_Period<-ifelse(DF_TimePeriod_melted$YEAR<=2002,"Pre-MPA",DF_TimePeriod_melted$Time_Period)
DF_TimePeriod_melted$Time_Period<-ifelse(DF_TimePeriod_melted$YEAR<=1994,NA,DF_TimePeriod_melted$Time_Period)


DF_TimePeriod_melted_MSE<-summarySE(DF_TimePeriod_melted,measurevar = c("value"),groupvars = c("Time_Period","cell_id"))

DF_TimePeriod_melted_MSE_Attributes<-join(DF_TimePeriod_melted_MSE,Attributes,by="cell_id")


DF_TimePeriod_melted_MSE_Attributes$name<-as.character(DF_TimePeriod_melted_MSE_Attributes$name)
# DF_TimePeriod_melted_MSE$Time_Period<-as.factor(DF_TimePeriod_melted_MSE$Time_Period)

ggplot(DF_TimePeriod_melted_MSE_Attributes,aes(x=prop_overlap,y=value,color=name))+ geom_point()+geom_smooth(method=lm,se=TRUE)


mpalist_2<-as.data.frame(unique(DF_TimePeriod_melted_MSE_Attributes$name));mpalist_2


#Plotting average kelp by proportion of protection
# i=10
for (i in 1:nrow(mpalist_2)){
  m=mpalist_2[i,]
  DF_sub<-subset(DF_TimePeriod_melted_MSE_Attributes,DF_TimePeriod_melted_MSE_Attributes$name==m)
  DF_sub<-subset(DF_sub,DF_sub$prop_overlap>0)
  DF_sub<-DF_sub[complete.cases(DF_sub),]
  nm<-DF_sub$name[1]
  nm_split<-as.data.frame(strsplit(nm,"_"))
  nm_split2<-paste(nm_split[5,],nm_split[4,])
  #Plotting average deltas by year
  p=ggplot(DF_sub, aes(x=prop_overlap, y=value, colour=Time_Period)) + 
    geom_point() + ylab("Kelp Biomass") +
    xlab("Proportion of Protection") + ggtitle(nm_split2) +
    labs(colour=c("Time Period"))
  assign(paste("Plot_TimePeriod_",i,sep=""),p)
}

# #Saving plots
# Plots_list<-ls(pattern="Plot_TimePeriod_")
# for (p in Plots_list){
#   get(p)
#   ggsave(filename = paste(p,".tiff",sep=""),plot=last_plot(),width=15,height=10,units=c("cm"),dpi=300)
# }

tiff(filename = paste("Kelp_by_Proportion_Of_Protection_WOzero.tiff",sep=""),width = 15,height = 6,units = "in",res = 300)
grid_arrange_shared_legend(Plot_TimePeriod_1,Plot_TimePeriod_3,Plot_TimePeriod_4,Plot_TimePeriod_8,Plot_TimePeriod_9,Plot_TimePeriod_10,Plot_TimePeriod_11,Plot_TimePeriod_2,Plot_TimePeriod_6,Plot_TimePeriod_5,Plot_TimePeriod_7,Plot_TimePeriod_12,nrow = 2,ncol = 6)
dev.off()


#Plotting average kelp by proportion of protection LM
# i=10
for (i in 1:nrow(mpalist_2)){
  m=mpalist_2[i,]
  DF_sub<-subset(DF_TimePeriod_melted_MSE_Attributes,DF_TimePeriod_melted_MSE_Attributes$name==m)
  DF_sub<-subset(DF_sub,DF_sub$prop_overlap>0)
  DF_sub<-DF_sub[complete.cases(DF_sub),]
  nm<-DF_sub$name[1]
  nm_split<-as.data.frame(strsplit(nm,"_"))
  nm_split2<-paste(nm_split[5,],nm_split[4,])
  #Plotting average deltas by year
  p=ggplot(DF_sub, aes(x=prop_overlap, y=value, colour=Time_Period)) +  
    geom_smooth(method="lm",se=TRUE) + ylab("Kelp Biomass") +
    xlab("Proportion of Protection") + ggtitle(nm_split2) +
    labs(colour=c("Time Period"))
  assign(paste("Plot_TimePeriod_",i,sep=""),p)
}

tiff(filename = paste("Kelp_by_Proportion_Of_Protection_WOzero_LM.tiff",sep=""),width = 15,height = 6,units = "in",res = 300)
grid_arrange_shared_legend(Plot_TimePeriod_1,Plot_TimePeriod_3,Plot_TimePeriod_4,Plot_TimePeriod_8,Plot_TimePeriod_9,Plot_TimePeriod_10,Plot_TimePeriod_11,Plot_TimePeriod_2,Plot_TimePeriod_6,Plot_TimePeriod_5,Plot_TimePeriod_7,Plot_TimePeriod_12,nrow = 2,ncol = 6)
dev.off()


#Plotting average kelp by proportion of protection Loess
# i=10
for (i in 1:nrow(mpalist_2)){
  m=mpalist_2[i,]
  DF_sub<-subset(DF_TimePeriod_melted_MSE_Attributes,DF_TimePeriod_melted_MSE_Attributes$name==m)
  DF_sub<-subset(DF_sub,DF_sub$prop_overlap>0)
  DF_sub<-DF_sub[complete.cases(DF_sub),]
  nm<-DF_sub$name[1]
  nm_split<-as.data.frame(strsplit(nm,"_"))
  nm_split2<-paste(nm_split[5,],nm_split[4,])
  #Plotting average deltas by year
  p=ggplot(DF_sub, aes(x=prop_overlap, y=value, colour=Time_Period)) +  
    geom_smooth(method="loess",se=TRUE) + ylab("Kelp Biomass") +
    xlab("Proportion of Protection") + ggtitle(nm_split2) +
    labs(colour=c("Time Period"))
  assign(paste("Plot_TimePeriod_",i,sep=""),p)
}


tiff(filename = paste("Kelp_by_Proportion_Of_Protection_WOzero_Loess.tiff",sep=""),width = 15,height = 6,units = "in",res = 300)
grid_arrange_shared_legend(Plot_TimePeriod_1,Plot_TimePeriod_3,Plot_TimePeriod_4,Plot_TimePeriod_8,Plot_TimePeriod_9,Plot_TimePeriod_10,Plot_TimePeriod_11,Plot_TimePeriod_2,Plot_TimePeriod_6,Plot_TimePeriod_5,Plot_TimePeriod_7,Plot_TimePeriod_12,nrow = 2,ncol = 6)
dev.off()



# DF_TimePeriod_melted_MSE_Attributes$distMPA_corrected<-ifelse(DF_TimePeriod_melted_MSE_Attributes$prop_overlap>=0.5,yes=-1*DF_TimePeriod_melted_MSE_Attributes$distMPA,no=DF_TimePeriod_melted_MSE_Attributes$distMPA)

#Plotting average kelp by distance from MPAS
# i=10
for (i in 1:nrow(mpalist_2)){
  m=mpalist_2[i,]
  DF_sub<-subset(DF_TimePeriod_melted_MSE_Attributes,DF_TimePeriod_melted_MSE_Attributes$name==m)
  DF_sub<-subset(DF_sub,DF_sub$distMPA>0)
  DF_sub<-DF_sub[complete.cases(DF_sub),]
  nm<-DF_sub$name[1]
  nm_split<-as.data.frame(strsplit(nm,"_"))
  nm_split2<-paste(nm_split[5,],nm_split[4,])
  #Plotting average deltas by year
  p=ggplot(DF_sub, aes(x=distMPA, y=value, colour=Time_Period)) +  
    geom_point() + geom_smooth(method=lm,se=TRUE) + ylab("Kelp Biomass") +
    xlab("Distance to Nearest MPA") + ggtitle(nm_split2) +
    labs(colour=c("Time Period"))
  assign(paste("Plot_TimePeriod_",i,sep=""),p)
}

tiff(filename = paste("Kelp_with_Distance_toMPAS_above0.tiff",sep=""),width = 15,height = 6,units = "in",res = 300)
grid_arrange_shared_legend(Plot_TimePeriod_1,Plot_TimePeriod_3,Plot_TimePeriod_4,Plot_TimePeriod_8,Plot_TimePeriod_9,Plot_TimePeriod_10,Plot_TimePeriod_11,Plot_TimePeriod_2,Plot_TimePeriod_6,Plot_TimePeriod_5,Plot_TimePeriod_7,Plot_TimePeriod_12,nrow = 2,ncol = 6)
dev.off()


#Plotting average kelp by distance from MPAS LM
# i=10
for (i in 1:nrow(mpalist_2)){
  m=mpalist_2[i,]
  DF_sub<-subset(DF_TimePeriod_melted_MSE_Attributes,DF_TimePeriod_melted_MSE_Attributes$name==m)
  nm<-DF_sub$name[1]
  DF_sub<-subset(DF_sub,DF_sub$distMPA>0)
  DF_sub<-DF_sub[complete.cases(DF_sub),]
  nm_split<-as.data.frame(strsplit(nm,"_"))
  nm_split2<-paste(nm_split[5,],nm_split[4,])
  #Plotting average deltas by year
  p=ggplot(DF_sub, aes(x=distMPA, y=value, colour=Time_Period)) +  
    geom_smooth(method="lm",se=TRUE) + ylab("Kelp Biomass") +
    xlab("Distance to Nearest MPA") + ggtitle(nm_split2) +
    labs(colour=c("Time Period"))
  assign(paste("Plot_TimePeriod_",i,sep=""),p)
}



tiff(filename = paste("Kelp_with_Distance_toMPAS_above0_LM.tiff",sep=""),width = 15,height = 6,units = "in",res = 300)
grid_arrange_shared_legend(Plot_TimePeriod_1,Plot_TimePeriod_3,Plot_TimePeriod_4,Plot_TimePeriod_8,Plot_TimePeriod_9,Plot_TimePeriod_10,Plot_TimePeriod_11,Plot_TimePeriod_2,Plot_TimePeriod_6,Plot_TimePeriod_5,Plot_TimePeriod_7,Plot_TimePeriod_12,nrow = 2,ncol = 6)
dev.off()



#Plotting average kelp by distance from MPAS Loess
# i=10
for (i in 1:nrow(mpalist_2)){
  m=mpalist_2[i,]
  DF_sub<-subset(DF_TimePeriod_melted_MSE_Attributes,DF_TimePeriod_melted_MSE_Attributes$name==m)
  DF_sub<-subset(DF_sub,DF_sub$distMPA>0)
  DF_sub<-DF_sub[complete.cases(DF_sub),]
  nm<-DF_sub$name[1]
  nm_split<-as.data.frame(strsplit(nm,"_"))
  nm_split2<-paste(nm_split[5,],nm_split[4,])
  #Plotting average deltas by year
  p=ggplot(DF_sub, aes(x=distMPA, y=value, colour=Time_Period)) +  
    geom_smooth(method="loess",se=TRUE) + ylab("Kelp Biomass") +
    xlab("Distance to Nearest MPA") + ggtitle(nm_split2) +
    labs(colour=c("Time Period"))
  assign(paste("Plot_TimePeriod_",i,sep=""),p)
}



tiff(filename = paste("Kelp_with_Distance_toMPAS_above0_Loess.tiff",sep=""),width = 15,height = 6,units = "in",res = 300)
grid_arrange_shared_legend(Plot_TimePeriod_1,Plot_TimePeriod_3,Plot_TimePeriod_4,Plot_TimePeriod_8,Plot_TimePeriod_9,Plot_TimePeriod_10,Plot_TimePeriod_11,Plot_TimePeriod_2,Plot_TimePeriod_6,Plot_TimePeriod_5,Plot_TimePeriod_7,Plot_TimePeriod_12,nrow = 2,ncol = 6)
dev.off()

?geom_smooth









