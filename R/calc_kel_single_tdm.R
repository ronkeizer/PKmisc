#' Calculate elimination rate when given a single TDM sample
#'
#' @param dose dose amount
#' @param V volume of distribution
#' @param t time or time after dose
#' @param dv observed value
#' @param tau dosing interval
#' @param t_inf infusion time
#' @param kel_init estimate of elimination rate
#' @param n_iter number of iterations to improve estimate of elimination rate
#' @export
calc_kel_single_tdm <- function (
  dose = 1000,
  V = 50,
  t = 10,
  dv = 10,
  tau = 12,
  t_inf = 1,
  kel_init = 0.1,
  n_iter = 25
) {
  t_next_dose <- tau - (t %% tau)
  kel <- kel_init
  for(i in 1:n_iter) {
    cpeak <- PKmisc::pk_1cmt_inf_cmax_ss(
      dose = dose, CL = kel * V, V = V, tau = tau, t_inf = t_inf
    )
    ## safeguard, iterate with reduced step size
    kel_tmp <- log(cpeak/dv) / (t %% tau - t_inf)
    ratio <- abs(kel_tmp - kel) / kel
    if(ratio > 0.25) {
      kel <- (kel + kel_tmp) / 2
    }
  }
  return(kel)
}
