#' Download the data
#'
#' This function downloads the data from the Census website. All 
#' Downloads are stored in the directory that was specified using 
#' \code{setCbpPath()}
#'
#' @return \code{true} if the function concludes without error
downloadCbp = function() {
  
  # try to create folder for data source if it doesn't already exist
  if(!file.exists(getCbpPath()$data_in)) {
       dir.create(getCbpPath()$data_in)
  }
  
  if(!file.exists(sprintf("%s/cbp10co.zip", getCbpPath()$data_in)) && !file.exists(sprintf("%s/cbp10co.txt", getCbpPath()$data_in))) {
    download.file("ftp://ftp.census.gov/econ2010/CBP_CSV/cbp10co.zip", sprintf("%s/cbp10co.zip", getCbpPath()$data_in))
  }
  if(file.exists(sprintf("%s/cbp10co.zip", getCbpPath()$data_in)) && !file.exists(sprintf("%s/cbp10co.txt", getCbpPath()$data_in))) {
    unzip(sprintf("%s/cbp10co.zip", getCbpPath()$data_in), files="cbp10co.txt", exdir=getCbpPath()$data_in)
  }
  
  if(!file.exists(sprintf("%s/cbp09co.zip", getCbpPath()$data_in)) && !file.exists(sprintf("%s/cbp09co.txt", getCbpPath()$data_in))) {
    download.file("ftp://ftp.census.gov/econ2009/CBP_CSV/cbp09co.zip", sprintf("%s/cbp09co.zip", getCbpPath()$data_in))
  }
  if(file.exists(sprintf("%s/cbp09co.zip", getCbpPath()$data_in)) && !file.exists(sprintf("%s/cbp09co.txt", getCbpPath()$data_in))) {
    unzip(sprintf("%s/cbp09co.zip", getCbpPath()$data_in), files="cbp09co.txt", exdir=getCbpPath()$data_in)
  }
  
  if(!file.exists(sprintf("%s/cbp08co.zip", getCbpPath()$data_in)) && !file.exists(sprintf("%s/cbp08co.txt", getCbpPath()$data_in))) {
    download.file("ftp://ftp.census.gov/econ2008/CBP_CSV/cbp08co.zip", sprintf("%s/cbp08co.zip", getCbpPath()$data_in))
  }
  if(file.exists(sprintf("%s/cbp08co.zip", getCbpPath()$data_in)) && !file.exists(sprintf("%s/cbp08co.txt", getCbpPath()$data_in))) {
    unzip(sprintf("%s/cbp08co.zip", getCbpPath()$data_in), files="Cbp08co.txt", exdir=getCbpPath()$data_in)
    file.rename(sprintf("%s/Cbp08co.txt", getCbpPath()$data_in), sprintf("%s/cbp08co.txt", getCbpPath()$data_in))
  }
  
  if(!file.exists(sprintf("%s/cbp07co.zip", getCbpPath()$data_in)) && !file.exists(sprintf("%s/cbp07co.txt", getCbpPath()$data_in))) {
    download.file("ftp://ftp.census.gov/econ2007/CBP_CSV/cbp07co.zip", sprintf("%s/cbp07co.zip", getCbpPath()$data_in))
  }
  if(file.exists(sprintf("%s/cbp07co.zip", getCbpPath()$data_in)) && !file.exists(sprintf("%s/cbp07co.txt", getCbpPath()$data_in))) {
    unzip(sprintf("%s/cbp07co.zip", getCbpPath()$data_in), files="Cbp07co.txt", exdir=getCbpPath()$data_in)
    file.rename(sprintf("%s/Cbp07co.txt", getCbpPath()$data_in), sprintf("%s/cbp07co.txt", getCbpPath()$data_in))
  }
  
  if(!file.exists(sprintf("%s/cbp06co.zip", getCbpPath()$data_in)) && !file.exists(sprintf("%s/cbp06co.txt", getCbpPath()$data_in))) {
    download.file("ftp://ftp.census.gov/econ2006/CBP_CSV/cbp06co.zip", sprintf("%s/cbp06co.zip", getCbpPath()$data_in))
  }
  if(file.exists(sprintf("%s/cbp06co.zip", getCbpPath()$data_in)) && !file.exists(sprintf("%s/cbp06co.txt", getCbpPath()$data_in))) {
    unzip(sprintf("%s/cbp06co.zip", getCbpPath()$data_in), files="cbp06co.txt", exdir=getCbpPath()$data_in)
  }
  
  if(!file.exists(sprintf("%s/cbp05co.zip", getCbpPath()$data_in)) && !file.exists(sprintf("%s/cbp05co.txt", getCbpPath()$data_in))) {
    download.file("ftp://ftp.census.gov/econ2005/CBP_CSV/cbp05co.zip", sprintf("%s/cbp05co.zip", getCbpPath()$data_in))
  }
  if(file.exists(sprintf("%s/cbp05co.zip", getCbpPath()$data_in)) && !file.exists(sprintf("%s/cbp05co.txt", getCbpPath()$data_in))) {
    unzip(sprintf("%s/cbp05co.zip", getCbpPath()$data_in), files="cbp05co.txt", exdir=getCbpPath()$data_in)
  }
  
  if(!file.exists(sprintf("%s/cbp04co.zip", getCbpPath()$data_in)) && !file.exists(sprintf("%s/cbp04co.txt", getCbpPath()$data_in))) {
    download.file("ftp://ftp.census.gov/econ2004/CBP_CSV/cbp04co.zip", sprintf("%s/cbp04co.zip", getCbpPath()$data_in))
  }
  if(file.exists(sprintf("%s/cbp04co.zip", getCbpPath()$data_in)) && !file.exists(sprintf("%s/cbp04co.txt", getCbpPath()$data_in))) {
    unzip(sprintf("%s/cbp04co.zip", getCbpPath()$data_in), files="cbp04co.txt", exdir=getCbpPath()$data_in)
  }
  
  if(!file.exists(sprintf("%s/cbp03co.zip", getCbpPath()$data_in)) && !file.exists(sprintf("%s/cbp03co.txt", getCbpPath()$data_in))) {
    download.file("ftp://ftp.census.gov/econ2003/CBP_CSV/cbp03co.zip", sprintf("%s/cbp03co.zip", getCbpPath()$data_in))
  }
  if(file.exists(sprintf("%s/cbp03co.zip", getCbpPath()$data_in)) && !file.exists(sprintf("%s/cbp03co.txt", getCbpPath()$data_in))) {
    unzip(sprintf("%s/cbp03co.zip", getCbpPath()$data_in), files="cbp03co.txt", exdir=getCbpPath()$data_in)
  }
  
  if(!file.exists(sprintf("%s/cbp02co.zip", getCbpPath()$data_in)) && !file.exists(sprintf("%s/cbp02co.txt", getCbpPath()$data_in))) {
    download.file("ftp://ftp.census.gov/econ2002/CBP_CSV/cbp02co.zip", sprintf("%s/cbp02co.zip", getCbpPath()$data_in))
  }
  if(file.exists(sprintf("%s/cbp02co.zip", getCbpPath()$data_in)) && !file.exists(sprintf("%s/cbp02co.txt", getCbpPath()$data_in))) {
    unzip(sprintf("%s/cbp02co.zip", getCbpPath()$data_in), files="Cbp02co.txt", exdir=getCbpPath()$data_in)
    file.rename(sprintf("%s/Cbp02co.txt", getCbpPath()$data_in), sprintf("%s/cbp02co.txt", getCbpPath()$data_in))
  }
  
  if(!file.exists(sprintf("%s/cbp01co.zip", getCbpPath()$data_in)) && !file.exists(sprintf("%s/cbp01co.txt", getCbpPath()$data_in))) {
    download.file("ftp://ftp.census.gov/Econ2001_And_Earlier/CBP_CSV/cbp01co.zip", sprintf("%s/cbp01co.zip", getCbpPath()$data_in))
  }
  if(file.exists(sprintf("%s/cbp01co.zip", getCbpPath()$data_in)) && !file.exists(sprintf("%s/cbp01co.txt", getCbpPath()$data_in))) {
    unzip(sprintf("%s/cbp01co.zip", getCbpPath()$data_in), files="cbp01co.txt", exdir=getCbpPath()$data_in)
  }
  
  if(!file.exists(sprintf("%s/cbp00co.zip", getCbpPath()$data_in)) && !file.exists(sprintf("%s/cbp00co.txt", getCbpPath()$data_in))) {
    download.file("ftp://ftp.census.gov/Econ2001_And_Earlier/CBP_CSV/cbp00co.zip", sprintf("%s/cbp00co.zip", getCbpPath()$data_in))
  }
  if(file.exists(sprintf("%s/cbp00co.zip", getCbpPath()$data_in)) && !file.exists(sprintf("%s/cbp00co.txt", getCbpPath()$data_in))) {
    unzip(sprintf("%s/cbp00co.zip", getCbpPath()$data_in), files="cbp00co.txt", exdir=getCbpPath()$data_in)
  }
  
  if(!file.exists(sprintf("%s/CBSA-EST2009-01.csv", getCbpPath()$data_in))) {
    download.file("http://www.census.gov/popest/data/metro/totals/2009/tables/CBSA-EST2009-01.csv", sprintf("%s/CBSA-EST2009-01.csv", getCbpPath()$data_in))
  }
  
  if(!file.exists(sprintf("%s/cbsa_definitions.txt", getCbpPath()$data_in))) {
    download.file("http://www.census.gov/population/metro/files/lists/2009/List1.txt", sprintf("%s/List1.txt", getCbpPath()$data_in))
    file.rename(sprintf("%s/List1.txt", getCbpPath()$data_in), sprintf("%s/cbsa_definitions.txt", getCbpPath()$data_in))
  }
  
  return(TRUE)
}
