
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

## Establish qty of graphs

par(mfrow = c(2,2), mar = c(4,4,2,1), oma = c(0,0,2,0))

## Plot the graph 1

plot(data$Global_active_power ~ data$Datetime, type = "l",
     ylab = "Global Active Power", xlab = "")

## Plot the graph 2

plot(data$Voltage ~ data$Datetime, type = "l", ylab = "Voltage", xlab = "datetime")

## Plot the graph 3

with(data, {
  plot(Sub_metering_1 ~ Datetime, type = "l",
       ylab = "Global Active Power", xlab = "")
  lines(Sub_metering_2 ~ Datetime, col = 'Red')
  lines(Sub_metering_3 ~ Datetime, col = 'Blue')

legend("topright", col = c("black", "red", "blue"), lty = 1, lwd = 2, bty="n",
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
})

## Plot the graph 4

plot(data$Global_reactive_power ~ data$Datetime, type = "l", 
     ylab = "Global_reactive_power", xlab = "datetime")


dev.copy(png,file="plot4.png")
dev.off()