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



##Plot 4

coal<-grep("Coal",f1$EI.Sector)
Values_scc<-f1[coal,]


d<-merge(x=f2,y=Values_scc,by="SCC")
d<-group_by(d,year)
d<-summarise(d,sum(d$Emissions))
names(d)<-c("Year","Emissions")


png(filename="./Exdata_final/plot4.png", width = 480, height = 480)

ggplot(d,aes(Year,Emissions)) +
  geom_point()+
  geom_line()+
  labs(title = "Emission Trend of Coal related sources")

dev.off()