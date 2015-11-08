# without this language setting, I get nl-BE values: do, vr, za
Sys.setlocale(category = "LC_ALL", locale = "English_United States.1252")
datafile <- "sourcedata/household_power_consumption.txt"
data <- read.table(datafile, header=TRUE, sep=";", stringsAsFactors=FALSE, dec=".")
filtereddata <- data[data$Date %in% c("1/2/2007","2/2/2007") ,]
rm(data) 
datetime <- strptime(paste(filtereddata$Date, filtereddata$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 
globalactivepower <- as.numeric(filtereddata$Global_active_power)
png("plot2.png", width=480, height=480)
plot(datetime, globalactivepower, type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.off()