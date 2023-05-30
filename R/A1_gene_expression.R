pacman::p_load(tidyverse, ggplot2,harrypotter,RColorBrewer,ghibli)

#read in data
gene<-read.csv(here::here("data/2023_03_21-gene_expression.csv"))

#make linear regression models
gene_lm<-lm(data=gene,growth_factor~as.factor(treatment)+concentration+as.factor(cell_type))
plot(gene_lm)
summary(gene_lm)#all are significant factors

p_smooth <- by(d, d$cat,
               function(x) geom_smooth(data=x, method = lm, formula = lm.mod(x)))

ggplot(gene,aes(x=concentration,y=growth_factor,color=treatment))+
  geom_point()+
  geom_smooth(method=lm)+scale_color_brewer(name="Treatment",palette = "Set1") +
  labs(x="Concentration of Growth Factor",y="Gene Expression")+
  ggtitle("Effect of Treatment on the Concentration of Growth Factor on Gene Expression")

ggplot(gene,aes(x=concentration,y=growth_factor,color=treatment))+
  geom_point()+
  geom_smooth(method=lm)+
  facet_wrap(~cell_type)+scale_color_brewer(name="Treatment",palette = "Set1") +
  labs(x="Concentration of Growth Factor",y="Gene Expression")+
  ggtitle("Effect of Treatment and Cell Line on the Concentration of Growth Factor on Gene Expression")


data_summary <- function(x) {
  m <- mean(x)
  ymin <- m-sd(x)
  ymax <- m+sd(x)
  return(c(y=m,ymin=ymin,ymax=ymax))
}

fun_mean <- function(x){
  return(data.frame(
                    y=quantile(x),label=quantile(x,na.rm=T)))}


#make box plots
ggplot(gene,aes(x=treatment,y=growth_factor,fill=treatment))+
  geom_boxplot()+scale_fill_ghibli_d(name="MononokeMedium",direction=-1) +
  labs(x="Treatment",y="Gene Expression")+
  ggtitle("Effect of Treatment on Gene Expression")+stat_summary(fun.data=fun_mean,geom="text")
ggplot(gene,aes(x=treatment,y=growth_factor,fill=cell_type))+geom_boxplot() +
  scale_fill_ghibli_d(name="TotoroMedium",direction=-1) +
  labs(x="Treatment",y="Gene Expression")+
  ggtitle("Effect of Treatment and Cell Line on Gene Expression")+
  scale_fill_discrete(name="Cell Line")+stat_summary(fun.data=fun_mean,geom="text")
ggplot(gene,aes(x=treatment,y=growth_factor,fill=treatment,color=gene_expression))+geom_boxplot() +
  facet_wrap(~cell_type)+scale_fill_ghibli_d(name="MononokeMedium",direction=-1)+scale_color_brewer(name="Gene",palette = "Dark2") +
  labs(x="Treatment",y="Gene Expression")+
  ggtitle("Effect of Treatment and Cell Line on Gene Expression") +
  stat_summary(fun.data=fun_mean,geom="text")
ggplot(gene,aes(x=treatment,y=growth_factor,fill=cell_type,color=gene_expression))+geom_boxplot()+
  scale_fill_ghibli_d(name="MononokeMedium",direction=-1)+scale_color_brewer(palette="Paired")+
  labs(x="Treatment",y="Gene Expression")+
  ggtitle("Effect of Treatment on Gene Expression")
ggplot(gene,aes(x=gene_expression,y=growth_factor,color=gene_expression))+geom_boxplot()
