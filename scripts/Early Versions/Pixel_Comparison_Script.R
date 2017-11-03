###Experimenting with calculalting contrast between pixels inside and outside of MPAs in California

#reading in used libraries
library(sp)
library(rgdal)
library(rgeos)
library(maptools)
library(raster)
library(tools)
library(Imap)
library(plyr)

#Setting working coordinate system
WGS84=CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs")
NAD83=CRS("+proj=longlat +ellps=GRS80 +datum=NAD83 +no_defs")
NAD83_proj=CRS("+proj=utm +zone=10 +ellps=GRS80 +datum=NAD83 +units=m")
WGS84_proj=CRS("+proj=utm +zone=10 +ellps=WGS84 +datum=WGS84 +units=m +no_defs")
Teales=CRS("+proj=aea +lat_1=34 +lat_2=40.5 +lat_0=0 +lon_0=-120+x_0=0 +y_0=-4000000 +ellps=GRS80 +datum=NAD83 +units=m +no_defs")



# setwd("C:/Users/jennm/Dropbox/ChannelIslands_Kelp_MPAs/data/Kelp_Downloads/")
# data_dir<-"C:/Users/jennm/Dropbox/ChannelIslands_Kelp_MPAs/data/"
# 

#########################################################################################################
## 1. Calculate  width of each MPA in the Channel Island MPA Shapefile

# # Make a Bounding Box shapefile for the study area
# coords_small = matrix(c(-118.8, 33.4,
#                         -118.8, 34.3,
#                         -120.7, 34.3,
#                         -120.7, 33.4,
#                         -118.8, 33.4), 
#                       ncol = 2, byrow = TRUE)

# P2 = Polygon(coords_small)
# Study_Area_BB = SpatialPolygons(list(Polygons(list(P2), ID = "a")),proj4string=WGS84)
# plot(Study_Area_BB, axes = TRUE)
# Study_Area_proj<-spTransform(Study_Area_BB,WGS84_proj)
# 
# #Bring in shoreline polygon
# Shoreline<-readShapePoly(paste(data_dir,"Global_Shoreline_GSHHS_WGS.shp",sep=""),proj4string=WGS84)
# 

# # Clipping shoreline by bounding box
# Channel_Islands<- gIntersection(Shoreline, Study_Area_BB, byid = TRUE, drop_lower_td = TRUE) #clip polygon 2 with polygon 1
# plot(Channel_Islands, add=TRUE,col = "lightblue")
# Channel_Islands_proj<-spTransform(Channel_Islands,WGS84_proj)
# Channel_Islands_proj<-Channel_Islands_proj[-1]
# Channel_Islands_proj<-as(Channel_Islands_proj, "SpatialPolygonsDataFrame")
# writeOGR(Channel_Islands_proj,".","Channel_Islands_proj",driver = "ESRI Shapefile")
Channel_Islands_proj<-readShapePoly(paste(getwd(),"/Channel_Islands_proj.shp",sep=""), verbose=TRUE, proj4string=WGS84_proj)
plot(Channel_Islands_proj)


#Bring in MPA file
MPAs_WGS_proj<- readShapePoly(paste(getwd(),"/Channel_Islands_proj.shp",sep=""), verbose=TRUE, proj4string=WGS84_proj)


MPA_ID<-MPAs_WGS_proj$Id
for (id in MPA_ID){
  new_shape<-MPAs_WGS_proj[MPAs_WGS_proj$Id==id,]
  mpa_type<-MPAs_WGS_proj$type[MPAs_WGS_proj$Id==id]
  mpa_name<-MPAs_WGS_proj$Name[MPAs_WGS_proj$Id==id]
  assign(paste("MPA_Shape",id,mpa_type,mpa_name,sep="_"),new_shape)
}           


