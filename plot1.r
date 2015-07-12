# check for the existence of the unzipped file in the working directory
if (file.exists("./household_power_consumption.txt")) {
  
  #loading data with data.table
  library(data.table)
  data = fread("./household_power_consumption.txt", sep=";",header=TRUE)
  
  #create a column DD with different data format
  data[,DD:=as.Date(data$Date,format='%d/%m/%Y')]
  
  #restrict data to the relevant time frame
  data = data[{data$DD>="2007-02-01" & data$DD<="2007-02-02"},]
  
  #set Global_active_power as numeric data
  data$Global_active_power <- as.numeric(data$Global_active_power)
  
  #plot histogram
  hist(data$Global_active_power, col="red", xlab="Global Active Power (kilowatts)", main="Global Active Power", cex.main=0.75, cex.axis=0.75, cex.lab=0.75)
  
  #export to png (width = 480, height = 480)
  dev.copy(png, file = "plot1.png", width = 480, height = 480, units = "px")
  dev.off()
} else {
  print("Please run the script with the file household_power_consumption.txt in the working directory") 
}