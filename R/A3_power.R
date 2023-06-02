#load packages
pacman::p_load(pwr)

#references for the equations are in Ryan 2013 Sample Size Determination 
#and Power pg149-151

#R^2 is 0.1, which is between predictors and response level
R2=0.1

#f2 is the effect size
#formula from Ryan 2013 Sample Size Determination and Power pg149
f2=R2/(1-R2)

#we want a power of 90%
power=0.9

#and a significance level of 0.05
alpha=0.05

#u is the numerator, which is the number of predictors - 1.
#The intercept counts as a predictor, which means we have 6 predictors, so
u=5

#calculation for power of a general linear model using F-statistic
#the unknown is v, the denominator
v=pwr.f2.test(u=u,
              f2=f2,
              sig.level = alpha,
              power=power
              )$v

#to find the sample size, we need to rearrange and solve v=n-u-1
n=ceiling(v+6)

#therefore, the sample size is
n

