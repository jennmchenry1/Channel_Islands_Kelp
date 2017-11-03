# Package ID: knb-lter-sbc.54.6 Cataloging System:https://pasta.lternet.edu.
# Data set title: SBC LTER: Time series of kelp biomass in the canopy from Landsat 5, 1984 -2011.
# Data set creator:    - Santa Barbara Coastal LTER 
# Data set creator:  Kyle Cavanaugh -  
# Data set creator:  David Siegel -  
# Data set creator:  Daniel Reed -  
# Data set creator:  Tom Bell -  
# Contact:    - Information Manager LTER Network Office  - tech-support@lternet.edu
# Contact:    - Information Manager, Santa Barbara Coastal LTER   - sbclter@msi.ucsb.edu
# Metadata Link: https://portal.lternet.edu/nis/metadataviewer?packageid=knb-lter-sbc.54.6
# Stylesheet for metadata conversion into program: John H. Porter, Univ. Virginia, jporter@lternet.edu 

infile1  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-sbc/54/6/5740106c54f21f53dd2c3b684ceb0468" 
infile1 <- sub("^https","http",infile1) 
 dt1 <-read.csv(infile1,header=F 
          ,skip=0
            ,sep=","  
        , col.names=c(
                    "latitude",     
                    "longitude",     
                    "date_utc",     
                    "biomass"    ), check.names=TRUE)
               
  
# Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
                
if (class(dt1$latitude)=="factor") dt1$latitude <-as.numeric(levels(dt1$latitude))[as.integer(dt1$latitude) ]
if (class(dt1$longitude)=="factor") dt1$longitude <-as.numeric(levels(dt1$longitude))[as.integer(dt1$longitude) ]                                   
# attempting to convert dt1$date_utc dateTime string to R date structure (date or POSIXct)                                
tmpDateFormat<-"%Y%m%d"
dt1$date_utc<-as.Date(dt1$date_utc,format=tmpDateFormat)
rm(tmpDateFormat) 
if (class(dt1$biomass)=="factor") dt1$biomass <-as.numeric(levels(dt1$biomass))[as.integer(dt1$biomass) ]

# Here is the structure of the input data frame:
str(dt1)                            
attach(dt1)                            
# The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 

summary(latitude)
summary(longitude)
summary(date_utc)
summary(biomass) 
detach(dt1)               
         

infile2  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-sbc/54/6/80fe84aba8c58b4fb5ca9af0d04a5d43" 
infile2 <- sub("^https","http",infile2) 
 dt2 <-read.csv(infile2,header=F 
          ,skip=0
            ,sep=","  
        , col.names=c(
                    "latitude",     
                    "longitude",     
                    "date_utc",     
                    "biomass"    ), check.names=TRUE)
               
  
# Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
                
if (class(dt2$latitude)=="factor") dt2$latitude <-as.numeric(levels(dt2$latitude))[as.integer(dt2$latitude) ]
if (class(dt2$longitude)=="factor") dt2$longitude <-as.numeric(levels(dt2$longitude))[as.integer(dt2$longitude) ]                                   
# attempting to convert dt2$date_utc dateTime string to R date structure (date or POSIXct)                                
tmpDateFormat<-"%Y%m%d"
dt2$date_utc<-as.Date(dt2$date_utc,format=tmpDateFormat)
rm(tmpDateFormat) 
if (class(dt2$biomass)=="factor") dt2$biomass <-as.numeric(levels(dt2$biomass))[as.integer(dt2$biomass) ]

# Here is the structure of the input data frame:
str(dt2)                            
attach(dt2)                            
# The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 

summary(latitude)
summary(longitude)
summary(date_utc)
summary(biomass) 
detach(dt2)               
         

infile3  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-sbc/54/6/12ff8f226221c44ff5b1d6172e361d0a" 
infile3 <- sub("^https","http",infile3) 
 dt3 <-read.csv(infile3,header=F 
          ,skip=0
            ,sep=","  
        , col.names=c(
                    "latitude",     
                    "longitude",     
                    "date_utc",     
                    "biomass"    ), check.names=TRUE)
               
  
# Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
                
if (class(dt3$latitude)=="factor") dt3$latitude <-as.numeric(levels(dt3$latitude))[as.integer(dt3$latitude) ]
if (class(dt3$longitude)=="factor") dt3$longitude <-as.numeric(levels(dt3$longitude))[as.integer(dt3$longitude) ]                                   
# attempting to convert dt3$date_utc dateTime string to R date structure (date or POSIXct)                                
tmpDateFormat<-"%Y%m%d"
dt3$date_utc<-as.Date(dt3$date_utc,format=tmpDateFormat)
rm(tmpDateFormat) 
if (class(dt3$biomass)=="factor") dt3$biomass <-as.numeric(levels(dt3$biomass))[as.integer(dt3$biomass) ]

