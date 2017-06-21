## Pixel Comparison Script

##Updated May 15, 2017

# ##Load in librarieslibrary(sp)
# library(rgdal)
install.packages("rgeos")
install.packages("maptools");
install.packages("raster");
library(tools)
install.packages("Imap");
install.packages("plyr");
install.packages("sp");
install.packages("gdistance");

library(rgeos)
library(gdistance)
library(sp)
library(Imap)
library(plyr)
library(raster)
library(maptools)
library(parallel)


# #Set directories on PC
setwd("~/Channel_Islands_Kelp_reboot_June2017/Channel_Islands_Kelp")
data_dir<-"~/Channel_Islands_Kelp_reboot_June2017/Channel_Islands_Kelp/output_June20"

# #Set directories on Pauper2
# home_dir<-paste(getwd(),"/Channel_Islands_Kelp/",sep=")
# out_dir<-paste(getwd(),"/out_compare_dir_may15",sep="");dir.create(out_dir)

#Bringing in the dataframe for pixel comparison
FINAL<-readRDS("FINAL_Kelp_19842011_Dataframe_03292017.Rds")
FINAL[is.na(FINAL)] <- 0
summary(FINAL)

#developing the list of MPAs
mpalist<-(unique(FINAL$name));mpalist

#for testing only. Comment out for runing script!
m=mpalist[5]

setwd(data_dir)


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
  return(Compare_MPAs)
}


Compare_ALL_MPAs<-data.frame(NULL)

mpalist<-unique(FINAL$name)
mclapply(1:12,function (xx){
  for (m in mpalist){
    print(paste("starting ",m,sep=""))
    subset<-subset(FINAL,FINAL$name==m)
    subset_in<-subset(subset,subset$PA==1)
    subset_out<-subset(subset,subset$PA==0)
    name<-m
    sub_len<-nrow(subset_in)
    r<-as.integer(sub_len)
    if (sum(r)==0) {
      next
    }
    if (sum(r)>0) {
      for (i in 1:1){
        data<-do.call("rbind",lapply(c(1:r),function (x){
          #Grabing inin, in out, and out out comparison pixels
          Pixel_in_rand<-as.data.frame(rbind(subset_in[x,],subset_in[sample(nrow(subset_in),1),]))
          Pixel_out_rand<-as.data.frame(subset_out[sample(nrow(subset_out),2),])
          Compare_MPAs<-PixelCompare(Pixel_in_rand,Pixel_out_rand)
          return(Compare_MPAs)}))
        Compare_ALL_MPAs<-rbind(Compare_ALL_MPAs,as.data.frame(data))
        write.csv(Compare_ALL_MPAs,file=paste("Compare_ALL_MPAS_version_",i,"_",m,".csv",sep=""))
      }
    }
  }
})


  })
    
  }

  

#pullng together all CSVs
temp = list.files(pattern="Compare_ALL_MPAS_version_2*")
Compiled = do.call("rbind",lapply(temp, read.csv))
Compiled_unique<-Compiled[!duplicated(Compiled[4:6]),]

write.csv(Compiled_unique,file="Pixel_Compare_DF_June20.csv")

dim(myfiles)
