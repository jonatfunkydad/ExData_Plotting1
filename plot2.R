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
## Add numeric variable, GlobalActivePower, converted from Global_active_power 
Data2Days$GlobalActivePower = as.numeric(as.character(Data2Days$Global_active_power))
## Add continuous DateTime variable
Data2Days <- transform(Data2Days, DateTime=as.POSIXct(paste(DateFormatted, Time)), "%d/%m/%Y %H:%M:%S")
## Set margins & avoid error, using clobal parameters
graphics.off() 
par("mar") 
par(mar=c(4,4,1,1))
## Predefine png file
png("plot2.png", width = 480, height = 480)
## Plot line chart
plot(Data2Days$DateTime,Data2Days$Global_active_power, 
     type="l", xlab="", ylab="Global Active Power (kilowatts)")
## Copy to png file of predefined size
dev.off()