# Here is the structure of the input data frame:
str(dt3)                            
attach(dt3)                            
# The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 

summary(latitude)
summary(longitude)
summary(date_utc)
summary(biomass) 
detach(dt3)               
         

infile4  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-sbc/54/6/81785af386830cfa10fc1a64fba2e0f4" 
infile4 <- sub("^https","http",infile4) 
 dt4 <-read.csv(infile4,header=F 
          ,skip=0
            ,sep=","  
        , col.names=c(
                    "latitude",     
                    "longitude",     
                    "date_utc",     
                    "biomass"    ), check.names=TRUE)
               
  
# Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
                
if (class(dt4$latitude)=="factor") dt4$latitude <-as.numeric(levels(dt4$latitude))[as.integer(dt4$latitude) ]
if (class(dt4$longitude)=="factor") dt4$longitude <-as.numeric(levels(dt4$longitude))[as.integer(dt4$longitude) ]                                   
# attempting to convert dt4$date_utc dateTime string to R date structure (date or POSIXct)                                
tmpDateFormat<-"%Y%m%d"
dt4$date_utc<-as.Date(dt4$date_utc,format=tmpDateFormat)
rm(tmpDateFormat) 
if (class(dt4$biomass)=="factor") dt4$biomass <-as.numeric(levels(dt4$biomass))[as.integer(dt4$biomass) ]

# Here is the structure of the input data frame:
str(dt4)                            
attach(dt4)                            
# The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 

summary(latitude)
summary(longitude)
summary(date_utc)
summary(biomass) 
detach(dt4)               
         

infile5  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-sbc/54/6/01efe09cb091b5fb13436777edfc0009" 
infile5 <- sub("^https","http",infile5) 
 dt5 <-read.csv(infile5,header=F 
          ,skip=0
            ,sep=","  
        , col.names=c(
                    "latitude",     
                    "longitude",     
                    "date_utc",     
                    "biomass"    ), check.names=TRUE)
               
  
# Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
                
if (class(dt5$latitude)=="factor") dt5$latitude <-as.numeric(levels(dt5$latitude))[as.integer(dt5$latitude) ]
if (class(dt5$longitude)=="factor") dt5$longitude <-as.numeric(levels(dt5$longitude))[as.integer(dt5$longitude) ]                                   
# attempting to convert dt5$date_utc dateTime string to R date structure (date or POSIXct)                                
tmpDateFormat<-"%Y%m%d"
dt5$date_utc<-as.Date(dt5$date_utc,format=tmpDateFormat)
rm(tmpDateFormat) 
if (class(dt5$biomass)=="factor") dt5$biomass <-as.numeric(levels(dt5$biomass))[as.integer(dt5$biomass) ]

# Here is the structure of the input data frame:
str(dt5)                            
attach(dt5)                            
# The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 

summary(latitude)
summary(longitude)
summary(date_utc)
summary(biomass) 
detach(dt5)               
         

infile6  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-sbc/54/6/70d16a8cef087a10afb6bb82110040a6" 
infile6 <- sub("^https","http",infile6) 
 dt6 <-read.csv(infile6,header=F 
          ,skip=0
            ,sep=","  
        , col.names=c(
                    "latitude",     
                    "longitude",     
                    "date_utc",     
                    "biomass"    ), check.names=TRUE)
               
  
# Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
                
if (class(dt6$latitude)=="factor") dt6$latitude <-as.numeric(levels(dt6$latitude))[as.integer(dt6$latitude) ]
if (class(dt6$longitude)=="factor") dt6$longitude <-as.numeric(levels(dt6$longitude))[as.integer(dt6$longitude) ]                                   
# attempting to convert dt6$date_utc dateTime string to R date structure (date or POSIXct)                                
tmpDateFormat<-"%Y%m%d"
dt6$date_utc<-as.Date(dt6$date_utc,format=tmpDateFormat)
rm(tmpDateFormat) 
if (class(dt6$biomass)=="factor") dt6$biomass <-as.numeric(levels(dt6$biomass))[as.integer(dt6$biomass) ]

# Here is the structure of the input data frame:
str(dt6)                            
attach(dt6)                            
# The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 

summary(latitude)
summary(longitude)
summary(date_utc)
summary(biomass) 
detach(dt6)               
         

infile7  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-sbc/54/6/ecf1547e8fbd2844e307b58baf456a2c" 
infile7 <- sub("^https","http",infile7) 
 dt7 <-read.csv(infile7,header=F 
          ,skip=0
            ,sep=","  
        , col.names=c(
                    "latitude",     
                    "longitude",     
                    "date_utc",     
                    "biomass"    ), check.names=TRUE)
               
  
# Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
                
