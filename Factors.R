#Factors
library(tidyverse)
install.packages('forcats')
library(forcats)
x1 <- c('Dec','Feb','Apr','May','Oct')
month_levels <- c('Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec')
y1 <- factor(x1,levels=month_levels)
y1
sort(y1)
#when u want the order to be same as the data provided
y1 <- factor(x1,levels=unique(x1))
y1
levels(y1)
forcats::gss_cat
gss_cat%>%
  dplyr::count(race)
library(ggplot2)
ggplot(gss_cat, mapping=aes(x=race,fill=race))+
  geom_bar()
?gss_cat
ggplot(gss_cat, mapping=aes(x=race,fill=race))+
  geom_bar()+
  scale_x_discrete(drop=FALSE)
gss_cat%>%
  dplyr::count(rincome)

ggplot(gss_cat,aes(x=rincome))+
  geom_bar()+
  theme(axis.text.x = element_text(angle=90,hjust=1))
ggplot(gss_cat,aes(x=partyid))+
  geom_bar()+
  theme(axis.text.x = element_text(angle=90,hjust=1))
gss_cat%>%
  dplyr::group_by(denom,relig)%>%
  dplyr::distinct(denom,relig)

library(dplyr)
relig <- gss_cat%>%
group_by(relig)%>%
  summarize(
    age=mean(age,na.rm=TRUE),
    tvhours=mean(tvhours, na.rm=TRUE),
    n=n()
  )
relig
ggplot(relig,aes(x=tvhours,y=relig))+
  geom_point()
ggplot(relig,aes(x=tvhours,y=fct_reorder(relig,tvhours)))+
  geom_point()

gss_cat%>%
  group_by(rincome)%>%
  summarize(
    age=mean(age,na.rm=TRUE),
    tvhours=mean(tvhours, na.rm=TRUE),
    n=n()
  )%>%
  ggplot(aes(x=age,y=fct_reorder(rincome,age)))+
  geom_point()


#Modifying factor levels
gss_cat%>%
  count(partyid,sort=TRUE)

gss_cat%>%
  mutate(partyid= fct_recode(partyid,
                             "Republican,Strong"="Strong republican",
                             "Democrat, Strong"='Strong democrat',
                             "Democrat, Weak"="Not str democrat",
                             "Independent, near Rep"="Ind,near rep",
                             "Independent, near Dem"="Ind,near dem",
                             "Republican, Weak"="Not str republican"))%>%
  count(partyid)

#Combine two or more levels into one

gss_cat%>%
  mutate(partyid= fct_recode(partyid,
                             "Republican,Strong"="Strong republican",
                             "Democrat, Strong"='Strong democrat',
                             "Democrat, Weak"="Not str democrat",
                             "Independent, near Rep"="Ind,near rep",
                             "Independent, near Dem"="Ind,near dem",
                             "Republican, Weak"="Not str republican",
                             "Other"="No answer",
                             "Other"="Don't know",
                             "Other"="Other party"))%>%
  count(partyid)
