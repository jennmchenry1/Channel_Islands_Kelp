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


#Setting the working directory
data_dir<-"C:/Users/jennm/Dropbox/PROJECTS/Channel_Island_Kelp_MPAs_working/data"
plot_dir<-"C:/Users/jennm/Dropbox/ChannelIsland_Kelp_MPAs_working/plots"
kelp_raw_dir<-"C:/Users/jennm/Dropbox/PROJECTS/Channel_Island_Kelp_MPAs_working/data/Kelp_Raw"
kelp_raster_dir<-"C:/Users/jennm/Dropbox/PROJECTS/Channel_Island_Kelp_MPAs_working/data/Kelp_Raster"



setwd(data_dir)

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


# # Clipping shoreline by bounding box
# Channel_Islands<- gIntersection(Shoreline, Study_Area_BB, byid = TRUE, drop_lower_td = TRUE) #clip polygon 2 with polygon 1
# plot(Channel_Islands, add=TRUE,col = "lightblue")
# Channel_Islands_proj<-spTransform(Channel_Islands,WGS84_proj)
# Channel_Islands_proj<-Channel_Islands_proj[-1]
# Channel_Islands_proj<-as(Channel_Islands_proj, "SpatialPolygonsDataFrame")
# writeOGR(Channel_Islands_proj,".","Channel_Islands_proj",driver = "ESRI Shapefile")
Channel_Islands_proj<-readShapePoly(paste(data_dir,"/Channel_Islands_proj.shp",sep=""), verbose=TRUE, proj4string=WGS84_proj)
plot(Channel_Islands_proj)


#Bring in MPA file
MPAs <- readShapePoly(paste(data_dir,"/Channel_Island_MPA.shp",sep=""), verbose=TRUE, proj4string=Teales)
names(MPAs)
MPAs$Name
MPAs$Type

#Converting MPAs shapefile to a WGS coordinate system
MPAs_WGS <- spTransform(MPAs, WGS84)
plot(MPAs_WGS)

#looping through MPAs to calculate widths

MPAs_WGS_proj<- spTransform(MPAs, WGS84_proj)
# writeOGR(MPAs_WGS_proj,".","MPAs_WGS_proj",driver = "ESRI Shapefile")

MPA_ID<-MPAs_WGS_proj$Id
for (id in MPA_ID){
  new_shape<-MPAs_WGS_proj[MPAs_WGS_proj$Id==id,]
  mpa_type<-MPAs_WGS_proj$type[MPAs_WGS_proj$Id==id]
  mpa_name<-MPAs_WGS_proj$Name[MPAs_WGS_proj$Id==id]
  assign(paste("MPA_Shape",id,mpa_type,mpa_name,sep="_"),new_shape)
}           


MPA_List<-ls(pattern="MPA_Shape_*")
# rm(list = ls(pattern = "MPA_Shape_*"))

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
out<-readRDS("Minimum_MPA_Diameter.Rds")
# 
# ########################################################################################################
# # loading in data to create the kelp dataframe
# 
# setwd(kelp_raw_dir)
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
# setwd(kelp_raster_dir)
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
# setwd(kelp_raster_dir)
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


# setwd(data_dir)
# # write.csv(STACK_DF,"FINAL_Kelp_19842011_Dataframe.csv")
# saveRDS(STACK_DF, "FINAL_Kelp_19842011_Dataframe.Rds")
# 
# #Bringing in the dataframe
# setwd(data_dir)
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
names(FINAL)
FINAL$name<-as.factor(FINAL$name)


#determining percent overlap
mpalist<-ls(pattern="MPA_Shape_");mpalist

Per_overlap_df<-data.frame()
Per_overlap_df_zero<-data.frame()

for (i in 1:nrow(FINAL)) {
  dat<-FINAL[i,]
  name<-dat[1,36]
  mpa=get(as.character(name))
  cell_id=dat$cell_id
  m=as.factor(name)
  width=subset(out,out$name==m);width=width[,2];width
  coordinates(dat)<-~X+Y
  proj4string(dat)<-WGS84_proj
  buff=gBuffer(dat, width=width/2)
  buffs_wet<-gDifference(buff,Channel_Islands_proj) #clip polygon 2 with polygon 1
  plot(MPAs_WGS_proj)
  plot(mpa,add=TRUE,col="red")
  plot(buffs_wet,col="green",add=TRUE)
  plot(dat,add=TRUE,col="red")
  inter=as.data.frame(gIntersects(buffs_wet,mpa,byid = TRUE))
  if (inter==TRUE) {
    area=gArea(buffs_wet) # in square meters
    overlap<-gIntersection(mpa,buffs_wet)
    overlap_area<-gArea(overlap)
    cell_out<-as.data.frame(cbind(name,cell_id))
    cell_out$prop_overlap<-as.numeric(overlap_area/area)
    Per_overlap_df<-as.data.frame(rbind(Per_overlap_df,cell_out))
  }
  else if (inter==FALSE) {
    cell_out<-as.data.frame(cbind(name,cell_id,as.integer(0)))
    Per_overlap_df_zero<-rbind(Per_overlap_df_zero,cell_out)
  }
  else {
    next
  }
}

Per_overlap_df_zero$V3<-as.numeric(0.000);names(Per_overlap_df_zero)<-c("name","cell_id","prop_overlap")

Per_overlap_df_FINAL<-rbind(Per_overlap_df,Per_overlap_df_zero)
summary(Per_overlap_df_FINAL)
warnings()


write.csv(Per_overlap_df_FINAL,"percent_overlap_calcualtion_07_12_2017.csv")


FINAL<-join(FINAL,Per_overlap_df_FINAL,by="cell_id")

write.csv(FINAL,file="FINAL_Kelp_19842011_Dataframe_07_12_2017.csv")