if (class(dt7$latitude)=="factor") dt7$latitude <-as.numeric(levels(dt7$latitude))[as.integer(dt7$latitude) ]
if (class(dt7$longitude)=="factor") dt7$longitude <-as.numeric(levels(dt7$longitude))[as.integer(dt7$longitude) ]                                   
# attempting to convert dt7$date_utc dateTime string to R date structure (date or POSIXct)                                
tmpDateFormat<-"%Y%m%d"
dt7$date_utc<-as.Date(dt7$date_utc,format=tmpDateFormat)
rm(tmpDateFormat) 
if (class(dt7$biomass)=="factor") dt7$biomass <-as.numeric(levels(dt7$biomass))[as.integer(dt7$biomass) ]

# Here is the structure of the input data frame:
str(dt7)                            
attach(dt7)                            
# The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 

summary(latitude)
summary(longitude)
summary(date_utc)
summary(biomass) 
detach(dt7)               
         

infile8  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-sbc/54/6/e7aff4f62b93b47d22eb6aa60604561a" 
infile8 <- sub("^https","http",infile8) 
 dt8 <-read.csv(infile8,header=F 
          ,skip=0
            ,sep=","  
        , col.names=c(
                    "latitude",     
                    "longitude",     
                    "date_utc",     
                    "biomass"    ), check.names=TRUE)
               
  
# Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
                
if (class(dt8$latitude)=="factor") dt8$latitude <-as.numeric(levels(dt8$latitude))[as.integer(dt8$latitude) ]
if (class(dt8$longitude)=="factor") dt8$longitude <-as.numeric(levels(dt8$longitude))[as.integer(dt8$longitude) ]                                   
# attempting to convert dt8$date_utc dateTime string to R date structure (date or POSIXct)                                
tmpDateFormat<-"%Y%m%d"
dt8$date_utc<-as.Date(dt8$date_utc,format=tmpDateFormat)
rm(tmpDateFormat) 
if (class(dt8$biomass)=="factor") dt8$biomass <-as.numeric(levels(dt8$biomass))[as.integer(dt8$biomass) ]

# Here is the structure of the input data frame:
str(dt8)                            
attach(dt8)                            
# The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 

summary(latitude)
summary(longitude)
summary(date_utc)
summary(biomass) 
detach(dt8)               
         

infile9  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-sbc/54/6/a3d9146dfbeadaab2ef9647899795449" 
infile9 <- sub("^https","http",infile9) 
 dt9 <-read.csv(infile9,header=F 
          ,skip=0
            ,sep=","  
        , col.names=c(
                    "latitude",     
                    "longitude",     
                    "date_utc",     
                    "biomass"    ), check.names=TRUE)
               
  
# Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
                
if (class(dt9$latitude)=="factor") dt9$latitude <-as.numeric(levels(dt9$latitude))[as.integer(dt9$latitude) ]
if (class(dt9$longitude)=="factor") dt9$longitude <-as.numeric(levels(dt9$longitude))[as.integer(dt9$longitude) ]                                   
# attempting to convert dt9$date_utc dateTime string to R date structure (date or POSIXct)                                
tmpDateFormat<-"%Y%m%d"
dt9$date_utc<-as.Date(dt9$date_utc,format=tmpDateFormat)
rm(tmpDateFormat) 
if (class(dt9$biomass)=="factor") dt9$biomass <-as.numeric(levels(dt9$biomass))[as.integer(dt9$biomass) ]

# Here is the structure of the input data frame:
str(dt9)                            
attach(dt9)                            
# The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 

summary(latitude)
summary(longitude)
summary(date_utc)
summary(biomass) 
detach(dt9)               
         

infile10  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-sbc/54/6/0c87577439cdaedde5ca70f14ce7f21a" 
infile10 <- sub("^https","http",infile10) 
 dt10 <-read.csv(infile10,header=F 
          ,skip=0
            ,sep=","  
        , col.names=c(
                    "latitude",     
                    "longitude",     
                    "date_utc",     
                    "biomass"    ), check.names=TRUE)
               
  
# Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
                
if (class(dt10$latitude)=="factor") dt10$latitude <-as.numeric(levels(dt10$latitude))[as.integer(dt10$latitude) ]
if (class(dt10$longitude)=="factor") dt10$longitude <-as.numeric(levels(dt10$longitude))[as.integer(dt10$longitude) ]                                   
# attempting to convert dt10$date_utc dateTime string to R date structure (date or POSIXct)                                
tmpDateFormat<-"%Y%m%d"
dt10$date_utc<-as.Date(dt10$date_utc,format=tmpDateFormat)
rm(tmpDateFormat) 
if (class(dt10$biomass)=="factor") dt10$biomass <-as.numeric(levels(dt10$biomass))[as.integer(dt10$biomass) ]

# Here is the structure of the input data frame:
str(dt10)                            
attach(dt10)                            
# The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 

summary(latitude)
summary(longitude)
summary(date_utc)
summary(biomass) 
detach(dt10)               
         

