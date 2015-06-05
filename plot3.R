
# plot3 -------------------------------------------------------------------
plot3 <- function() {
      plot(rep(hpc.table$DateTime,3), 
           c(hpc.table$Sub_metering_1,
             hpc.table$Sub_metering_2,
             hpc.table$Sub_metering_3),
           type='n', 
           xlab="", ylab="Energy sub metering")
      lines(hpc.table$DateTime, hpc.table$Sub_metering_1)
      lines(hpc.table$DateTime, hpc.table$Sub_metering_2, col="red")
      lines(hpc.table$DateTime, hpc.table$Sub_metering_3, col="blue")
      
      ## making the legend more compact than the standard one
      ## without reducing font size too much
      ## (see an example code of right-justifying a set of labels
      ## provided in graphics::legend docs)
      text.width <- strwidth(" Sub_metering_1", cex=0.67)
      box <- legend("topright", legend = c(" "," "," "),
             col=c("black", "red", "blue"), 
             y.intersp=0.7, lty = 1, text.width=text.width,
             cex=0.67)
      text(x=box$text$x, y=box$text$y,
           c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
           col="black", adj=c(0,0.5))
      
      # save to png file --------------------------------------------------
      dev.copy(png, file="plot3.png")
      dev.off()
}

## download and unpack the data if needed, make a table
source("./prepareData.R")
prepareData()
plot3()