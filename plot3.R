if (!require("Source_Classification_code.rds")) {
  fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
  download.file(fileURL, "NEI_data.zip")
}

if (file.exists("NEI_data.zip")) {
  unzip("NEI_data.zip")
}

# Read both RDS files.
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Subset the data based on the year
NEI_1999_Balt <- subset(NEI, NEI$year=="1999" & NEI$fips=="24510")
NEI_2002_Balt <- subset(NEI, NEI$year=="2002" & NEI$fips=="24510")
NEI_2005_Balt <- subset(NEI, NEI$year=="2005" & NEI$fips=="24510")
NEI_2008_Balt <- subset(NEI, NEI$year=="2008" & NEI$fips=="24510")

# Subset the data based on the type for each year
NEI_1999_Balt_Point <- subset(NEI_1999_Balt, NEI_1999_Balt$type =="POINT")
NEI_1999_Balt_nonPoint <- subset(NEI_1999_Balt, NEI_1999_Balt$type =="NONPOINT")
NEI_1999_Balt_onRoad <- subset(NEI_1999_Balt, NEI_1999_Balt$type =="ON-ROAD")
NEI_1999_Balt_nonRoad <- subset(NEI_1999_Balt, NEI_1999_Balt$type =="NON-ROAD")

NEI_2002_Balt_Point <- subset(NEI_2002_Balt, NEI_2002_Balt$type =="POINT")
NEI_2002_Balt_nonPoint <- subset(NEI_2002_Balt, NEI_2002_Balt$type =="NONPOINT")
NEI_2002_Balt_onRoad <- subset(NEI_2002_Balt, NEI_2002_Balt$type =="ON-ROAD")
NEI_2002_Balt_nonRoad <- subset(NEI_2002_Balt, NEI_2002_Balt$type =="NON-ROAD")

NEI_2005_Balt_Point <- subset(NEI_2005_Balt, NEI_2005_Balt$type =="POINT")
NEI_2005_Balt_nonPoint <- subset(NEI_2005_Balt, NEI_2005_Balt$type =="NONPOINT")
NEI_2005_Balt_onRoad <- subset(NEI_2005_Balt, NEI_2005_Balt$type =="ON-ROAD")
NEI_2005_Balt_nonRoad <- subset(NEI_2005_Balt, NEI_2005_Balt$type =="NON-ROAD")

NEI_2008_Balt_Point <- subset(NEI_2008_Balt, NEI_2008_Balt$type =="POINT")
NEI_2008_Balt_nonPoint <- subset(NEI_2008_Balt, NEI_2008_Balt$type =="NONPOINT")
NEI_2008_Balt_onRoad <- subset(NEI_2008_Balt, NEI_2008_Balt$type =="ON-ROAD")
NEI_2008_Balt_nonRoad <- subset(NEI_2008_Balt, NEI_2008_Balt$type =="NON-ROAD")

# Compute the total PM 25 Emission for each type from 1999 to 2008
NEI_1999_sum_Point <- sum(NEI_1999_Balt_Point$Emissions)
NEI_1999_sum_nonPoint <- sum(NEI_1999_Balt_nonPoint$Emissions)
NEI_1999_sum_nonRoad <- sum(NEI_1999_Balt_nonRoad$Emissions)
NEI_1999_sum_onRoad <- sum(NEI_1999_Balt_onRoad$Emissions)

NEI_2002_sum_Point <- sum(NEI_2002_Balt_Point$Emissions)
NEI_2002_sum_nonPoint <- sum(NEI_2002_Balt_nonPoint$Emissions)
NEI_2002_sum_nonRoad <- sum(NEI_2002_Balt_nonRoad$Emissions)
NEI_2002_sum_onRoad <- sum(NEI_2002_Balt_onRoad$Emissions)

NEI_2005_sum_Point <- sum(NEI_2005_Balt_Point$Emissions)
NEI_2005_sum_nonPoint <- sum(NEI_2005_Balt_nonPoint$Emissions)
NEI_2005_sum_nonRoad <- sum(NEI_2005_Balt_nonRoad$Emissions)
NEI_2005_sum_onRoad <- sum(NEI_2005_Balt_onRoad$Emissions)

NEI_2008_sum_Point <- sum(NEI_2008_Balt_Point$Emissions)
NEI_2008_sum_nonPoint <- sum(NEI_2008_Balt_nonPoint$Emissions)
NEI_2008_sum_nonRoad <- sum(NEI_2008_Balt_nonRoad$Emissions)
NEI_2008_sum_onRoad <- sum(NEI_2008_Balt_onRoad$Emissions)

# Data frame for each type from 1999 to 2008
sum_total_Balt_Point <-data.frame(unique(NEI$year),"PM25_total"=c(NEI_1999_sum_Point,NEI_2002_sum_Point,NEI_2005_sum_Point,NEI_2008_sum_Point))
sum_total_Balt_nonPoint <-data.frame(unique(NEI$year),"PM25_total"=c(NEI_1999_sum_nonPoint,NEI_2002_sum_nonPoint,NEI_2005_sum_nonPoint,NEI_2008_sum_nonPoint))
sum_total_Balt_onRoad <-data.frame(unique(NEI$year),"PM25_total"=c(NEI_1999_sum_onRoad,NEI_2002_sum_onRoad,NEI_2005_sum_onRoad,NEI_2008_sum_onRoad))
sum_total_Balt_nonRoad <-data.frame(unique(NEI$year),"PM25_total"=c(NEI_1999_sum_nonRoad,NEI_2002_sum_nonRoad,NEI_2005_sum_nonRoad,NEI_2008_sum_nonRoad))

# Rename the column names
colnames(sum_total_Balt_Point) <- c("year","PM")
colnames(sum_total_Balt_nonPoint) <- c("year","PM")
colnames(sum_total_Balt_onRoad) <- c("year","PM")
colnames(sum_total_Balt_nonRoad) <- c("year","PM")

# Combine all into one data frame
sum_total_Balt_type <- cbind(sum_total_Balt_Point,sum_total_Balt_nonPoint$PM,sum_total_Balt_onRoad$PM,sum_total_Balt_nonRoad$PM)

# Rename the colum
colnames(sum_total_Balt_type) <- c("year","Point","nonPoint","onRoad","nonRoad")

# In order to use ggplot2, we need a long format
a <- melt(sum_total_Balt_type, id.vars="year", variable.name="Type")

# Create the plot
png("plot3.png")
ggplot(a, aes(x=year,y=value,group = Type, color= Type)) + geom_line() + xlab("YEAR") + ylab("PM Emission") + ggtitle("PM Emission for Each Type from 1999 to 2008")
dev.off()