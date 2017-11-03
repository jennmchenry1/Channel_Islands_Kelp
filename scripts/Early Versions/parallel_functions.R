library(Rmetapop)

n_iter = 200
log_sigmaR = 0.5
alpha = 1
beta= 0.5

### simulate residuals
resids <- rnorm(n_iter,-log_sigmaR^2/2,log_sigmaR)

### simulate fake spawner data
spawners <- rlnorm(n_iter,0,1)

### deterministic function 
det_rec <- alpha*spawners*exp(-beta*spawners)

### generate fake data with ricker model
recruits <- alpha*spawners*exp(-beta*spawners+resids)

df1 <- data.frame(list(S= spawners,R= recruits,D= det_rec))

### recruits per spawner
ggplot(aes(S,R),data= df1)+
  geom_point()+
  geom_line(aes(y= D))+
  ylab("recruits")+
  xlab("spawners")

## log recruits per spawner
ggplot(aes(S,log(R/S)),data= df1)+
  geom_point()+
  geom_line(aes(y= log(D/S)))+
  ylab("recruits")+
  xlab("spawners")

### create your function
LOO <- function(ind,data){
    a <- gam(R~s(S),data= df1[-ind,],family = gaussian(link= "log"))
    pred <- predict(a,newdata= df1[ind,])
    error = log(df1[ind,]$R/df1[ind,]$S)-pred
    return(error)
}

### create your input to loop over
hit_list <- as.list(seq (1,n_iter,1)) 

### run it
time_a <- system.time(test <- lapply(hit_list, LOO))

### note the 
time_b <- system.time(test2 <- mclapply(hit_list, LOO,mc.cores=2,mc.preschedule = F))

### put it back together
df1$LOO_Data <- unlist(test)

sd(df1$LOO_Data)

### plot data
