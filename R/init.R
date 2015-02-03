#' Set the environmental variables to the data directories
#' 
#' This function sets the environmental variables that point to the directories
#' where the downloaded and processed data is stored
#' 
#' @param data_in a string with the path to the directory where the downloaded 
#' data will be stored
#' @param data_out a string with the path to the directory where the processed 
#' data will be stored
#' @return \code{true} if the function concludes successfully
setCbpPath = function(data_in, data_out) {
  
  data_in = gsub("~", path.expand("~"), data_in)
  data_out = gsub("~", path.expand("~"), data_out)
  
  Sys.setenv("cbpR_data_in" = data_in)
  Sys.setenv("cbpR_data_out" = data_out)
  
  # try to create folder for data source if it doesn't already exist
  if(!file.exists(getCbpPath()$data_in)) {
    dir.create(getCbpPath()$data_in)
  }
  
  # try to create folder for data output if it doesn't already exist
  if(!file.exists(getCbpPath()$data_out)) {
    dir.create(getCbpPath()$data_out)
  }
  
  return(TRUE)
  
}

#' Get the path to the data directories
#'
#' @return a list with the paths to the data directories
getCbpPath = function() {
  
  return(list(
    "data_in" =  Sys.getenv("cbpR_data_in"),
    "data_out" = Sys.getenv("cbpR_data_out")
  ))
  
}

#' Check if the data directories are set
#'
#' This function produces an error if the data directories were not set.
#' 
#' @return \code{true} if the function concludes without error
checkCbp = function() {
  
  if(getCbpPath()$data_in == "") {
    stop('Please use setCbpPath(data_in, data_out) to define the path to the directory where the downloaded data will be stored')
  }
  
  if(getCbpPath()$data_out == "") {
    stop('Please use setCbpPath(data_in, data_out) to define the path to the directory where the final datasets will be stored')
  }
  
  return(TRUE)  
}