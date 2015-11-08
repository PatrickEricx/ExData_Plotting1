# the file is downloaded in this folder: C:/Coursera/04_graphs/sourcedata
 setwd("C:/Coursera/04_graphs")
 datafile <- "sourcedata/household_power_consumption.txt"
 data <- read.table(datafile, header=TRUE, sep=";", stringsAsFactors=FALSE, dec=".") # > 2M observations  
 filtereddata <- data[data$Date %in% c("1/2/2007","2/2/2007") ,]                     #   2880 observations
 rm(data)                             # do not keep this large variable longer then necessary consuming memory space
 # we choose histogram on one variable: Global_active_power
 globalactivepower <- as.numeric(filtereddata$Global_active_power)
 png("plot1.png", width=480, height=480)
 # The label frequency is automatically added on the Y-axis.
 # color : orangered1, based on a forum comment
 # https://class.coursera.org/exdata-034/forum/thread?thread_id=64
 hist(globalactivepower, col="orangered1", main="Global Active Power", xlab="Global Active Power (kilowatts)")
 dev.off()
