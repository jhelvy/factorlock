#' Set factor levels based on row order
#'
#' Description
#' @keywords factors, levels
#'
#' @param df A `data.frame` object.
#' @param cols A character or character vector of the column names to apply the
#' factor leveling to. Defaults to `NULL` in which case all character or factor
#' type variables will be re-leveled.
#' @param rev Reverse the factor level? Defaults to `FALSE`
#' @return The function returns a data frame.
#' @export
#' @examples
#' library(ggplot2)
#' library(dplyr)
#'
#' # By default, bar charts made with {ggplot2} follow alphabetical ordering:
#'
#' mpg |>
#'   count(manufacturer) |>
#'   ggplot() +
#'   geom_col(aes(x = n, y = manufacturer))
#'
#' # If you want to sort the bars based on n,
#' # you have to reorder the **factor levels**:
#'
#' mpg |>
#'   count(manufacturer) |>
#'   ggplot() +
#'   geom_col(aes(x = n, y = reorder(manufacturer, n)))
#'
#' # {factorlock} allows you to "lock" the factor ordering
#' # to that of the row ordering in the data frame:
#'
#' mpg |>
#'   count(manufacturer) |>
#'   arrange(n) |>
#'   factorlock::lock_factors() |>
#'   ggplot() +
#'   geom_col(aes(x = n, y = manufacturer))
#'
#' # By default all character or factor type variables are "locked,"
#' # but you can also specify which variables you want to "lock" while
#' # leaving the others alone:
#'
#' mpg |>
#'   count(manufacturer) |>
#'   arrange(n) |>
#'   factorlock::lock_factors("manufacturer") |>
#'   ggplot() +
#'   geom_col(aes(x = n, y = manufacturer))
#'
#' # You can also get a reverse factor ordering with `rev = TRUE`:
#'
#' mpg |>
#'   count(manufacturer) |>
#'   arrange(n) |>
#'   factorlock::lock_factors(rev = TRUE) |>
#'   ggplot() +
#'   geom_col(aes(x = n, y = manufacturer))
#'
lock_factors <- function(df, cols = NULL, rev = FALSE) {
    df <- as.data.frame(df)
    types <- unlist(lapply(df, class))
    if (!is.null(cols)) {
        fct_ids <- which(names(df) %in% cols)
    } else {
        fct_ids <- which(types %in% c("character", "factor"))
    }
    for (i in seq(length(fct_ids))) {
      col <- df[,i]
      factor_levels <- unique(col)
      if (rev) { factor_levels <- rev(factor_levels) }
      df[,i] <- factor(col, levels = factor_levels)
    }
    return(df)
}
