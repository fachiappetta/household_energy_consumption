setwd("~/Desktop/DS/R STUDIO/exp_data")

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

#create histogram
png(file = "Plot1.png")
hist(febdata$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", col = "red")
dev.off()


