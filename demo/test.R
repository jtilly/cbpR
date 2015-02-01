# test.R 
library(sqldf)
rm(list=ls())

naicsList = c("512131", "327320", "441110", "441320")

# define the naics code to be used
# naics = "512131"
for(naics in naicsList) {
  
  # get the population data for all core based statistical areas
  population = getPopulationData()
  
  # get the county break-down for each cbsa
  # skip puerto rico, american samoa, virgin islands, the district of columbia, and guam
  # also skip Marble Falls, TX Micropolitan Statistical Area, 
  #           Weatherford, OK Micropolitan Statistical Area
  #           The Villages, FL Micropolitan Statistical Area
  # because there are no annual population estimates for these
  cbsa = getCBSAs(metro=FALSE, 
                  drop_states = c("PR", "AS", "VI", "DC", "GU"),
                  drop_cbsas = c('31920', '48220', '45540')
  )
  
  # get the firm county for each county for a specific industry
  firms = getFirmCount(naics = naics)
  
  # limit firms to counties that show up the micropolitan statistical area list
  select = as.numeric(firms$fips) %in% as.numeric(cbsa$counties$fips)
  firmsSubSet = firms[select, ]
  
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
  
  # group by cbsa id
  dataSet = sqldf("SELECT cbsaid, fipsstate, (year+2000) AS year,
                 SUM(est) AS est,
                 SUM(n1_4) AS n1_4,
                 SUM(n5_9) AS n5_9,
                 SUM(n10_19) AS n10_19,
                 SUM(n20_49) AS n20_49,
                 SUM(n50_99) AS n50_99,
                 SUM(n100_249) AS n100_249,
                 SUM(n250_499) AS n250_499,
                 SUM(n500_999) AS n500_999,
                 SUM(n1000plus) AS n1000plus
                 FROM firmsSubSet GROUP BY cbsaid, year ORDER BY cbsaid ASC, year ASC")
  
  # save the data set as csv file
  write.csv(dataSet, sprintf("data_%s.txt", naics))
  
}