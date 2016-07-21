#Fist manually download file to your working directory and unzip its content straight into your working
#directory. Then the following command wil read the file and select only the relevant 2 dates we'll work with.

input <- read.csv2(file="./household_power_consumption.txt", header=TRUE, sep=";")
input$Date <- as.Date(input$Date, format="%d/%m/%Y")   
input_sel <- input[input$Date==as.Date("2007-02-01", format="%Y-%m-%d") | input$Date==as.Date("2007-02-02", format="%Y-%m-%d"),]

#Tidy the dataset
##1. Convert Date and Time to a single DateTime variable
rm(input)
input_sel$Date <- as.character.Date(input_sel$Date)
input_sel$Datetime <- paste(input_sel$Date, input_sel$Time, sep=" ")
input_sel$Datetime <- strptime(input_sel$Datetime, format="%Y-%m-%d %H:%M:%S")
##2. Check if the measurment variables have any missing values and if so replace them by the NA symbol using gsub(pattern="?",replacement="NA", x=clean_col) . 
##   Then convert them to numeric variables
for (i in 1:7) {
  clean_col <- input_sel[,i+2]
  print(sum(clean_col=="?"))
  input_sel[,i+2] <- as.numeric(as.character(input_sel[,i+2]))
}


#Create plot 4 - Combination of 4 graphs and send it to a png file
png(filename="./plot4.png", width=480, height=480, units="px")
par(mfrow=c(2,2), oma=c(0,1,0,0), mar=c(5,4,1,2))
##First graph
with(input_sel,plot(x=Datetime,y=Global_active_power, type="n", ylab="Global Active Power (kilowatts)", xlab=""))
with(input_sel,lines(x=Datetime, y=Global_active_power, type="l"))
##Second graph
with(input_sel,plot(x=Datetime,y=Voltage, type="n"))
with(input_sel,lines(x=Datetime, y=Voltage, type="l"))
##Third graph
with(input_sel,plot(x=Datetime,y=Sub_metering_1, type="n", ylab="Energy sub metering", xlab=""))
with(input_sel,lines(x=Datetime, y=Sub_metering_1, type="l"))
with(input_sel,lines(x=Datetime, y=Sub_metering_2, type="l", col="red"))
with(input_sel,lines(x=Datetime, y=Sub_metering_3, type="l", col="blue"))
legend("topright", col=c("black", "red", "blue"), lty=1, legend=names(input_sel[,7:9]), bty="n")
##Fourth graph
with(input_sel,plot(x=Datetime,y=Global_reactive_power, type="n"))
with(input_sel,lines(x=Datetime, y=Global_reactive_power, type="l"))
dev.off()