library(dplyr)
library(tidyr)
# Let's assume the file is already here after running plot1.R
# and all comments for duplicating code are in there
data<-read.csv("household_power_consumption.txt",sep=";",na.strings="?")
data<-filter(data,Date %in% c("1/2/2007","2/2/2007"))
timestamp<-strptime(paste(data$Date,data$Time,sep=" "),"%d/%m/%Y %H:%M:%S")
ts<-cbind(timestamp,select(data,-Date,-Time))
png("plot4.png",width=480,height=480,units="px")

# Let us set up the frame, columns first for already prepared plots 2 and 3
par(mfcol=c(2,2))

# Do first chart - plot2 with changed y label
plot(ts$timestamp,ts$Global_active_power,type="n",main="",ylab="Global Active Power",xlab="")
lines(ts$timestamp,ts$Global_active_power)

# Do second, bottom left chart - plot3, see comments in plot3.R
sb<- ts %>% select(timestamp,Sub_metering_1,Sub_metering_2,Sub_metering_3) %>% gather(subtype,value,-timestamp)
plot(sb$timestamp,sb$value,type="n",main="",ylab="Energy sub metering",xlab="")
colorblind=c("black","red","blue")
lines(ts$timestamp,ts$Sub_metering_1,col=colorblind[1])
lines(ts$timestamp,ts$Sub_metering_2,col=colorblind[2])
lines(ts$timestamp,ts$Sub_metering_3,col=colorblind[3])
# This time legend is borderless
legend("topright", legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty=c(1,1,1), col=colorblind, bty="n")

# Now top right
plot(ts$timestamp,ts$Voltage,xlab="datetime",ylab="Voltage",type="n")
lines(ts$timestamp,ts$Voltage)

# Now bottom right
plot(ts$timestamp,ts$Global_reactive_power,xlab="datetime",ylab="Global_reactive_power",type="n")
lines(ts$timestamp,ts$Global_reactive_power)

# Close the file
dev.off()