infile11  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-sbc/54/6/21a173a398142a27bce0d4dfefa4b73f" 
infile11 <- sub("^https","http",infile11) 
 dt11 <-read.csv(infile11,header=F 
          ,skip=0
            ,sep=","  
        , col.names=c(
                    "latitude",     
                    "longitude",     
                    "date_utc",     
                    "biomass"    ), check.names=TRUE)
               
  
# Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
                
if (class(dt11$latitude)=="factor") dt11$latitude <-as.numeric(levels(dt11$latitude))[as.integer(dt11$latitude) ]
if (class(dt11$longitude)=="factor") dt11$longitude <-as.numeric(levels(dt11$longitude))[as.integer(dt11$longitude) ]                                   
# attempting to convert dt11$date_utc dateTime string to R date structure (date or POSIXct)                                
tmpDateFormat<-"%Y%m%d"
dt11$date_utc<-as.Date(dt11$date_utc,format=tmpDateFormat)
rm(tmpDateFormat) 
if (class(dt11$biomass)=="factor") dt11$biomass <-as.numeric(levels(dt11$biomass))[as.integer(dt11$biomass) ]

# Here is the structure of the input data frame:
str(dt11)                            
attach(dt11)                            
# The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 

summary(latitude)
summary(longitude)
summary(date_utc)
summary(biomass) 
detach(dt11)               
         

infile12  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-sbc/54/6/4ce64630cdca8737d85f04cdb15120cb" 
infile12 <- sub("^https","http",infile12) 
 dt12 <-read.csv(infile12,header=F 
          ,skip=0
            ,sep=","  
        , col.names=c(
                    "latitude",     
                    "longitude",     
                    "date_utc",     
                    "biomass"    ), check.names=TRUE)
               
  
# Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
                
if (class(dt12$latitude)=="factor") dt12$latitude <-as.numeric(levels(dt12$latitude))[as.integer(dt12$latitude) ]
if (class(dt12$longitude)=="factor") dt12$longitude <-as.numeric(levels(dt12$longitude))[as.integer(dt12$longitude) ]                                   
# attempting to convert dt12$date_utc dateTime string to R date structure (date or POSIXct)                                
tmpDateFormat<-"%Y%m%d"
dt12$date_utc<-as.Date(dt12$date_utc,format=tmpDateFormat)
rm(tmpDateFormat) 
if (class(dt12$biomass)=="factor") dt12$biomass <-as.numeric(levels(dt12$biomass))[as.integer(dt12$biomass) ]

# Here is the structure of the input data frame:
str(dt12)                            
attach(dt12)                            
# The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 

summary(latitude)
summary(longitude)
summary(date_utc)
summary(biomass) 
detach(dt12)               
         

infile13  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-sbc/54/6/e5b83151139f00afcb9fea496997ec75" 
infile13 <- sub("^https","http",infile13) 
 dt13 <-read.csv(infile13,header=F 
          ,skip=0
            ,sep=","  
        , col.names=c(
                    "latitude",     
                    "longitude",     
                    "date_utc",     
                    "biomass"    ), check.names=TRUE)
               
  
# Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
                
if (class(dt13$latitude)=="factor") dt13$latitude <-as.numeric(levels(dt13$latitude))[as.integer(dt13$latitude) ]
if (class(dt13$longitude)=="factor") dt13$longitude <-as.numeric(levels(dt13$longitude))[as.integer(dt13$longitude) ]                                   
# attempting to convert dt13$date_utc dateTime string to R date structure (date or POSIXct)                                
tmpDateFormat<-"%Y%m%d"
dt13$date_utc<-as.Date(dt13$date_utc,format=tmpDateFormat)
rm(tmpDateFormat) 
if (class(dt13$biomass)=="factor") dt13$biomass <-as.numeric(levels(dt13$biomass))[as.integer(dt13$biomass) ]

# Here is the structure of the input data frame:
str(dt13)                            
attach(dt13)                            
# The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 

summary(latitude)
summary(longitude)
summary(date_utc)
summary(biomass) 
detach(dt13)               
         

infile14  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-sbc/54/6/4dbaac177f8894a0f77aeaab1cb69bda" 
infile14 <- sub("^https","http",infile14) 
 dt14 <-read.csv(infile14,header=F 
          ,skip=0
            ,sep=","  
        , col.names=c(
                    "latitude",     
                    "longitude",     
                    "date_utc",     
                    "biomass"    ), check.names=TRUE)
               
  
# Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
                
if (class(dt14$latitude)=="factor") dt14$latitude <-as.numeric(levels(dt14$latitude))[as.integer(dt14$latitude) ]
if (class(dt14$longitude)=="factor") dt14$longitude <-as.numeric(levels(dt14$longitude))[as.integer(dt14$longitude) ]                                   
# attempting to convert dt14$date_utc dateTime string to R date structure (date or POSIXct)                                
tmpDateFormat<-"%Y%m%d"
dt14$date_utc<-as.Date(dt14$date_utc,format=tmpDateFormat)
rm(tmpDateFormat) 
if (class(dt14$biomass)=="factor") dt14$biomass <-as.numeric(levels(dt14$biomass))[as.integer(dt14$biomass) ]

