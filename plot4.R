## Path to the data
dataPath = "./data/household_power_consumption.txt"

## Load in the date column and find the appropriate range.
dates <- read.table(dataPath, sep=";", colClasses=c(NA, "NULL", "NULL", "NULL", 
                                                    "NULL", "NULL", "NULL", 
                                                    "NULL", "NULL"))
dates <- as.Date(dates[,1], "%d/%m/%Y")
startRange <- as.Date("01/02/2007", "%d/%m/%Y") ## Keep the format the same
endRange <- as.Date("02/02/2007", "%d/%m/%Y")

inRange <- dates == startRange | dates == endRange
firstRow <- match(TRUE, inRange)
rm(dates)
## Load in the appropriate subset of the data

data <- read.table(dataPath, sep=";", nrows = sum(inRange, na.rm=TRUE), 
                   skip=firstRow-1,
                   col.names=c("Date","Time", "Global_active_power", 
                               "Global_reactive_power", "Voltage", 
                               "Global_intensity", "Sub_metering_1",
                               "Sub_metering_2","Sub_metering_3"))

## Convert the date and time to a single timestamp
validInd <- 2:nrow(data)
dateTimes <- paste(as.Date(data[validInd,1],"%d/%m/%Y"), data[validInd,2])
dateTimes <- strptime(dateTimes, "%Y-%m-%d %H:%M:%S")

  
## Set up the new file and pipe the appropriate graphics to it
png('plot4.png')
par(mfrow=c(2,2))

## First figure, global active power
plot(dateTimes, data[validInd, "Global_active_power"], "n", 
     ylab = "Global Active Power (kilowatts)", xla = "")
lines(dateTimes, data[validInd, "Global_active_power"])

## Second figure, voltage
plot(dateTimes, data[validInd, "Voltage"], "n", 
     ylab = "Voltage", xla = "datetime")
lines(dateTimes, data[validInd, "Voltage"])

## Third figure, sub metering
plot(dateTimes, Sub_metering_1, "n", 
     ylab = "Energy sub metering", xla = "")
lines(dateTimes, Sub_metering_1)
lines(dateTimes, Sub_metering_2, col = "red")
lines(dateTimes, Sub_metering_3, col = "blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lwd=1, col=c("black", "red", "blue"), bty="n")

## Fourth figure, global reactive power
plot(dateTimes, data[validInd, "Global_reactive_power"], "n", 
     ylab = "Global_reactive_power", xla = "datetime")
lines(dateTimes, data[validInd, "Global_reactive_power"])


dev.off()