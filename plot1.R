
### Estimated amount of memory needed to load the datas
## 2075259 rows, 9 lines multiplied by 8 byte
# below in megabytes
est <-  round(2075259*9*8/2^{20}, 2)
est

### A test to import only a subset with sqdlf but not really fast
# library(sqldf)
# df <- read.csv.sql('household_power_consumption.txt', "select * from file where Date in('1/2/2007','2/2/2007')", header = T, sep = ";")


### load the datas
mylink <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

# modify the line below if you want to try in your own computer
myfolder <- "C:/Users/maele/Documents/WORK/JHOPKINS/Exploratory_data_analysis/week1/ExData_Plotting1"

setwd(myfolder)
myfile_in_myfolder <- paste0(myfolder,"/the_zip_file.zip")
download.file(mylink, destfile = myfile_in_myfolder )
unzip("the_zip_file.zip")
df <- read.csv("household_power_consumption.txt", sep =";")


### a test to import only a subset with sqdlf but not really fast
# library(sqldf)
# df <- read.csv.sql('household_power_consumption.txt', "select * from file where Date in('1/2/2007','2/2/2007')", header = T, sep = ";")


### data wrangling

# subset the datas
df_date_sub <- df[df$Date == "1/2/2007" |df$Date == "2/2/2007", ]

# convert dates and time
df_date_sub <- df_date_sub %>%  mutate(DateAsDate = as.Date(Date,"%d/%m/%Y"))
df_date_sub <- df_date_sub %>% mutate(DateTime = strptime(paste(Date,Time), format = "%d/%m/%Y %H:%M:%S" ))

# convert characters to numeric when needed
df_date_sub <- df_date_sub %>% mutate(Global_active_power = as.numeric(Global_active_power))
df_date_sub$Sub_metering_1 <- as.numeric(df_date_sub$Sub_metering_1)
df_date_sub$Sub_metering_2 <- as.numeric(df_date_sub$Sub_metering_2)
df_date_sub$Voltage <- as.numeric(df_date_sub$Voltage)
df_date_sub$Global_reactive_power <- as.numeric(df_date_sub$Global_reactive_power)

#Switch date display language to english
Sys.setlocale("LC_TIME","en_CA.UTF-8" )

### build the first plot

png(file = "Plot 1.png", width = 480, height = 480)
hist(df_date_sub$Global_active_power, main = "Global Active Power", xlab = "Global active power (kilowatts)", col = "red")
dev.off()