# Here is the structure of the input data frame:
str(dt14)                            
attach(dt14)                            
# The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 

summary(latitude)
summary(longitude)
summary(date_utc)
summary(biomass) 
detach(dt14)               
         

infile15  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-sbc/54/6/338cd6a14261d6e99ace65f93177d816" 
infile15 <- sub("^https","http",infile15) 
 dt15 <-read.csv(infile15,header=F 
          ,skip=0
            ,sep=","  
        , col.names=c(
                    "latitude",     
                    "longitude",     
                    "date_utc",     
                    "biomass"    ), check.names=TRUE)
               
  
# Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
                
if (class(dt15$latitude)=="factor") dt15$latitude <-as.numeric(levels(dt15$latitude))[as.integer(dt15$latitude) ]
if (class(dt15$longitude)=="factor") dt15$longitude <-as.numeric(levels(dt15$longitude))[as.integer(dt15$longitude) ]                                   
# attempting to convert dt15$date_utc dateTime string to R date structure (date or POSIXct)                                
tmpDateFormat<-"%Y%m%d"
dt15$date_utc<-as.Date(dt15$date_utc,format=tmpDateFormat)
rm(tmpDateFormat) 
if (class(dt15$biomass)=="factor") dt15$biomass <-as.numeric(levels(dt15$biomass))[as.integer(dt15$biomass) ]

# Here is the structure of the input data frame:
str(dt15)                            
attach(dt15)                            
# The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 

summary(latitude)
summary(longitude)
summary(date_utc)
summary(biomass) 
detach(dt15)               
         

infile16  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-sbc/54/6/34a9aafb19eda07252c62cdc6a0b6bf9" 
infile16 <- sub("^https","http",infile16) 
 dt16 <-read.csv(infile16,header=F 
          ,skip=0
            ,sep=","  
        , col.names=c(
                    "latitude",     
                    "longitude",     
                    "date_utc",     
                    "biomass"    ), check.names=TRUE)
               
  
# Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
                
if (class(dt16$latitude)=="factor") dt16$latitude <-as.numeric(levels(dt16$latitude))[as.integer(dt16$latitude) ]
if (class(dt16$longitude)=="factor") dt16$longitude <-as.numeric(levels(dt16$longitude))[as.integer(dt16$longitude) ]                                   
# attempting to convert dt16$date_utc dateTime string to R date structure (date or POSIXct)                                
tmpDateFormat<-"%Y%m%d"
dt16$date_utc<-as.Date(dt16$date_utc,format=tmpDateFormat)
rm(tmpDateFormat) 
if (class(dt16$biomass)=="factor") dt16$biomass <-as.numeric(levels(dt16$biomass))[as.integer(dt16$biomass) ]

# Here is the structure of the input data frame:
str(dt16)                            
attach(dt16)                            
# The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 

summary(latitude)
summary(longitude)
summary(date_utc)
summary(biomass) 
detach(dt16)               
         

infile17  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-sbc/54/6/da21ea736200cc296dc0cf61a41e9600" 
infile17 <- sub("^https","http",infile17) 
 dt17 <-read.csv(infile17,header=F 
          ,skip=0
            ,sep=","  
        , col.names=c(
                    "latitude",     
                    "longitude",     
                    "date_utc",     
                    "biomass"    ), check.names=TRUE)
               
  
# Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
                
if (class(dt17$latitude)=="factor") dt17$latitude <-as.numeric(levels(dt17$latitude))[as.integer(dt17$latitude) ]
if (class(dt17$longitude)=="factor") dt17$longitude <-as.numeric(levels(dt17$longitude))[as.integer(dt17$longitude) ]                                   
# attempting to convert dt17$date_utc dateTime string to R date structure (date or POSIXct)                                
tmpDateFormat<-"%Y%m%d"
dt17$date_utc<-as.Date(dt17$date_utc,format=tmpDateFormat)
rm(tmpDateFormat) 
if (class(dt17$biomass)=="factor") dt17$biomass <-as.numeric(levels(dt17$biomass))[as.integer(dt17$biomass) ]

# Here is the structure of the input data frame:
str(dt17)                            
attach(dt17)                            
# The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 

summary(latitude)
summary(longitude)
summary(date_utc)
summary(biomass) 
detach(dt17)               
         

infile18  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-sbc/54/6/43ecff3f2f012c43b992d1fe6e0f2e8d" 
infile18 <- sub("^https","http",infile18) 
 dt18 <-read.csv(infile18,header=F 
          ,skip=0
            ,sep=","  
        , col.names=c(
                    "latitude",     
                    "longitude",     
                    "date_utc",     
                    "biomass"    ), check.names=TRUE)
               
  
# Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
                
if (class(dt18$latitude)=="factor") dt18$latitude <-as.numeric(levels(dt18$latitude))[as.integer(dt18$latitude) ]
if (class(dt18$longitude)=="factor") dt18$longitude <-as.numeric(levels(dt18$longitude))[as.integer(dt18$longitude) ]                                   
# attempting to convert dt18$date_utc dateTime string to R date structure (date or POSIXct)                                
tmpDateFormat<-"%Y%m%d"
dt18$date_utc<-as.Date(dt18$date_utc,format=tmpDateFormat)
rm(tmpDateFormat) 
if (class(dt18$biomass)=="factor") dt18$biomass <-as.numeric(levels(dt18$biomass))[as.integer(dt18$biomass) ]

# Here is the structure of the input data frame:
str(dt18)                            
attach(dt18)                            
# The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 

summary(latitude)
summary(longitude)
summary(date_utc)
summary(biomass) 
detach(dt18)               
         

infile19  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-sbc/54/6/b39f89afe2b1463565d29354c190b72f" 
infile19 <- sub("^https","http",infile19) 
 dt19 <-read.csv(infile19,header=F 
          ,skip=0
            ,sep=","  
        , col.names=c(
                    "latitude",     
                    "longitude",     
                    "date_utc",     
                    "biomass"    ), check.names=TRUE)
               
  
# Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
                
if (class(dt19$latitude)=="factor") dt19$latitude <-as.numeric(levels(dt19$latitude))[as.integer(dt19$latitude) ]
if (class(dt19$longitude)=="factor") dt19$longitude <-as.numeric(levels(dt19$longitude))[as.integer(dt19$longitude) ]                                   
# attempting to convert dt19$date_utc dateTime string to R date structure (date or POSIXct)                                
tmpDateFormat<-"%Y%m%d"
dt19$date_utc<-as.Date(dt19$date_utc,format=tmpDateFormat)
rm(tmpDateFormat) 
if (class(dt19$biomass)=="factor") dt19$biomass <-as.numeric(levels(dt19$biomass))[as.integer(dt19$biomass) ]

# Here is the structure of the input data frame:
str(dt19)                            
attach(dt19)                            
# The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 

summary(latitude)
summary(longitude)
summary(date_utc)
summary(biomass) 
detach(dt19)               
         

infile20  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-sbc/54/6/9b4b03133540c7d736bc4d7ed246d569" 
infile20 <- sub("^https","http",infile20) 
 dt20 <-read.csv(infile20,header=F 
          ,skip=0
            ,sep=","  
        , col.names=c(
                    "latitude",     
                    "longitude",     
                    "date_utc",     
                    "biomass"    ), check.names=TRUE)
               
  
# Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
                
if (class(dt20$latitude)=="factor") dt20$latitude <-as.numeric(levels(dt20$latitude))[as.integer(dt20$latitude) ]
if (class(dt20$longitude)=="factor") dt20$longitude <-as.numeric(levels(dt20$longitude))[as.integer(dt20$longitude) ]                                   
# attempting to convert dt20$date_utc dateTime string to R date structure (date or POSIXct)                                
tmpDateFormat<-"%Y%m%d"
dt20$date_utc<-as.Date(dt20$date_utc,format=tmpDateFormat)
rm(tmpDateFormat) 
if (class(dt20$biomass)=="factor") dt20$biomass <-as.numeric(levels(dt20$biomass))[as.integer(dt20$biomass) ]

# Here is the structure of the input data frame:
str(dt20)                            
attach(dt20)                            
# The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 

summary(latitude)
summary(longitude)
summary(date_utc)
summary(biomass) 
detach(dt20)               
         

infile21  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-sbc/54/6/86387c19722a1e1cbdda60787da50ad5" 
infile21 <- sub("^https","http",infile21) 
 dt21 <-read.csv(infile21,header=F 
          ,skip=0
            ,sep=","  
        , col.names=c(
                    "latitude",     
                    "longitude",     
                    "date_utc",     
                    "biomass"    ), check.names=TRUE)
               
  
# Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
                
if (class(dt21$latitude)=="factor") dt21$latitude <-as.numeric(levels(dt21$latitude))[as.integer(dt21$latitude) ]
if (class(dt21$longitude)=="factor") dt21$longitude <-as.numeric(levels(dt21$longitude))[as.integer(dt21$longitude) ]                                   
# attempting to convert dt21$date_utc dateTime string to R date structure (date or POSIXct)                                
tmpDateFormat<-"%Y%m%d"
dt21$date_utc<-as.Date(dt21$date_utc,format=tmpDateFormat)
rm(tmpDateFormat) 
if (class(dt21$biomass)=="factor") dt21$biomass <-as.numeric(levels(dt21$biomass))[as.integer(dt21$biomass) ]

