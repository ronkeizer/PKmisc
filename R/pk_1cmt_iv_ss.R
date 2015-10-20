#' PK of iv 1 compartment drug at steady state
#'
#' @param t vector of time
#' @param t_inf infusion time
#' @param dose dose
#' @param tau dosing interval
#' @param CL clearance
#' @param V volume of distribution
#' @param ruv residual error (list)
#' @export
pk_1cmt_iv_ss <- function(
    t = c(0:24),
    dose = 100,
    t_inf = 1,
    tau = 8,
    CL = 5,
    V = 50,
    ruv = NULL
  ) {
  k <- CL / V
  tmp <- c()
  t_dos <- t %% tau
  dat <- data.frame(cbind(t = t, dv = 0))
  dat$dv[t_dos < t_inf]  <- (dose / (CL * t_inf)) * ((1-exp(-k * t_dos[t_dos < t_inf]) + (exp(-k*tau) * (1-exp(-k*t_inf)) * exp(-k*(t_dos[t_dos < t_inf] - t_inf)) / (1-exp(-k*tau)))))
  dat$dv[t_dos >= t_inf] <- (dose / (CL * t_inf)) * (1-exp(-k*t_inf)) * exp(-k*(t_dos[t_dos >= t_inf] - t_inf)) / (1-exp(-k*tau))
  if(!is.null(ruv)) {
    dat$dv <- add_ruv (dat$dv, ruv)
  }
  return(dat)
}
