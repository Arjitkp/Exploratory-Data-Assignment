library(data.table)
library(dplyr)



if(!file.exists("Exdata_final")){
  dir.create("Exdata_final")
}

fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"

download.file(fileurl,destfile="./Exdata_final/final.zip")

filelist<-unzip("./Exdata_final/final.zip")

f1<-tbl_df(readRDS(filelist[1]))
f2<-tbl_df(readRDS(filelist[2]))
##f_m <- merge(f1,f2,by.x = "SCC", by.y = "SCC")
Sum_year <- summarise(group_by(f2,year),sum(Emissions))

##Plot 1
png(filename="./Exdata_final/plot1.png", width = 480, height = 480)
barplot(height = Sum_year$`sum(Emissions)`,names.arg = c(Sum_year$year),xlab = "Year", ylab = expression('Total PM'[2.5]*' emission'), main = expression('Total PM'[2.5]*' emissions at throughout years'))


dev.off()