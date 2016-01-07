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

## Extract the relevant variable and prepare to plot it
globalActivePower <- data[validInd, "Global_active_power"]

## Set up the new file and pipe the appropriate graphics to it
png('plot1.png')
hist(globalActivePower, xlab = "Global_active_power", 
     main = "Global Active Power (kilowatts")
dev.off()