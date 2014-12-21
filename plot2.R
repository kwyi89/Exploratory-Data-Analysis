if (!require("Source_Classification_Code.rds")) {
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

# Calculate the total PM25 Emission
sum_1999_Balt <- sum(NEI_1999_Balt$Emissions)
sum_2002_Balt <- sum(NEI_2002_Balt$Emissions)
sum_2005_Balt <- sum(NEI_2005_Balt$Emissions)
sum_2008_Balt <- sum(NEI_2008_Balt$Emissions)

# Create a data frame
sum_total_Balt <- data.frame(unique(NEI$year),"PM25_total"=c(sum_1999_Balt,sum_2002_Balt,sum_2005_Balt,sum_2008_Balt))

# Plot the data and add some aesthetics 
png("plot2.png")
plot(sum_total_Balt$unique.NEI.year,sum_total_Balt$PM25_total, type="o",main="Total PM25 Emission Per Year in the Baltimore City, Maryland",xlab="Year",ylab="Amount of PM2.5 emitted, in tons")
dev.off()

# The amount of PM25 emitted decreases from 1999 to 2008.