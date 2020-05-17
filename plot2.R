#read in raw data file
testData <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", stringsAsFactors = FALSE)

#filter dates for those specified in assignment
filteredData <- testData[testData$Date == "1/2/2007" | testData$Date == "2/2/2007", ]

#Add a column containing both date and time info
filteredData$dateTime <- strptime(paste(filteredData$Date, filteredData$Time), format = "%d/%m/%Y %H:%M:%S")

#convert several columns to numeric
numericCols <- names (filteredData[,3:9])
filteredData[numericCols] <- sapply(filteredData[numericCols], as.numeric)

#create plot2, note required dimenstions of 480x480 are default arguments to png function
png("plot2.png")
with(filteredData, plot(dateTime, Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)"))
dev.off()