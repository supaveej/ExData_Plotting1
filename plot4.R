library(dplyr)
#file path for text file containing data
fpath <- "./household_power_consumption.txt"

#import data from text file (colon separated with header and convert '?' to NAs)
dt <- tbl_df(read.table(fpath, sep = ';', header = TRUE, na.strings = c('?')))
dt <- filter(dt,Date %in% c("1/2/2007","2/2/2007"))

#add DateTime column to data table
dt$DateTime <- strptime(paste(dt$Date,dt$Time),"%d/%m/%Y %H:%M:%S")
dt$Date <- as.Date(dt$Date)

#plot 4 graphs in a 2x2 format
png("plot4.png", width=480, height=480)
par(mfrow=c(2,2))
# Plot 1,1 -------------------------------------------
with(dt, 
     plot(DateTime, Global_active_power, 
          type="l", 
          xlab="", 
          ylab="Global Active Power (kilowatts)"))
# Plot 1,2 -------------------------------------------
with(dt, 
     plot(DateTime, Voltage, 
          type="l", 
          xlab="datetime", 
          ylab="Voltage"))
# Plot 2,1 -------------------------------------------
with(dt, 
     plot(DateTime, Sub_metering_1, 
          type="l", 
          xlab="", 
          ylab="Energy sub metering"))
with(dt,
     lines(DateTime, Sub_metering_2, col="red") )
with(dt,
     lines(DateTime, Sub_metering_3, col="blue") )
legend("topright",legend=names(dt[7:9]),col=c("black","red","blue"), lwd=1, bty="n")
# Plot 2,2 -------------------------------------------
with(dt, 
     plot(DateTime, Global_reactive_power, 
          type="l", 
          xlab="datetime"))

dev.off()
