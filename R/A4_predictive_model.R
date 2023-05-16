#make a predictive model for Karl and the IMRaD report

#we are going to use the lme4 and lmerTest package
pacman::p_load(tidyverse,ggplot,lmerTest,lme4)

#read in data
gene<-read.csv("C:/Users/AHS Student/Desktop/KarlBerator/data/2023_03_21-gene_expression.csv")

#fit model with lmer
