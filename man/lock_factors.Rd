% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/lock_factors.R
\name{lock_factors}
\alias{lock_factors}
\title{Set factor levels based on row order}
\usage{
lock_factors(df, cols = NULL, rev = FALSE)
}
\arguments{
\item{df}{A \code{data.frame} object.}

\item{cols}{A character or character vector of the column names to apply the
factor leveling to. Defaults to \code{NULL} in which case all character or factor
type variables will be re-leveled.}

\item{rev}{Reverse the factor level? Defaults to \code{FALSE}}
}
\value{
The function returns a data frame.
}
\description{
Description
}
\examples{
library(ggplot2)
library(dplyr)

# By default, bar charts made with {ggplot2} follow alphabetical ordering:

mpg |>
  count(manufacturer) |>
  ggplot() +
  geom_col(aes(x = n, y = manufacturer))

# If you want to sort the bars based on n,
# you have to reorder the **factor levels**:

mpg |>
  count(manufacturer) |>
  ggplot() +
  geom_col(aes(x = n, y = reorder(manufacturer, n)))

# {factorlock} allows you to "lock" the factor ordering
# to that of the row ordering in the data frame:

mpg |>
  count(manufacturer) |>
  arrange(n) |>
  factorlock::lock_factors() |>
  ggplot() +
  geom_col(aes(x = n, y = manufacturer))

# By default all character or factor type variables are "locked,"
# but you can also specify which variables you want to "lock" while
# leaving the others alone:

mpg |>
  count(manufacturer) |>
  arrange(n) |>
  factorlock::lock_factors("manufacturer") |>
  ggplot() +
  geom_col(aes(x = n, y = manufacturer))

# You can also get a reverse factor ordering with `rev = TRUE`:

mpg |>
  count(manufacturer) |>
  arrange(n) |>
  factorlock::lock_factors(rev = TRUE) |>
  ggplot() +
  geom_col(aes(x = n, y = manufacturer))

}
\keyword{factors,}
\keyword{levels}
