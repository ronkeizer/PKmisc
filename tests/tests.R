library(PKmisc)
library(testit)

## NCA
data <- data.frame(cbind(time = c(0, 1, 2, 4, 6, 8),
                         dv = c(300, 1400, 1150, 900, 700, 400)))
t1 <- nca(data)
assert("NCA estimates are correct (AUCinf)", round(t1$auc_inf) == 9164)
assert("NCA estimates are correct (AUCt)", round(t1$auc_t) == 6824)
assert("NCA estimates are correct (css)", round(t1$css) == 1137)
