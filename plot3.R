library(dplyr)
epc_data <- read.table("household_power_consumption.txt",header=TRUE,sep = ";")
epc_data <- mutate(epc_data, Date = as.character(Date), Time=as.character(Time), dt = paste(Date,Time),
                   Sub_metering_1=as.character(Sub_metering_1),
                   Sub_metering_2=as.character(Sub_metering_2),
                   Sub_metering_3=as.character(Sub_metering_3)
                   )
epc_data <- filter(epc_data,Date  %in% c("1/2/2007", "2/2/2007" ))
epc_data$datetime <- strptime(epc_data$dt, "%d/%m/%Y %H:%M:%S")
ds <- mutate(epc_data,Date = as.Date(Date,"%d/%m/%Y"))

ds$Sub_metering_1[ds$Sub_metering_1 == "?"] <- NA
ds$Sub_metering_2[ds$Sub_metering_2 == "?"] <- NA
ds$Sub_metering_3[ds$Sub_metering_3 == "?"] <- NA

ds$Sub_metering_1 <- as.numeric(ds$Sub_metering_1)
ds$Sub_metering_2 <- as.numeric(ds$Sub_metering_2)
ds$Sub_metering_3 <- as.numeric(ds$Sub_metering_3)
png(filename = "plot3.png",width=480,height=480)
plot(x=ds$datetime, y=ds$Sub_metering_1, ylab ="Energy sub metering",type="n",xlab="")
lines(x=ds$datetime,y=ds$Sub_metering_1)
lines(x=ds$datetime,y=ds$Sub_metering_2,col = "red")
lines(x=ds$datetime,y=ds$Sub_metering_3,col = "blue")
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=1,col=c("black","red","blue"))
dev.off()
