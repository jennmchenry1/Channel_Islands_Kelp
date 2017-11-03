## Pixel Comparison Script

##Updated May 01, 2017

# ##Load in librarieslibrary(sp)
library(rgdal)
library(rgeos)
library(maptools)
library(raster)
library(tools)
library(Imap)
library(plyr)

#Set directories
setwd("C:/Users/jennm/Dropbox/ChannelIslands_Kelp_MPAs/data/Kelp_Downloads/")
data_dir<-"C:/Users/jennm/Dropbox/ChannelIslands_Kelp_MPAs/data/"


#Bringing in the dataframe for pixel comparison
FINAL<-readRDS("FINAL_Kelp_19842011_Dataframe_03292017.Rds")
FINAL[is.na(FINAL)] <- 0
summary(FINAL)

#developing the list of MPAs
mpalist<-(unique(FINAL$name));mpalist

#for testing only. Comment out for runing script!
m=mpalist[2]


# making a commparison function.
PixelCompare<-function(Pixel_in_rand,Pixel_out_rand){
  year=names(Pixel_in_rand[11:38])
  #grab ids
  in_in_id<-t(Pixel_in_rand[,3]);colnames(in_in_id)<-c("Pixel_A_id","Pixel_B_id")
  out_out_id<-t(Pixel_out_rand[,3]);colnames(out_out_id)<-c("Pixel_A_id","Pixel_B_id")
  in_out_id<-cbind(Pixel_in_rand[1,3],Pixel_out_rand[1,3]);colnames(in_out_id)<-c("Pixel_A_id","Pixel_B_id")
  #calculate relative protection
  rp_inin<-Pixel_in_rand[1,4]-Pixel_in_rand[2,4]
  rp_inout<-Pixel_in_rand[1,4]-Pixel_out_rand[1,4]
  rp_outout<-Pixel_out_rand[1,4]-Pixel_out_rand[2,4]
  #get kelp info
  IN_kelp<-t(as.data.frame(Pixel_in_rand[c(11:38)]));rownames(IN_kelp)<-NULL
  OUT_kelp<-t(as.data.frame(Pixel_out_rand[c(11:38)]));rownames(OUT_kelp)<-NULL
  #make into points
  coordinates(Pixel_in_rand)<-~X+Y
  coordinates(Pixel_out_rand)<-~X+Y
  dist_inin<-gDistance(Pixel_in_rand,Pixel_in_rand,byid=TRUE);rownames(dist_inin)<-NULL
  dist_inout<-gDistance(Pixel_in_rand,Pixel_out_rand,byid=TRUE);rownames(dist_inout)<-NULL
  dist_outout<-gDistance(Pixel_out_rand,Pixel_out_rand,byid=TRUE);rownames(dist_outout)<-NULL
  ININ_info<-cbind(in_in_id,rp_inin,dist_inin[1,2]);rownames(ININ_info)<-NULL
  IN_IN<-cbind("1-1",year,ININ_info,as.data.frame(IN_kelp));colnames(IN_IN)<-c("comparison_id","Year","Pixel_A_id","Pixel_B_id","Delta_Protection","Pixel_Dist","Pixel_A","Pixel_B")
  INOUT_info<-cbind(in_out_id,rp_inout,dist_inout[1,1]);rownames(INOUT_info)<-NULL
  IN_OUT<-cbind("1-0",year,INOUT_info,cbind(as.data.frame(IN_kelp[,1]),as.data.frame(OUT_kelp[,1]))); colnames(IN_OUT)<-c("comparison_id","Year","Pixel_A_id","Pixel_B_id","Delta_Protection","Pixel_Dist","Pixel_A","Pixel_B")
  OUTOUT_info<-cbind(out_out_id,rp_outout,dist_outout[1,2])
  OUT_OUT<-cbind("0-0",year,OUTOUT_info,as.data.frame(OUT_kelp));colnames(OUT_OUT)<-c("comparison_id","Year","Pixel_A_id","Pixel_B_id","Delta_Protection","Pixel_Dist","Pixel_A","Pixel_B")
  Compare_MPAs<-cbind(name,rbind(IN_IN,IN_OUT,OUT_OUT))
  write
  return(Compare_MPAs)
}


year=names(FINAL[11:38])

Compare_ALL_MPAs<-data.frame(NULL)
# m=mpalist[2]

for (m in mpalist) {
  print(paste("starting ",m,sep=""))
  subset<-subset(FINAL,FINAL$name==m)
  subset_in<-subset(subset,subset$PA==1)
  subset_out<-subset(subset,subset$PA==0)
  name<-m
  sub_len<-nrow(subset_in)
  r<-as.integer(sub_len)
  # r=1
  if (sum(r)==0) {
    next
  }
  if (sum(r)>0) {
    for (i in 1:sum(r)){
      #Grabing inin, in out, and out out comparison pixels
      Pixel_in_rand<-rbind(subset_in[i,],subset_in[sample(nrow(subset_in),1),])
      Pixel_out_rand<-subset_out[sample(nrow(subset_out),2),]
      Compare_MPAs<-PixelCompare(Pixel_in_rand,Pixel_out_rand)
      Compare_ALL_MPAs<-rbind(Compare_ALL_MPAs,Compare_MPAs)
    }
  }
}




