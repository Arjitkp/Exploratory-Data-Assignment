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



##Plot 2
Baltimore_city <- group_by(f2,year)
Baltimore_city <- filter(Baltimore_city,fips=="24510")
Baltimore_city<-summarise(Baltimore_city,sum(Emissions))

png(filename="./Exdata_final/plot2.png", width = 480, height = 480)
barplot(height = Baltimore_city$`sum(Emissions)`,names.arg = c(Baltimore_city$year),xlab = "Year", ylab = expression('Total PM'[2.5]*' emission'), main = expression('Total PM'[2.5]*' emissions in Baltimore'))


dev.off()