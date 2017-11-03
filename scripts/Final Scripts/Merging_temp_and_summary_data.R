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
sum=read.csv("Summary_Table_Channel_Island_Kelp_19842011_LT3000km.csv")

head(sst)
