### Figures for Ukrainian values ###


library(tidyverse)
library(readstata13)
library(gapminder)
library(here)
library(socviz)
library(tidyverse)
library(haven)
library(foreign)
library(readxl)
library(cowplot)
library(ggrepel)
library(ggalt)
library(ggfortify)
library(ggforce)
library(concaveman)
library(magrittr)
library(dplyr)
library(ggpubr)
library(readxl)
library(ggrepel)
library(ggfortify)
library(ggforce)
library(gapminder)
library(here)
library(socviz)
library(tidyverse)
library(haven)
library(foreign)
library(readxl)
library(cowplot)
library(ggrepel)
library(ggalt)
library(ggfortify)
library(ggforce)
library(concaveman)
library(magrittr)
library(dplyr)
library(ggpubr)


setwd("SET YOUR WORKING DIRECTORY")


#############################################################################################
#################################  UKRAINE BY REGIONS  ######################################

mydata <- read_excel("YOUR WORKING DIRECTORY/Ukraine by region.xlsx")


mydata$group <- factor(mydata$group, c("Old EU-members",
                                      "New EU-members",
                                      "Ukraine - West",
                                      "Ukraine - Kyiv",
                                      "Ukraine - East/South",
                                      "Ukraine (all regions)", 
                                      "Russia"))                                         




EU_values <- ggplot(data = mydata, mapping = aes(x = group, y = EU_Values)) + 
  geom_point(size = 1.5) + 
  geom_errorbar(mapping = aes(ymin = EU_Values - CI_EU_Values, ymax = EU_Values + CI_EU_Values), width = 0) + 
  scale_y_continuous(limits = c(50,77)) + 
  labs(title = "EU-values",
       x = NULL,
       y = NULL) +
  coord_flip() + 
  theme_bw(14) +
  theme(panel.grid.minor.y = element_blank(),
        panel.grid.major.y = element_blank()) + 
  theme(title=element_text(size=12), 
        axis.text=element_text(size=12)) + 
  scale_x_discrete(expand = expansion(mult=0.0, 0.3)) +
  expand_limits(x=8) +  
  theme(plot.title = element_text(hjust = 0.4)) + 
  geom_text(aes(label=EU_Values), vjust=-0.6, size = 3.2, color = "grey40")


ggsave("EU-Values2.PNG", plot = EU_values , height = 2, width = 8)




freedom <-  ggplot(data = mydata, mapping = aes(x = group, y = P_Freedom)) + 
  geom_point(size = 1.5) + 
  geom_errorbar(mapping = aes(ymin = P_Freedom - CI_P_Freedom, ymax = P_Freedom + CI_P_Freedom), width = 0) + 
  scale_y_continuous(limits = c(32,91)) + 
  labs(title = "Personal Freedom",
       x = NULL,
       y = NULL) + 
  coord_flip() + 
  theme_bw(14) +
  theme(panel.grid.minor.y = element_blank(),
        panel.grid.major.y = element_blank())+ 
  theme(axis.text.x = element_blank(),
        axis.ticks = element_blank())+ 
  theme(title=element_text(size=10), 
              axis.text=element_text(size=10))+ 
  scale_x_discrete(expand = expansion(mult=0.0, 0.3)) +
  expand_limits(x=8) +
  theme(plot.title = element_text(hjust = 0.4)) + 
  geom_text(aes(label=P_Freedom), vjust=-0.6, size = 3.2, color = "grey40")


ggsave("Personal Freedom.PNG", plot = freedom , height = 2, width = 8)


#Individual Autonomy
autonomy <-  ggplot(data = mydata, mapping = aes(x = group, y = I_Autonomy)) + 
  geom_point(size = 1.5) + 
  geom_errorbar(mapping = aes(ymin = I_Autonomy - CI_I_Autonomy, ymax = I_Autonomy + CI_I_Autonomy), width = 0) + 
  scale_y_continuous(limits = c(32,91)) + 
  labs(title = "Individual Autonomy",
       x = NULL,
       y = NULL) + 
  coord_flip() + 
  theme_bw(14) +
  theme(panel.grid.minor.y = element_blank(),
        panel.grid.major.y = element_blank())+ 
  theme(axis.text.x = element_blank(),
        axis.ticks = element_blank())+ 
  theme(title=element_text(size=10), 
        axis.text=element_text(size=10))+ 
  scale_x_discrete(expand = expansion(mult=0.0, 0.3)) +
  expand_limits(x=8) +
  theme(plot.title = element_text(hjust = 0.4)) + 
  geom_text(aes(label=I_Autonomy), vjust=-0.6, size = 3.2, color = "grey40")


