#Read inputfile
if (!file.exists("./Assignment_wk1")) {dir.create("./Assignment_wk1")}
download.file(url="https://d396qusza40orc.cloudfront.net/exdata%252Fdata%252Fhousehold_power_consumption.zip",destfile="./Assignment_wk1/HHpowerdata")
unzip("./Assignment_wk1/HHpowerdata")