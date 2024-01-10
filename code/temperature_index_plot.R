#####All of this code and inspiration for. my notes comes from this video####
#https://www.youtube.com/watch?v=fskblEWSeWU&list=PLmNrK_nkqBpJTSHf3IsN_K_pjFu58z9Oq&index=3

library(tidyverse)

#### First read in the data ####
read_csv("data/GLB.Ts+dSST.csv", skip = 1, na = "***") 
#skip=1 skips the first line in the data set which in our case is headers
#na = "***" tells the program to read any ***'s in the file as NAs


####Let's make a more complicated version of that code####
##I want the annual average so I'm going to select the column with the J-D average
read_csv("data/GLB.Ts+dSST.csv", skip = 1, na = "***")  %>%
  select(year = Year, t_diff = 'J-D') #I'm also renaming the columns


####Now let's generate a simple ggplot####
read_csv("data/GLB.Ts+dSST.csv", skip = 1, na = "***")  %>%
  select(year = Year, t_diff = 'J-D') %>%
  ggplot(aes(x=year, y=t_diff))+
    geom_line()

####Now let's add the points####
#I want a white fill and a gray background and I want the line to be gray#
read_csv("data/GLB.Ts+dSST.csv", skip = 1, na = "***")  %>%
  select(year = Year, t_diff = 'J-D') %>%
  ggplot(aes(x=year, y=t_diff))+
  geom_line(color = "gray")+
  geom_point(fill = "white", color = "gray", shape = 21)
#shape 21 changes the plotting symbol to allow multicolored dots.

####Let's edit the theme####
#I want the white background with the gray grid lines#
read_csv("data/GLB.Ts+dSST.csv", skip = 1, na = "***")  %>%
  select(year = Year, t_diff = 'J-D') %>%
  ggplot(aes(x=year, y=t_diff))+
  geom_line(color = "gray")+
  geom_point(fill = "white", color = "gray", shape = 21) +
  theme_light()

####Now I also want a smoothing line that sort of fits it all####
read_csv("data/GLB.Ts+dSST.csv", skip = 1, na = "***")  %>%
  select(year = Year, t_diff = 'J-D') %>%
  ggplot(aes(x=year, y=t_diff))+
  geom_line(color = "gray")+
  geom_point(fill = "white", color = "gray", shape = 21) +
  geom_smooth()+
  theme_light()

####Let's mess with the smooth line aesthetic####
##I notice the line has a "cloud" around it and it's blue and thicker than the 
#background line and it's not quite as wiggly as our reference figure
read_csv("data/GLB.Ts+dSST.csv", skip = 1, na = "***")  %>%
  select(year = Year, t_diff = 'J-D') %>%
  ggplot(aes(x=year, y=t_diff))+
  geom_line(color = "gray", size = 0.5)+
  geom_point(fill = "white", color = "gray", shape = 21) +
  geom_smooth(se = FALSE, color = "black", size = 0.5, span = 0.25)+
  theme_light()
#se = false get's rid of that cloud
# color = black oobviously changes the color
#and then I change the size of both lines to 0.5
#argument span changes the "wigglyness" of the smoothing line. 
#0.75 is default for span
#I'm going to try and make it even wigglier
read_csv("data/GLB.Ts+dSST.csv", skip = 1, na = "***")  %>%
  select(year = Year, t_diff = 'J-D') %>%
  ggplot(aes(x=year, y=t_diff))+
  geom_line(color = "gray", size = 0.5)+
  geom_point(fill = "white", color = "gray", shape = 21) +
  geom_smooth(se = FALSE, color = "black", size = 0.5, span = 0.15)+
  theme_light()


####Let's output the file####
#so we can get a better understanding of the dimensions of the figure we want
ggsave("figures/temperature_index_plot.png", width = 6, height = 4)

####Now we're going to tackle the axis#####
#we can do that with scale_x_continuous
read_csv("data/GLB.Ts+dSST.csv", skip = 1, na = "***")  %>%
  select(year = Year, t_diff = 'J-D') %>%
  ggplot(aes(x=year, y=t_diff))+
  geom_line(color = "gray", size = 0.5)+
  geom_point(fill = "white", color = "gray", shape = 21) +
  geom_smooth(se = FALSE, color = "black", size = 0.5, span = 0.15)+
  scale_x_continuous(breaks = seq(1880, 2023, 20)) +
  scale_y_continuous(limits=c(-0.5,1.5)) +
  theme_light()
#using scale_x_continuous i add the years I want shown in by 20 year increments
#using scale_y_continuous i add the limits which I want to show

