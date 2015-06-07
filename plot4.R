
# plot4 -------------------------------------------------------------------
## Plots four plots placed in 2x2 grid, columns-wise:
## - a plot drawn by the plot2() function
## - a plot drawn by the plot3() function
## - weekdays of observations dates plotted along the x axis,
##    voltage values along the y axis
## - - weekdays of observations dates plotted along the x axis,
##    global reactive power along the y axis
## (no points are drawn, only lines)
##
## set pngfile equals to NULL in order not to write to a file
plot4 <- function(pngfile="./plot4.png") {
      par(mfcol = c(2,2))
      ## change locale to suppress localized days of week
      ## see discussion on http://stackoverflow.com/q/5345132/4869831
      locale <- Sys.getlocale("LC_TIME")
      Sys.setlocale("LC_TIME","C")
      source('./plot2.R')
      plot2(NULL)
      source('./plot3.R')
      plot3(cex.legend=.4,cex.text=1.7,bty='n', NULL)
      
      plot(hpc.table$DateTime, hpc.table$Voltage,
           xlab="datetime", ylab="Voltage",
           cex.lab=.9, cex.axis=.9,type='n')
      lines(hpc.table$DateTime, hpc.table$Voltage)
      
      plot(hpc.table$DateTime, hpc.table$Global_reactive_power,
           xlab="datetime", ylab="Global_reactive_power",
           cex.lab=.9, cex.axis=.9,type='n')
      lines(hpc.table$DateTime, hpc.table$Global_reactive_power)
      
      # save to png file if needed --------------------------------------------
      if (!is.null(pngfile)) {
            dev.copy(png, file=pngfile)
            dev.off()
      }
      Sys.setlocale("LC_TIME",locale)
      par(mfcol = c(1,1))
}
