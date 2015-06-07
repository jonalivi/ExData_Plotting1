# plot3 -------------------------------------------------------------------
## Plots weekdays of observations dates along the x axis and 
## three datasets energy sub metering along the y axis,
## Sub_metering_1 in black color, Sub_metering_2 in red,
## Sub_metering_3 in blue.
## These parameter values are well-suited for 480x480 resolution.
## Roughly, cex.legend determines the width of the legend box,
## while cex.text determines the font size of the labels inside of it.  
## (see the example code of right-justifying a set of labels
## provided in graphics::legend docs)
## set pngfile equals to NULL in order not to write to a file
plot3 <- function(cex.legend=.6, 
                  cex.text=1.3,
                  bty='o',
                  pngfile="./plot3.png") {
      ## download and unpack the data if needed, make a table
      if (!exists("dataPrepared", mode="logical"))
            dataPrepared <<- FALSE
      if (!dataPrepared){
            source("./prepareData.R")
            prepareData()      
      }
      ## change locale to suppress localized days of week
      ## see discussion on http://stackoverflow.com/q/5345132/4869831
      locale <- Sys.getlocale("LC_TIME")
      Sys.setlocale("LC_TIME","C")
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
      
      # save to png file if needed --------------------------------------------
      if (!is.null(pngfile)) {
            dev.copy(png, file=pngfile)
            dev.off()
      }
      Sys.setlocale("LC_TIME",locale)
}
