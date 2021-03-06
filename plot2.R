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

png("plot2.png", width = 480, height = 480) # open file

plot(data$DateTime, data$Global_active_power, type = "l", xlab = "",
     ylab = "Global Active Power (kilowatt)") # plot

dev.off() # close file
