library(dplyr)
library(tidyr)
data<-read.csv("household_power_consumption.txt",sep=";",na.strings="?")
data<-filter(data,Date %in% c("1/2/2007","2/2/2007"))
timestamp<-strptime(paste(data$Date,data$Time,sep=" "),"%d/%m/%Y %H:%M:%S")
ts<-cbind(timestamp,select(data,-Date,-Time))
# Assignment suggest to use both as.Date and strptime, but I have no idea why
# strptime on Time alone would actually use current date, which is wrong
# so next two lines aren't needed
#data$Date<-as.Date(data$Date,"%d/%m/%Y")
#data$Time<-strptime(data$Time,"%H:%M:%S")
png("plot3.png",width=480,height=480,units="px")
# example was transparent but no reason for this so let's not do it
# otherwise it would end with
# ,bg="transparent")

# Let us gather it all to one column, so that plot() will scale Y correctly
sb<- ts %>% select(timestamp,Sub_metering_1,Sub_metering_2,Sub_metering_3) %>% gather(subtype,value,-timestamp)
plot(sb$timestamp,sb$value,type="n",main="",ylab="Energy sub metering",xlab="")

# I am colorblind, btw, so I couldn't replicate colors from the example
colorblind=c("black","red","blue")

lines(ts$timestamp,ts$Sub_metering_1,col=colorblind[1])
lines(ts$timestamp,ts$Sub_metering_2,col=colorblind[2])
lines(ts$timestamp,ts$Sub_metering_3,col=colorblind[3])

legend("topright", legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty=c(1,1,1), col=colorblind)

dev.off()
