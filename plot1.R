library(dplyr)

# Get the data file, if itsn't not in the current folder yet
file<-"household_power_consumption.txt"
remote<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
local<-"household_power_consumption.zip"
if (!file.exists(file))
{
  print("Data file is not found, downloading")
  download.file(remote,local)
  print("Unzipping")
  unzip(local)
  file.remove(local)
}

# Couple of hundred megabytes shouldn't be a problem for a modern computer,
# so let's load full file and filter it afterwards, it should be faster this way
data<-read.csv("household_power_consumption.txt",sep=";",na.strings="?")
data<-filter(data,Date %in% c("1/2/2007","2/2/2007"))

# Glue date and time together a timestamp
# Assignment suggested to use both as.Date() and strptime(), but there's
# actually no need for as.Date()
timestamp<-strptime(paste(data$Date,data$Time,sep=" "),"%d/%m/%Y %H:%M:%S")
ts<-cbind(timestamp,select(data,-Date,-Time))

# Open picture file as ordered
png("plot1.png",width=480,height=480,units="px")
# example was transparent but no reason for this so let's not do it

# Build the chart
hist(ts$Global_active_power,col="red",xlab="Global Active Power (kilowatts)",main="Global Active Power")

# Close the file
dev.off()
