setwd("/Users/frankiechiappetta/Documents/GitHub/household_energy_consumption")

library(plyr)
library(dplyr)
library(readr)
library(data.table)

#download data set
if(!file.exists("data")){dir.create("data")}
fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileurl, destfile = "./data.zip")

#unzip file
unzip(zipfile = "./data.zip", exdir = "./data")

#store column names as characters
columnnames <- colnames(read.table("./data/household_power_consumption.txt", nrow = 1, header = TRUE, sep = ";"))

#read dates from 2007-02-01 and 2007-02-02
#dataset <- read.table("/Users/frankiechiappetta/Desktop/DS/R STUDIO/exp_data/data/household_power_consumption.txt", header=TRUE, sep = ";")
febdata <- fread("grep -E '^1/2/2007|^2/2/2007' ./data/household_power_consumption.txt", col.names = (columnnames), na.strings="?")

#convert time to time class
datetime <- strptime(paste(febdata$Date, febdata$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 

#convert time to time class
febdata$Time <- as.POSIXct(datetime)

#convert date to date class
febdata$Date <- as.Date(febdata$Date, "%d/%m/%y")

#create graphing device
png(file = "Plot3.png", width=480, height=480)

#plot
x <- febdata$Time
y1 <- febdata$Sub_metering_1
y2 <- febdata$Sub_metering_2
y3 <- febdata$Sub_metering_3
plot(x, y1, type="l", ylab ="Energy sub metering", xlab = "", ylim = c(0,38))
lines(x, y2,  type="l", col = "red")
lines(x, y3,  type="l", col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=1.5, col = c("black", "red", "blue"))

#turn off graphing device
dev.off()