# MPA_List<-ls(pattern="MPA_Shape_*")
# # rm(list = ls(pattern = "MPA_Shape_*")) 
# 
# out<-data.frame()
# for (m in MPA_List){
#   shp<-get(m)
#   name<-m
#   r<-raster(extent(shp),res=c(10,10))
#   projection(r)<-proj4string(shp)
#   r10<-rasterize(shp,field=1,r)
#   min_diam<-as.integer(10*ifelse(nrow(r10)<ncol(r10),nrow(r10),ncol(r10)))
#   mpa_info<-cbind.data.frame(name,min_diam)
#   out<-rbind.data.frame(out,mpa_info)}
# 
# saveRDS(out,"Minimum_MPA_Diameter.Rds")
# out<-readRDS("Minimum_MPA_Diameter.Rds")
# 
# ########################################################################################################
# # loading in data to create the kelp dataframe
# 
# 
# tmpDateFormat<-"%Y%m%d"
# #loading in all csvs
# temp = list.files(pattern="_20140117.csv")
# for (i in 1:length(temp)) {
#   assign("new.temp", read.csv(temp[i], col.names=c("Lat","Lon","date_UTC","Biomass")))
#   if (class(new.temp$Lat)=="factor") new.temp$Lat <-as.numeric(levels(new.temp$Lat))[as.integer(new.temp$Lat)]
#   if (class(new.temp$Lon)=="factor") new.temp$Lon <-as.numeric(levels(new.temp$Lon))[as.integer(new.temp$Lon)]
#   new.temp$date_UTC<-as.Date(as.character(new.temp$date_UTC),format=tmpDateFormat,origin="1970-01-01")
#   assign(temp[i],new.temp)
#   rm(new.temp)}
# 

# #turning csvs into rasters and saving as RDS files. 
# data_ls<-ls(pattern="_20140117.csv")
# for (i in 1:length(data_ls)) {
#   name_split=as.data.frame(strsplit(data_ls[i],"_"))
#   year=as.character(name_split[5,])
#   print(paste("starting year:",year,sep=" "))
#   assign("dat",as.data.frame(get(data_ls[i])))
#   dat$Biomass[dat$Biomass<0] <- NA
#   coordinates(dat)= ~Lon + Lat
#   proj4string(dat)=WGS84
#   dat<-spTransform(dat,WGS84_proj)
#   dat<-dat[Study_Area_proj,]
#   rs_temp<-raster(ext=extent(dat),resolution=c(30,30))
#   rs_out<-rasterize(dat, rs_temp, dat$Biomass,fun=mean,na.rm=TRUE) # we use a mean
#   names(rs_out)<-c("Biomass")
#   #rs_out[rs_out==-998]<-NA
#   assign(paste(year,".tiff",sep=""),rs_out)
#   writeRaster(rs_out,paste(year,".tiff",sep=""),overwrite=TRUE)
#   saveRDS(rs_out, paste(paste(year,".RDS",sep="")))
#   print(paste("finished with year:",year,sep=" "))
# }
# 
# 


# rs_ls<-ls(pattern=".tiff")
# 
# for (rs in rs_ls){
#   tiff(paste(getwd(),"/plots_",rs,sep=""),width=10,height=10,units=c("cm"),res=300)
#   plot(get(rs),main=paste(rs,sep=""),cex.lab=1,cex.axis=1)
#   plot(MPAs_WGS,
#        add=TRUE,
#        border="red")
#   plot(Channel_Islands, 
#        col="lightblue",
#        border="black",
#        add=TRUE)
#   plot(Study_Area_BB,
#        border="orange",
#        add=TRUE)
#   dev.off()
# }

#bringing in tifs
# tif_list<-list.files(pattern=".tif$");tif_list
# rs_stack<-stack(tif_list);rs_stack
# proj4string(rs_stack)<-WGS84_proj
# 
# 
# #Turning the raster stack into a DF
# STACK<-rs_stack
# STACK_DF<-as.data.frame(STACK,row.names=NULL,xy=TRUE)
# names(STACK_DF)
# colnames(STACK_DF)<-c("X","Y","1984","1985","1986","1987","1988","1989","1990","1991","1992","1993","1994","1995","1996","1997","1998","1999","2000","2001","2002","2003","2004","2005","2006","2007","2008","2009","2010","2011")


