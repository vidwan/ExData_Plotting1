library(dplyr)
epc_data <- read.table("household_power_consumption.txt",header=TRUE,sep = ";")
epc_data <- mutate(epc_data, Date = as.character(Date), Time=as.character(Time), dt = paste(Date,Time))
epc_data <- filter(epc_data,Date  %in% c("1/2/2007", "2/2/2007" ))
epc_data$datetime <- strptime(epc_data$dt, "%d/%m/%Y %H:%M:%S")
ds <- mutate(epc_data,Date = as.Date(Date,"%d/%m/%Y"))

ds$Global_active_power <- as.character(ds$Global_active_power)
ds$Global_active_power[ds$Global_active_power == "?"] <- NA
ds$Global_active_power <- as.numeric(ds$Global_active_power)
png(filename = "plot2.png",width=480,height=480)
plot(x=ds$datetime, y=ds$Global_active_power, ylab ="Global Active Power (kilowatts)",type="l",xlab="")
dev.off()
