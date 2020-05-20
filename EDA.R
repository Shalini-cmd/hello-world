#EDA Practice
ggplot(diamonds)+
  geom_histogram(aes(x=x),binwidth = 0.01)+
 coord_cartesian(xlim=c(2,10))
outliers_x <- diamonds%>%
  filter(x>9)

ggplot(diamonds)+
  geom_histogram(aes(x=y),binwidth = 0.3)+
  coord_cartesian(xlim=c(0,10)) #more common


ggplot(diamonds)+
  geom_histogram(aes(x=z),binwidth = 0.3)+
  coord_cartesian(xlim=c(0,10)) 

ggplot(diamonds)+
  geom_histogram(aes(x=price),binwidth = 10)
  
ggplot(diamonds)+
  geom_histogram(aes(x=price),binwidth = 10)+
  coord_cartesian(xlim=c(12000,20000))

diamonds%>%
  filter(price==max(price))%>%
  select(cut,x,y,z,price)


diamonds%>%
  filter(price>12000)%>%
  select(cut,x,y,z,price)

diamonds%>%
  group_by(cut)%>%
  summarize(avg_price=mean(price),
            avg_price2=mean(price<12000))%>%
  select(cut,avg_price,avg_price2)

diamonds%>%
  filter(carat==0.99)%>%
  count()
#23 diamonds with 0.99 carat

diamonds%>%
  filter(carat==1)%>%
  count()
# 1558 diamonds
diamonds%>%
  filter(carat==1)%>%
  group_by(cut,carat)%>%
  summarize(sum(price)/n())
lm(AverageCost ~ Output + I(Output^2))

diamonds%>%
  filter(carat==0.99)%>%
  group_by(cut,carat)%>%
  summarize(sum(price)/n())

ggplot(diamonds)+
  geom_histogram(aes(x=price))#,binwidth = 10) #chooses a binwidth by default

ggplot(diamonds)+
  geom_histogram(aes(x=price),binwidth = 10)+
  coord_cartesian(xlim=(c(0,2200)),ylim=(c(0,111)))

library(tidyverse)
diamonds%>%
  mutate(y=ifelse(y<3|y>20,NA,y))%>%
  ggplot(aes(x=x,y=y))+
  geom_point(na.rm=TRUE)

nycflights13::flights%>%
  mutate(cancelled=is.na(dep_delay),
         sched_hour=sched_dep_time%/%60,
         sched_min=sched_dep_time %% 60,
         sched_time=sched_hour+sched_min)%>%
  ggplot(aes(x=sched_time))+
   geom_bar(
     mapping=aes(color=cancelled)
   )

#how the price of diamonds vary with its quality
ggplot(data=diamonds,mapping=aes(x=price))+
  geom_freqpoly(mapping=aes(color=cut),binwidth=500)

ggplot(data=diamonds,mapping=aes(x=price,y=..density..))+
  geom_freqpoly(mapping=aes(color=cut),binwidth=500)
#area under each frequncy polygon becomes 1 on using density instead of count

ggplot(data=diamonds,mapping=aes(x=cut))+
  geom_bar(aes(fill=cut))

#A visual shorthand for distribution
ggplot(data=diamonds,mapping=aes(x=price))+
  geom_freqpoly(mapping=aes(color=cut),binwidth=500)

ggplot(data=diamonds,aes(x=cut,y=price))+
  geom_boxplot()

nycflights13::flights%>%
  mutate(cancelled=is.na(dep_delay),
         sched_hour=sched_dep_time%/%60,
         sched_min=sched_dep_time %% 60,
         sched_time=sched_hour+sched_min)%>%
  ggplot(aes(x=cancelled,y=sched_time))+
  geom_boxplot()

ggplot(data=diamonds,aes(x=carat))+
  geom_histogram(aes(fill=cut))
 # coord_flip()

install.packages('lvplot')
library(lvplot)

ggplot(data=diamonds,aes(x=cut,y=price))+
  geom_lv()

ggplot(data=diamonds,aes(x=price))+
  geom_histogram(binwidth = 100)+
  facet_wrap(~cut)
ggplot(data=diamonds,aes(x=cut,y=price))+
  geom_violin()

ggplot(diamonds)+
  geom_count(mapping=aes(x=color,y=cut))

diamonds%>%
  count(color,cut)%>%
  ggplot(aes(x=color, y=cut))+
  geom_tile(mapping=aes(fill=n))

#Two continuous variables
ggplot(diamonds)+
  geom_point(mapping=aes(x=carat, y=price),
             alpha=1/4)
ggplot(diamonds, aes(x=carat, y=price))+
  geom_freqpoly(aes(color=carat))


            