# # write.csv(STACK_DF,"FINAL_Kelp_19842011_Dataframe.csv")
# saveRDS(STACK_DF, "FINAL_Kelp_19842011_Dataframe.Rds")
# 
# #Bringing in the dataframe
# df<-readRDS("FINAL_Kelp_19842011_Dataframe.Rds")
# names(df)
# df$TOTAL_BIOMASS<-rowSums(df[c(3:30)],na.rm=TRUE)
# head(df)
# summary(df$TOTAL_BIOMASS)
# hist(df$TOTAL_BIOMASS)
# 
# 
# #removing zeros 
# df_az<-df[df$TOTAL_BIOMASS>0,]
# df_zero<-df[df$TOTAL_BIOMASS==0,]
# 
# 
# summary(df_az)
# head(df_az)
# 
# hist(df_az$TOTAL_BIOMASS)


# ########################################################################################################
# # Steps to do:
# # Step 1 - choose all pixels associated with MPA Q
# names(out)
# 
# head(df_az)
# 
# 
# ##For each point, find the ID of the nearest polygon.
# MPAS_WGS_DF<-as.data.frame(MPAs_WGS_proj[c(1:3)])
# MPAS_WGS_DF
# 
# 
# 
# names(df_az)
# df_analysis<-df_az
# 
# ## For each point, find name of nearest polygon
# out_analysis_df<-NULL
# for (i in 1:nrow(df_analysis)) {
#   point<-df_analysis[i,]
#   coordinates(point)<-~X+Y
#   proj4string(point)<-WGS84_proj
#   dist<-gDistance(point,MPAs_WGS_proj,byid = TRUE)
#   dist<-as.data.frame(dist);names(dist)<-c("min_dist")
#   Id<-rownames(dist);dist$Id<-Id
#   nearestMPA<-dist[which.min(dist$min_dist),]
#   out_line<-cbind(nearestMPA,as.data.frame(point))
#   out_analysis_df<-rbind(out_analysis_df,out_line)}
# 
# head(out_analysis_df)
# dim(df_analysis)
# dim(out_analysis_df)
# 
# #creating the final dataframe for analysis and plotting (saving too)
# FINAL_NAMED_DF<-join(MPAS_WGS_DF,FINAL_NAMED_DF,by="Id")
# summary(FINAL_NAMED_DF)
# names(FINAL_NAMED_DF)
# head(FINAL_NAMED_DF)
# names(FINAL)
# colnames(FINAL_NAMED_DF)<-c("Id","nearestMPAType","nearestMPAName","distMPA","X","Y","1984","1985","1986","1987","1988","1989","1990","1991","1992","1993","1994","1995","1996","1997","1998","1999","2000","2001","2002","2003","2004","2005","2006","2007","2008","2009","2010","2011","TOTAL_BIOMASS")
# 
# 
# 
# # Step 1b - Calculate MPA width (minimum diameter that passes through the center of the MPA
# FINAL_NAMED_DF$name<-paste("MPA_Shape",FINAL_NAMED_DF$Id,FINAL_NAMED_DF$nearestMPAType,FINAL_NAMED_DF$nearestMPAName,sep="_")
# out<-as.data.frame(out)
# 
# #creating unique call value
# FINAL_NAMED_DF$cell_id<-c(1:85529)
# # unique_combos<-expand.grid(c(1:474),c(1:474))
# # num_unique_combos<-as.numeric(dim(unique_combos)[1])
# 
# 
# FINAL_NAMED_DF<-as.data.frame(FINAL_NAMED_DF)
# ##Turning the df into a sp to find MPAs within
# DF_SP<-FINAL_NAMED_DF
# coordinates(DF_SP)<-~X+Y
# proj4string(DF_SP)<-WGS84_proj
# MPAs_WGS_proj$PA<-1
# names(DF_SP)
# MPA_PA <- over(DF_SP, MPAs_WGS_proj[,"PA"])
# plot(DF_SP);plot(MPAs_WGS_proj,add=TRUE,border="red")
# 
# names(FINAL_NAMED_DF)
# FINAL_NAMED_DF<-cbind(FINAL_NAMED_DF,MPA_PA)
# FINAL_NAMED_DF$PA<-as.factor(ifelse(is.na(FINAL_NAMED_DF$PA)==TRUE,0,FINAL_NAMED_DF$PA))
# names(FINAL_NAMED_DF)
# 
# write.csv(FINAL_NAMED_DF,file="FINAL_Kelp_19842011_Dataframe_03282017.csv")
# saveRDS(FINAL_NAMED_DF,"FINAL_Kelp_19842011_Dataframe_03282017.Rds")
# 

