# plot3 -------------------------------------------------------------------
## These parameter values are well-suited for 480x480 resolution.
## Roughly, cex.legend determines the width of the legend box,
## while cex.text determines the font size of the labels inside of it.  
## (see the example code of right-justifying a set of labels
## provided in graphics::legend docs)
plot3 <- function(cex.legend=.6, 
                  cex.text=1.3,
                  bty='o') {
      ## download and unpack the data if needed, make a table
      if (!exists("dataPrepared", mode="logical"))
            dataPrepared <<- FALSE
      if (!dataPrepared){
            source("./prepareData.R")
            prepareData()      
      }
      plot(rep(hpc.table$DateTime,3), 
           c(hpc.table$Sub_metering_1,
             hpc.table$Sub_metering_2,
             hpc.table$Sub_metering_3),
           type='n', 
           xlab="", ylab="Energy sub metering",
           cex.lab=.9, cex.axis=.9)
      lines(hpc.table$DateTime, hpc.table$Sub_metering_1)
      lines(hpc.table$DateTime, hpc.table$Sub_metering_2, col="red")
      lines(hpc.table$DateTime, hpc.table$Sub_metering_3, col="blue")
      
      text.width <- strwidth(" Sub_metering_1", 
                             cex=cex.legend*cex.text*0.86)
      box <- legend("topright", legend = c(" "," "," "),
             col=c("black", "red", "blue"), 
             y.intersp=cex.legend*1.6, lty = 1, text.width=text.width,
             cex=cex.legend, bty=bty)
      text(x=box$text$x, y=box$text$y,
           c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
           col="black", adj=c(0,0.5),cex=cex.legend*cex.text)
      
      # save to png file --------------------------------------------------
      dev.copy(png, file="./plot3.png")
      dev.off()
}
