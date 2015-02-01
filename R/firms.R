#' Get the firm count data from the County Business Patterns (CBP)
#' 
#' This function processes the downloaded CPB data and generates 
#' a long panel data set. The data frame contains the following columns
#' \itemize{
#' \item \code{fips} the fips code
#' \item \code{fipsstate} the state fips code
#' \item \code{fipscty} the county fips code within the state
#' \item \code{year} the year of observation
#' \item \code{est} the number of establishments
#' \item \code{n1_4} the number of establishments with between 1 and 4 employees
#' \item \code{n5_9} the number of establishments with between 5 and 9 employees
#' \item \code{n10_19} ... with between 10 and 19 employees
#' \item \code{n20_49} ... with between 20 and 49 employees
#' \item \code{n50_99}... with between 50 and 99 employees
#' \item \code{n100_249} ... with between 100 and 249 employees
#' \item \code{n250_499} ... with between 250 and 499 employees
#' \item \code{n500_999} ... with between 500 and 999 employees
#' \item \code{n1000plus} ... with between more than 1000 employees
#' } 
#' @param naics a string with the naics code of the industry
#' @param years a vector of strings with the last two digits of years for which
#' to process the data
#' @return a data frame of a long panel with the CPB data on the county level
getFirmCount =  function(naics, 
                         years = c('09','08','07','06','05','04','03','02','01','00')) {
  
  checkCbp()
  
  for(yX in years) {
    if(!file.exists(sprintf("%s/cbp%sco.txt", getCbpPath()$data_in, yX))) {
      stop(sprintf("Cannot find the source file %s/cbp%sco.txt of the County
        Business Patterns. Please run the function downloadCbp() to download it.", getCbpPath()$data_in, yX))
    }
  }
  
  # initialize firms to be NA
  firms = NA
  
  # format_groups
  formatGroup1 = c('06','05','04','03','02','01','00')
  formatGroup2 = c('10','09','08','07')
  
  # read the county business patterns
  for(yX in years) {
    
    print(sprintf('loading firm data for year %s', yX));
    
    # open file and read into a data frame
    f <- file(sprintf("%s/cbp%sco.txt", getCbpPath()$data_in, yX))
    df <- sqldf("SELECT * FROM f", dbname = tempfile(), file.format = list(header = T, row.names = F), stringsAsFactors=FALSE)
    close(f)
    
    if(yX %in% formatGroup1) {
        colnames(df) = c("fipsstate","fipscty","naics","empflag","emp","qp1","ap",
                       "est","n1_4","n5_9","n10_19","n20_49","n50_99","n100_249",
                       "n250_499","n500_999","n1000plus", "n1000_1499", "n1500_2499", 
                       "n2500_4999", "n5000plus", "censtate", "cencty")
    }
    
    if(yX %in% formatGroup2) {
        colnames(df) = c("fipsstate", "fipscty", "naics", "empflag", "emp_nf", "emp", "qp1_nf", "qp1",
                       "ap_nf", "ap", "est", "n1_4", "n5_9", "n10_19", "n20_49", "n50_99", "n100_249",
                       "n250_499", "n500_999", "n1000plus", "n1000_1499", "n1500_2499", "n2500_4999",
                       "n5000plus", "censtate", "cencty")
    }    
    
    # remove all symbols from naics codes except numbers
    df$naics = gsub("[^0-9]", "", df$naics, "")
    # turn all state and county identifiers into numbers
    df$fipsstate = gsub("[^0-9]", "", df$fipsstate, "")
    df$fipscty = gsub("[^0-9]", "", df$fipscty, "")  
    # make a fips
    df$fips = paste(df$fipsstate, df$fipscty, sep = "")
    # store all fips
    all_fips = unique(df$fips)
    # drop all naics codes that we're not interested in
    df = df[ df$naics == naics, ]
    # make a zero entry for all counties that have zero entries for this industry
    makeZeros = function(x) {
        dfZero = data.frame(
          substr(x, 0, 2),
          cbind(substr(x, 3, 5)), 
          rep(naics, length(x)), 
          matrix(0, nrow = length(x), ncol=(NCOL(df)-4)),
          cbind(x), stringsAsFactors=FALSE)
        colnames(dfZero) = colnames(df)
        return(dfZero)
    }
   
    df = data.frame(rbind(df, makeZeros(all_fips[!as.numeric(all_fips) %in% unique(as.numeric(df$fips))])), stringsAsFactors=FALSE)
     
    # create new data frame
    firmsYear = data.frame( df$fips, df$fipsstate, 
                            df$fipscty, rep(yX, length(df$fipsstate)), df$est, df$n1_4, df$n5_9, df$n10_19, 
                            df$n20_49, df$n50_99, df$n100_249, df$n250_499, 
                            df$n500_999, df$n1000plus, stringsAsFactors = FALSE)
    
    
    colnames(firmsYear) = c("fips",
                            "fipsstate", 
                            "fipscty",
                            "year",
                            "est",
                            "n1_4",
                            "n5_9",
                            "n10_19",
                            "n20_49",
                            "n50_99",
                            "n100_249",
                            "n250_499",
                            "n500_999",
                            "n1000plus")
    
    if(identical(NA,firms)) {
      firms = firmsYear 
    } else {
      firms = data.frame(rbind(firms, firmsYear), stringsAsFactors = FALSE)
    }
    
  }
  
  return(firms) 
}