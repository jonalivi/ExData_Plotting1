
# plot2 -------------------------------------------------------------------
## plots dates and times of observations along the x axis
## and global active power along the y axis
## set pngfile equals to NULL in order not to write to a file
plot2 <- function(pngfile="./plot2.png") {
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
      plot(hpc.table$DateTime, hpc.table$Global_active_power,
            type='n', 
            xlab="", ylab="Global Active Power (kilowatts)",
            cex.lab=0.9, cex.axis=0.9)
      lines(hpc.table$DateTime, hpc.table$Global_active_power,
             lty=1)
       
      # save to png file if needed --------------------------------------------
      if (!is.null(pngfile)) {
            dev.copy(png, file=pngfile)
            dev.off()
      }
}