library(dplyr)
epc_data <- read.table("household_power_consumption.txt",header=TRUE,sep = ";")
epc_data <- mutate(epc_data,Date = as.Date(Date,"%d/%m/%Y"))

epc_data$Global_active_power <- as.character(epc_data$Global_active_power)
epc_data$Global_active_power[epc_data$Global_active_power == "?"] <- NA

ds <- epc_data[which(as.character(epc_data$Date) %in% c("2007-02-01", "2007-02-02")),]
ds$Global_active_power <- as.numeric(ds$Global_active_power)
png(filename = "plot1.png",width=480,height=480)
hist(ds$Global_active_power, xlab = "Global Active Power (kilowatts)",col="red", main = "Global Active Power")
dev.off()