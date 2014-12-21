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
NEI_1999 <- subset(NEI, NEI$year=="1999")
NEI_2002 <- subset(NEI, NEI$year=="2002")
NEI_2005 <- subset(NEI, NEI$year=="2005")
NEI_2008 <- subset(NEI, NEI$year=="2008")

# Calculate the total PM25 Emission
sum_1999 <- sum(NEI_1999$Emissions)
sum_2002 <- sum(NEI_2002$Emissions)
sum_2005 <- sum(NEI_2005$Emissions)
sum_2008 <- sum(NEI_2008$Emissions)

# Create a data frame
sum_total <- data.frame(unique(NEI$year),"PM25_total"=c(sum_1999,sum_2002,sum_2005,sum_2008))

# Plot the data and add some aesthetics 
png("plot1.png")
plot(sum_total$unique.NEI.year,sum_total$PM25_total, type="o",main="Total PM25 Emission Per Year",xlab="Year",ylab="Amount of PM2.5 emitted, in tons")
dev.off()

# The amount of PM25 emitted decreases from 1999 to 2008.