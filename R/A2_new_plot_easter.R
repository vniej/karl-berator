#to make a plot just like jono's but with times new roman

pacman::p_load(tidyverse, ggplot2, ggrepel, showtext,harrypotter,patchwork)
#read in data
gene<-read.csv("C:/Users/AHS Student/Desktop/KarlBerator/data/2023_03_21-gene_expression.csv")
gene

#change gene names
gene$gene_expression=fct_recode(gene$gene_expression,
                                JZC="GL_JZC",
                                fUg="GL_fUg",
                                CsE="GL_CsE",
                                bNo="GL_bNo",
                                xpo="GL_xpo",
                                Rza="GL_Rza",
                                Hoe="GL_Hoe",
                                jEK="GL_jEK")

#add times new roman font
font_add(
  family="times",
  regular=here::here(
    "figs","times.ttf"
  )
)

#make plot
showtext_auto()
ggplot(gene,aes(x=concentration,y=growth_factor,color=treatment))+
  theme_light()+
  geom_point(aes(fill=treatment),shape = 21,size = 2,colour = "black")+

  scale_x_continuous(breaks = seq(0, 10, by = 1))+
  facet_wrap(~cell_type)+
  #geom_label(aes(label = gene_expression),nudge_x = 0.35, size = 4)+
  geom_label_repel(aes(fill=treatment,label = gene_expression),color="black",family="times")+
  scale_fill_hp_d(name="Treatment",
                   labels=c("Activating factor 42","Placebo"),
                   option="Ravenclaw")+
  theme(

    text=element_text(family="times",size=20),
    legend.position = "bottom",
    strip.background = element_rect()
  )+
  labs(
    x="\u00b5g/ml",
    y="Gene Expression"
  )


#make 2 plots to add together

p1<- ggplot(gene[gene$cell_type=="Cell-type",],aes(x=concentration,y=growth_factor,color=treatment))+
  theme_light()+
  geom_point(aes(fill=treatment),shape = 21,size = 3.5,colour = "black")+

  scale_x_continuous(breaks = seq(0, 10, by = 1))+
  geom_label_repel(data=subset(gene,
                               subset= concentration == 10 & cell_type=="Cell-type"),
                   aes(fill=treatment,label = gene_expression),
                   color="black",
                   nudge_x = 1,
                   min.segment.length = 0.1,
                   show.legend=FALSE,
                   family="times",
                   size=20)+
  scale_fill_hp_d(name="Treatment",
                  labels=c("Activating factor 42","Placebo"),
                  option="Ravenclaw")+
  theme(

    text=element_text(family="times",size=20),
    legend.position = "bottom"
  )+
  labs(
    x="\u00b5g/ml",
    y="Gene Expression"
  ) +
  ggtitle("Cell-type 101")

p2<- ggplot(gene[gene$cell_type=="Wild-type",],aes(x=concentration,y=growth_factor,color=treatment))+
  theme_light()+
  geom_point(aes(fill=treatment),shape = 21,size = 3.5,colour = "black")+

  scale_x_continuous(breaks = seq(0, 10, by = 1))+
  geom_label_repel(data=subset(gene,
                               subset= concentration == 10 & cell_type=="Wild-type"),
                   aes(fill=treatment,label = gene_expression),
                   color="black",
                   nudge_x = 1,
                   min.segment.length = 0.1,
                   family="times",
                   size=20,
                   show.legend=FALSE)+
  scale_fill_hp_d(name="Treatment",
                  labels=c("Activating factor 42","Placebo"),
                  option="Ravenclaw")+
  theme(

    text=element_text(family="times",size=50),
    legend.position = "none",
    #legend.key= element_rect(fill = "white")
  )+
  labs(
    x="\u00b5g/ml",
    y="Gene Expression"
  )+
  ggtitle("Wild-type")

p<-(p2+p1) / guide_area() +
  plot_layout(guides = 'collect')+
 theme(
  text=element_text(family="times",size=50),
  legend.position = "bottom")+
plot_annotation(tag_levels = 'A')

p<-p2+p1+
  plot_annotation(tag_levels = 'A')+
  plot_layout(guides = 'collect')&
  theme(
    text=element_text(family="times",size=50),
    legend.position = "bottom")





#export image as a tiff
ggsave(
  filename=here::here("figs","gene_plot.tiff"),
  plot=p,
  width=9,
  height=6,
  units="in",
  dpi=500
)

# stop running
showtext_auto(FALSE)

