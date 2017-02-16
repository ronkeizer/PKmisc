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
  kel <- CL / V
  k12 <- Q / V
  k21 <- Q / V2
  t12 <- log(2) / ((1/2) * ((k12 + k21 + kel) - sqrt((k12 + k21 + kel)^2 - (4*k21*kel))))
  return(t12)
}
