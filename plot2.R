# Author: Patrick Ericx
# Creation date: 20-feb-2016
# Coursera - Exploratory Data Analysis
# Assignment: course project 1
# plot2.R contains the code to create output file plot2.png
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
 
exercise2 <- FilteredSourceData
exercise2$Date <- as.character(exercise2$Date)
exercise2$Time <- as.character(exercise2$Time)
exercise2$DateTime <- with(exercise2, paste(Date, Time, " "))
exercise2$TS <- strptime(exercise2$DateTime, format="%d/%m/%Y %H:%M:%S")

# This language setting is required to get the day names in English.
language <- "English"
Sys.setlocale("LC_TIME", language)        # [1] "English_United States.1252"
png("plot2.png", width=480, height=480)
with(exercise2, plot(TS, Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)"))
dev.off()
