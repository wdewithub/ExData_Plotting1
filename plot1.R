#Download file and unzip it. This gave a 403 Error. So request manual download of file

# if (!file.exists("./Assignment_wk1")) {dir.create("./Assignment_wk1")}
# download.file(url="https://d396qusza40orc.cloudfront.net/exdata%252Fdata%252Fhousehold_power_consumption.zip",destfile="./Assignment_wk1/HHpowerdata", ssl.verifyPeer=FALSE)
# unzip("./Assignment_wk1/HHpowerdata")

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


#Create plot 1 - A histogram of global active power and send it to a png file
png(filename="./plot1.png", width=480, height=480, units="px")
with(input_sel,hist(Global_active_power,col="red", xlab="Global Active Power (kilowatts)", main="Global Active Power"))
dev.off()

