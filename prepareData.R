## a utility to download (if needed) and prepare the data:
## puts the downloaded archive into the "./data" folder,
## unzips it, reads into  data.table and makes the data tidy

prepareData <- function() {
      library(data.table)
      library(dplyr)
      library(lubridate)
      
      # download the data if needed --------------------------------------------
      
      if (!file.exists("./data")) {
            message("'./data' catalog not found. Creating it.")
            dir.create("./data")
      }
      unzipped <- "./data/household_power_consumption.txt"
      if (!file.exists(unzipped)) {
            destfile <- "./data/exdata%2Fdata%2Fhousehold_power_consumption.zip"
            if (!file.exists(destfile)) {
                  message("data zip archive not found. Downloading it.")
                  url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
                  ## use this line if you are on Windows
                  download.file(url, destfile=destfile, mode="wb")
                  ## for non-Windows users run next line instead
                  ##download.file(url, destfile=destfile, mode="wb", method="curl")
                  ## add a timestamp
                  if (!file.exists("./data/tlabel"))
                        file.create("./data/tlabel")
                  tlabel <- file("./data/tlabel","w")
                  cat(paste(destfile, url, date(), sep=";"), file=tlabel)
                  close(tlabel)
            }
            ## unpack the data if needed
            message("Unpacking the data")
            unzip(zipfile=destfile,exdir="./data")
      }
      
      # read the data into the global var --------------------------------------
      
      hpc.table <<- fread(unzipped,na.strings = "?",colClasses=rep("character",9))
      
      
      # select and prepare the data --------------------------------------------
      
      ## add a column for Date/Time
      hpc.table <<- mutate(hpc.table,
                           DateTime=dmy_hms(
                                 paste(hpc.table$Date,
                                       hpc.table$Time, " ")))
      # drop Date and Time columns after combining into DateTime
      hpc.table <<- select(hpc.table, -1, -2)
      ## leave only rows with dates from 2007-02-01 to 2007-02-02
      hpc.table <<- filter(hpc.table, 
                           as.Date(DateTime) >= "2007-02-01",
                           as.Date(DateTime) <= "2007-02-02")
      ## convert all non-date columns to numeric
      hpc.table <<- as.data.frame(hpc.table)
      for (k in 1:7) {
            hpc.table <<- hpc.table[!is.na(hpc.table[k]),]
            hpc.table[[k]] <<- as.numeric(hpc.table[[k]])
      }   
}
