# Download Data File (used for all plots - uncomment only if you need to download)
#download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "./household_power_consumption.zip")

#Read household_power_consumption.zip into a dataframe
data <- read.csv2(unz('household_power_consumption.zip', "household_power_consumption.txt"), na.strings="?")

#Filter for only required dates
data <- subset(data, Date=="1/2/2007" | Date=="2/2/2007")

#Clean up data types
data$Date <- as.character(data$Date)
data$Time <- as.character(data$Time)
data$Global_active_power <- as.character(data$Global_active_power)
data$Global_active_power <- as.numeric(data$Global_active_power)
data$Sub_metering_1 <- as.numeric(as.character(data$Sub_metering_1))
data$Sub_metering_2 <- as.numeric(as.character(data$Sub_metering_2))
data$Sub_metering_3 <- as.numeric(as.character(data$Sub_metering_3))
data$Voltage <- as.numeric(as.character(data$Voltage))
data$Global_reactive_power <- as.numeric(as.character(data$Global_reactive_power))

#Create datetime feature from Date and Time
data$datetime <- paste(data$Date, data$Time)
data$datetime <- strptime(data$datetime, '%d/%m/%Y %H:%M:%S')

#plot the graph to a png
png('plot4.png', width=480, height=480)

#set to 2x2 grid of graphs
par(mfrow=c(2,2))

#plot upper left
print(plot(data$datetime, data$Global_active_power, type="l", ylab="Global Active Power (kilowatts)", xlab=""))
#plot upper right
print(plot(data$datetime, data$Voltage, type="l", ylab="Voltage", xlab="datetime"))
#plot lower left
print(plot(data$datetime, data$Sub_metering_1, type="l", ylab="Energy Sub Metering", xlab = ""))
print(lines(data$datetime, data$Sub_metering_2, type="l", col="red"))
print(lines(data$datetime, data$Sub_metering_3, type="l", col="blue"))
print(legend("topright",legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), lty=c(1,1), bty="n"))
#plot lower right
print(plot(data$datetime, data$Global_reactive_power, type="l", ylab="Global_reactive_power", xlab="datetime"))
#close connection
dev.off()