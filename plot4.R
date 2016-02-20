# Author: Patrick Ericx
# Creation date: 20-feb-2016
# Coursera - Exploratory Data Analysis
# Assignment: course project 1
# plot4.R contains the code to create output file plot4.png
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

exercise4 <- FilteredSourceData
exercise4$Date <- as.character(exercise4$Date)
exercise4$Time <- as.character(exercise4$Time)
exercise4$DateTime <- with(exercise4, paste(Date, Time, " "))
exercise4$TS <- strptime(exercise4$DateTime, format="%d/%m/%Y %H:%M:%S")

# This language setting is required to get the day names in English.
language <- "English"
Sys.setlocale("LC_TIME", language)

png("plot4.png", height=480, width=480)
par(mfrow=c(2,2))
# Graph 1
with(exercise4, plot(TS, Global_active_power, type="l", xlab="", ylab="Global Active Power"))

# Graph 2
exercise4$Voltage <- as.numeric(as.character(exercise4$Voltage))
with(exercise4, plot(TS, Voltage, type="l", lwd=1, xlab="datetime", yaxt="n"))
axis(side=2, at=c(234, 236, 238, 240, 242, 244, 246), tick=TRUE, labels=c(234,"",238,"",242,"",246))

# Graph 3
exercise4$Sub1 <- as.numeric(as.character(exercise4$Sub_metering_1))
exercise4$Sub2 <- as.numeric(as.character(exercise4$Sub_metering_2))
exercise4$Sub3 <- as.numeric(as.character(exercise4$Sub_metering_3))
with(exercise4, plot(TS, Sub1, type="l", xlab="", ylab="Energy sub metering"))
with(exercise4, lines(TS, Sub2, type="l", col="red"))
with(exercise4, lines(TS, Sub3, type="l", col="blue"))
legend("topright",c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=c(1,1,1), lwd=c(1, 1, 1), cex=0.75, col=c("black", "red","blue"), bty="n")

# Graph 4
# with the default axis (plot with nothing specified, one on two values was not printed).
exercise4$Global_reactive_power <- as.numeric(as.character(exercise4$Global_reactive_power))
with(exercise4, plot(TS, Global_reactive_power, type="l", lwd=1, xlab="datetime", yaxt="n"))
axis(side=2, at=c(0.0, 0.1, 0.2, 0.3, 0.4, 0.5), tick=TRUE, labels=c("0.0", 0.1, 0.2, 0.3, 0.4, 0.5), cex.axis=0.9)

dev.off()
