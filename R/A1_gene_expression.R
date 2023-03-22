pacman::p_load(tidyverse, ggplot2,harrypotter,RColorBrewer,ghibli)

#read in data
gene<-read.csv("C:/Users/AHS Student/Desktop/KarlBerator/data/2023_03_21-gene_expression.csv")
gene

#make linear regression models
gene_lm<-lm(data=gene,growth_factor~as.factor(treatment)+concentration+as.factor(cell_type))
plot(gene_lm)
summary(gene_lm)#all are significant factors

p_smooth <- by(d, d$cat,
               function(x) geom_smooth(data=x, method = lm, formula = lm.mod(x)))

ggplot(gene,aes(x=concentration,y=growth_factor,color=treatment))+
  geom_point()+
  geom_smooth(method=lm)+scale_color_brewer(palette = "Set1")

ggplot(gene,aes(x=concentration,y=growth_factor,color=treatment))+
  geom_point()+
  geom_smooth(method=lm)+
  facet_wrap(~cell_type)+ scale_color_brewer(palette = "Set1")# scale_colour_hp_d(option="LunaLovegood")


#make box plots
ggplot(gene,aes(x=treatment,y=growth_factor,fill=treatment))+geom_boxplot()+scale_fill_ghibli_d(name="MononokeMedium",direction=-1)
ggplot(gene,aes(x=treatment,y=growth_factor,fill=cell_type))+geom_boxplot() +scale_fill_ghibli_d(name="MononokeMedium",direction=-1)
ggplot(gene,aes(x=treatment,y=growth_factor,fill=treatment,color=gene_expression))+geom_boxplot() +
  facet_wrap(~cell_type)+scale_fill_ghibli_d(name="MononokeMedium",direction=-1)+scale_color_brewer(palette = "Dark2")
ggplot(gene,aes(x=treatment,y=growth_factor,fill=cell_type,color=gene_expression))+geom_boxplot()+
  scale_fill_ghibli_d(name="MononokeMedium",direction=-1)+scale_color_brewer(palette="Paired")
ggplot(gene,aes(x=gene_expression,y=growth_factor,color=gene_expression))+geom_boxplot()
