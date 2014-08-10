require(sqldf)
require(graphics)
Plot3 <- function()
{
remove(DTHPCC)
remove(DTHPC)
DTHPC<-read.csv.sql("household_power_consumption.txt",header=TRUE,sep=";",sql="select * from file where Date in ('1/2/2007','2/2/2007') ")
DTHPC$Global_active_power<-as.numeric(DTHPC$Global_active_power)
DTHPC$Dt<-as.Date(DTHPC$Date,format="%d/%m/%Y")
DTHPC$Sub_metering_1<-as.numeric(DTHPC$Sub_metering_1)
DTHPC$Sub_metering_2<-as.numeric(DTHPC$Sub_metering_2)
DTHPC$Sub_metering_3<-as.numeric(DTHPC$Sub_metering_3)
#DTHPC$DTime<-data.frame(strptime(paste0(DTHPC$Dt," ",DTHPC$Time),format="%Y-%m-%d %H:%M:%S",tz="EST"))
DTHPCC<-cbind(DTHPC[,],strptime(paste0(DTHPC$Dt," ",DTHPC$Time),format="%Y-%m-%d %H:%M:%S",tz="EST"))
colnames(DTHPCC)[11]<-"DTime"
png(filename = "plot3.png",
         width = 480, height = 480, units = "px", pointsize = 12,
         bg = "white")
plot(DTHPCC$DTime,DTHPCC$Sub_metering_1,type="l",xlab="",ylab="Energy sub metering",col="black")
lines(xy.coords(DTHPCC$DTime,DTHPCC$Sub_metering_2),type="l",col="red")
lines(DTHPCC$DTime,DTHPCC$Sub_metering_3,type="l",col="blue")
legend("topright",lty=1,col=c("black","red","blue"),
                     legend=c("sub_metering_1","sub_metering_2","sub_metering_3")
       )
dev.off()
}
Plot3()
