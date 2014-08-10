require(sqldf)
Plot2 <- function()
{
remove(DTHPC)
remove(DTHPCC)
DTHPC<-read.csv.sql("household_power_consumption.txt",header=TRUE,sep=";",sql="select * from file where Date in ('1/2/2007','2/2/2007') ")
DTHPC$Global_active_power<-as.numeric(DTHPC$Global_active_power)
DTHPC$Dt<-as.Date(DTHPC$Date,format="%d/%m/%Y")
#DTHPC$DTime<-data.frame(strptime(paste0(DTHPC$Dt," ",DTHPC$Time),format="%Y-%m-%d %H:%M:%S",tz="EST"))
DTHPCC<-cbind(DTHPC[,],strptime(paste0(DTHPC$Dt," ",DTHPC$Time),format="%Y-%m-%d %H:%M:%S",tz="EST"))
colnames(DTHPCC)[11]<-"DTime"
png(filename = "plot2.png",
    width = 480, height = 480, units = "px", pointsize = 12,
    bg = "white")
plot(DTHPCC$DTime,DTHPCC$Global_active_power,type="l",xlab="",ylab="Global Active Power (killowatts)") 
dev.off()
}

Plot2()