# Here is the structure of the input data frame:
str(dt21)                            
attach(dt21)                            
# The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 

summary(latitude)
summary(longitude)
summary(date_utc)
summary(biomass) 
detach(dt21)               
         

infile22  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-sbc/54/6/1ac7ce9e5a2afbdd7ce70d0774927bfb" 
infile22 <- sub("^https","http",infile22) 
 dt22 <-read.csv(infile22,header=F 
          ,skip=0
            ,sep=","  
        , col.names=c(
                    "latitude",     
                    "longitude",     
                    "date_utc",     
                    "biomass"    ), check.names=TRUE)
               
  
# Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
                
if (class(dt22$latitude)=="factor") dt22$latitude <-as.numeric(levels(dt22$latitude))[as.integer(dt22$latitude) ]
if (class(dt22$longitude)=="factor") dt22$longitude <-as.numeric(levels(dt22$longitude))[as.integer(dt22$longitude) ]                                   
# attempting to convert dt22$date_utc dateTime string to R date structure (date or POSIXct)                                
tmpDateFormat<-"%Y%m%d"
dt22$date_utc<-as.Date(dt22$date_utc,format=tmpDateFormat)
rm(tmpDateFormat) 
if (class(dt22$biomass)=="factor") dt22$biomass <-as.numeric(levels(dt22$biomass))[as.integer(dt22$biomass) ]

# Here is the structure of the input data frame:
str(dt22)                            
attach(dt22)                            
# The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 

summary(latitude)
summary(longitude)
summary(date_utc)
summary(biomass) 
detach(dt22)               
         

infile23  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-sbc/54/6/93581a7595a7579461591ae2f5f20203" 
infile23 <- sub("^https","http",infile23) 
 dt23 <-read.csv(infile23,header=F 
          ,skip=0
            ,sep=","  
        , col.names=c(
                    "latitude",     
                    "longitude",     
                    "date_utc",     
                    "biomass"    ), check.names=TRUE)
               
  
# Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
                
if (class(dt23$latitude)=="factor") dt23$latitude <-as.numeric(levels(dt23$latitude))[as.integer(dt23$latitude) ]
if (class(dt23$longitude)=="factor") dt23$longitude <-as.numeric(levels(dt23$longitude))[as.integer(dt23$longitude) ]                                   
# attempting to convert dt23$date_utc dateTime string to R date structure (date or POSIXct)                                
tmpDateFormat<-"%Y%m%d"
dt23$date_utc<-as.Date(dt23$date_utc,format=tmpDateFormat)
rm(tmpDateFormat) 
if (class(dt23$biomass)=="factor") dt23$biomass <-as.numeric(levels(dt23$biomass))[as.integer(dt23$biomass) ]

# Here is the structure of the input data frame:
str(dt23)                            
attach(dt23)                            
# The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 

summary(latitude)
summary(longitude)
summary(date_utc)
summary(biomass) 
detach(dt23)               
         

infile24  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-sbc/54/6/b8d1183f7044789b6ec8c9bcc36d5728" 
infile24 <- sub("^https","http",infile24) 
 dt24 <-read.csv(infile24,header=F 
          ,skip=0
            ,sep=","  
        , col.names=c(
                    "latitude",     
                    "longitude",     
                    "date_utc",     
                    "biomass"    ), check.names=TRUE)
               
  
# Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
                
if (class(dt24$latitude)=="factor") dt24$latitude <-as.numeric(levels(dt24$latitude))[as.integer(dt24$latitude) ]
if (class(dt24$longitude)=="factor") dt24$longitude <-as.numeric(levels(dt24$longitude))[as.integer(dt24$longitude) ]                                   
# attempting to convert dt24$date_utc dateTime string to R date structure (date or POSIXct)                                
tmpDateFormat<-"%Y%m%d"
dt24$date_utc<-as.Date(dt24$date_utc,format=tmpDateFormat)
rm(tmpDateFormat) 
if (class(dt24$biomass)=="factor") dt24$biomass <-as.numeric(levels(dt24$biomass))[as.integer(dt24$biomass) ]

# Here is the structure of the input data frame:
str(dt24)                            
attach(dt24)                            
# The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 

summary(latitude)
summary(longitude)
summary(date_utc)
summary(biomass) 
detach(dt24)               
         

infile25  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-sbc/54/6/b63dfede3492f8d60a2403da24222845" 
infile25 <- sub("^https","http",infile25) 
 dt25 <-read.csv(infile25,header=F 
          ,skip=0
            ,sep=","  
        , col.names=c(
                    "latitude",     
                    "longitude",     
                    "date_utc",     
                    "biomass"    ), check.names=TRUE)
               
  
# Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
                
