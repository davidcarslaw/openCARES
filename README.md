
<!-- Edit the README.Rmd only!!! The README.md is generated automatically from README.Rmd. -->

# openCARES: tools for vehicle remote emission sensing analysis

<img src="inst/CARES_logo.jpeg" alt="CARES logo" width="35%" class="center"/>

## Introduction

The **openCARES** R package contains tools to assist with the analysis
of vehicle remote emission sensing (RES) data and provide new insights
from potentially complex data sets. This is anticipated to be useful for
those working on the development of RES technologies, in addition to end
users such as city authorities, who want to better understand real-world
vehicle emissions. The package has been developed under the framework of
the City Air Remote Emission Sensing (CARES) project. For the main CARES
website, see <https://cares-project.eu/>.

## Package installation

``` r
require(devtools)
install_github('davidcarslaw/openCARES')
```

## Automated analysis

The goal of the CARES project is to reduce the hurdles for the practical
application of remote emission sensing. The analysis of RES data can be
challenging and within the community of researchers and practitioners
that typically conduct experiments, there is a wide variation in the
analysis approaches used and their consistency.

The main component of the openCARES package is the production of an
**automated summary report**, which provides a quick and reliable way of
presenting key summary data and plots from RES measurement campaigns.
The report provides details of measurement site conditions, vehicle
fleet composition, and an evaluation of fuel-specific emission factors
by vehicle type, fuel type, emission standard, manufacturer and so on.
The effect of ambient temperature and vehicle deterioration on emissions
is also explored.

The package includes example data from a measurement campaign conducted
in Milan, Italy. This can be used directly to run the automated
analysis. The package also contains the source file, which allows users
to produce the summary report with any RES data. Information on the
column names that would be expected in a data set is provided.
