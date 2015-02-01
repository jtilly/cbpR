# population

getPopulationData = function() {
  censusEstimatesLines <- readLines("data_source/CBSA-EST2009-01.csv", encoding = "UTF-8")
  censusEstimates = textConnection(censusEstimatesLines[-c(1:19, 415:416, 991:1000)], encoding = "UTF-8")
  population =  read.csv(censusEstimates, header = FALSE, as.is=TRUE)
  colnames(population) = c("cbsaid", "empty", "cbsaname", "pop2009", "pop2008", 
                           "pop2007", "pop2006", "pop2005", "pop2004", "pop2003", 
                           "pop2002", "pop2001", "pop2000", "Estimate Base", 
                           "Census")
  population = population[,!colnames(population) %in% "empty"]
  stripCommas = function(str) { as.integer(gsub(",","", str)) }
  population[,-c(1:2)] = sapply(population[,-c(1:2)], stripCommas)
  
  return(population)
}