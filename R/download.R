# download data
downloadData = function() {
  
  dir.create("data_source")
  
  download.file("ftp://ftp.census.gov/econ2010/CBP_CSV/cbp10co.zip", "data_source/cbp10co.zip")
  download.file("ftp://ftp.census.gov/econ2009/CBP_CSV/cbp09co.zip", "data_source/cbp09co.zip")
  download.file("ftp://ftp.census.gov/econ2008/CBP_CSV/cbp08co.zip", "data_source/cbp08co.zip")
  download.file("ftp://ftp.census.gov/econ2007/CBP_CSV/cbp07co.zip", "data_source/cbp07co.zip")
  download.file("ftp://ftp.census.gov/econ2006/CBP_CSV/cbp06co.zip", "data_source/cbp06co.zip")
  download.file("ftp://ftp.census.gov/econ2005/CBP_CSV/cbp05co.zip", "data_source/cbp05co.zip")
  download.file("ftp://ftp.census.gov/econ2004/CBP_CSV/cbp04co.zip", "data_source/cbp04co.zip")
  download.file("ftp://ftp.census.gov/econ2003/CBP_CSV/cbp03co.zip", "data_source/cbp03co.zip")
  download.file("ftp://ftp.census.gov/econ2002/CBP_CSV/cbp02co.zip", "data_source/cbp02co.zip")
  download.file("ftp://ftp.census.gov/Econ2001_And_Earlier/CBP_CSV/cbp01co.zip", "data_source/cbp01co.zip")
  download.file("ftp://ftp.census.gov/Econ2001_And_Earlier/CBP_CSV/cbp00co.zip", "data_source/cbp00co.zip")
  
  unzip("data_source/cbp10co.zip", files="cbp10co.txt", exdir="data_source")
  unzip("data_source/cbp09co.zip", files="cbp09co.txt", exdir="data_source")
  unzip("data_source/cbp08co.zip", files="Cbp08co.txt", exdir="data_source")
  unzip("data_source/cbp07co.zip", files="Cbp07co.txt", exdir="data_source")
  unzip("data_source/cbp06co.zip", files="cbp06co.txt", exdir="data_source")
  unzip("data_source/cbp05co.zip", files="cbp05co.txt", exdir="data_source")
  unzip("data_source/cbp04co.zip", files="cbp04co.txt", exdir="data_source")
  unzip("data_source/cbp03co.zip", files="cbp03co.txt", exdir="data_source")
  unzip("data_source/cbp02co.zip", files="Cbp02co.txt", exdir="data_source")
  unzip("data_source/cbp01co.zip", files="cbp01co.txt", exdir="data_source")
  unzip("data_source/cbp00co.zip", files="cbp00co.txt", exdir="data_source")
  
  file.rename("data_source/Cbp02co.txt", "data_source/cbp02co.txt")
  file.rename("data_source/Cbp08co.txt", "data_source/cbp08co.txt")
  file.rename("data_source/Cbp07co.txt", "data_source/cbp07co.txt")
  
  download.file("http://www.census.gov/popest/data/metro/totals/2009/tables/CBSA-EST2009-01.csv", "data_source/CBSA-EST2009-01.csv")
  download.file("https://www.census.gov/population/metro/files/lists/2009/List1.txt", "data_source/List1.txt")
  file.rename("data_source/List1.txt", "data_source/cbsa_definitions.txt")
  
  return(TRUE)
}