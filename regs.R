library('maxLik')
library('miscTools')
library('sampleSelection')
library('sandwich')
library('survival')
library('AER')
library('colorspace')
library('ggplot2')

RMSD <- function(x,y) sqrt(mean((x-y)^2))

yestimate <- function(x, k, b) k * x + b

# rm(list=ls())

data_x = read.csv('C:\\Users\\HASEE\\Desktop\\censoredData\\datamat_x6.csv',header = FALSE)
data_Ry = read.csv('C:\\Users\\HASEE\\Desktop\\censoredData\\datamat_Ry6.csv',header = FALSE)
data_Cy = read.csv('C:\\Users\\HASEE\\Desktop\\censoredData\\datamat_Cy6.csv',header = FALSE)

Rfit_lmslp<-array(0,dim = c(1,1000)) # 真实数据的ols拟合slope结果，1000次
Cfit_lmslp<-array(0,dim = c(1,1000)) # 截尾数据的ols拟合slope结果，1000次
Cfit_tobitslp<-array(0,dim = c(1,1000)) # 截尾数据的tobit拟合slope结果，1000次

Rfit_lmintc<-array(0,dim = c(1,1000)) # 真实数据的ols拟合intc结果，1000次
Cfit_lmintc<-array(0,dim = c(1,1000)) # 真实数据的ols拟合intc结果，1000次
Cfit_tobitintc<-array(0,dim = c(1,1000)) # 真实数据的tobit拟合intc结果，1000次

ks_test_arr_lm <-array(0,dim = c(1,1000))
ks_test_arr_tobit <- array(0,dim = c(1,1000))

for(n in 1:1000){
  x = data_x[,n] # cols !!!
  Ry = data_Ry[,n] # cols
  Cy = data_Cy[,n] # cols
  Rfit_lm<-lm(Ry ~ x)
  Cfit_lm<-lm(Cy ~ x)
  y_trunc <- max(Cy)
  Cfit_tobit<-tobit(Cy~x,left = -Inf, right = y_trunc)
  
  ## slope
  Rfit_lmslp[n] <- Rfit_lm$coefficients[2]
  Cfit_lmslp[n] <- Cfit_lm$coefficients[2]
  Cfit_tobitslp[n] <- Cfit_tobit$coefficients[2]
  # Cfit_tobit$coefficients[2]
  
  ## intercept
  Rfit_lmintc[n] <- Rfit_lm$coefficients[1]
  Cfit_lmintc[n] <- Cfit_lm$coefficients[1]
  Cfit_tobitintc[n] <- Cfit_tobit$coefficients[1]
  
  ## yestimate
  ye_R_lm <- yestimate(x, Rfit_lm$coefficients[2],Rfit_lm$coefficients[1])
  ye_C_lm <- yestimate(x,Cfit_lm$coefficients[2],Cfit_lm$coefficients[1])
  ye_C_tobit <- yestimate(x,Cfit_tobit$coefficients[2],Cfit_tobit$coefficients[1])
  
  ## ks test
  ks_test_arr_lm[n] <- ks.test(ye_R_lm,ye_C_lm)[2]
  ks_test_arr_tobit[n] <- ks.test(ye_R_lm,ye_C_tobit)[2]
}

# summary(Rfit)
# summary(Cfit_lm)

##下面都是slope
fit_lm_abs_slp <- abs(Rfit_lmslp - Cfit_lmslp)
fit_tobit_abs_slp <- abs(Rfit_lmslp - Cfit_tobitslp)

mean(Rfit_lmslp)
mean(Cfit_lmslp)
mean(Cfit_tobitslp)
mean(fit_lm_abs_slp) # D1的slope均值
sd(fit_lm_abs_slp) # D1的slope标准差
mean(fit_tobit_abs_slp) # D2的slope均值
sd(fit_tobit_abs_slp) # D2的slope标准差

t.test(fit_lm_abs_slp,fit_tobit_abs_slp,paired = T) # t-test in slp D1 VS D2
t.test(Rfit_lmslp,Cfit_lmslp,paired = T) # t-test in slp R vs C ols
t.test(Rfit_lmslp,Cfit_tobitslp,paired = T) # t-test in slp R vs C tobit

## 模型拟合 ABS 和 RMSD
ABS_slp_lm = mean(fit_lm_abs_slp)
ABS_slp_tobit = mean(fit_tobit_abs_slp)
RMSD_slp_lm = RMSD(Rfit_lmslp,Cfit_lmslp)
RMSD_slp_tobit = RMSD(Rfit_lmslp,Cfit_tobitslp)

## 下面都是intc
fit_lm_abs_intc <- abs(Rfit_lmintc - Cfit_lmintc)
fit_tobit_abs_intc <- abs(Rfit_lmintc - Cfit_tobitintc)

mean(Rfit_lmintc) 
mean(Cfit_lmintc) 
mean(Cfit_tobitintc)
mean(fit_lm_abs_intc) # D1的intc均值
sd(fit_lm_abs_intc) # D1的intc标准差
mean(fit_tobit_abs_intc) # D2的intc均值
sd(fit_tobit_abs_intc) # D2的intc标准差

t.test(fit_lm_abs_intc,fit_tobit_abs_intc,paired = T) # t-test in intc
t.test(Rfit_lmintc,Cfit_lmintc,paired = T) # t-test in intc R vs C ols
t.test(Rfit_lmintc,Cfit_tobitintc,paired = T) # t-test in intc R vs C tobit

## 模型拟合 ABS 和 RMSD
ABS_intc_lm = mean(fit_lm_abs_intc)
ABS_intc_tobit = mean(fit_tobit_abs_intc)
RMSD_intc_lm = RMSD(Rfit_lmintc,Cfit_lmintc)
RMSD_intc_tobit = RMSD(Rfit_lmintc,Cfit_tobitintc)

sum(ks_test_arr_lm>0.05)
sum(ks_test_arr_tobit>0.05)