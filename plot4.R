## Set Working Directory
setwd("C:/Users/Jon/WORK/COURSES/DATASCIENCESPECIALISATIONS/CourseWork/Exploratory_DataAnalysis_W1")
## Read in data from text file
FullData <- read.table("household_power_consumption.txt", sep=";", header= TRUE)
## Check dimensions are what was expected
dim(FullData)
## Check how many records to expect from filetered dataset
table(FullData$Date)
## Add formatted date field, DateFormatted
FullData$DateFormatted <- strptime(FullData$Date, format="%d/%m/%Y")
## Filter dataset
Data2Days <- subset(FullData, as.Date(DateFormatted) >= "2007-02-01" & as.Date(DateFormatted) <= "2007-02-02")
## Convert variables to numeric datatype 
Data2Days$Global_active_power = as.numeric(as.character(Data2Days$Global_active_power))
Data2Days$Global_reactive_power <- as.numeric(as.character(Data2Days$Global_reactive_power))
Data2Days$Voltage <- as.numeric(as.character(Data2Days$Voltage))
## Add continuous DateTime variable
Data2Days <- transform(Data2Days, DateTime=as.POSIXct(paste(DateFormatted, Time)), "%d/%m/%Y %H:%M:%S")
## Set margins & avoid error, using clobal parameters
graphics.off() 
par("mar") 
par(mar=c(4,4,1,1))
par(mfrow=c(2,2))

## Plot 1 : Global Active Power
with(Data2Days, {plot(DateTime, Global_active_power, type="l", xlab="", ylab="Global Active Power")})
## Plot 2 : Voltage
with(Data2Days, {plot(DateTime, Voltage, 
                      type="l", xlab="datetime", ylab="Voltage")})
##PLOT 3
with(Data2Days, {plot(DateTime, Sub_metering_1, 
                      type="l", xlab="", ylab="Energy sub metering")})
lines(Data2Days$DateTime,Data2Days$Sub_metering_2,col="red")
lines(Data2Days$DateTime,Data2Days$Sub_metering_3,col="blue")
legend("topright", col=c("black","red","blue"), c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "), 
       lty=c(1,1), bty="n", cex=.5) 
#PLOT 4
with(Data2Days, {plot(DateTime, Global_reactive_power, 
                      type="l", xlab="datetime", ylab="Global_reactive_power")})
## Copy plot to png file
dev.copy(png, file="plot4.png", width=480, height=480)
## Close device
dev.off()