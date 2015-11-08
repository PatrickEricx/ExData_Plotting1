Sys.setlocale(category = "LC_ALL", locale = "English_United States.1252")
datafile <- "sourcedata/household_power_consumption.txt"
data <- read.table(datafile, header=TRUE, sep=";", stringsAsFactors=FALSE, dec=".")
filtereddata <- data[data$Date %in% c("1/2/2007","2/2/2007") ,]
rm(data)

datetime <- strptime(paste(filtereddata$Date, filtereddata$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 
globalActivePower <- as.numeric(filtereddata$Global_active_power)
globalReactivePower <- as.numeric(filtereddata$Global_reactive_power)
voltage <- as.numeric(filtereddata$Voltage)
subMetering1 <- as.numeric(filtereddata$Sub_metering_1)
subMetering2 <- as.numeric(filtereddata$Sub_metering_2)
subMetering3 <- as.numeric(filtereddata$Sub_metering_3)

png("plot4.png", width=480, height=480)
par(mfrow = c(2, 2)) 

plot(datetime, globalActivePower, type="l", xlab="", ylab="Global Active Power", cex=0.2)

plot(datetime, voltage, type="l", xlab="datetime", ylab="Voltage")

plot(datetime, subMetering1, type="l", ylab="Energy Submetering", xlab="")
lines(datetime, subMetering2, type="l", col="red")
lines(datetime, subMetering3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=, lwd=2.5, col=c("black", "red", "blue"), bty="o")

plot(datetime, globalReactivePower, type="l", xlab="datetime", ylab="Global_reactive_power")

dev.off()
