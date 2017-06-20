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



##Plot 6

mobile_B<-grep("On-Road",f1$EI.Sector)
Value_B<-f1[mobile,]


data_B<-filter(f2,fips=="24510")
data_LA<-filter(f2,fips=="06037")


k_B<-merge(x=data_B,y=Value_B,by="SCC")
k_LA<-merge(x=data_LA,y=Value_B,bu="SCC")

k_B<-group_by(k_B,year)
k_LA<-group_by(k_LA,year)

k_B<-summarise(k_B,sum(Emissions))
k_B<-mutate(k_B,City="Baltimore")
k_LA<-summarise(k_LA,sum(Emissions))
k_LA<-mutate(k_LA,City="Los Angeles")

DF<-rbind(k_B,k_LA)
names(DF)<-c("Year","Emissions","City")


png(filename="./Exdata_final/plot6.png", width = 480, height = 480)

ggplot(DF,aes(Year,Emissions, colour = City)) +
  geom_point()+
  geom_line()+
  labs(title = "Emission Comparison between of Baltimore and Los Angeles")






dev.off()