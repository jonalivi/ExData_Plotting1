
# plot2 -------------------------------------------------------------------
plot2 <- function() {
       plot(hpc.table$DateTime, hpc.table$Global_active_power,
            type='n', 
            xlab="", ylab="Global Active Power (kilowatts)")
       lines(hpc.table$DateTime, hpc.table$Global_active_power,
             lty=1)
       
       # save to png file --------------------------------------------------
       dev.copy(png, file="plot2.png")
       dev.off()
}

## download and unpack the data if needed, make a table
source("./prepareData.R")
prepareData()
plot2()