####Now let's get rid of that negative space around the graph####
#Use an argument called expand
read_csv("data/GLB.Ts+dSST.csv", skip = 1, na = "***")  %>%
  select(year = Year, t_diff = 'J-D') %>%
  ggplot(aes(x=year, y=t_diff))+
  geom_line(color = "gray", size = 0.5)+
  geom_point(fill = "white", color = "gray", shape = 21) +
  geom_smooth(se = FALSE, color = "black", size = 0.5, span = 0.15)+
  scale_x_continuous(breaks = seq(1880, 2023, 20), expand = c(0,0)) +
  scale_y_continuous(limits=c(-0.5,1.5), expand = c(0,0)) +
  theme_light()
#Now the values on the axis are right to the edge.

####I want to remove the tick marks####
read_csv("data/GLB.Ts+dSST.csv", skip = 1, na = "***")  %>%
  select(year = Year, t_diff = 'J-D') %>%
  ggplot(aes(x=year, y=t_diff))+
  geom_line(color = "gray", size = 0.5)+
  geom_point(fill = "white", color = "gray", shape = 21) +
  geom_smooth(se = FALSE, color = "black", size = 0.5, span = 0.15)+
  scale_x_continuous(breaks = seq(1880, 2023, 20), expand = c(0,0)) +
  scale_y_continuous(limits=c(-0.5,1.5), expand = c(0,0)) +
  theme_light()+
  theme(
    axis.ticks = element_blank()
  )


####Time to modify our labels!####
#Use labs
#the \n that i insert in the middle of the subtitle line induces a line break
read_csv("data/GLB.Ts+dSST.csv", skip = 1, na = "***")  %>%
  select(year = Year, t_diff = 'J-D') %>%
  ggplot(aes(x=year, y=t_diff))+
  geom_line(color = "gray", size = 0.5)+
  geom_point(fill = "white", color = "gray", shape = 21) +
  geom_smooth(se = FALSE, color = "black", size = 0.5, span = 0.15)+
  scale_x_continuous(breaks = seq(1880, 2023, 20), expand = c(0,0)) +
  scale_y_continuous(limits=c(-0.5,1.5), expand = c(0,0)) +
  labs(
    x = "YEAR",
    y = "Temperature anomaly (C)",
    title = "GLOBAL LAND-OCEAN TEMPERATURE INDEX",
    subtitle = "Data source: NASA's Goddard Insitute for Space Studies (GISS).\nCredit: NASA/GISS"
  )+
  theme_light()+
  theme(
    axis.ticks = element_blank()
  )

####I really want to make a few more changes to look like the reference plot####
read_csv("data/GLB.Ts+dSST.csv", skip = 1, na = "***")  %>%
  select(year = Year, t_diff = 'J-D') %>%
  ggplot(aes(x=year, y=t_diff))+
  geom_line(color = "gray", size = 0.5)+
  geom_point(fill = "white", color = "gray", shape = 21) +
  geom_smooth(se = FALSE, color = "black", size = 0.5, span = 0.15)+
  scale_x_continuous(breaks = seq(1880, 2023, 20), expand = c(0,0)) +
  scale_y_continuous(limits=c(-0.5,1.5), expand = c(0,0)) +
  labs(
    x = "YEAR",
    y = "Temperature anomaly (C)",
    title = "GLOBAL LAND-OCEAN TEMPERATURE INDEX",
    subtitle = "Data source: NASA's Goddard Insitute for Space Studies (GISS).\nCredit: NASA/GISS"
  )+
  theme_light()+
  theme(
    axis.ticks = element_blank(),
    plot.title.position = "plot",
    plot.title = element_text(margin = margin(b=15), color="red", face="bold"),
    plot.subtitle = element_text(size=8)
  )
# plot.title.position = "plot", brings everything to the left

####Make margin smaller and add margin for subtitle####
read_csv("data/GLB.Ts+dSST.csv", skip = 1, na = "***")  %>%
  select(year = Year, t_diff = 'J-D') %>%
  ggplot(aes(x=year, y=t_diff))+
  geom_line(color = "gray", size = 0.5)+
  geom_point(fill = "white", color = "gray", shape = 21) +
  geom_smooth(se = FALSE, color = "black", size = 0.5, span = 0.15)+
  scale_x_continuous(breaks = seq(1880, 2023, 20), expand = c(0,0)) +
  scale_y_continuous(limits=c(-0.5,1.5), expand = c(0,0)) +
  labs(
    x = "YEAR",
    y = "Temperature anomaly (C)",
    title = "GLOBAL LAND-OCEAN TEMPERATURE INDEX",
    subtitle = "Data source: NASA's Goddard Insitute for Space Studies (GISS).\nCredit: NASA/GISS"
  )+
  theme_light()+
  theme(
    axis.ticks = element_blank(),
    plot.title.position = "plot",
    plot.title = element_text(margin = margin(b=10), color="red", face="bold"),
    plot.subtitle = element_text(size=8, margin = margin(b=10))
  )  
