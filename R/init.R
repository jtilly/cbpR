setCbpPath = function(data_in, data_out) {
  
  Sys.setenv("cbpR_data_in" = data_in)
  Sys.setenv("cbpR_data_out" = data_out)
  
  return(TRUE)
  
}

getCbpPath = function() {
  
  return(list(
    "data_in" =  Sys.getenv("cbpR_data_in"),
    "data_out" = Sys.getenv("cbpR_data_out")
  ))
  
}

checkCbp = function() {
  
  if(getCbpPath()$data_in == "") {
    stop('Please use setCbpPath to define the path to the directory where the downloaded data will be stored')
  }
  
  if(getCbpPath()$data_out == "") {
    stop('Please use setCbpPath to define the path to the directory where the final datasets will be stored')
  }
  
  
  
}