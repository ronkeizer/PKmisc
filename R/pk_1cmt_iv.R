#' PK of iv 1 compartment drug
#'
#' @param t vector of time
#' @param t_inf infusion time
#' @param dose dose
#' @param tau dosing interval
#' @param CL clearance
#' @param V volume of distribution
#' @param ruv residual error (list)
#' @export
pk_1cmt_iv <- function(
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
  dat <- data.frame(cbind(t = t, dv = 0))
  t_dos <- t %% tau
  n_dos <- floor(t/tau)
  unq_dos <- unique(n_dos) + 1
  for(i in seq(unq_dos)) {
    sel <- n_dos >= i-1
    tmp <- dat[sel,]
    tmp$t <- tmp$t - (i-1)*tau
    tmp[tmp$t < t_inf,]$dv <- (dose / (CL * t_inf)) * (1-exp(-k*tmp$t[tmp$t < t_inf]))
    tmp[tmp$t >= t_inf,]$dv <- (dose / (CL * t_inf)) * (1-exp(-k*t_inf)) * exp(-k*(tmp$t[tmp$t >= t_inf] - t_inf))
    dat[sel,]$dv <- dat[sel,]$dv + tmp$dv
  }
  if(!is.null(ruv)) {
    dat$dv <- add_ruv (dat$dv, ruv)
  }
  return(dat)
}
