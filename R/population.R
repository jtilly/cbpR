#' Returns a long panel of the population data
#'
#' Reshapes the population data for the Core-Based Statistical Areas into
#' a long panel.
#' 
#' @return a data frame with population data for micro- and metropolitan
#' statistical areas
#' @examples
#' \dontrun{getPopulationData()}
getPopulationData = function() {
  
  checkCbp()
  
  if (!file.exists(sprintf('%s/CBSA-EST2009-01.csv', getCbpPath()$data_in))) {
    stop('Cannot find the Census file with the population estimates. Please run the function downloadCbp() to download it.')
  }   
    
  censusEstimatesLines <- readLines(sprintf('%s/CBSA-EST2009-01.csv',
                                            getCbpPath()$data_in), encoding = 'UTF-8')
  censusEstimates = textConnection(censusEstimatesLines[-c(1:19, 415:416, 991:1000)], encoding = 'UTF-8')
  population =  read.csv(censusEstimates, header = FALSE, as.is = TRUE)
  colnames(population) = c('cbsaid', 'empty', 'cbsaname', 'pop2009', 'pop2008', 
                           'pop2007', 'pop2006', 'pop2005', 'pop2004', 'pop2003', 
                           'pop2002', 'pop2001', 'pop2000', 'Estimate Base', 
                           'Census')
  population = population[,!colnames(population) %in% 'empty']
  stripCommas = function(str) { as.integer(gsub(',','', str)) }
  population[,-c(1:2)] = sapply(population[,-c(1:2)], stripCommas)
  
  # reshape this dataset from wide to long
  populationLong = NULL;
  for (cX in colnames(population)) {
      if (grepl("pop[0-9]{4}", cX)) {
        populationYear = data.frame( population$cbsaid, rep( substr(cX, 4, 7), length(population$cbsaid)),  population[,cX == colnames(population)], stringsAsFactors = FALSE)
        colnames(populationYear) = c("cbsaid", "year", "population")
        populationLong = data.frame(rbind(populationLong, populationYear), stringsAsFactors = FALSE)
      }
  }
  
  return(populationLong)
}
