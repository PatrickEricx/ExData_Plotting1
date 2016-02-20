# Author: Patrick Ericx
# Creation date: 20-feb-2016
# Coursera - Exploratory Data Analysis
# Assignment: course project 1
# plot3.R contains the code to create output file plot3.png
# The zip file with the source data is downloaded and unzipped manually on Windows.
setwd("C:/Coursera/04_graphs")
dir <- "exdata_data_household_power_consumption"
sourcefile <- "household_power_consumption.txt"
sourcefilename <- paste(paste(dir, "/", sep = ""), sourcefile, sep="")
# It is a large dataset, 126 MB. Reading this file takes some time.
sourcedata <- read.csv(sourcefilename, header=TRUE, sep=";")
# Windows locale:                   nl-BE, date format = D/M/YYYY
# We filter on only these 2 values: 2007-02-01 and 2007-02-02.

Filter_1feb <- subset(sourcedata, Date == "1/2/2007")
Filter_2feb <- subset(sourcedata, Date == "2/2/2007")
rm(sourcedata)
FilteredSourceData <- rbind(Filter_1feb, Filter_2feb)
rm(Filter_1feb) 
rm(Filter_2feb)

FilteredSourceData$Global_active_power <- as.numeric(as.character(FilteredSourceData$Global_active_power))

exercise3 <- FilteredSourceData
exercise3$Date <- as.character(exercise3$Date)
exercise3$Time <- as.character(exercise3$Time)
exercise3$DateTime <- with(exercise3, paste(Date, Time, " "))
exercise3$TS <- strptime(exercise3$DateTime, format="%d/%m/%Y %H:%M:%S")
# This language setting is required to get the day names in English.
language <- "English"
Sys.setlocale("LC_TIME", language)      #[1] "English_United States.1252"
exercise3$Sub1 <- as.numeric(as.character(exercise3$Sub_metering_1))
exercise3$Sub2 <- as.numeric(as.character(exercise3$Sub_metering_2))
exercise3$Sub3 <- as.numeric(as.character(exercise3$Sub_metering_3))

png("plot3.png", width=480, height=480)
with(exercise3, plot(TS, Sub1, type="l", xlab="", ylab="Energy sub metering"))
with(exercise3, lines(TS, Sub2, type="l", col="red"))
with(exercise3, lines(TS, Sub3, type="l", col="blue"))
legend("topright",c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=c(1,1,1), lwd=c(2.5, 2.5, 2.5), col=c("black", "red","blue"))
dev.off()
