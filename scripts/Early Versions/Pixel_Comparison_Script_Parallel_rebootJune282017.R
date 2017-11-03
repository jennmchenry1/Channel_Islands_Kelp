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
install.packages("foreach")

library(sp)

library(gdistance)
library(rgeos)
library(Imap)
library(plyr)
library(raster)
library(maptools)
library(parallel)
library(foreach)
library(doParallel)

# #Set directories on PC
setwd("~/Channel_Islands_Kelp_reboot_June2017/Channel_Islands_Kelp")
data_dir<-"~/Channel_Islands_Kelp_reboot_June2017/Channel_Islands_Kelp/output_June27"

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
  nm=Pixel_in_rand[1,2]
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
  Compare_MPAs<-cbind(nm,rbind(IN_IN,IN_OUT,OUT_OUT))
  return(Compare_MPAs)
}







#setup parallel backend to use many processors
iterator=1:100
cores=detectCores()
cl <- makeCluster(cores[1]-1) #not to overload your computer
registerDoParallel(cl)
#check model 
list<-foreach(i=1:12,.combine=rbind) %dopar% {
  list2<-do.call("rbind",lapply(iterator,function(j) {paste("print_this_",i,"_",j,sep="")}))
  return(list2)
}
stopCluster(cl)



MPA_Data<-split(FINAL,factor(FINAL$name))
names(MPA_Data)<-NULL

iterator=1:100

#setup parallel backend to use many processors
cores=detectCores()
cl <- makeCluster(cores[1]-1) #not to overload your computer
registerDoParallel(cl)
#comparison parallel script
list<-foreach(i=1:12,.combine=rbind,.packages=c("sp","rgeos")) %dopar% {
  list2<-do.call("rbind",lapply(iterator,function(j) {
    dat=as.data.frame(MPA_Data[i])
    name=as.character(dat$name[1])
    subset_in<-subset(dat,dat$PA==1)
    subset_out<-subset(dat,dat$PA==0)
    sub_len<-nrow(subset_in)
    r<-as.integer(sub_len)
    if (sum(r)==0) {
      print("woops! No inside data!")
    }
    if (sum(r)>0) {
      list3<-do.call("rbind",lapply(c(1:sub_len),function (k){
        # Grabing inin, in out, and out out comparison pixels
        Pixel_in_rand<-as.data.frame(rbind(subset_in[k,],subset_in[sample(nrow(subset_in),1),]))
        Pixel_out_rand<-as.data.frame(subset_out[sample(nrow(subset_out),2),])
        out<-PixelCompare(Pixel_in_rand,Pixel_out_rand)
        return(out)
        # paste(i,j,name,sub_len,k,"yes",sep="_")
      }))
      return(list3)
      write.csv(list3,paste("Pixel_Comparison_Output_Iteration_",name,"_",j,".csv",sep=""))
    }
  }))
  return(list2)
}
stopCluster(cl)


#Saving the output list
write.csv(list,"FINAL_Pixel_Comparison_June272017.csv")
Compiled_unique<-list[!duplicated(list[3:5]),]
write.csv(Compiled_unique,file="Unique_Pixel_Compare_DF_June27.csv")


