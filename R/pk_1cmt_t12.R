#' Calculate terminal half-life for 1-compartment model
#'
#' @param CL clearance
#' @param V volume of central compartment
#' @export
pk_1cmt_t12 <- function(
  CL = 3,
  V = 30,
  Q = 2,
  V2 = 20
) {
  ## conversions, if necessary
  if(class(CL) == "list" && !is.null(CL$value)) { CL <- CL$value }
  if(class(V) == "list"  && !is.null(V$value)) { V <- V$value }
  print(CL)
  print(V)
  kel <- CL / V
  t12 <- log(2) / kel
  return(t12)
}