#the b in margin indicates we refer to the bottom margin.

####Now let's work on tackling that legend####
#first I will go ahead and give the colors theme numbers
read_csv("data/GLB.Ts+dSST.csv", skip = 1, na = "***")  %>%
  select(year = Year, t_diff = 'J-D') %>%
  ggplot(aes(x=year, y=t_diff))+
  geom_line(aes(color = "1"), size = 0.5)+
  geom_point(fill = "white", aes(color = "1"), shape = 21) +
  geom_smooth(se = FALSE, aes(color = "2"), size = 0.5, span = 0.15)+
  scale_x_continuous(breaks = seq(1880, 2023, 20), expand = c(0,0)) +
  scale_y_continuous(limits=c(-0.5,1.5), expand = c(0,0)) +
  labs(
    x = "YEAR",
    y = "Temperature anomaly (C)",
    title = "GLOBAL LAND-OCEAN TEMPERATURE INDEX",
    subtitle = "Data source: NASA's Goddard Insitute for Space Studies (GISS).\nCredit: NASA/GISS"
  )+
  theme_light()+
  theme(
    axis.ticks = element_blank(),
    plot.title.position = "plot",
    plot.title = element_text(margin = margin(b=10), color="red", face="bold"),
    plot.subtitle = element_text(size=8, margin = margin(b=10))
  )  
#but this makes it salmon and teal and the legend is not where I want it.
#we need to change the color of the legen and move it

####Adjusting legend#####
read_csv("data/GLB.Ts+dSST.csv", skip = 1, na = "***")  %>%
  select(year = Year, t_diff = 'J-D') %>%
  ggplot(aes(x=year, y=t_diff))+
  geom_line(aes(color = "1"), size = 0.5)+
  geom_point(fill = "white", aes(color = "1"), shape = 21) +
  geom_smooth(se = FALSE, aes(color = "2"), size = 0.5, span = 0.15)+
  scale_x_continuous(breaks = seq(1880, 2023, 20), expand = c(0,0)) +
  scale_y_continuous(limits=c(-0.5,1.5), expand = c(0,0)) +
  scale_color_manual(name = NULL, 
                     breaks = c(1,2),
                     values=c("gray", "black"),
                     labels=c("Annual mean", "Lowess smoothing"))+
  labs(
    x = "YEAR",
    y = "Temperature anomaly (C)",
    title = "GLOBAL LAND-OCEAN TEMPERATURE INDEX",
    subtitle = "Data source: NASA's Goddard Insitute for Space Studies (GISS).\nCredit: NASA/GISS"
  )+
  theme_light()+
  theme(
    axis.ticks = element_blank(),
    plot.title.position = "plot",
    plot.title = element_text(margin = margin(b=10), color="red", face="bold"),
    plot.subtitle = element_text(size=8, margin = margin(b=10))
  )  
#So now I fixed the colors


####Move the legend and change the circle####
read_csv("data/GLB.Ts+dSST.csv", skip = 1, na = "***")  %>%
  select(year = Year, t_diff = 'J-D') %>%
  ggplot(aes(x=year, y=t_diff))+
  geom_line(aes(color = "1"), size = 0.5)+
  geom_point(fill = "white", aes(color = "1"), shape = 21, show.legend = FALSE) +
  geom_smooth(se = FALSE, aes(color = "2"), size = 0.5, span = 0.15)+
  scale_x_continuous(breaks = seq(1880, 2023, 20), expand = c(0,0)) +
  scale_y_continuous(limits=c(-0.5,1.5), expand = c(0,0)) +
  scale_color_manual(name = NULL, 
                     breaks = c(1,2),
                     values=c("gray", "black"),
                     labels=c("Annual mean", "Lowess smoothing"))+
  labs(
    x = "YEAR",
    y = "Temperature anomaly (C)",
    title = "GLOBAL LAND-OCEAN TEMPERATURE INDEX",
    subtitle = "Data source: NASA's Goddard Insitute for Space Studies (GISS).\nCredit: NASA/GISS"
  )+
  theme_light()+
  theme(
    axis.ticks = element_blank(),
    plot.title.position = "plot",
    plot.title = element_text(margin = margin(b=10), color="red", face="bold"),
    plot.subtitle = element_text(size=8, margin = margin(b=10)),
    legend.position = c(0.2, 0.9)
  )  
