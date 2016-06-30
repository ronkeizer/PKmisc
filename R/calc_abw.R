#' Calculate adjusted body weight (ABW)
#'
#' Often used for chemotherapy calculations when actual weight > 120% of IBW.
#'
#' @param weight actual body weight in kg
#' @param ibw ideal body weight in kg
#' @param ... parameters passed to ibw function (if `ibw` not specified)
#'
calc_abw <- function(weight=NULL, ibw=NULL, verbose = TRUE, ...) {
  if(is.null(weight)) {
    stop("Weight needs to be specified!")
  }
  if(is.null(ibw)) {
    if(verbose) {
      message("Note: IBW not specified, trying to calculate from other parameters.")
    }
    ibw <- calc_ibw(...)
  }
  if(is.null(ibw)) {
    stop("IBW required for calculation of ABW.")
  }
  abw <- ibw + (weight-ibw)*0.4
  return(abw)
}
