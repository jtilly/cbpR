#' Get the firm count data from the County Business Patterns (CBP)
#' 
#' This is an R Package that downloads and prepares panel data sets from the 
#' Census County Business Patterns (CBP).
#' 
#' It downloads the CPB data on the county level and then allows the user to 
#' aggregate the data up into larger geographic entities such as Metropolitan 
#' Statistical Areas, Micropolitan Statistical Areas, or some user defined 
#' collection of counties.
#'
#' The file demo/cardealers.R contains a demonstration. It generates a panel 
#' data set for "New Car Dealers" (NAICS 441110). The data set ranges from 2000 
#' to 2009. It aggregates the firm count data from the County Business Patterns 
#' into Micropolitan Statistical Areas and returns a dataset with annual data 
#' on the firm count, employment (if available), firm count by employment, and 
#' population figures for each Micropolitan Statistical Area. The population 
#' estimates are taken from the Annual Estimates of the Population of 
#' Metropolitan and Micropolitan Statistical Areas: April 1, 2000 to July 1, 
#' 2009 (CBSA-EST2009-01). The Micropolitan Statistical Area definitions are 
#' taken from the Census 2003-2009 Delineation Files. 
#' 
#' The data frame \code{firms} contains the following columns
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
#' 
#' @docType package
#' @name cpbR
NULL