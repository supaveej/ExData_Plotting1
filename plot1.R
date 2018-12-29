library(dplyr)
#file path for text file containing data
fpath <- "./household_power_consumption.txt"

#import data from text file (colon separated with header and convert '?' to NAs)
dt <- tbl_df(read.table(fpath, sep = ';', header = TRUE, na.strings = c('?')))
dt <- filter(dt,Date %in% c("1/2/2007","2/2/2007"))

#add DateTime column to data table
dt$DateTime <- strptime(paste(dt$Date,dt$Time),"%d/%m/%Y %H:%M:%S")
dt$Date <- as.Date(dt$Date)

#plot histogram of Global_active_power
hist(dt$Global_active_power, main="Global Active Power", 
     col="red", xlab="Global Active Power (kilowatts)")
dev.copy(png, "plot1.png", width=480, height=480, units="px")
dev.off()


