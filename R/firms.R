# firms

getFirmCount =  function(naics, 
                         years = c('10','09','08','07','06','05','04','03','02','01','00')) {
  
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