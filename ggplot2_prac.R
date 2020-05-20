library(tidyverse)
library(ggplot2)
attach(ggplot2::mpg)

ggplot(mpg,mapping=aes(x=displ,y=hwy,color=displ<5))+
  geom_point()

#to split plots into subplots
#based on one variable - facet_wrap()
ggplot(mpg)+
  geom_point(mapping=aes(x=displ, y=hwy))+
  facet_wrap(~class,ncol=2)

#Facet_grip when multiple variables
ggplot(mpg)+
  geom_point(mapping=aes(x=displ, y=hwy))+
  facet_grid(drv~cyl)
ggplot(mpg)+
  geom_point(mapping=aes(x=displ,y=hwy,color=class))+
  geom_smooth(mapping=aes(x=displ, y=hwy,linetype=drv))+
  facet_grid(drv~.)

ggplot(mpg)+
  geom_point(mapping=aes(x=displ,y=hwy,color=class))+
  geom_smooth(aes(x=displ,y=hwy))

ggplot(mpg)+
  geom_point(mapping=aes(x=displ,y=hwy,color=class))+
  geom_smooth(aes(x=displ,y=hwy),se=FALSE)

attach(ggplot2::diamonds)
ggplot(diamonds)+
  geom_bar(mapping=aes(x=cut))
ggplot(diamonds)+
  geom_bar(mapping=aes(x=cut, y=stat(prop),group=1))

ggplot(diamonds)+
  geom_bar(aes(x=cut,fill=clarity),show.legend=FALSE)

ggplot(diamonds)+
  geom_bar(aes(x=cut,fill=clarity),position='fill',show.legend=FALSE)
#column chart
ggplot(diamonds)+
  geom_bar(aes(x=cut,fill=clarity),position='dodge',show.legend=FALSE)
ggplot(mpg)+
  geom_boxplot(aes(class,hwy,color=drv))
