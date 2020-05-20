#three rules for tidy dataset
#1. Each variable should have a column
#2. Each pbservation must have its own row
#3. Each value must have its own cell
table1%>%
  group_by(year,country)%>%
  summarize(n_cases=sum(cases))
table1%>%
  group_by(country)%>%
  mutate(per_cases=sum(cases)*10000/sum(population))
#Spreading and gathering
table4a
#variable values are columns here 
tidy4a <- table4a%>%
  gather('1999','2000',key='year',value = 'cases')
tidy4b <- table4b%>%
  gather('1999','2000',key='year',value='population')
left_join(tidy4a,tidy4b)
library(tidyr)
table2

#each observation is spread across 2 rows
table2%>%
  spread(key='type',value='count')

stocks <- tibble(
  year = c(2015, 2015, 2016, 2016),
  half = c(1, 2, 1, 2),
  return = c(1.88, 0.59, 0.92, 0.17)
)
stocks
stocks%>%
  spread(key='half',value='return')
table4a
table4a%>%
  gather('1999','2000',key='year',value='cases')

people <- tribble(
  ~name, ~key, ~value,
  #-----------------|--------|------
  "Phillip Woods", "age", 45,
  "Phillip Woods", "height", 186,
  "Phillip Woods", "age", 50,
  "Jessica Cordero", "age", 37,
  "Jessica Cordero", "height", 156
)
glimpse(people)

people%>%
  spread(key='key',value='value')
people2 <- people%>%
  group_by(name,key)%>%
  mutate(obs=row_number())
people2%>%
  spread(key,value)

preg <- tribble(
  ~pregnant, ~male, ~female,
  "yes", NA, 10,
  "no", 20, 12
)
preg

preg%>%
  gather('male','female',key='gender',value='age')

#Separating and Uniting
table3
#splitting a column with more than one variable values into separate variable columns
tidy3 <- table3%>%
  separate(rate,c('cases','population'))
# by default the derived columns are of type character
class(tidy3$cases)
tidy3 <- table3%>%
  separate(rate,c('cases','population'),convert=TRUE)
class(tidy3$cases)
table3
#if i want to split the column year
tidy3_t <- table3%>%
  separate(year,c('century','decade'),sep=2)%>%
  separate(rate,c('cases','population'),convert=TRUE)
tidy3_t

#Unite() is the inverse of separate()
#unites multiple columns into one
table5
table5%>%
  unite(new,century,year)

table5%>%
  unite(new,century,year,sep='')

tibble(x = c("a,b,c", "d,e,f,g", "h,i,j")) %>%
  separate(x, c("one", "two", "three"),extra='drop')

tibble(x = c("a,b,c", "d,e,f,g", "h,i,j")) %>%
  separate(x, c("one", "two", "three"),extra='merge')

tibble(x = c("a,b,c", "d,e,f,g", "h,i,j")) %>%
  separate(x, c("one", "two", "three"),fill='right')

#Missing Values
stocks <- tibble(
  year=c(2015,2015,2015,2015,2016,2016,2016),
  qtr=c(1,2,3,4,2,3,4),
  return=c(1.88,0.59,0.35,NA,0.92,0.17,2.66)
)
stocks

stocks%>%
  spread(year,return)%>%
  gather('2015','2016',key='year',value='return')

stocks%>%
  complete(year,qtr)
#complete takes a set of columns and find all unique combinations and make sure our data has complete set

#CASE STUDY
who
who1 <- who%>%
  gather(new_sp_m014:newrel_f65,key='key',value='cases',na.rm=TRUE)
who1 <- who1%>%
  mutate(key=stringr::str_replace(key,'newrel','new_rel'))
who2 <- who1%>%
  separate(key,c('type1','type2','type3'),sep='_')
who2
View(who2)
who3 <- who2%>%
  separate(type3,c('gender','age_Range'),sep=1)
who3
View(who3)
who3 <- who3%>%
  mutate(age_Range=stringr::str_replace(age_Range,'014','0014'))%>%
  mutate(age_Range=stringr::str_replace(age_Range,'65','65++'))%>%
  separate(age_Range,c('ll','ul'),sep=2)
tidywho <- who3%>%
  unite(age_range,ll,ul,sep='-')%>%
  select(-iso2,-iso3,-type1)
head(tidywho)
