#load packages
pacman::p_load(tidyverse, ggplot2,harrypotter,RColorBrewer,ghibli)

#read in data
gene<-read.csv(here::here("data/2023_03_21-gene_expression.csv"))

#conduct EDA of data set
#firstly plot growth factor of gene expression against concentration
#with a linear trend line

#colour coded by treatment
ggplot(gene,aes(x=concentration,y=growth_factor,color=treatment))+
  geom_point()+
  #add linear trendline
  geom_smooth(method=lm)+
  scale_color_brewer(name="Treatment",palette = "Set1") +
  #label plot
  labs(x="Concentration of Growth Factor",y="Gene Expression")+
  ggtitle("Effect of Treatment on the Concentration of Growth Factor on Gene Expression")

#colour coded by treatment and separated by cell type
ggplot(gene,aes(x=concentration,y=growth_factor,color=treatment))+
  geom_point()+
  #add linear trendline
  geom_smooth(method=lm)+
  #separate by cell type
  facet_wrap(~cell_type)+ 
  scale_color_brewer(name="Treatment",palette = "Set1") +
  #label plot
  labs(x="Concentration of Growth Factor",y="Gene Expression")+
  ggtitle("Effect of Treatment and Cell Line on the Concentration of Growth Factor on Gene Expression")


#then plot some box plots to visual the data
#box plot of the gene expression, with a separate box plot for each treatment
ggplot(gene,aes(x=treatment,y=growth_factor,fill=treatment))+
  geom_boxplot()+
  scale_fill_ghibli_d(name="MononokeMedium",direction=-1) +
  #label plot
  labs(x="Treatment", y="Gene Expression")+
  ggtitle("Effect of Treatment on Gene Expression")



#box plot of the gene expression, with a separate box plot for each treatment 
#and cell line. Colour coded by cell line
ggplot(gene,aes(x=treatment,y=growth_factor,fill=cell_type))+
  geom_boxplot() +
  scale_fill_ghibli_d(name="TotoroMedium",direction=-1) +
  #label plot
  labs(x="Treatment", y="Gene Expression")+
  ggtitle("Effect of Treatment and Cell Line on Gene Expression")+
  #change colour code name
  scale_fill_discrete(name="Cell Line")

#box plot of the gene expression, with a separate box plot for each gene. 
#colour coded by treatment and separated by cell line.
ggplot(gene,aes(x=treatment,y=growth_factor,fill=treatment,color=gene_expression))+
  geom_boxplot() +
  #separate by cell line
  facet_wrap(~cell_type)+
  #colour for treatments
  scale_fill_ghibli_d(name="MononokeMedium",direction=-1)+
  #colour for genes
  scale_color_brewer(name="Gene",palette = "Dark2") +
  #label plot
  labs(x="Treatment", y="Gene Expression")+
  ggtitle("Effect of Treatment and Cell Line on Gene Expression")

#these box plots were repeated, with labels to read off for the tables.
#function to label the quantiles on the box plots. 
#The mean and standard deviation was found by changing quantile to 
#mean and sd in the function respectively
fun_mean <- function(x){
  return(data.frame(
    y=quantile(x),label=quantile(x,na.rm=T)))}

#the above box plots with labelled quantile values. 
#These were read off the plots to produce the tables in the powerpoint
#box plot of the gene expression, with a separate box plot for each treatment
ggplot(gene,aes(x=treatment,y=growth_factor,fill=treatment))+
  geom_boxplot()+
  scale_fill_ghibli_d(name="MononokeMedium",direction=-1) +
  labs(x="Treatment", y="Gene Expression")+
  ggtitle("Effect of Treatment on Gene Expression")+
  #add stats to plot
  stat_summary(fun.data=fun_mean,geom="text")


#box plot of the gene expression, with a separate box plot for each treatment 
#and cell line. Colour coded by cell line
ggplot(gene,aes(x=treatment,y=growth_factor,fill=cell_type))+
  geom_boxplot() +
  scale_fill_ghibli_d(name="TotoroMedium",direction=-1) +
  labs(x="Treatment", y="Gene Expression")+
  #label plot
  ggtitle("Effect of Treatment and Cell Line on Gene Expression")+
  scale_fill_discrete(name="Cell Line")+
  #add stats to plot
  stat_summary(fun.data=fun_mean,geom="text")

#box plot of the gene expression, with a separate box plot for each gene. 
#colour coded by treatment and separated by cell line.
ggplot(gene,aes(x=treatment,y=growth_factor,fill=treatment,color=gene_expression))+
  geom_boxplot() +
  #separate by cell line
  facet_wrap(~cell_type)+
  #colour for treatments
  scale_fill_ghibli_d(name="MononokeMedium",direction=-1)+
  #colour code genes
  scale_color_brewer(name="Gene",palette = "Dark2") +
  #label plot
  labs(x="Treatment", y="Gene Expression")+
  ggtitle("Effect of Treatment and Cell Line on Gene Expression") +
  #add stats to plot
  stat_summary(fun.data=fun_mean,geom="text")


#the powerpoint is in the presentation folder.
