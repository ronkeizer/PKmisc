#' Calculate terminal half-life for 2-compartment model
#'
#' @param CL clearance
#' @param V volume of central compartment
#' @param Q inter-compartimental clearance
#' @param V2 volume of peripheral compartment
#' @export
pk_2cmt_t12 <- function(
  CL = 3,
  V = 30,
  Q = 2,
  V2 = 20
) {
  ## conversions, if necessary
  if(class(CL) == "list" && !is.null(CL$value)) { CL <- CL$value }
  if(class(V) == "list"  && !is.null(V$value)) { V <- V$value }
  if(class(Q) == "list"  && !is.null(Q$value)) { Q <- Q$value }
  if(class(V2) == "list" && !is.null(V2$value)) { V2 <- V2$value }
  kel <- CL / V
  k12 <- Q / V
  k21 <- Q / V2
  t12 <- log(2) / ((1/2) * ((k12 + k21 + kel) - sqrt((k12 + k21 + kel)^2 - (4*k21*kel))))
  return(t12)
}
