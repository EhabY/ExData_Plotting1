library(data.table)

################################################################################
#                               Data Processing                                #
################################################################################

# Reading data
data <- fread("household_power_consumption.txt", na.strings = "?",
              colClasses = c("character", "character", rep("numeric", 7)))

# Filter it to only the 1st and 2nd of Feb 2007
data <- subset(data, Date == "1/2/2007" | Date == "2/2/2007")

################################################################################
#                                   Plotting                                   #
################################################################################

RED <- "#ff2500"

png("plot1.png", width = 480, height = 480) # open file

hist(data$Global_active_power, xlab = "Global Active Power (kilowatts)",
     main = "Global Active Power", col = RED) # plot

dev.off() # close file
