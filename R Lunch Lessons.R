#create a matrix
mat <-matrix(c(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16),nrow=4)
mat

mat[lower.tri(mat, diag=FALSE)] #by default it's FALSE
mat[upper.tri(mat,diag=TRUE)] <- 0
mat

#to know about all the built in datasets
library(help='datasets')
series1 <- c(1:9)
series1    
series2 <- c(2:10)
series1*2
series1/2 #remainder
series1 %/% 2 #qoutient

short <- series2[1:4]
short
series1 + short #the shorter vector should be a multiple for being recycled

LETTERS
letters
#removing a sequnce of indices
LETTERS[3:15]
#removing selected indices
LETTERS[c(3,12:17)]
#Removing certain indices
LETTERS[-c(3:15)]
LETTERS[-3:-15]

rep(c(TRUE,FALSE),13)
LETTERS[rep(c(TRUE,FALSE),13)]
LETTERS[rep(c(FALSE,TRUE),13)]
letterframe <- data.frame(LETTERS,letters,position=1:length(LETTERS))

#Power Analysis

qnorm(0.05,170,65/sqrt(400),lower.tail = FALSE)
pnorm(175.34,180,65/sqrt(400),lower.tail = TRUE)

qnorm(0.01,170,65/sqrt(400),lower.tail = FALSE)
pnorm(177.56,180,65/sqrt(400),lower.tail = TRUE)
#sample size
qnorm(0.05,170,65/sqrt(1000),lower.tail = FALSE)
pnorm(173.38,180,65/sqrt(1000),lower.tail = TRUE) #~0

#Atomic types built into R
i.am.logical <- TRUE
is.logical(i.am.logical)
is.logical(False)
is.logical(1)
as.numeric(TRUE)
TRUE & FALSE
TRUE | FALSE
i.am.integer <- as.integer(3)
class(i.am.integer)
as.integer(3.35)
i.am.numeric <- 10.35
class(i.am.numeric)
i.am.complex <- 3i
class(i.am.complex)
i.am.character <- "I like R"
substr(i.am.character,start=3,stop=8)
nchar(i.am.character)
length(i.am.character)

#Basic types
#VECTOR
vector1 <- 1
#vectors are actually closer to array
i.am.a.vector <- c(1,2,3)
#can also assign string into a vector
i.am.a.vector <- c('twas','brillig','and')
another.vector <- c(1,'twas')
#when u mix datatypes, it converts everything to character
#Length will give the length of the vector
length(another.vector)
#to find number of characters in each element
nchar(i.am.a.vector)

#Vectors are not necessarily strings,
#they might look likt it but they are not
i.am.another.vector <- c("1",'can','do','it','right','now')
paste(i.am.a.vector,i.am.another.vector)
#better result, we can just concat
c(i.am.a.vector, i.am.another.vector)

#LISTS
#What are lists?
#Lists are a form of vector where you can store different data types
#without coercing them into character

i.am.a.vector <- c(1,"Hello",TRUE)
i.am.a.vector
i.am.a.list <- list(1,"Hello",TRUE)
i.am.a.list

#there can be multiple lists within a list
a.list <- c(1:5) #numeric
another.list <- c(letters[1:5]) #alphabets
yet.another.list <- c(TRUE,FALSE,TRUE) #logical
i.am.the.list <- list(a.list, another.list, yet.another.list)
i.am.the.list

#We can name each list accordingly
names(i.am.the.list)
#Null because we didn't have any
names(i.am.the.list) <- c('numeric','alphabet','logical')
i.am.the.list
#Another way
i.am.the.list <- list(num=a.list, alpha=another.list, logicl=yet.another.list)
names(i.am.the.list)
i.am.the.vector <- c(a.list, another.list, yet.another.list)
i.am.the.vector

#FACTORS
#a list of unique values

