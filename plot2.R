
# plot2 -------------------------------------------------------------------
plot2 <- function() {
      ## download and unpack the data if needed, make a table
      if (!exists("dataPrepared", mode="logical"))
            dataPrepared <<- FALSE
      if (!dataPrepared){
            source("./prepareData.R")
            prepareData()      
      }    
      plot(hpc.table$DateTime, hpc.table$Global_active_power,
            type='n', 
            xlab="", ylab="Global Active Power (kilowatts)",
            cex.lab=0.9, cex.axis=0.9)
      lines(hpc.table$DateTime, hpc.table$Global_active_power,
             lty=1)
       
      # save to png file --------------------------------------------------
      dev.copy(png, file="./plot2.png")
      dev.off()
}