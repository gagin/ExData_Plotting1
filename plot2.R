library(dplyr)
# Let's assume the file is already here after running plot1.R
# and all comments for duplicating code are in there
data<-read.csv("household_power_consumption.txt",sep=";",na.strings="?")
data<-filter(data,Date %in% c("1/2/2007","2/2/2007"))
timestamp<-strptime(paste(data$Date,data$Time,sep=" "),"%d/%m/%Y %H:%M:%S")
ts<-cbind(timestamp,select(data,-Date,-Time))
png("plot2.png",width=480,height=480,units="px")

# Plot 2 is different though
plot(ts$timestamp,ts$Global_active_power,type="n",main="",ylab="Global Active Power (kilowatts)",xlab="")
lines(ts$timestamp,ts$Global_active_power)
dev.off()
