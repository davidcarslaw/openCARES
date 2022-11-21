
<!-- Edit the README.Rmd only!!! The README.md is generated automatically from README.Rmd. -->

# openCARES: tools for vehicle remote emission sensing analysis

<img src="inst/CARES_logo.jpeg" alt="CARES logo" width="35%" class="center"/>

## Introduction

The **openCARES** R package contains tools to assist with the analysis
of vehicle remote emission sensing data. The tools focus on the
development of new insights from potentially complex data sets. This is
anticipated to be useful for those working on the development of remote
emission sensing technologies, in addition to end users such as city
authorities, who want to better understand real-world emissions. The
package has been developed under the framework of the City Air Remote
Emission Sensing (CARES) project. For the main CARES website, see
<https://cares-project.eu/>.

## Package installation

``` r
require(devtools)
install_github('davidcarslaw/openCARES')
```

## Summary analysis report

The goal of the CARES project is to reduce the hurdles for the practical
application of remote emission sensing. The analysis of RES data can be
challenging and within the community of researchers and practitioners
that typically conduct experiments, there is a wide variation in the
analysis approaches used and their consistency.

The main component of the openCARES package is the production of an
**automated summary report**, which provides a quick and reliable way of
presenting key summary data and plots from remote emission sensing
measurement campaigns. End users can compile a report based on their own
remote emission sensing data. The report provides details of measurement
site conditions, vehicle fleet composition, and an evaluation of
fuel-specific emission factors by vehicle type, fuel type, emission
standard, manufacturer and so on. The effect of ambient temperature and
vehicle deterioration on emissions is also explored.

### Producing the summary report

(Add some instructions here on how users can produce the report using
their own data)
