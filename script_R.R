#libraries required for basic bar graph
library(ggplot2)
library(devtools)
library(dplyr)

#read csv function for reading the file from internet, usb or local drive
guidelines <- read.csv("/EarthWorks/Wastewater Guidelines_columned.csv", header=TRUE)

#this the variable for the data file I am using. Typing the name will display the contents of the file
guidelines

#a good practive to summarize your data. I learned this from video tutorials of data science gurus
summary(guidelines)

#ggplot function (your_data, aes(x parameter, y parameter))
ggplot(guidelines, aes(Influent, Parameter))+
  
  #geom_bar(stat, fill and width of the bar) --- [this is the bar plot based on the x and y defined above]
  geom_bar(stat="identity", fill="Grey60", width = 0.25)+
  
  #geom_bar(your parameter of choice, stat, fill and width of the bar)
  geom_bar(aes(Effluent),stat="identity", fill="blue", width = 0.25)+
  
  #geom_errorbar(your parameter of choice(x, ymin, ymax), width, color and size) --- [very cool! adds a line at the end of your bar] 
  geom_errorbar(aes(x=Effluent, ymin=Parameter, ymax=Parameter),width=1.5, color="green",size=15)+
  
  #geom_point(aesthetics, color, fill, size, shape{number 25 for the upside down triangle}, nudge to find the spot)
  geom_point(aes(Guideline),color="orange", fill="orange", size=1.5, shape=25, position = position_nudge(y=-0.083))+
  
  #geom_text to get the values for the parameters on the panel
  geom_text(data=guidelines, aes(label=Influent, x=Influent), stat="identity", position=position_dodge(width=0.9),size=4,hjust=-0.2,color="Grey60",fontface='bold')+
  geom_text(data=guidelines, aes(label=Effluent, x=Effluent), stat="identity", position=position_dodge(width=0.9), size=3.5, hjust=0.6,vjust=-3., color="blue")+
  
  #I used geom_label here to make the numbers stand out from the grid background {parse for bold fonts did not return bold fonts???}
  geom_label(data=guidelines, aes(label=Guideline, x=Guideline), stat="identity", position=position_dodge(width=0.9), parse = TRUE, size=3.6, hjust=0.4,vjust=2.5, color="orange")+
  
  #I use this function to modify headers for the x and y axis (saves the hassle of adding extra lines) 
  scale_x_continuous("Concentration (mg/L)")+
  #use continuous if your y axis is also numerical 
  scale_y_discrete("Parameters")+

  #here you can change the theme
  theme(
    axis.text= element_text(color = 'black',family='serif'),
    panel.background = element_line(color = "grey95")
  )+
  
  theme_light(base_rect_size = 0, base_size = 16)


