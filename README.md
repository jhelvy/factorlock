
<!-- README.md is generated from README.Rmd. Please edit that file -->

# factorlock <a href='https://jhelvy.github.io/factorlock/'><img src='man/figures/logo.png' align="right" style="height:139px;"/></a>

<!-- badges: start -->

[![CRAN
status](https://www.r-pkg.org/badges/version/factorlock)](https://CRAN.R-project.org/package=factorlock)
[![Travis build
status](https://app.travis-ci.com/jhelvy/factorlock.svg?branch=master)](https://app.travis-ci.com/github/jhelvy/factorlock)
[![](http://cranlogs.r-pkg.org/badges/grand-total/factorlock?color=blue)](https://cran.r-project.org/package=factorlock)
<!-- badges: end -->

# Installation

The current version is not yet on CRAN, but you can install it from
Github using the {remotes} package:

``` r
# install.packages("remotes")
remotes::install_github("jhelvy/factorlock")
```

Load the library with:

``` r
library(factorlock)
```

# Usage

The only thing this package does is provide the
`factorlock::lock_factors()` function to make it easier to reorder
factors in a data frame according to the row order.

By default, bar charts made with {ggplot2} follow alphabetical ordering:

``` r
library(ggplot2)
library(dplyr)

mpg |>
  count(manufacturer) |>
  ggplot() +
  geom_col(aes(x = n, y = manufacturer))
```

<img src="man/figures/bars1-1.png" width="576" />

If you wanted to sort the bars based on `n`, many people make the
mistake of sorting the *data frame* and assuming the reordered rows will
pass through to the bars, like this:

``` r
mpg |>
  count(manufacturer) |>
  arrange(n) |>
  ggplot() +
  geom_col(aes(x = n, y = manufacturer))
```

<img src="man/figures/bars2-1.png" width="576" />

**But this produces the same chart!** 🤦

Instead, to sort the bars based on `n` you have to reorder the **factor
levels**:

``` r
mpg |>
  count(manufacturer) |>
  ggplot() +
  geom_col(aes(x = n, y = reorder(manufacturer, n)))
```

<img src="man/figures/bars-reorder-1.png" width="576" />

I find this rather unintuitive and difficult to remember, let alone
confusing because the ordering of the rows in the data frame won’t match
the factor ordering (which is rather opaque to the user).

{factorlock} provides an alternative approach by allowing you to “lock”
the factor ordering to that of the row ordering in the data frame:

``` r
mpg |>
  count(manufacturer) |>
  arrange(n) |>
  factorlock::lock_factors() |>
  ggplot() +
  geom_col(aes(x = n, y = manufacturer))
```

<img src="man/figures/bars-locked-1.png" width="576" />

Notice that you also get better axis label names for free here since the
`y` variable is still mapped to just `manufacturer` instead of
`reorder(manufacturer, n)`.

By default all character or factor type variables are “locked”, but you
can also specify which variables you want to “lock” while leaving the
others alone:

``` r
mpg |>
  count(manufacturer) |>
  arrange(n) |>
  factorlock::lock_factors("manufacturer") |>
  ggplot() +
  geom_col(aes(x = n, y = manufacturer))
```

<img src="man/figures/bars-locked-named-1.png" width="576" />

You can also get a reverse factor ordering with `rev = TRUE`:

``` r
mpg |>
  count(manufacturer) |>
  arrange(n) |>
  factorlock::lock_factors(rev = TRUE) |>
  ggplot() +
  geom_col(aes(x = n, y = manufacturer))
```

<img src="man/figures/bars-locked-rev-1.png" width="576" />

# Author, Version, and License Information

- Author: *John Paul Helveston* <https://www.jhelvy.com/>
- Date First Written: *May 10, 2023*
- License:
  [MIT](https://github.com/jhelvy/factorlock/blob/master/LICENSE.md)

# Citation Information

If you use this package for in a publication, I would greatly appreciate
it if you cited it - you can get the citation by typing
`citation("factorlock")` into R:

``` r
citation("factorlock")
#> 
#> To cite factorlock in publications use:
#> 
#>   John Paul Helveston (2022). factorlock: Set Factors Levels Based on
#>   Row Order.
#> 
#> A BibTeX entry for LaTeX users is
#> 
#>   @Manual{,
#>     title = {factorlock: Set Factors Levels Based on Row Order},
#>     author = {John Paul Helveston},
#>     year = {2022},
#>     note = {R package},
#>     url = {https://jhelvy.github.io/factorlock/},
#>   }
```
