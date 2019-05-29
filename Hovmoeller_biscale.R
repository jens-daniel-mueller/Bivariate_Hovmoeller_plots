# Required Packages -------------------------------------------------------

library(tidyverse)
library(biscale)
library(cowplot)


# Read gridded Finnmaid data 2016 -----------------------------------------

df <- read_csv("Data/Finnmaid_2016_Hovmoeller.csv")


# Plot Hovmoeller diagrams for pCO2 and Temperature -----------------------

df %>% 
  ggplot(aes(week_date, dist_TRA_int, fill=pCO2))+
  geom_raster()+
  scale_fill_viridis_c()+
  theme_bw()+
  scale_y_continuous(expand = c(0,0))+
  scale_x_datetime(expand = c(0,0))

ggsave("Plots/Hovmoeller_pCO2.jpg", width = 5, height = 3)

df %>% 
  ggplot(aes(week_date, dist_TRA_int, fill=Tem))+
  geom_raster()+
  scale_fill_viridis_c(option = "B")+
  theme_bw()+
  scale_y_continuous(expand = c(0,0))+
  scale_x_datetime(expand = c(0,0))

ggsave("Plots/Hovmoeller_Tem.jpg", width = 5, height = 3)



# Create classes for bivariate plot ---------------------------------------

df <- df %>% 
  bi_class(pCO2, Tem)



# Plot with bivariate color scale -----------------------------------------

df %>% 
  ggplot(aes(Tem, pCO2, col=bi_class))+
  geom_point()+
  theme_bw()

ggsave("Plots/bi_classes.jpg", width = 7, height = 5)


legend <- bi_legend("DkBlue", dim=3, "pCO2", "Tem")

Hov <- df %>% 
  ggplot(aes(week_date, dist_TRA_int, fill=bi_class))+
  geom_raster(show.legend = FALSE)+
  bi_scale_fill("DkBlue", dim = 3)+
  theme_bw()+
  scale_y_continuous(expand = c(0,0))+
  scale_x_datetime(expand = c(0,0))

finalPlot <- ggdraw() +
  draw_plot(Hov, 0, 0, .65, 1) +
  draw_plot(legend, .6, .4, .35, .35)

finalPlot

ggsave("Plots/Hovmoeller_bivariate_color.jpg", width = 7, height = 3)




# Available 3x3 color palettes --------------------------------------------

bi_pal(pal = "Brown", dim = 3)
bi_pal(pal = "DkBlue", dim = 3)
bi_pal(pal = "DkCyan", dim = 3)
bi_pal(pal = "DkViolet", dim = 3)
bi_pal(pal = "GrPink", dim = 3)