ggsave("Individual Autonomy.PNG", plot = autonomy , height = 2, width = 8)



#Ethnic Tolerance
tolerance <-  ggplot(data = mydata, mapping = aes(x = group, y = E_Tolerance)) + 
  geom_point(size = 1.5) + 
  geom_errorbar(mapping = aes(ymin = E_Tolerance - CI_E_Tolerance, ymax = E_Tolerance + CI_E_Tolerance), width = 0) + 
  scale_y_continuous(limits = c(32,91)) + 
  labs(title = "Ethnic Tolerance",
       x = NULL,
       y = NULL) + 
  coord_flip() + 
  theme_bw(14) +
  theme(panel.grid.minor.y = element_blank(),
        panel.grid.major.y = element_blank())+ 
  theme(axis.text.x = element_blank(),
        axis.ticks = element_blank())+ 
  theme(title=element_text(size=10), 
        axis.text=element_text(size=10)) + 
  scale_x_discrete(expand = expansion(mult=0.0, 0.3)) +
  expand_limits(x=8)+
  theme(plot.title = element_text(hjust = 0.4)) + 
  geom_text(aes(label=E_Tolerance), vjust=-0.6, size = 3.2, color = "grey40")


ggsave("Ethnic Tolerance.PNG", plot = tolerance , height = 2, width = 8)


#Civic Honesty
honesty <-  ggplot(data = mydata, mapping = aes(x = group, y = C_Honesty)) + 
  geom_point(size = 1.5) + 
  geom_errorbar(mapping = aes(ymin = C_Honesty - CI_C_Honesty, ymax = C_Honesty + CI_C_Honesty), width = 0) + 
  scale_y_continuous(limits = c(32,91)) + 
  labs(title = "Civic Honesty",
       x = NULL,
       y = NULL) + 
  coord_flip() + 
  theme_bw(14) +
  theme(panel.grid.minor.y = element_blank(),
        panel.grid.major.y = element_blank())+ 
  theme(axis.text.x = element_blank(),
        axis.ticks = element_blank())+  
  theme(title=element_text(size=10), 
        axis.text=element_text(size=10)) + 
  scale_x_discrete(expand = expansion(mult=0.0, 0.3)) +
  expand_limits(x=8)+
  theme(plot.title = element_text(hjust = 0.4)) + 
  geom_text(aes(label=C_Honesty), vjust=-0.6, size = 3.2, color = "grey40")


ggsave("Civic Honesty.PNG", plot = honesty, height = 2, width = 8)



#Gender Equality
gender <-  ggplot(data = mydata, mapping = aes(x = group, y = G_Equality)) + 
  geom_point(size = 1.5) + 
  geom_errorbar(mapping = aes(ymin = G_Equality - CI_G_Equality, ymax = G_Equality + CI_G_Equality), width = 0) + 
  scale_y_continuous(limits = c(32,91)) + 
  labs(title = "Gender Equality",
       x = NULL,
       y = NULL) + 
  coord_flip() + 
  theme_bw(14) +
  theme(panel.grid.minor.y = element_blank(),
        panel.grid.major.y = element_blank()) + 
  theme(title=element_text(size=10), 
        axis.text=element_text(size=10)) + 
  scale_x_discrete(expand = expansion(mult=0.0, 0.3)) +
  expand_limits(x=8) +
  theme(plot.title = element_text(hjust = 0.4)) + 
  geom_text(aes(label=G_Equality), vjust=-0.6, size = 3.2, color = "grey40")


ggsave("Gender Equality.PNG", plot = gender, height = 2, width = 8)


#Liberal Democracy
democracy <-  ggplot(data = mydata, mapping = aes(x = group, y = L_Democracy)) + 
  geom_point(size = 1.5) + 
  geom_errorbar(mapping = aes(ymin = L_Democracy - CI_L_Democracy, ymax = L_Democracy + CI_L_Democracy), width = 0) + 
  scale_y_continuous(limits = c(32,91)) + 
  labs(title = "Liberal Democracy",
       x = NULL,
       y = NULL) + 
  coord_flip() + 
  theme_bw(14) +
  theme(panel.grid.minor.y = element_blank(),
        panel.grid.major.y = element_blank()) + 
  theme(title=element_text(size=10), 
        axis.text=element_text(size=10)) + 
  scale_x_discrete(expand = expansion(mult=0.0, 0.3)) +
  expand_limits(x=8) +
  theme(plot.title = element_text(hjust = 0.4)) + 
  geom_text(aes(label=L_Democracy), vjust=-0.6, size = 3.2, color = "grey40")


