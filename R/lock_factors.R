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
