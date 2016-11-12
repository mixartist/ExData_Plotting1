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

#Create datetime feature from Date and Time
data$datetime <- paste(data$Date, data$Time)
data$datetime <- strptime(data$datetime, '%d/%m/%Y %H:%M:%S')

#plot the graph to a png
png('plot1.png', width=480, height=480)
print(hist(data$Global_active_power, 
           breaks=12, 
           xlab="Global Active Power (kilowatts)", 
           main="Global Active Power", 
           col='red'))
dev.off()