ggsave("Liberal Democracy.PNG", plot = democracy, height = 2, width = 8)


				


combined <- cowplot::plot_grid(EU_values, freedom, autonomy, tolerance, honesty, gender, democracy, nrow = 7)

ggsave("Combined plot.PNG", plot = combined , height = 12, width = 8)




combined2 <- cowplot::plot_grid(freedom, autonomy, tolerance, honesty, gender, democracy, nrow = 3, rel_heights = c(0.32, 0.32, 0.36))

ggsave("Combined plot2.PNG", plot = combined2 , height = 5, width = 8)


combined3 <- cowplot::plot_grid(EU_values, combined2, nrow = 2, rel_heights = c(0.25, 0.75))
ggsave("Combined plot3.PNG", plot = combined3 , height = 10, width = 8)









#############################################################################################
################################# UKRAINE BY GENERATIONS ####################################

mydata_gen <- read_excel("YOUR WORKING DIRECTORY/Countries by generation.xlsx")


mydata_gen$group <- factor(mydata_gen$group, c("Old EU-members",
                                               "New EU-members",
                                               "Ukraine",
                                               "Russia"))                                         





EU_values_g <- ggplot(data = mydata_gen, mapping = aes(x = group, y = EU_Values, color = Generation)) + 
  geom_point(size = 1.5) + 
  geom_errorbar(mapping = aes(ymin = EU_Values - CI_EU_Values, ymax = EU_Values + CI_EU_Values), width = 0) + 
  scale_y_continuous(limits = c(52,77)) + 
  labs(title = "EU-values",
       x = NULL,
       y = NULL) +
  coord_flip() + 
  theme_bw(14) +
  theme(panel.grid.minor.y = element_blank(),
        panel.grid.major.y = element_blank()) + 
  theme(axis.text.x = element_blank(),
        axis.ticks = element_blank()) + 
  theme(title=element_text(size=12), 
        axis.text=element_text(size=12)) +
  theme(plot.title = element_text(hjust = 0.4))  + 
  geom_text_repel(aes(label=EU_Values), vjust=-0.6, size = 3.2, color = "grey40")


ggsave("EU-Values_g.PNG", plot = EU_values_g , height = 2, width = 8)




freedom_g <-  ggplot(data = mydata_gen, mapping = aes(x = group, y = P_Freedom, color = Generation)) + 
  geom_point(size = 1.5) + 
  geom_errorbar(mapping = aes(ymin = P_Freedom - CI_P_Freedom, ymax = P_Freedom + CI_P_Freedom), width = 0) + 
  scale_y_continuous(limits = c(32,92)) + 
  labs(title = "Personal Freedom",
       x = NULL,
       y = NULL) + 
  coord_flip() + 
  theme_bw(14) +
  theme(panel.grid.minor.y = element_blank(),
        panel.grid.major.y = element_blank()) + 
  theme(axis.text.x = element_blank(),
        axis.ticks = element_blank())+ 
  theme(title=element_text(size=10)) +
  theme(plot.title = element_text(hjust = 0.4)) +  
  theme(legend.position = "none")  + 
  geom_text_repel(aes(label=P_Freedom), vjust=-0.6, size = 3.2, color = "grey40")


ggsave("Personal Freedom_g.PNG", plot = freedom_g , height = 2, width = 8)


#Individual Autonomy
autonomy_g <-  ggplot(data = mydata_gen, mapping = aes(x = group, y = I_Autonomy, color = Generation)) + 
  geom_point(size = 1.5) + 
  geom_errorbar(mapping = aes(ymin = I_Autonomy - CI_I_Autonomy, ymax = I_Autonomy + CI_I_Autonomy), width = 0) + 
  scale_y_continuous(limits = c(32,92)) + 
  labs(title = "Individual Autonomy",
       x = NULL,
       y = NULL) + 
  coord_flip() + 
  theme_bw(14) +
  theme(panel.grid.minor.y = element_blank(),
        panel.grid.major.y = element_blank())+ 
  theme(axis.text.x = element_blank(),
        axis.ticks = element_blank())+ 
  theme(title=element_text(size=10)) +
  theme(plot.title = element_text(hjust = 0.4)) +  
  theme(legend.position = "none")  + 
  geom_text_repel(aes(label=I_Autonomy), vjust=-0.6, size = 3.2, color = "grey40")


ggsave("Individual Autonomy_g.PNG", plot = autonomy_g , height = 2, width = 8)



