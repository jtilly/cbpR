# cardealers.R
#
# This is a simple demonstration that generates a panel data set for "New Car
# Dealers" (NAICS 441110). The data set ranges from 2000 to 2009 and contains
# all Micropolitan Statistical Areas. It aggregates up the firm count data from
# the County Business Pattern into Micropolitan Statistical Areas and returns
# a dataset with annual data on the firm count and population figures for each 
# Micropolitan Statistical Area.

library(cbpR)
library(sqldf)

# define the location of data_in and data_out
setCbpPath("~/cbpR/data_source", "~/cbpR")

# download the data (if needed)
downloadCbp()

# naics list
naics = "441110";
years = c('10','09','08','07','06','05','04','03','02','01','00')

# get the population data for all core based statistical areas
population = getPopulationData()

# get the county definitions of cbsas, drop states and cbsas for which
# we don't have population numbers
cbsa = getCBSAs(metro=FALSE, 
                drop_states = c("PR", "AS", "VI", "DC", "GU"),
                drop_cbsas = c('31920', '48220', '45540')
)

# get the firm county for each county for a specific industry
firms = getFirmCount(naics = naics, years=years)

# limit firms to counties that show up the micropolitan statistical area list
firmsSubSet = firms[as.numeric(firms$fips) %in% as.numeric(cbsa$counties$fips), ]

# simple function that maps fips into cbsaid
fips2cbsa = function(fips) { 
  ret = cbsa$counties$cbsa[as.numeric(cbsa$counties$fips)==as.numeric(fips)][1]  
  if(length(ret)==0) {
    return(NA)
  } else {
    return(ret)
  }
}

# assign the cbsa id
firmsSubSet$cbsaid = sapply(firmsSubSet$fips, fips2cbsa)

# group by cbsa id and merge the data with population figures
dataSet = sqldf("SELECT F.cbsaid AS cbsaid, F.fipsstate, (F.year+2000) AS year,
                 SUM(F.est) AS est,
                 SUM(F.n1_4) AS n1_4,
                 SUM(F.n5_9) AS n5_9,
                 SUM(F.n10_19) AS n10_19,
                 SUM(F.n20_49) AS n20_49,
                 SUM(F.n50_99) AS n50_99,
                 SUM(F.n100_249) AS n100_249,
                 SUM(F.n250_499) AS n250_499,
                 SUM(F.n500_999) AS n500_999,
                 SUM(F.n1000plus) AS n1000plus,
                 P.population AS population
                 FROM firmsSubSet F LEFT JOIN population P ON F.cbsaid=P.cbsaid AND (F.year+2000)=P.year
                 GROUP BY F.cbsaid, F.year ORDER BY F.cbsaid ASC, F.year ASC")

# save the data set as csv file
write.csv(dataSet, sprintf("%s/data_%s.txt", getCbpPath()$data_out,  naics))
