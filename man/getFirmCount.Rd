% Generated by roxygen2 (4.1.1): do not edit by hand
% Please edit documentation in R/firms.R
\name{getFirmCount}
\alias{getFirmCount}
\title{Get the firm count data from the County Business Patterns (CBP)}
\usage{
getFirmCount(naics, years = c("09", "08", "07", "06", "05", "04", "03", "02",
  "01", "00"))
}
\arguments{
\item{naics}{a string with the naics code of the industry}

\item{years}{a vector of strings with the last two digits of years for which
to process the data}
}
\value{
a data frame of a long panel with the CPB data on the county level
}
\description{
This function processes the downloaded CPB data and generates
a long panel data set. The data frame contains the following columns
\itemize{
\item \code{fips} the fips code
\item \code{fipsstate} the state fips code
\item \code{fipscty} the county fips code within the state
\item \code{year} the year of observation
\item \code{est} the number of establishments
\item \code{n1_4} the number of establishments with between 1 and 4 employees
\item \code{n5_9} the number of establishments with between 5 and 9 employees
\item \code{n10_19} ... with between 10 and 19 employees
\item \code{n20_49} ... with between 20 and 49 employees
\item \code{n50_99}... with between 50 and 99 employees
\item \code{n100_249} ... with between 100 and 249 employees
\item \code{n250_499} ... with between 250 and 499 employees
\item \code{n500_999} ... with between 500 and 999 employees
\item \code{n1000plus} ... with between more than 1000 employees
}
}

