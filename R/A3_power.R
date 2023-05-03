#load packages
pacman::p_load(tidyverse,pwr)

#R^2 of 0.1 between predictors and response level
#f2 is the effect size
R2=0.1
f2=R2/(1-R2)

#we want a power of 90%
power=0.9

#and a significance level of 0.05
alpha=0.05

#u is the numerator, which is num of predictors - 1.
#The intercept counts as a predictor, which means we have 6 predictors, so
u=5

#calculation for power of a general linear model
v=pwr.f2.test(u=u,f2=f2,sig.level = alpha,power=power)$v

#to find the sample size, we need to rearrange and solve v=n-u-1
n=ceiling(v+6)

