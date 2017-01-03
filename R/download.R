#' Download the data
#'
#' This function downloads the data from the Census website. All 
#' Downloads are stored in the directory that was specified using 
#' \code{setCbpPath()}
#'
#' @return \code{true} if the function concludes without error
#' @examples 
#' setCbpPath('~/cbpR_data_source', '~/cbpR_data_final')
downloadCbp = function() {
  
  # try to create folder for data source if it doesn't already exist
  if (!file.exists(getCbpPath()$data_in)) {
    dir.create(getCbpPath()$data_in)
  }
  
  if (!file.exists(sprintf("%s/cbp00co.txt", getCbpPath()$data_in)) 
     & !file.exists(sprintf("%s/cbp00co.Rda", getCbpPath()$data_in)) )
    downloadFile(url = "ftp://ftp.census.gov/Econ2001_And_Earlier/CBP_CSV/cbp00co.zip",
                 filename = "cbp00co.zip",
                 size = 16024897)
  if (!file.exists(sprintf("%s/cbp01co.txt", getCbpPath()$data_in)) 
     & !file.exists(sprintf("%s/cbp01co.Rda", getCbpPath()$data_in)) )
    downloadFile(url = "ftp://ftp.census.gov/Econ2001_And_Earlier/CBP_CSV/cbp01co.zip",
                 filename = "cbp01co.zip",
                 size = 16090372)
  if (!file.exists(sprintf("%s/cbp02co.txt", getCbpPath()$data_in)) 
     & !file.exists(sprintf("%s/cbp02co.Rda", getCbpPath()$data_in)) )
    downloadFile(url = "ftp://ftp.census.gov/econ2002/CBP_CSV/cbp02co.zip",
                 filename = "cbp02co.zip",
                 size = 16112812)
  if (!file.exists(sprintf("%s/cbp03co.txt", getCbpPath()$data_in)) 
     & !file.exists(sprintf("%s/cbp03co.Rda", getCbpPath()$data_in)) )
    downloadFile(url = "ftp://ftp.census.gov/econ2003/CBP_CSV/cbp03co.zip",
                 filename = "cbp03co.zip",
                 size = 14924287)
  if (!file.exists(sprintf("%s/cbp04co.txt", getCbpPath()$data_in)) 
     & !file.exists(sprintf("%s/cbp04co.Rda", getCbpPath()$data_in)) )
    downloadFile(url = "ftp://ftp.census.gov/econ2004/CBP_CSV/cbp04co.zip",
                 filename = "cbp04co.zip",
                 size = 16409289)
  if (!file.exists(sprintf("%s/cbp05co.txt", getCbpPath()$data_in)) 
     & !file.exists(sprintf("%s/cbp05co.Rda", getCbpPath()$data_in)) )
    downloadFile(url = "ftp://ftp.census.gov/econ2005/CBP_CSV/cbp05co.zip",
                 filename = "cbp05co.zip",
                 size = 14931003)
  if (!file.exists(sprintf("%s/cbp06co.txt", getCbpPath()$data_in)) 
     & !file.exists(sprintf("%s/cbp06co.Rda", getCbpPath()$data_in)) )
    downloadFile(url = "ftp://ftp.census.gov/econ2006/CBP_CSV/cbp06co.zip",
                 filename = "cbp06co.zip",
                 size = 15011674)
  if (!file.exists(sprintf("%s/cbp07co.txt", getCbpPath()$data_in)) 
     & !file.exists(sprintf("%s/cbp07co.Rda", getCbpPath()$data_in)) )
    downloadFile(url = "ftp://ftp.census.gov/econ2007/CBP_CSV/cbp07co.zip",
                 filename = "cbp07co.zip",
                 size = 16791213)
  if (!file.exists(sprintf("%s/cbp08co.txt", getCbpPath()$data_in)) 
     & !file.exists(sprintf("%s/cbp08co.Rda", getCbpPath()$data_in)) )
    downloadFile(url = "ftp://ftp.census.gov/econ2008/CBP_CSV/cbp08co.zip",
                 filename = "cbp08co.zip",
                 size = 16430296)
  if (!file.exists(sprintf("%s/cbp09co.txt", getCbpPath()$data_in)) 
     & !file.exists(sprintf("%s/cbp09co.Rda", getCbpPath()$data_in)) )
    downloadFile(url = "ftp://ftp.census.gov/econ2009/CBP_CSV/cbp09co.zip",
                 filename = "cbp09co.zip",
                 size = 16144126)
  downloadFile(url = "http://www.census.gov/population/metro/files/lists/2009/List1.txt",
               filename = "cbsa_definitions.txt",
               size = 162963 )
  downloadFile(url = "http://jtilly.io/cbpR/data/CBSA-EST2009-01.csv",
               filename = "CBSA-EST2009-01.csv",
               size = 139765)
  
  if (file.exists(sprintf("%s/cbp09co.zip", getCbpPath()$data_in)) && !file.exists(sprintf("%s/cbp09co.txt", getCbpPath()$data_in))) {
    unzip(sprintf("%s/cbp09co.zip", getCbpPath()$data_in), files = "cbp09co.txt", exdir = getCbpPath()$data_in)
  }
  
  if (file.exists(sprintf("%s/cbp08co.zip", getCbpPath()$data_in)) && !file.exists(sprintf("%s/cbp08co.txt", getCbpPath()$data_in))) {
    unzip(sprintf("%s/cbp08co.zip", getCbpPath()$data_in), files = "Cbp08co.txt", exdir = getCbpPath()$data_in)
    file.rename(sprintf("%s/Cbp08co.txt", getCbpPath()$data_in), sprintf("%s/cbp08co.txt", getCbpPath()$data_in))
  }
  
  if (file.exists(sprintf("%s/cbp07co.zip", getCbpPath()$data_in)) && !file.exists(sprintf("%s/cbp07co.txt", getCbpPath()$data_in))) {
    unzip(sprintf("%s/cbp07co.zip", getCbpPath()$data_in), files = "Cbp07co.txt", exdir = getCbpPath()$data_in)
    file.rename(sprintf("%s/Cbp07co.txt", getCbpPath()$data_in), sprintf("%s/cbp07co.txt", getCbpPath()$data_in))
  }
  if (file.exists(sprintf("%s/cbp06co.zip", getCbpPath()$data_in)) && !file.exists(sprintf("%s/cbp06co.txt", getCbpPath()$data_in))) {
    unzip(sprintf("%s/cbp06co.zip", getCbpPath()$data_in), files = "cbp06co.txt", exdir = getCbpPath()$data_in)
  }
  
  if (file.exists(sprintf("%s/cbp05co.zip", getCbpPath()$data_in)) && !file.exists(sprintf("%s/cbp05co.txt", getCbpPath()$data_in))) {
    unzip(sprintf("%s/cbp05co.zip", getCbpPath()$data_in), files = "cbp05co.txt", exdir = getCbpPath()$data_in)
  }
  
  if (file.exists(sprintf("%s/cbp04co.zip", getCbpPath()$data_in)) && !file.exists(sprintf("%s/cbp04co.txt", getCbpPath()$data_in))) {
    unzip(sprintf("%s/cbp04co.zip", getCbpPath()$data_in), files = "cbp04co.txt", exdir = getCbpPath()$data_in)
  }
  
  if (file.exists(sprintf("%s/cbp03co.zip", getCbpPath()$data_in)) && !file.exists(sprintf("%s/cbp03co.txt", getCbpPath()$data_in))) {
    unzip(sprintf("%s/cbp03co.zip", getCbpPath()$data_in), files = "cbp03co.txt", exdir = getCbpPath()$data_in)
  }
  
  if (file.exists(sprintf("%s/cbp02co.zip", getCbpPath()$data_in)) && !file.exists(sprintf("%s/cbp02co.txt", getCbpPath()$data_in))) {
    unzip(sprintf("%s/cbp02co.zip", getCbpPath()$data_in), files = "Cbp02co.txt", exdir = getCbpPath()$data_in)
    file.rename(sprintf("%s/Cbp02co.txt", getCbpPath()$data_in), sprintf("%s/cbp02co.txt", getCbpPath()$data_in))
  }
  
  if (file.exists(sprintf("%s/cbp01co.zip", getCbpPath()$data_in)) && !file.exists(sprintf("%s/cbp01co.txt", getCbpPath()$data_in))) {
    unzip(sprintf("%s/cbp01co.zip", getCbpPath()$data_in), files = "cbp01co.txt", exdir = getCbpPath()$data_in)
  }
  
  if (file.exists(sprintf("%s/cbp00co.zip", getCbpPath()$data_in)) && !file.exists(sprintf("%s/cbp00co.txt", getCbpPath()$data_in))) {
    unzip(sprintf("%s/cbp00co.zip", getCbpPath()$data_in), files = "cbp00co.txt", exdir = getCbpPath()$data_in)
  }
  
  return(TRUE)
}

