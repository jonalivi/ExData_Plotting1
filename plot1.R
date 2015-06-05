# plot the histogram -------------------------------------------------------
plot1 <- function() {
      hist(hpc.table$Global_active_power, col="red",
      xlab = "Global Active Power (kilowatts)",
      main = "Global Active Power")

      # save to png file --------------------------------------------------------

      dev.copy(png, file="plot1.png")
      dev.off()
}

## download and unpack the data if needed, make a table
source("./prepareData.R")
prepareData()
plot1()

