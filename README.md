# cbpR: Working with the County Business Patterns Data in R 
[![Build Status](https://travis-ci.org/jtilly/cbpR.png)](https://travis-ci.org/jtilly/cbpR)

### What is this package about?

This is an R Package that downloads and prepares panel data sets from the **[Census County Business Patterns (CBP)](http://www.census.gov/econ/cbp/)**.

It downloads the CBP data on the county level and then allows the user to aggregate the data up into larger geographic entities such as Metropolitan Statistical Areas, Micropolitan Statistical Areas, or some user defined collection of counties.

The file [`demo/cardealers.R`](https://github.com/jtilly/cbpR/blob/master/demo/cardealers.R) contains a demonstration. It generates a panel data set for "New Car Dealers" [(NAICS 441110)](http://www.census.gov/cgi-bin/sssd/naics/naicsrch?code=441110&search=2012%20NAICS%20Search). The data set ranges from 2000 to 2009. It aggregates the firm count data from the County Business Patterns into Micropolitan Statistical Areas and returns a dataset with annual data on the firm count, employment (if available), firm count by employment, and population figures for each Micropolitan Statistical Area. The population estimates are taken from the *Annual Estimates of the Population of Metropolitan and Micropolitan Statistical Areas: April 1, 2000 to July 1, 2009* [(CBSA-EST2009-01)](https://www.census.gov/popest/data/metro/totals/2009/). The Micropolitan Statistical Area definitions are taken from the [Census 2003-2009 Delineation Files](https://www.census.gov/population/metro/files/lists/2009/List1.txt) .

Note that the CBP data is also directly available for Micropolitan Statistical Areas. However, since the definitions of Micropolitan Statistical Areas have changed frequently in the past, using county level data (and aggregating it for a particular definition of Micropolitan Statistical Areas) is a more reliable way to get a long and balanced panel.

### Installation and how to use

```
source("http://jtilly.io/install_github/install_github.R")
library("cbpR")
```

Once the package is loaded, use
```
setCbpPath("~/cbpR_data_source", "~/cbpR_data_final")
```
to define where to store the source data that will be downloaded and where to store the generated data sets.
The package needs to download the source data. This only needs to be done once. The data will then be stored locally. To download the source data, run
```
downloadCbp()
```
If the source data already exists on the system, it will not be downloaded again.
To get the firm count data from the County Business Patterns, use
```
firms = getFirmCount(naics = "441110", years=c("07", "08", "09"))
```
More details are in [`demo/cardealers.R`](https://github.com/jtilly/cbpR/blob/master/demo/cardealers.R).

A rudimentary documentation is available [here](http://jtilly.github.io/cbpR/cbpR.pdf).

### Example
[`demo/cardealers.R`](https://github.com/jtilly/cbpR/blob/master/demo/cardealers.R) loads a data set for new car dealers and then creates a dataframe `dataSet`. You can run this script using `demo(cardealers)`. The transition frequency matrix (rows=last year, columns=this year) for new car dealers in Micropolitan Statistical Areas (N=573) between 2000 and 2009 looks as follows:
```
     0   1   2   3   4   5   6   7   8   9 >=10
0    0   0   0   0   0   0   0   0   0   0    0
1    0 100  15   1   0   0   0   0   0   0    0
2    0  21 300  65   5   1   0   0   0   0    0
3    0  10  77 422  88  18   3   0   0   0    0
4    0   0  15 123 373 102  20   4   1   0    0
5    0   0   6  37 137 356 116  25   1   0    1
6    0   0   1   3  35 171 334 114  23   5    1
7    0   0   0   0  10  26 146 182  66  25    5
8    0   0   0   0   0  10  32  75 109  52   33
9    0   0   0   0   1   0  15  26  64 105   59
>=10 0   0   0   0   1   0   1  13  39  79  801
```
The corresponding transition probability matrix looks as follows:
```
       0    1    2    3    4    5    6    7    8    9 >=10
0      -    -    -    -    -    -    -    -    -    -    -
1      - 0.86 0.13 0.01 0.00 0.00 0.00 0.00 0.00 0.00 0.00
2      - 0.05 0.77 0.17 0.01 0.00 0.00 0.00 0.00 0.00 0.00
3      - 0.02 0.12 0.68 0.14 0.03 0.00 0.00 0.00 0.00 0.00
4      - 0.00 0.02 0.19 0.58 0.16 0.03 0.01 0.00 0.00 0.00
5      - 0.00 0.01 0.05 0.20 0.52 0.17 0.04 0.00 0.00 0.00
6      - 0.00 0.00 0.00 0.05 0.25 0.49 0.17 0.03 0.01 0.00
7      - 0.00 0.00 0.00 0.02 0.06 0.32 0.40 0.14 0.05 0.01
8      - 0.00 0.00 0.00 0.00 0.03 0.10 0.24 0.35 0.17 0.11
9      - 0.00 0.00 0.00 0.00 0.00 0.06 0.10 0.24 0.39 0.22
>=10   - 0.00 0.00 0.00 0.00 0.00 0.00 0.01 0.04 0.08 0.86
```
