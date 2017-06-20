library(data.table)
library(dplyr)
library(ggplot2)


if(!file.exists("Exdata_final")){
  dir.create("Exdata_final")
}

fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"

download.file(fileurl,destfile="./Exdata_final/final.zip")

filelist<-unzip("./Exdata_final/final.zip")

f1<-tbl_df(readRDS(filelist[1]))
f2<-tbl_df(readRDS(filelist[2]))



##Plot 3
emit<-filter(f2,fips=="24510")
emit<- group_by(emit,type,year)
emit<-summarise(emit,sum(Emissions))
names(emit)<-c("Type","Year","Emissions")


png(filename="./Exdata_final/plot3.png", width = 480, height = 480)

ggplot(emit,aes(Year,Emissions, colour = Type)) +
  geom_point()+
  geom_line()+
  labs(title = "Emission Trend of Baltimore City")

dev.off()