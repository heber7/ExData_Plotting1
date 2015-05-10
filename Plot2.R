
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

plot(data$Global_active_power ~ data$Datetime, type = "l",
     ylab = "Global Active Power (kilowatts)", xlab = "")

## Creating the PNG file
dev.copy(png,file="plot2.png")
dev.off()

