#Importing data

setwd("C:\\Users\\ca_m_\\Desktop\\R\\ExData_Plotting1")
if (!file.exists("exdata_data_household_power_consumption.zip")){
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
                "exdata_data_household_power_consumption.zip", method = "curl")
}
if (!file.exists("household_power_consumption.txt")){
  unzip("exdata_data_household_power_consumption.zip")
}
rows_read <- grep("3/2/2007", readLines("household_power_consumption.txt"))[1] - grep("1/2/2007", readLines("household_power_consumption.txt"))[1]
data <- read.table("household_power_consumption.txt", col.names = c("Date",
                                                                    "Time",
                                                                    "Global_active_power",
                                                                    "Global_reactive_power",
                                                                    "Voltage",
                                                                    "Global_intensity",
                                                                    "Sub_metering_1",
                                                                    "Sub_metering_2",
                                                                    "Sub_metering_3"), 
                   sep = ";", 
                   skip= grep("^[1,2]/2/2007", readLines("household_power_consumption.txt"))[1]-1,
                   nrows = rows_read)


# Converting 1st & 2nd columns to dates/hours

data$date_time <- strptime(paste(data$Date, data$Time), format =  "%d/%m/%Y %H:%M:%S")


# Plot

png("plot2.png", width=480, height=480)
plot(data$date_time, data$Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)")
dev.off()