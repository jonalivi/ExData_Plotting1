library(data.table)
library(dplyr)
library(lubridate)

# download the data -------------------------------------------------------


if (!file.exists("./data"))
      dir.create("./data")
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
destfile <- "./data/EPS.zip"
## use this line if you are on Windows
download.file(url, destfile=destfile, mode="wb")
## for non-Windows users run next line instead
##download.file(url, destfile=destfile, mode="wb", method="curl")
## add a timestamp
if (!file.exists("./data/tlabel"))
      file.create("./data/tlabel")
tlabel <- file("./data/tlabel","w")
cat(date(), file=tlabel)
close(tlabel)
## unpack the data
unzip(zipfile=destfile,exdir="./data")


# read the data -----------------------------------------------------------

file <- "./data/household_power_consumption.txt"
hpc.table <- fread(file,na.strings = "?",colClasses=rep("character",9))


# select and prepare the data ---------------------------------------------

## add a column for Date/Time
hpc.table <- mutate(hpc.table,
                    DateTime=dmy_hms(
                          paste(hpc.table$Date,
                                hpc.table$Time, " ")))
hpc.table <- select(hpc.table, -1, -2)
## leave only rows with dates from 2007-02-01 to 2007-02-02
hpc.table <- filter(hpc.table, 
                    as.Date(DateTime) >= "2007-02-01",
                    as.Date(DateTime) <= "2007-02-02")
## convert all non-date columns to numeric
hpc.table <- as.data.frame(hpc.table)
for (k in 1:7) {
      hpc.table <- hpc.table[!is.na(hpc.table[k]),]
      hpc.table[[k]] <- as.numeric(hpc.table[[k]])
}   


# plot --------------------------------------------------------------------

hist(hpc.table$Global_active_power, col="red",
     xlab = "Global Active Power (kilowatts)",
     main = "Global Active Power")


# save to png file --------------------------------------------------------

dev.copy(png, file="plot1.png")
dev.off()
