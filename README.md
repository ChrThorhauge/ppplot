# phallogram

A novelty R package with exactly one function: `pp_plot()`, which plots a
histogram shaped like a phallus.

## Installation

```r
# install.packages("remotes")
remotes::install_github("ChrThorhauge/ppplot")
```

## Usage

```r
library(phallogram)

pp_plot()
pp_plot(bins = 61, col = "steelblue", main = "Quarterly Growth")

# The generated data is returned invisibly
x <- pp_plot()
summary(x)
```
