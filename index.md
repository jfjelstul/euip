# euinfr

This R package provides tools for easily accessing data from the API for the European Union Infringement Procedure (EUIP) dataset by Josh Fjelstul, Ph.D. The EUIP dataset has a REST API that users can call to get data on the European Union (EU) infringement procedure, including data on European Commission infringement cases, data on individual decisions in infringement cases made by the Commission, time-varying summary data by member state, and time-varying summary data by Directorate-General. Directorates-General (DGs) are the departments of the Commission that manage individual infringement cases.

The full EUIP dataset and all replication code is available [here](https://github.com/jfjelstul/EU-infringement-data) and the source code for the EUIP dataset REST API is available [here](https://github.com/jfjelstul/EU-infringement-data-API).

## Installation

You can install the latest development version from GitHub:

```r
# install.packages("devtools")
devtools::install_github("jfjelstul/euinfr")
```

## Citation

If you use data from this package in a project or paper, please cite the following article in the American Political Science Review (APSR):

> Fjelstul, Joshua C., and Clifford J. Carrubba. "The politics of international oversight: Strategic monitoring and legal compliance in the European Union." American Political Science Review 112.3 (2018): 429-445.

The bibtex entry for the article is:

```
@article{FjelstulCarrubba2018,
    title={The politics of international oversight: Strategic monitoring and legal compliance in the European Union},
    author={Fjelstul, Joshua C. and Carrubba, Clifford J.},
    journal={American Political Science Review},
    volume={112},
    number={3},
    pages={429--445},
    year={2018},
    publisher={Cambridge University Press}
}
```