if (class(dt25$latitude)=="factor") dt25$latitude <-as.numeric(levels(dt25$latitude))[as.integer(dt25$latitude) ]
if (class(dt25$longitude)=="factor") dt25$longitude <-as.numeric(levels(dt25$longitude))[as.integer(dt25$longitude) ]                                   
# attempting to convert dt25$date_utc dateTime string to R date structure (date or POSIXct)                                
tmpDateFormat<-"%Y%m%d"
dt25$date_utc<-as.Date(dt25$date_utc,format=tmpDateFormat)
rm(tmpDateFormat) 
if (class(dt25$biomass)=="factor") dt25$biomass <-as.numeric(levels(dt25$biomass))[as.integer(dt25$biomass) ]

# Here is the structure of the input data frame:
str(dt25)                            
attach(dt25)                            
# The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 

summary(latitude)
summary(longitude)
summary(date_utc)
summary(biomass) 
detach(dt25)               
         

infile26  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-sbc/54/6/7caa48797b2fb4ab71624886f1aa4262" 
infile26 <- sub("^https","http",infile26) 
 dt26 <-read.csv(infile26,header=F 
          ,skip=0
            ,sep=","  
        , col.names=c(
                    "latitude",     
                    "longitude",     
                    "date_utc",     
                    "biomass"    ), check.names=TRUE)
               
  
# Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
                
if (class(dt26$latitude)=="factor") dt26$latitude <-as.numeric(levels(dt26$latitude))[as.integer(dt26$latitude) ]
if (class(dt26$longitude)=="factor") dt26$longitude <-as.numeric(levels(dt26$longitude))[as.integer(dt26$longitude) ]                                   
# attempting to convert dt26$date_utc dateTime string to R date structure (date or POSIXct)                                
tmpDateFormat<-"%Y%m%d"
dt26$date_utc<-as.Date(dt26$date_utc,format=tmpDateFormat)
rm(tmpDateFormat) 
if (class(dt26$biomass)=="factor") dt26$biomass <-as.numeric(levels(dt26$biomass))[as.integer(dt26$biomass) ]

# Here is the structure of the input data frame:
str(dt26)                            
attach(dt26)                            
# The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 

summary(latitude)
summary(longitude)
summary(date_utc)
summary(biomass) 
detach(dt26)               
         

infile27  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-sbc/54/6/89b64a4d7ed26a766ea0335770b5e3f2" 
infile27 <- sub("^https","http",infile27) 
 dt27 <-read.csv(infile27,header=F 
          ,skip=0
            ,sep=","  
        , col.names=c(
                    "latitude",     
                    "longitude",     
                    "date_utc",     
                    "biomass"    ), check.names=TRUE)
               
  
# Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
                
if (class(dt27$latitude)=="factor") dt27$latitude <-as.numeric(levels(dt27$latitude))[as.integer(dt27$latitude) ]
if (class(dt27$longitude)=="factor") dt27$longitude <-as.numeric(levels(dt27$longitude))[as.integer(dt27$longitude) ]                                   
# attempting to convert dt27$date_utc dateTime string to R date structure (date or POSIXct)                                
tmpDateFormat<-"%Y%m%d"
dt27$date_utc<-as.Date(dt27$date_utc,format=tmpDateFormat)
rm(tmpDateFormat) 
if (class(dt27$biomass)=="factor") dt27$biomass <-as.numeric(levels(dt27$biomass))[as.integer(dt27$biomass) ]

# Here is the structure of the input data frame:
str(dt27)                            
attach(dt27)                            
# The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 

summary(latitude)
summary(longitude)
summary(date_utc)
summary(biomass) 
detach(dt27)               
         

infile28  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-sbc/54/6/360d850733ec2feb1fb82ce6941d3b64" 
infile28 <- sub("^https","http",infile28) 
 dt28 <-read.csv(infile28,header=F 
          ,skip=0
            ,sep=","  
        , col.names=c(
                    "latitude",     
                    "longitude",     
                    "date_utc",     
                    "biomass"    ), check.names=TRUE)
               
  
# Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
                
if (class(dt28$latitude)=="factor") dt28$latitude <-as.numeric(levels(dt28$latitude))[as.integer(dt28$latitude) ]
if (class(dt28$longitude)=="factor") dt28$longitude <-as.numeric(levels(dt28$longitude))[as.integer(dt28$longitude) ]                                   
# attempting to convert dt28$date_utc dateTime string to R date structure (date or POSIXct)                                
tmpDateFormat<-"%Y%m%d"
dt28$date_utc<-as.Date(dt28$date_utc,format=tmpDateFormat)
rm(tmpDateFormat) 
if (class(dt28$biomass)=="factor") dt28$biomass <-as.numeric(levels(dt28$biomass))[as.integer(dt28$biomass) ]

# Here is the structure of the input data frame:
str(dt28)                            
attach(dt28)                            
# The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 

summary(latitude)
summary(longitude)
summary(date_utc)
summary(biomass) 
detach(dt28)               
        




