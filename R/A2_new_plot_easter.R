#Aim: to make a plot just like Jono's but with times new roman

#load packages
pacman::p_load(tidyverse, ggplot2, ggrepel, showtext,harrypotter,patchwork)

#read in data
gene<-read.csv(here::here("data/2023_03_21-gene_expression.csv"))

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

#add Times New Roman font
font_add(
  family="times",
  regular=here::here(
    "figs","times.ttf"
  )
)
showtext_auto()

#Make gene expression against concentration plot for 'cell-type'
p2<- ggplot(gene[gene$cell_type=="Cell-type",], 
            aes(x=concentration,y=growth_factor,color=treatment))+
  theme_light()+
  #plot points with black outline and colour coded by treatment
  geom_point(aes(fill=treatment),shape = 21,size = 3.5,colour = "black")+
  #select scale for x axis
  scale_x_continuous(breaks = seq(0, 10, by = 1))+
  #label lines to match Jono's plot
  geom_label_repel(data=subset(gene,
                               subset= concentration == 10 & cell_type=="Cell-type"),
                   aes(fill=treatment,label = gene_expression),
                   color="black",
                   nudge_x = 1,
                   min.segment.length = 0.1,
                   show.legend=FALSE,
                   family="times",
                   size=20)+
  #colour code based on treatment type
  scale_fill_hp_d(name="Treatment",
                  labels=c("Activating factor 42","Placebo"),
                  option="Ravenclaw")+
  #set font as times new roman
  theme(
    text=element_text(family="times",size=20),
    legend.position = "bottom"
  )+
  #label x and y axis
  labs(
    x="\u00b5g/ml",
    y="Gene Expression"
  ) +
  #name plot after cell type
  ggtitle("Cell-type 101")

#Make gene expression against concentration plot for 'wild-type'
p1<- ggplot(gene[gene$cell_type=="Wild-type",],
            aes(x=concentration,y=growth_factor,color=treatment))+
  theme_light()+
  #plot points with black outline and colour coded by treatment
  geom_point(aes(fill=treatment),shape = 21,size = 3.5,colour = "black")+
  #select scale for x axis
  scale_x_continuous(breaks = seq(0, 10, by = 1))+
  #label lines to match Jono's plot
  geom_label_repel(data=subset(gene,
                               subset= concentration == 10 & cell_type=="Wild-type"),
                   aes(fill=treatment,label = gene_expression),
                   color="black",
                   nudge_x = 1,
                   min.segment.length = 0.1,
                   family="times",
                   size=20,
                   show.legend=FALSE)+
  #colour code based on treatment type
  scale_fill_hp_d(name="Treatment",
                  labels=c("Activating factor 42","Placebo"),
                  option="Ravenclaw")+
  #set font as times new roman
  theme(
    text=element_text(family="times",size=50),
    legend.position = "none",
  )+
  #label x and y axis
  labs(
    x="\u00b5g/ml",
    y="Gene Expression"
  )+
  #name plot after cell type
  ggtitle("Wild-type")


#add two plots together
p<-p1+p2+
  #annotate A and B
  plot_annotation(tag_levels = 'A')+
  #have legend for treatment type at the bottom
  plot_layout(guides = 'collect')&
  theme(
    text=element_text(family="times",size=50),
    legend.position = "bottom")


#export plot as a tiff with required dimensions and dpi
ggsave(
  filename=here::here("figs","gene_plot2.tiff"),
  plot=p,
  width=9,
  height=6,
  units="in",
  dpi=500
)

# stop running text
showtext_auto(FALSE)