#Ethnic Tolerance
tolerance_g <-  ggplot(data = mydata_gen, mapping = aes(x = group, y = E_Tolerance, color = Generation)) + 
  geom_point(size = 1.5) + 
  geom_errorbar(mapping = aes(ymin = E_Tolerance - CI_E_Tolerance, ymax = E_Tolerance + CI_E_Tolerance), width = 0) + 
  scale_y_continuous(limits = c(32,92)) + 
  labs(title = "Ethnic Tolerance",
       x = NULL,
       y = NULL) + 
  coord_flip() + 
  theme_bw(14) +
  theme(panel.grid.minor.y = element_blank(),
        panel.grid.major.y = element_blank())+ 
  theme(axis.text.x = element_blank(),
        axis.ticks = element_blank())+ 
  theme(title=element_text(size=10)) +
  theme(plot.title = element_text(hjust = 0.4)) +  
  theme(legend.position = "none")  + 
  geom_text_repel(aes(label=E_Tolerance), vjust=-0.6, size = 3.2, color = "grey40")


ggsave("Ethnic Tolerance_g.PNG", plot = tolerance_g , height = 2, width = 8)


#Civic Honesty
honesty_g <-  ggplot(data = mydata_gen, mapping = aes(x = group, y = C_Honesty, color = Generation)) + 
  geom_point(size = 1.5) + 
  geom_errorbar(mapping = aes(ymin = C_Honesty - CI_C_Honesty, ymax = C_Honesty + CI_C_Honesty), width = 0) + 
  scale_y_continuous(limits = c(32,92)) + 
  labs(title = "Civic Honesty",
       x = NULL,
       y = NULL) + 
  coord_flip() + 
  theme_bw(14) +
  theme(panel.grid.minor.y = element_blank(),
        panel.grid.major.y = element_blank())+ 
  theme(axis.text.x = element_blank(),
        axis.ticks = element_blank())+  
  theme(title=element_text(size=10)) +
  theme(plot.title = element_text(hjust = 0.4)) +  
  theme(legend.position = "none") + 
  geom_text_repel(aes(label=C_Honesty), vjust=-0.6, size = 3.2, color = "grey40")


ggsave("Civic Honesty_g.PNG", plot = honesty_g, height = 2, width = 8) 



#Gender Equality
gender_g <-  ggplot(data = mydata_gen, mapping = aes(x = group, y = G_Equality, color = Generation)) + 
  geom_point(size = 1.5) + 
  geom_errorbar(mapping = aes(ymin = G_Equality - CI_G_Equality, ymax = G_Equality + CI_G_Equality), width = 0) + 
  scale_y_continuous(limits = c(32,92)) + 
  labs(title = "Gender Equality",
       x = NULL,
       y = NULL) + 
  coord_flip() + 
  theme_bw(14) +
  theme(panel.grid.minor.y = element_blank(),
        panel.grid.major.y = element_blank())+ 
  theme(title=element_text(size=10)) +
  theme(plot.title = element_text(hjust = 0.4)) +  
  theme(legend.position = "none") + 
  geom_text_repel(aes(label=G_Equality), vjust=-0.6, size = 3.2, color = "grey40")



ggsave("Gender Equality_g.PNG", plot = gender_g, height = 2, width = 8)


#Liberal Democracy
democracy_g <-  ggplot(data = mydata_gen, mapping = aes(x = group, y = L_Democracy, color = Generation)) + 
  geom_point(size = 1.5) + 
  geom_errorbar(mapping = aes(ymin = L_Democracy - CI_L_Democracy, ymax = L_Democracy + CI_L_Democracy), width = 0) + 
  scale_y_continuous(limits = c(32,92)) + 
  labs(title = "Liberal Democracy",
       x = NULL,
       y = NULL) + 
  coord_flip() + 
  theme_bw(14) +
  theme(panel.grid.minor.y = element_blank(),
        panel.grid.major.y = element_blank())+ 
  theme(title=element_text(size=10)) +
  theme(plot.title = element_text(hjust = 0.4)) +  
  theme(legend.position = "none") + 
  geom_text_repel(aes(label=L_Democracy), vjust=-0.6, size = 3.2, color = "grey40")


ggsave("Liberal Democracy_g.PNG", plot = democracy_g, height = 2, width = 8)





generations_combined  <- cowplot::plot_grid(EU_values_g, freedom_g, autonomy_g, tolerance_g, honesty_g, gender_g, democracy_g, nrow = 7)

ggsave("Combined generations plot.PNG", plot = generations_combined , height = 10, width = 8)





generations_combined2 <- cowplot::plot_grid(freedom_g, autonomy_g, tolerance_g, honesty_g, gender_g, democracy_g, nrow = 3, rel_heights = c(0.32, 0.32, 0.36))

