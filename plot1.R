# plot the histogram -------------------------------------------------------
plot1 <- function() {
      ## download and unpack the data if needed, make a table
      if (!exists("dataPrepared", mode="logical"))
            dataPrepared <<- FALSE
      if (!dataPrepared){
            source("./prepareData.R")
            prepareData()      
      }            
      hist(hpc.table$Global_active_power, col="red",
      xlab = "Global Active Power (kilowatts)",
      main = "Global Active Power", 
      cex.lab=.9, cex.axis=.9, cex.main=.9)

      # save to png file --------------------------------------------------------

      dev.copy(png, file="./plot1.png")
      dev.off()
}