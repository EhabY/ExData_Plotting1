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

png("plot3.png", width = 480, height = 480) # open file

plot(data$DateTime, data$Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering") # start plotting

lines(data$DateTime, data$Sub_metering_1)
lines(data$DateTime, data$Sub_metering_2, col = RED)
lines(data$DateTime, data$Sub_metering_3, col = BLUE)

legend("topright", col = c("black", RED, BLUE), lwd = 1,
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.off() # close file
