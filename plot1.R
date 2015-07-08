library(dplyr)
data<-read.csv("household_power_consumption.txt",sep=";",na.strings="?")
data<-filter(data,Date %in% c("1/2/2007","2/2/2007"))
timestamp<-strptime(paste(data$Date,data$Time,sep=" "),"%d/%m/%Y %H:%M:%S")
ts<-cbind(timestamp,select(data,-Date,-Time))
# Assignment suggest to use both as.Date and strptime, but I have no idea why
# strptime on Time alone would actually use current date, which is wrong
# so next two lines aren't needed
#data$Date<-as.Date(data$Date,"%d/%m/%Y")
#data$Time<-strptime(data$Time,"%H:%M:%S")
png("plot1.png",width=480,height=480,units="px")
# example was transparent but no reason for this so let's not do it
# otherwise it would end with
# ,bg="transparent")
hist(ts$Global_active_power,col="red",xlab="Global Active Power (kilowatts)",main="Global Active Power")
dev.off()
