#read in raw data file
testData <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", stringsAsFactors = FALSE, na.strings = "?")

#filter dates for those specified in assignment
filteredData <- testData[testData$Date == "1/2/2007" | testData$Date == "2/2/2007", ]

#Add a column containing both date and time info
filteredData$dateTime <- strptime(paste(filteredData$Date, filteredData$Time), format = "%d/%m/%Y %H:%M:%S")

#convert several columns to numeric
numericCols <- names (filteredData[,3:9])
filteredData[numericCols] <- sapply(filteredData[numericCols], as.numeric)

#create plot4, note required dimenstions of 480x480 are default arguments to png function
png("plot4.png")
par(mfrow = c(2,2))

#top left chart
with(filteredData, plot(dateTime, Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)"))

#top right chart
with(filteredData, plot(dateTime, Voltage, type = "l", xlab = "datetime", ylab = "Voltage"))

#bottom left chart
with(filteredData, plot(dateTime, Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering"))
with(filteredData, lines(dateTime, Sub_metering_2, col = "red"))
with(filteredData, lines(dateTime, Sub_metering_3, col = "blue"))
legend("topright", legend = names(filteredData[,7:9]), lwd = c(1,1,1), col = c("black", "red", "blue"))

#bottom right chart
with(filteredData, plot(dateTime, Global_reactive_power, type = "l", xlab = "datetime"))

dev.off()