# check for the existence of the unzipped file in the working directory
if (file.exists("./household_power_consumption.txt")) {
  
  #loading data with data.table
  library(data.table)
  data = fread("./household_power_consumption.txt", sep=";",header=TRUE)
  
  #create a column DD with different data format
  data[,DD:=as.Date(data$Date,format='%d/%m/%Y')]
  
  #restrict data to the relevant time frame
  data = data[{data$DD>="2007-02-01" & data$DD<="2007-02-02"},]
  
  #create the column CH, formatting+merging Time and Date
  data[,CH:=as.POSIXct(x = paste(as.Date(data$Date, format = "%d/%m/%Y"), data$Time), format = "%Y-%m-%d %H:%M:%S")]
  
  #set Global_active_power as numeric data
  data$Global_active_power <- as.numeric(data$Global_active_power)
  
  #plot graphs (in 2 rows and 2 columns) - clockwise from topleft
  par(mfrow = c(2,2))
  
  with(data, plot(CH, Global_active_power, type="n", xlab="", ylab="Global Active Power", cex.axis=0.75, cex.lab=0.75))
  with(data, lines(CH, Global_active_power), type="l")
  
  with(data, plot(CH, Voltage, type="n", xlab="datetime", ylab="Voltage", cex.axis=0.75, cex.lab=0.75))
  with(data, lines(CH, Voltage), type="l")
  
  with(data, plot(CH, Sub_metering_1, type="n", xlab="", ylab="Energy sub metering", cex.axis=0.75, cex.lab=0.75))
  with(data, lines(CH, Sub_metering_1, col="black"))
  with(data, lines(CH, Sub_metering_2, col="red"))
  with(data, lines(CH, Sub_metering_3, col="blue"))
  legend("topright", lty = 1, cex=0.75, col = c("black", "red","blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty = "n")

  with(data, plot(CH, Global_reactive_power, type="n", xlab="datetime", ylab="Global_reactive_power", cex.axis=0.75, cex.lab=0.75))
  with(data, lines(CH, Global_reactive_power), type="l")
    
  #export to png (width = 480, height = 480)
  dev.copy(png, file = "plot4.png", width = 480, height = 480, units = "px")
  dev.off()
} else {
  print("Please run the script with the file household_power_consumption.txt in the working directory") 
}