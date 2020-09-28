library(data.table)

################################################################################
#                               Data Processing                                #
################################################################################

# Reading data
data <- fread("household_power_consumption.txt", na.strings = "?",
              colClasses = c("character", "character", rep("numeric", 7)))

# Filter it to only the 1st and 2nd of Feb 2007
data <- subset(data, Date == "1/2/2007" | Date == "2/2/2007")

# Combine Date and Time to form a single DateTime
data$DateTime <- as.POSIXct(paste(data$Date, data$Time), format = "%d/%m/%Y %H:%M:%S")

################################################################################
#                                   Plotting                                   #
################################################################################

RED <- "#ff2500"
BLUE <- "#0433ff"

png("plot4.png", width = 480, height = 480) # open file

par(mfrow = c(2, 2))

# top left
plot(data$DateTime, data$Global_active_power, type = "l", xlab = "",
     ylab = "Global Active Power (kilowatt)")

# top right
plot(data$DateTime, data$Voltage, type = "l", xlab = "datetime",
     ylab = "Voltage")

# bottom left
plot(data$DateTime, data$Sub_metering_1, type = "n", xlab = "",
     ylab = "Energy sub metering")

lines(data$DateTime, data$Sub_metering_1)
lines(data$DateTime, data$Sub_metering_2, col = RED)
lines(data$DateTime, data$Sub_metering_3, col = BLUE)

legend("topright", col = c("black", RED, BLUE), lwd = 1, bty = "n", cex = 0.9,
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# bottom right
with(data, plot(DateTime, Global_reactive_power, type = "l", xlab = "datetime"))

dev.off() # close file
