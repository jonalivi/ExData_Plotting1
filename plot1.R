# plot the histogram of global active power values frequency distribution -----
## set pngfile equals to NULL in order not to write to a file
plot1 <- function(pngfile="./plot1.png") {
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

      # save to png file if needed --------------------------------------------
      if (!is.null(pngfile)) {
            dev.copy(png, file=pngfile)
            dev.off()
      }
}