#' Downloads a file and checks the size
#'
#' This function downloads the specified file and verifies its size. 
#' Since the Census servers don't always work without error, the function tries 
#' downloading each file ten times before it gives up.
#'
#' @param url contains the url of the file to be downloaded
#' @param filename to be used locally
#' @param size of the file in bytes
#' @return \code{true} if the function concludes without error
#' @examples 
#' downloadFile(url = "ftp://ftp.census.gov/Econ2001_And_Earlier/CBP_CSV/cbp00co.zip",
#'              filename = "cbp00co.zip",
#'              size = 16024897)
downloadFile = function(url, filename, size) {
  
  success = FALSE;
  
  if (file.exists(paste(getCbpPath()$data_in, filename, sep = "/"))) {
    if (file.info(paste(getCbpPath()$data_in, filename, sep = "/"))$size == size) {
      success = TRUE;
    } else {
      unlink(paste(getCbpPath()$data_in, filename, sep = "/"))
    }
  }
  
  iter = 0
  while (!success) {
    download.file(url, paste(getCbpPath()$data_in, filename, sep = "/"))
    if (file.info(paste(getCbpPath()$data_in, filename, sep = "/"))$size == size) {
      success = TRUE;
    }
    # if download failed, then wait a second and try again
    if (!success) {
      Sys.sleep(0.5)
    }
    iter = iter + 1
    if (iter > 10) {
      stop(sprintf("Couldn't download %s from %s", filename, url));
    }
    
  }
  
  return(success)
}
