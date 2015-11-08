colname = read.table("household_power_consumption.txt",sep = ";", nrows = 1,header = TRUE)
data = read.table("household_power_consumption.txt",sep=";",skip=66637,nrows = 2880,col.names = names(colname))
data$Time = paste(data$Date,":",data$Time,sep="")
x = lapply(data$Time,strptime,format="%d/%m/%Y:%H:%M:%S")
t = lapply(x,as.POSIXlt)
t = lapply(t,as.numeric)
png(filename = "plot4.png",width = 480, height = 480, units = "px")
par(mfrow = c(2,2))
# fig 1
plot(t,data$Global_active_power,type = 'l',pch = 21,ylab = "Global Active Power (kilowatts)",xaxt = "n", xlab = "")
axis(1,labels=c("Thu","Fri","Sat"),at=c(t[[1]],t[[1440]],t[[2880]]))
#fig 2
plot(t,data$Voltage,type = 'l',pch = 21,ylab = "Voltage",xaxt = "n", xlab = "datetime")
axis(1,labels=c("Thu","Fri","Sat"),at=c(t[[1]],t[[1440]],t[[2880]]))
#fig 3
plot(t,data$Sub_metering_1,type = 'l',pch = 21,ylab = "Energy sub metering",xaxt = "n", xlab = "")
axis(1,labels=c("Thu","Fri","Sat"),at=c(t[[1]],t[[1440]],t[[2880]]))
lines(x=t,y=data$Sub_metering_2,col="red",type='l',pch=21)
lines(x=t,y=data$Sub_metering_3,col="blue",type='l',pch=21)
legend("topright",legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"),lty = 1)

#fig 4
plot(t,data$Global_reactive_power,type = 'l',pch = 21,ylab = "Global_reactive_power",xaxt = "n", xlab = "datetime")
axis(1,labels=c("Thu","Fri","Sat"),at=c(t[[1]],t[[1440]],t[[2880]]))
dev.off()
