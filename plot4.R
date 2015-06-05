
# plot4 -------------------------------------------------------------------

plot4 <- function() {
      par(mfcol = c(2,2))
      ## change locale to suppress localized days of week
      ## see discussion on http://stackoverflow.com/q/5345132/4869831
      locale <- Sys.getlocale("LC_TIME")
      Sys.setlocale("LC_TIME","C")
      source('./plot2.R')
      plot2()
      source('./plot3.R')
      plot3(cex.legend=.4,cex.text=1.7,bty='n')
      
      plot(hpc.table$DateTime, hpc.table$Voltage,
           xlab="datetime", ylab="Voltage",
           cex.lab=.9, cex.axis=.9,type='n')
      lines(hpc.table$DateTime, hpc.table$Voltage)
      
      plot(hpc.table$DateTime, hpc.table$Global_reactive_power,
           xlab="datetime", ylab="Global_reactive_power",
           cex.lab=.9, cex.axis=.9,type='n')
      lines(hpc.table$DateTime, hpc.table$Global_reactive_power)
      
      # save to png file --------------------------------------------------
      dev.copy(png, file="./plot4.png")
      dev.off()
      Sys.setlocale("LC_TIME",locale)
      par(mfcol = c(1,1))
}
