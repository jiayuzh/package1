# Generated by using Rcpp::compileAttributes() -> do not edit by hand
# Generator token: 10BE3573-1514-4C36-9D1C-5A225CD40393

#' Calculate the euclidean distance between 2 points
#'
#' @param x1 A numeric vector of the coordinates of x1 point.
#' @param x2 A numeric vector of the coordinates of x2 point.
#' @param size A integer of the length of x1 or/and x2.
#' @export
cppdist <- function(x1, x2, size) {
    .Call(`_package1_cppdist`, x1, x2, size)
}