# setwd(data_dir)
FINAL<-readRDS("FINAL_Kelp_19842011_Dataframe_03282017.Rds")
# 
# m=mpalist[1]
# #determining percent overlap
# mpalist<-(unique(FINAL$name));mpalist
# Per_overlap_df<-data.frame()
# for (m in mpalist) {
#   print(paste("starting ",m,sep=""))
#   name=m
#   mpa=get(m)
#   subset=subset(FINAL,FINAL$name==m)
#   width=subset(out,out$name==m);width=width[,2]
#   coordinates(subset)<-~X+Y
#   proj4string(subset)<-WGS84_proj
#   buff=gBuffer(subset, width=width/2,byid=TRUE)
#   inter=as.data.frame(gIntersects(buff,mpa,byid = TRUE))
#   for (i in 1:ncol(inter)) {
#     print(paste("starting loop for b ",i,sep=""))
#     if (inter[i]==TRUE) {
#       b<-buff[i,]
#       cell_id<-b$cell_id
#       b_wet<-gDifference(b,Channel_Islands_proj,byid = TRUE) #clip polygon 2 with polygon 1
#       area=gArea(b_wet) # in square meters
#       overlap<-gIntersection(mpa,b_wet)
#       overlap_area<-gArea(overlap)
#       prop_overlap<-as.numeric(overlap_area/area)
#       cell_out<-as.data.frame(cbind(name,cell_id))
#       cell_out$prop_overlap<-prop_overlap
#       Per_overlap_df<-rbind(Per_overlap_df,cell_out)
#     }
#     else if (inter[i]==FALSE) {
#       b<-buff[i,]
#       cell_id<-b$cell_id
#       prop_overlap=as.numeric(0)
#       cell_out<-as.data.frame(cbind(name,cell_id,prop_overlap))
#       Per_overlap_df<-rbind(Per_overlap_df,cell_out)
#     }
#     else {
#        next
#     }
#   }
# }

# 
# Per_overlap_df<-as.data.frame(Per_overlap_df);head(Per_overlap_df)
# Per_overlap_df$prop_overlap<-as.numeric(Per_overlap_df$prop_overlap)
# 
# # FINAL<-join(Per_overlap_df,FINAL,by="cell_id")
# write.csv(FINAL,file="FINAL_Kelp_19842011_Dataframe_03292017.csv")
# saveRDS(FINAL,file="FINAL_Kelp_19842011_Dataframe_03292017.Rds")
# 


FINAL<-readRDS("FINAL_Kelp_19842011_Dataframe_03292017.Rds")
# FINAL<-read.csv("FINAL_Kelp_19842011_Dataframe_03292017.csv")
head(FINAL)
names(FINAL)
summary(FINAL)

FINAL[is.na(FINAL)] <- 0
summary(FINAL)

# coordinates(FINAL)<-~X+Y
# proj4string(FINAL)<-WGS84_proj
# 
# hist(FINAL$distMPA)
# test<-subset(FINAL,FINAL$distMPA>20000)
# FINAL<-subset(FINAL,FINAL$distMPA<20000)
# 
# plot(MPAs_WGS_proj)
# plot(test,add=TRUE,col="red")
# plot(FINAL,add=TRUE)
# 
# hist(FINAL$distMPA)
# 
# names(FINAL) 
# FINAL<-as.data.frame(FINAL)


# Step 2 - subset only pixels where kelp is present sometime in the timeseries (cut tail of zeros)
# done above


# Step 3 - Produce IN-OUT contrasts dataset
# Repeat for xx runs
# Randomly choose pixel A from all pixels in MPA
# Randomly pair with pixel B chosen from all pixels outside of MPA
# Produce a dataset of contrasts with the following columns:


