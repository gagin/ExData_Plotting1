library(dplyr)
library(tidyr)
# Let's assume the file is already here after running plot1.R
# and all comments for duplicating code are in there
data<-read.csv("household_power_consumption.txt",sep=";",na.strings="?")
data<-filter(data,Date %in% c("1/2/2007","2/2/2007"))
timestamp<-strptime(paste(data$Date,data$Time,sep=" "),"%d/%m/%Y %H:%M:%S")
ts<-cbind(timestamp,select(data,-Date,-Time))
png("plot3.png",width=480,height=480,units="px")

# First, let's build a canvas
# Let us gather it all to one column, so that plot() will scale Y correctly
sb<- ts %>% select(timestamp,Sub_metering_1,Sub_metering_2,Sub_metering_3) %>% gather(subtype,value,-timestamp)
plot(sb$timestamp,sb$value,type="n",main="",ylab="Energy sub metering",xlab="")

# I am colorblind, btw, so I couldn't recognize exact colors from the example
# So I'll use simpler ones
colorblind=c("black","red","blue")

# Let's add lines to the canvas
lines(ts$timestamp,ts$Sub_metering_1,col=colorblind[1])
lines(ts$timestamp,ts$Sub_metering_2,col=colorblind[2])
lines(ts$timestamp,ts$Sub_metering_3,col=colorblind[3])

# Add legend
legend("topright", legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty=c(1,1,1), col=colorblind)

# Close file
dev.off()
