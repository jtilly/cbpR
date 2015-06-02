#' Returns a list of Core-Based Statistical Areas and counties
#'
#' This function uses the 2003-2009 definitions of Core-Based Statistical Areas
#' and returns a map of counties into Micro- and Metropolitan Statistical Areas.
#'
#' @param drop_states is a vector of state abbreviations to drop from the data
#' @param drop_cbsas is a vector of CBSA IDs (as strings) to drop from the data
#' @param metro is a boolean whether to include metropolitan statistical areas
#' @param micro is a boolean whether to include micropolitan statistical areas 
#' @return a list of data frames with micropolitan statistical areas, 
#' metropolitan statistical areas and counties
getCBSAs = function(drop_states=NA, drop_cbsas=NA, metro=TRUE, micro=TRUE) {
  
  checkCbp()
  
  if(!file.exists(sprintf("%s/cbsa_definitions.txt", getCbpPath()$data_in))) {
    stop("Cannot find the Census file with the definitions of the Core Based Statistical Areas (CBSAs). Please run the function downloadCbp() to download it.")
  }   
    
  # read the metro/micropolitan statistical are definitions
  definitions = readLines(sprintf("%s/cbsa_definitions.txt", getCbpPath()$data_in), encoding = "UTF-8")
  definitions = definitions[definitions!='']
  
  # delete all rows where the first five digits are not a cbsa code
  definitions = definitions[grepl("[0-9]",substr(definitions, 0, 5))]
  cbsa = data.frame( substr(definitions, 0, 5), stringsAsFactors = FALSE)
  colnames(cbsa) <- c('cbsaid')
  
  # find division codes and add them
  cbsa$div = as.integer(substr(definitions, 9, 13))
  
  # find fips and add them
  cbsa$fips = as.integer(substr(definitions, 17, 21))
  
  # find names and add them
  cbsa$name = gsub("^\\s+|\\s+$", "", substr(definitions, 22, 100))
  
  # create a dummy for metro and micro areas
  cbsa$metro = grepl("Metropolitan", cbsa$name)
  cbsa$micro = grepl("Micropolitan", cbsa$name)
  cbsa$county = !cbsa$metro & !cbsa$metro
  
  # get the state abbreviation out of the names
  m = regexpr("[A-Z]{2}", cbsa$name)
  cbsa$state = regmatches(cbsa$name, m)
  
  cbsa = cbsa[!cbsa$state %in% drop_states,]
  cbsa = cbsa[!cbsa$cbsaid %in% drop_cbsas,]
  
  # assign cbsa type to counties
  counties = cbsa[!is.na(cbsa$fips),]
  cbsaMetro = cbsa[is.na(cbsa$fips), c(1,5)]
  isMetro = function(cbsa) { 
    ret = cbsaMetro[cbsaMetro$cbsa==cbsa,2][1]
    if(length(ret)==0) { return(FALSE) }
    return(ret)
  }
  counties$metro = sapply(counties$cbsa, isMetro)
  counties$micro = !counties$metro
  
  if(metro==FALSE) {
    counties =  counties[counties$micro,]
  }
  if(micro==FALSE) {
    counties = counties[counties$metro,]
  } 
  
  return(list(
      "metro" = cbsa[cbsa$metro & is.na(cbsa$fips),],
      "micro" = cbsa[cbsa$micro & is.na(cbsa$fips),],
      "counties" = counties
  ))   
}