# Comparing pixels 
mpalist<-(unique(FINAL$name));mpalist
PixelCompare<-function(Pixel_in_rand,Pixel_out_rand){
  year=names(Pixel_in_rand[11:38])
  #grab ids
  in_in_id<-t(Pixel_in_rand[,3]);colnames(in_in_id)<-c("Pixel_A_id","Pixel_B_id")
  out_out_id<-t(Pixel_out_rand[,3]);colnames(out_out_id)<-c("Pixel_A_id","Pixel_B_id")
  in_out_id<-cbind(Pixel_in_rand[,3],Pixel_out_rand[,3]);colnames(in_out_id)<-c("Pixel_A_id","Pixel_B_id")
  #calculate relative protection
  rp_inin<-Pixel_in_rand[1,4]-Pixel_in_rand[2,4]
  rp_inout<-Pixel_in_rand[,4]-Pixel_out_rand[,4]
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
  IN_OUT1<-cbind("1-0",year,in_out_id[1,1],in_out_id[1,2],rp_inout[1],dist_inout[1,1],cbind(as.data.frame(IN_kelp[,1]),as.data.frame(OUT_kelp[,1]))); 
  colnames(IN_OUT1)<-c("comparison_id","Year","Pixel_A_id","Pixel_B_id","Delta_Protection","Pixel_Dist","Pixel_A","Pixel_B")
  IN_OUT2<-cbind("1-0",year,in_out_id[2,1],in_out_id[2,2],rp_inout[2],dist_inout[2,2],cbind(as.data.frame(IN_kelp[,2]),as.data.frame(OUT_kelp[,2]))); 
  colnames(IN_OUT2)<-c("comparison_id","Year","Pixel_A_id","Pixel_B_id","Delta_Protection","Pixel_Dist","Pixel_A","Pixel_B")
  OUTOUT_info<-cbind(out_out_id,rp_outout,dist_outout[1,2])
  OUT_OUT<-cbind("0-0",year,OUTOUT_info,as.data.frame(OUT_kelp));colnames(OUT_OUT)<-c("comparison_id","Year","Pixel_A_id","Pixel_B_id","Delta_Protection","Pixel_Dist","Pixel_A","Pixel_B")
  Compare_MPAs<-cbind(name,rbind(IN_IN,IN_OUT1,IN_OUT2,OUT_OUT))
  return(Compare_MPAs)
}


year=names(FINAL[11:38])
counting_pixels<-aggregate(FINAL$TOTAL_BIOMASS~FINAL$name+FINAL$PA,FINAL,FUN=NROW)
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
    for (i in 1:3){
      for (j in 1:sum(r)){
        #Grabing inin, in out, and out out comparison pixels
        Pixel_in_rand<-rbind(subset_in[j,],subset_in[sample(nrow(subset_in),1),])
        Pixel_out_rand<-subset_out[sample(nrow(subset_out),2),]
        Compare_MPAs<-PixelCompare(Pixel_in_rand,Pixel_out_rand)
        Compare_ALL_MPAs<-rbind(Compare_ALL_MPAs,Compare_MPAs)
      }
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






#   COL1 = MPA name - name of MPA Q
# COL2 = Pair ID - a serial number with the contrast
# COL3 = Pixel A ID (or location)
# COL4 = Pixel B ID (or location)
# COL5 = Distance Between Pixel A and Pixel B
# COL6 = Calculate relative degree of protection - WET area of
# a circle with DIAMETER = MPA width (from step 1b) that is protected 
# so using water area only.  this will be 1 for the pixel at the center 
# of the MPA and less than 1 for most other pixels.  It will be .5 for a 
# pixel right on a straight edge of an MPA (1/2 of the circle will be in 
# and 1/2 will be out.  It will be zero for pixels more than 1/2 a MPA 
# width away from the MPA edge.  Possible this should be done for all
# pixels once in a step separate from these runs.
# COL7 = Date of sample
# COL8 = Kelp at Pixel A on that date
# COL9 = Kelp at Pixel B on that date
# COL10 = Delta (Kelp at Pixel A on that date - kelp on pixel B on that date
#The above could be split into two datasets 1 with COL1-COL6 (short).  1 with COL2 + COL7-COL10
# 
# Step 4 -  Examine distribution of Distance Values in STEP 3 (COL5).  Decide how to constrain OUT-OUT dataset
# 
# Step 5 - Follow steps in Step 3 except that Pixel A is also selected at random from pixels outside of MPA and distance between pixels may need to be constrained in some way.
# 



test<-lm(Delta~comparison_id+relative_protection+pixel_dist+YEAR+name,data=Out_comparison_DF)
summary(test)