ggsave("Generations Combined plot2.PNG", plot = generations_combined2 , height = 5, width = 8)


generations_combined3 <- cowplot::plot_grid(EU_values_g, generations_combined2, nrow = 2, rel_heights = c(0.25, 0.75))
ggsave("Generations Combined plot3.PNG", plot = generations_combined3 , height = 8, width = 8)










##########################################################################################
########################################## MDS ###########################################
                        # all countries, split Ukraine # 


myMDS1 <- read_excel("YOUR WORKING DIRECTORY/MDS1.xls")



p <- ggplot(data = myMDS1, mapping = aes(x = d1, y = d2))

MDS1 <- p + geom_point(aes(size = population_c4)) + 
  geom_text_repel(aes(label=country2), vjust=-1, size = 2.5, box.padding = 0.33, nudge_y = 0.5) + 
  scale_y_continuous(limits = c(-30, 27), expand = c(0.00, 0.0), labels = NULL) +
  scale_x_continuous(limits = c(-60, 47), expand = c(0.00, 0.0), labels = NULL) + 
  labs(x = "Dimension 1", y = "Dimension 2", size=NULL) +
  guides(size = "none") + 
  theme(legend.title = element_text(size = 8),legend.text = element_text(size = 6)) + 
  theme_minimal_grid()


MDS1

ggsave("MDS1.png", plot = MDS1, height = 4.5, width = 8, dpi=600)



### same but with culture zones 
myMDS1$cult_zone <- factor(myMDS1$cult_zone, levels = c("Orthodox",
                                                "Western Post-Communist",
                                                "Western Catholic",
                                                "Western Protestant"))
myMDS1$cult_zone2 <- factor(myMDS1$cult_zone2, levels = c("Orthodox",
                                                        "Western Post-Communist",
                                                        "Western Catholic",
                                                        "Western Protestant"))

p2 <- ggplot(data = myMDS1, mapping = aes(x = d1, y = d2, color = cult_zone))

MDS2 <- p2 + geom_point(aes(size = population_c4, color = cult_zone)) + 
  geom_text_repel(aes(label=country2), vjust=-1, size = 2.5, box.padding = 0.33, nudge_y = 0.5) + 
  scale_y_continuous(limits = c(-30, 30), expand = c(0.00, 0.0), labels = NULL) +
  scale_x_continuous(limits = c(-60, 47), expand = c(0.00, 0.0), labels = NULL) + 
  labs(x = "Dimension 1", y = "Dimension 2", size=NULL, color = "Culture zone") + 
  theme_minimal_grid() + 
  geom_encircle(aes(group=cult_zone2, fill = cult_zone2), alpha=0.3, s_shape=0.45, expand=0.05) + 
  guides(size = "none", fill = "none") +
  theme(legend.title = element_text(size = 12),legend.text = element_text(size = 10)) + 
  theme(legend.position="bottom")


MDS2

ggsave("MDS2.png", plot = MDS2, height = 4.5, width = 8, dpi=600)







##################### MDS - NUTS1 - Russia, Ukraine, Poland and Germany ################

myMDSnuts <- read_excel("YOUR WORKING DIRECTORY/MDS2.xls")


myMDSnuts$country <- factor(myMDSnuts$country, levels = c("Russia", 
                                                          "Ukraine", 
                                                          "Poland", 
                                                          "Germany"))

nuts1 <- ggplot(data = myMDSnuts, mapping = aes(x = d1, y = d2, color = country))

MDS_nuts <- nuts1 + geom_point(aes(color = country)) + 
  geom_text_repel(aes(label=nuts1), vjust=-1, size = 2.5, box.padding = 0.33, nudge_y = 0.5) + 
  scale_y_continuous(limits = c(-30, 30), expand = c(0.00, 0.0), labels = NULL) +
  scale_x_continuous(limits = c(-60, 47), expand = c(0.00, 0.0), labels = NULL) + 
  labs(x = "Dimension 1", y = "Dimension 2", size=NULL, color = "Country") + 
  theme_minimal_grid() + 
  geom_encircle(aes(group=country, fill = country), alpha=0.3, s_shape=0.6, expand=0.02) + 
  guides(size = "none", fill = "none") +
  theme(legend.title = element_text(size = 12),legend.text = element_text(size = 10)) + 
  theme(legend.position="bottom")


MDS_nuts

ggsave("MDS nuts1.png", plot = MDS_nuts, height = 4.5, width = 8, dpi=600)


# end of R-script 
