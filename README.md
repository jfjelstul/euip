# euip

An `R` package for the European Union Infringement Procedure (EUIP) Database. The EUIP database is part of the European Union Compliance Project (EUCP), which also includes the [European Union State Aid (EUSA) Database](https://github.com/jfjelstul/eusa) and the [European Union Technical Regulation Database](https://github.com/jfjelstul/eutr). The EUCP is introduced in the working paper "Legal Compliance in the European Union: Institutional Procedures and Strategic Enforcement Behavior" by Joshua C. Fjelstul. 

The EUIP Database includes 22 datasets on the European Union's formal infringement procedure (2002-2020), including data on the universe of infringement cases and decisions made by the Commission in infringement cases. The database also includes time-series, cross-sectional, directed dyad-year, and network data on cases and decisions. 

The EUIP Database is, in part, an updated version of the data used in the article "The politics of international oversight: Strategic monitoring and legal compliance in the European Union" by Joshua C. Fjelstul and Clifford J. Carrubba in the American Political Science Review (APSR).

## Installation

You can install the latest development version of the `euip` package from GitHub:

```r
# install.packages("devtools")
devtools::install_github("jfjelstul/euip")
```

## Documentation

The codebook for the database is included as a `tibble` in the `R` package: `euip::codebook`. The same information is also available in the `R` documentation for each dataset. For example, you can see the codebook for the `euip::cases` dataset by running `?euip::cases`. You can also read the documentation on the [package website](https://jfjelstul.github.io/euip/).

## Citation

If you use data from the `euip` package in a project or paper, please cite the following article in the American Political Science Review (APSR):

> Fjelstul, Joshua C., and Clifford J. Carrubba. 2018. "The politics of international oversight: Strategic monitoring and legal compliance in the European Union." American Political Science Review 112(3): 429-445.

The bibtex entry for the article is:

```
@article{FjelstulCarrubba2018,
    title={The politics of international oversight: Strategic monitoring and legal compliance in the European Union},
    author={Fjelstul, Joshua C. and Carrubba, Clifford J.},
    journal={American Political Science Review},
    volume={112},
    number={3},
    pages={429--445},
    year={2018}
}
```

Please also cite the `R` package:

> Joshua Fjelstul (2021). evoeu: The Evolution of European Union Law (EvoEU) Database. R package version 0.1.0.9000.
> 
The `BibTeX` entry for the package is:

```
@Manual{,
  title = {evoeu: The Evolution of European Union Law (EvoEU) Database},
  author = {Joshua Fjelstul},
  year = {2021},
  note = {R package version 0.1.0.9000},
}
```

## Problems

If you notice an error in the data or a bug in the `R` package, please report it [here](https://github.com/jfjelstul/euip/issues).
