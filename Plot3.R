
Text <- file("household_power_consumption.txt")

kakadu <- read.csv(Text, header = TRUE, sep = ';', 
                      na.strings = "?", nrows = 2075259, check.names = FALSE, 
                      stringsAsFactors = FALSE, comment.char = "", quote = '\"')
kakadu$Date <- as.Date(kakadu$Date, format = "%d/%m/%Y")

## Subsetting the data
data <- subset(kakadu, subset = (Date >= "2007-02-01" & Date <= "2007-02-02"))
rm(kakadu)

## Converting dates
datetime <- paste(as.Date(data$Date), data$Time)
data$Datetime <- as.POSIXct(datetime)

## Plot the graph

with(data, {
  plot(Sub_metering_1 ~ Datetime, type = "l", 
       ylab = "Global Active Power (kilowatts)", xlab = "")
  lines(Sub_metering_2 ~ Datetime, col = 'Red')
  lines(Sub_metering_3 ~ Datetime, col = 'Blue')
})
legend("topright", col = c("black", "red", "blue"), lty = 1, lwd = 2,
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

##dev.copy(png,file="plot3.png")
##dev.off()