par(mfrow=c(1,1))
head(Out_comparison_DF)
# write.csv(Out_comparison_DF,"Out_comparison_df.csv")
write.csv(Compare_ALL_MPAs,"Out_comparison_df_revised.csv")

# Out_comparison_DF<-read.csv("Out_comparison_df.csv")
Out_comparison_DF<-read.csv("Out_comparison_df_revised.csv")

hist(Out_comparison_DF$Pixel_Dist)

head(Out_comparison_DF)

Out_comparison_DF$YEAR<-gsub( "X", "", Out_comparison_DF$Year)
Out_comparison_DF$name<-as.factor(Out_comparison_DF$name)
summary(Out_comparison_DF$name)
Out_comparison_DF$Delta_Kelp<-Out_comparison_DF$Pixel_A-Out_comparison_DF$Pixel_B



InIn<-subset(Out_comparison_DF,Out_comparison_DF$comparison_id=="1-1");dim(InIn)
OutOut<-subset(Out_comparison_DF,Out_comparison_DF$comparison_id=="0-0");dim(OutOut)
InOut<-subset(Out_comparison_DF,Out_comparison_DF$comparison_id=="1-0");dim(InOut)


Addland <- function() {
  plot(Channel_Islands_proj,add=TRUE,col="black")
}

m=mpalist[1]
#determining percent overlap
mpalist<-(unique(Out_comparison_DF$name));mpalist
for (m in mpalist){
  # InIn_sub<-InIn;InIn_sub$YEAR<-gsub("X","",InIn_sub$Year)
  # InOut_sub<-InOut;InOut_sub$YEAR<-gsub("X","",InOut_sub$Year);
  # OutOut_sub<-OutOut;OutOut_sub$YEAR<-gsub("X","",OutOut_sub$Year)
  InIn_sub<-subset(InIn,InIn$name==m);InIn_sub$YEAR<-gsub("X","",InIn_sub$Year)
  InOut_sub<-subset(InOut,InOut$name==m);InOut_sub$YEAR<-gsub("X","",InOut_sub$Year);
  OutOut_sub<-subset(OutOut,OutOut$name==m);OutOut_sub$YEAR<-gsub("X","",OutOut_sub$Year)
  if (nrow(InIn_sub)>0 & nrow(InOut)>0 & nrow(OutOut)>0){
    ##Averaging deltas by year
    InOut_sub_agg<-aggregate(InOut_sub$Delta_Kelp,by=list(InOut_sub$Year),mean,na.rm=TRUE);InOut_sub_agg$YEAR<-gsub("X","",InOut_sub_agg$Group.1);InOut_sub_agg$comparison<-c("InOut")
    OutOut_sub_agg<-aggregate(OutOut_sub$Delta_Kelp,by=list(OutOut_sub$Year),mean,na.rm=TRUE);OutOut_sub_agg$YEAR<-gsub("X","",OutOut_sub_agg$Group.1);OutOut_sub_agg$comparison<-c("OutOut")
    InIn_sub_agg<-aggregate(InIn_sub$Delta_Kelp,by=list(InIn_sub$Year),mean,na.rm=TRUE);InIn_sub_agg$YEAR<-gsub("X","",InIn_sub_agg$Group.1);InIn_sub_agg$comparison<-c("InIn")
    DF_agg<-rbind(InOut_sub_agg,OutOut_sub_agg,InIn_sub_agg)
    #Plotting average deltas by year
    tiff(filename = paste(m,".tiff",sep=""),width = 6,height = 8,units = "in",res = 300)
    par(mfrow=c(3,1))
    plot(InIn_sub_agg$YEAR,InIn_sub_agg$x,main="In In Comparison",xlab="Year",ylab="Mean Delta",ylim=c(-600,600))
    plot(InOut_sub_agg$YEAR,InOut_sub_agg$x, main="In Out Comparison",xlab="Year",ylab="Mean Delta");abline(h=0,v=2003)
    plot(OutOut_sub_agg$YEAR,OutOut_sub_agg$x,main="Out Out Comparison",xlab="Year",ylab="Mean Delta",ylim=c(-600,600))
    # plot(InIn_sub$YEAR,InIn_sub$kelp_A, main="Kelp Biomass Inside",xlab="Year",ylab="Kelp Biomass")
    dev.off()
    # tiff(filename=paste(m,"aggregated.tiff",sep=""),width=6,height=6,units="in",res=300)
    # ggplot(DF_agg,aes(x=YEAR,y=x,color=comparison))+geom_point(size=3)+scale_colour_hue(l=50)+geom_smooth(method=lm,se=FALSE,fullrange=TRUE)
    # dev.off()
  }
  else {
    next
  }
}