#show.legend = FALSE removes the circle from the legen in geom_point
#then we use legend.position in theme to give R a vector to tell it where.
#this vector is the relative position on the x and y axes.

####Troubleshoot Legend Position####
#We would change the vector values but I'lll just put in the final ones that work
#There is also extra space above the legend
#That is because we set the title of the legend to NULL but R holds space.
#The hack is to make the font size of the legend title 0
read_csv("data/GLB.Ts+dSST.csv", skip = 1, na = "***")  %>%
  select(year = Year, t_diff = 'J-D') %>%
  ggplot(aes(x=year, y=t_diff))+
  geom_line(aes(color = "1"), size = 0.5)+
  geom_point(fill = "white", aes(color = "1"), shape = 21, show.legend = FALSE) +
  geom_smooth(se = FALSE, aes(color = "2"), size = 0.5, span = 0.15)+
  scale_x_continuous(breaks = seq(1880, 2023, 20), expand = c(0,0)) +
  scale_y_continuous(limits=c(-0.5,1.5), expand = c(0,0)) +
  scale_color_manual(name = NULL, 
                     breaks = c(1,2),
                     values=c("gray", "black"),
                     labels=c("Annual mean", "Lowess smoothing"))+
  labs(
    x = "YEAR",
    y = "Temperature anomaly (C)",
    title = "GLOBAL LAND-OCEAN TEMPERATURE INDEX",
    subtitle = "Data source: NASA's Goddard Insitute for Space Studies (GISS).\nCredit: NASA/GISS"
  )+
  theme_light()+
  theme(
    axis.ticks = element_blank(),
    plot.title.position = "plot",
    plot.title = element_text(margin = margin(b=10), color="red", face="bold"),
    plot.subtitle = element_text(size=8, margin = margin(b=10)),
    legend.position = c(0.2, 0.9),
    legend.title = element_text(size=0),
    legend.key.height = unit(10, "pt"),
    legend.margin = margin(0,0,0,0)
  )  
#legend key height smooshes things together as well. I'm not exactly sure how
#legend margin set everything to 0 to remove those margins


####The last thing ot do is give the legend squares over lines####
#Remember there are three geoms we're plotting: line, pint, and smooth
#The easiest way to get the square is to turn off the legend for the line
#and the smoothed line and to turn back of the geom point
#then override what point is shown in the legend
read_csv("data/GLB.Ts+dSST.csv", skip = 1, na = "***")  %>%
  select(year = Year, t_diff = 'J-D') %>%
  ggplot(aes(x=year, y=t_diff))+
  geom_line(aes(color = "1"), size = 0.5, show.legend = FALSE)+
  geom_point(fill = "white", aes(color = "1"), shape = 21, show.legend = TRUE) +
  geom_smooth(se = FALSE, aes(color = "2"), size = 0.5, span = 0.15,show.legend = FALSE)+
  scale_x_continuous(breaks = seq(1880, 2023, 20), expand = c(0,0)) +
  scale_y_continuous(limits=c(-0.5,1.5), expand = c(0,0)) +
  scale_color_manual(name = NULL, 
                     breaks = c(1,2),
                     values=c("gray", "black"),
                     labels=c("Annual mean", "Lowess smoothing"),
                     guide = guide_legend(override.aes = list(shape=15, size=5)))+
  labs(
    x = "YEAR",
    y = "Temperature anomaly (C)",
    title = "GLOBAL LAND-OCEAN TEMPERATURE INDEX",
    subtitle = "Data source: NASA's Goddard Insitute for Space Studies (GISS).\nCredit: NASA/GISS"
  )+
  theme_light()+
  theme(
    axis.ticks = element_blank(),
    plot.title.position = "plot",
    plot.title = element_text(margin = margin(b=10), color="red", face="bold"),
    plot.subtitle = element_text(size=8, margin = margin(b=10)),
    legend.position = c(0.2, 0.9),
    legend.title = element_text(size=0),
    legend.key.height = unit(10, "pt"),
    legend.margin = margin(0,0,0,0)
  )  
##guide = guide_legend(override.aes = list(shape=15, size =5)) says take the guide legend and
#override the shape factor and put a square (15) and size indicates how big ot make it

