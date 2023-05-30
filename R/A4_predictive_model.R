#make a predictive model for the IMRaD report

#we are going to use the lme4 package
pacman::p_load(ggplot,lmerTest,lme4)

#read in data
gene<-read.csv(here::here("karl-berator/data/2023_03_21-gene_expression.csv"))

#fit model with lmer
model_lme4<-lmer(growth_factor~(concentration|gene_expression)+ concentration*
                   treatment*cell_type,
                 data=gene)

#summary statistics and assumption checking
summary(model_lme4)
plot(model_lme4)

#plot predictive model
ggplot(gene,aes(x=concentration,y=growth_factor,color=gene_expression))+
  geom_point()+
  geom_line(aes(y=predict(model_lme4)))+
  labs(
    x="\u00b5g/ml",
    y="Growth Factor (units)"
  ) + ggtitle("Predictive Model for Gene Expression")


