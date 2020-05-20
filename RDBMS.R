library(tidyverse)
library(nycflights13)
planes%>%
  count(tailnum)%>%
  filter(n>1)
weather%>%
  count(year,month,day,hour,origin)%>%
  filter(n>1)
flights%>%
  count(year,month,day,tailnum)%>%
  filter(n>1)
flights_new <- flights%>%
  mutate(pkey=row_number())
flights_new%>%
  count(year,month,day,pkey)%>%
  filter(n>1)

flights2 <- flights_new%>%
  select(year:day,origin,dest,carrier,tailnum)
head(flights2)

#Alternative 1
left_join(airlines,flights2,by='carrier')
#Alternative 2
flights2%>%
  select(-origin,-dest)%>%
  mutate(carrier_name=airlines$name[match(carrier,airlines$carrier)])
flights2%>%
  left_join(airports,by=c('origin'='faa'))

library(ggplot2)
install.packages('maps')
library(maps)
flights%>%
  group_by(dest)%>%
  summarize(avg_delay=mean(arr_delay,na.rm=TRUE))%>%
  select(dest,avg_delay)%>%
  left_join(airports,by=c("dest"='faa'))%>%
  ggplot(aes(lon,lat),color=avg_delay)+
  borders("state")+
  geom_point()+
  coord_quickmap()
head(planes)  

flights%>%
  group_by(tailnum)%>%
  summarize(avg_delay=mean(arr_delay,na.rm=TRUE), latest_year=max(year))%>%
  select(tailnum,avg_delay,latest_year)%>%
  inner_join(planes,by='tailnum')%>%
  mutate(op_years=latest_year-year)%>%
  ggplot(mapping=aes(x=op_years,y=avg_delay))+
  geom_point()

flights%>%
  group_by(year,month,day,hour,origin)%>%
  summarize(avg_delay=mean(arr_delay,na.rm=TRUE))%>%
  inner_join(weather)%>%
  filter(dense_rank(desc(avg_delay))<6)%>%
  count(temp,dewp,humid,wind_dir,wind_speed,precip,pressure)%>%
  filter(n>1)

flights%>%
  filter(year==2013,month==6,day==13)%>%
  group_by(dest)%>%
  summarize(avg_delay=mean(arr_delay,na.rm=TRUE), n_count=n())%>%
  inner_join(airports, by=c('dest'='faa'))%>%
  ggplot(aes(x=lon,y=lat,color=n_count,size=n_count))+
  borders('state')+
  geom_point()
#due to tornadoes - massive delay

#Filtering Joins
top_dest <- flights%>%
  count(dest,sort=TRUE)%>%
  head(10)
flights%>%
  filter(dest %in% top_dest$dest)
flights%>%
  semi_join(top_dest)
flights%>%
  anti_join(planes,by='tailnum')%>%
  count(tailnum)
