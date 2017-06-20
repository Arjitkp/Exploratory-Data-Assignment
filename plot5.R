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



##Plot 5

mobile<-grep("On-Road",f1$EI.Sector)
Values_scc<-f1[mobile,]


d<-filter(f2,fips=="24510")



k<-merge(x=d,y=Values_scc,by="SCC")
k<-group_by(k,year)
k<-summarise(k,sum(Emissions))
names(k)<-c("Year","Emissions")


png(filename="./Exdata_final/plot5.png", width = 480, height = 480)

ggplot(k,aes(Year,Emissions)) +
  geom_point()+
  geom_line()+
  labs(title = "Emission Trend of Motor Vehicle sources in Baltimore")

dev.off()