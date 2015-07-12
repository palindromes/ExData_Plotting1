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
  
  #plot graph
  with(data, plot(CH, Global_active_power, type="n", xlab="", ylab="Global Active Power (kilowatts)", cex.axis=0.75, cex.lab=0.75))
  with(data, lines(CH, Global_active_power), type="l")
  
  #export to png (width = 480, height = 480)
  dev.copy(png, file = "plot2.png", width = 480, height = 480, units = "px")
  dev.off()
} else {
  print("Please run the script with the file household_power_consumption.txt in the working directory") 
}