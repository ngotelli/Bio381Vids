# --------------------------------------
# for loops and functional programming
# 01 Apr 2020
# NJG
# --------------------------------------
#

# different types of functions in r
z <- 1:10

# built-in functions ("prefix" functions)
mean(z)

# "in-fix" functions
z + 100
`+`(z,100)

# user-defined functions
# --------------------------------------
# FUNCTION my_fun
# description: calculate maximum of sin of x + x
# inputs: numeric vector
# outputs: 1-element numeric vector
########################################
my_fun <- function(x=runif(5)) {

z <- max(sin(x) + x)

return(z)

} # end of my_fun
# --------------------------------------
my_fun()
my_fun(z)

# anonymous function
# unnamed, used for single calculations,
# usually with a single input.
# by convention input x
# typically only 1 line of code
function(x) x + 3 # anonymous function
function(x) x + 3 (10) # try to provide input
(function(x) x + 3) (10)

# First task: apply function to each row (or column) of a matrix
m <- matrix(1:20, nrow=5,byrow=TRUE)
print(m)

# for loop solution
# create a vector of nmeric values to hold output
output <- vector("numeric",nrow(m))
str(output)

# run the function in a for loop 
# for each row of the matrix

for (i in seq_len(nrow(m))) {
  output[i] <- my_fun(m[i,])
}
print(output)

# apply solution
# use the apply() function to do the same thing
# apply(X,MARGIN,FUN,...)
# X = vector or an array (=matrix)
# MARGIN 1=row, 2=column, c(1,2)=rows and columns
# ... optional arguments to FUN

# apply function my_fun to each row of m
row_out <- apply(X=m,
                 MARGIN=1,
                 FUN=my_fun)
print(row_out)

# apply function my_fun to each column of m
apply(m,2,my_fun)

# apply function my_fun to each element of the matrix
apply(m,c(1,2),my_fun)

# use apply functions with anonymous function
apply(m,1,function(x) max(sin(x) + x))

# apply to columns
apply(m,2,function(x) max(sin(x) + x))

# apply to elements
apply(m,c(1,2),function(x) max(sin(x) + x))

# what happen to outputs of variable length?
# first, modify code to simply reshuffle order of the elements in each row (or column)

apply(m,1,sample)

# caution! array output from apply goes into the columns
t(apply(m,1,sample))

# function to choose a random number of elements
# from each row and pick them in random order
apply(m,
      1,
      function(x) x[sample(1:length(x),
                           size=sample(1:length(x)))])
# apply may output a vector, a matrix, or a list!


# Second task: apply a function to every column of a data frame. 
df <- data.frame(x=runif(20),y=runif(20),z=runif(20))

# for loop soo\lution

output <- vector("numeric",ncol(df))
print(output)

# preferred structure
output <- rep(NA,ncol(df))
print(output)

for (i in seq_len(ncol(df))) {
  output[i] <- sd(df[,i])/mean(df[,i])
}
print(output)

# lapply solution
# use lapply to do the same thing
# lapply(X,FUN,xxx)
# X is a vector (atomic or list)
# FUN is a function applied to each element of the list or vector
# (note: a data frame is a list of vectors)
# ... addition inputs to FUN

# output of lapply is always a list
# names are retained from original structure
summary_out <- lapply(df,
                      function(x) sd(x)/mean(x))
print(summary_out)

# sapply tries to simplify out to a vector or a matrix (s(implify)apply)
# vapply requires specify output formats (v(erify)apply)

# challenge: what if not all dataframe columns
# are of the same type?

treatment <- rep(c("Control","Treatment"),each=(nrow(df)/2))
print(treatment)
df2 <- cbind(treatment,df)
head(df2)

# for loop solution
output2 <- rep(NA,ncol(df2))

for (i in seq_len(ncol(df2))) {
  if(!is.numeric(df2[,i])) next
  output2[i] <- sd(df2[,i])/mean(df2[,i])
}
print(output2)

# lapply solution
z <- lapply(df2,
       function(x) if(is.numeric(x)) sd(x)/mean(x))
print(z)
unlist(z)

# Third task: split/apply/combine for groups in a data frame

# use df2 for this, and split over the two groups
print(df2)

# for loop solution
g <- unique(df2$treatment)
print(g)

out_g <- rep(NA,length(g))
names(out_g) <- g
print(out_g)

for (i in seq_along(g)) {
  df_sub <- df2[df2$treatment==g[i],]
  out_g[i] <- sd(df_sub$x)/mean(df_sub$x)
} 
print(out_g)

# tapply
# use tapply to do the same thing (t(agged)apply)
# tapply(X,INDEX,FUN,...)
# X is a vector (atomic or list) to be subsetted
# INDEX is a list of factors (or character strings)
# designating one or more groups in the data
# ... addition inputs to FUN

z <- tapply(X=df2$x,
            INDEX=df2$treatment,
            FUN=function(x) sd(x)/mean(x))
print(z)

# Fourth Task: Replicate a stochastic process

# --------------------------------------
# FUNCTION pop_gen
# description: generate a stochastic population track of varying length
# inputs: number of time steps
# outputs: numeric vector of population size
########################################
pop_gen <- function(z=sample.int(n=10,size=1)) {

n <- round(1000*runif(z))
return(n)

} # end of pop_gen
# --------------------------------------
pop_gen()

# for loop solution

n_reps <- 20
list_out <- vector("list",n_reps)
head(list_out)

for (i in seq_len(n_reps)){
  list_out[i] <- list(pop_gen())
}
head(list_out)

# replicate solution
# use replicate() to do the same thing
# replicate(n,expr)
# n = number of times to repeat the operation
# expr is a function (base or user-defined) or 
# an expression (anonymous function without the function call)

z_out <- replicate(n=5,pop_gen())
print(z_out)

# Fifth Task: Sweep a function with all parameter combinations
# species area function S = cA^z
# this has parameters c, z, and A as inputs
# S is the output

# first set up a data frame with all 
# parameter combinations
a_pars <- 1:10
c_pars <- c(100,150,125)
z_pars <- c(0.10,0.16,0.26,0.30)
df <- expand.grid(a=a_pars,
                  c=c_pars,
                  z=z_pars)
head(df)

# for loop solution
df_out <- cbind(df,s=NA)
head(df_out)

for (i in seq_len(nrow(df))) {
  df_out$s[i] <- df$c[i]*(df$a[i]^df$z[i])
}
head(df_out)

# mapply solution
# using mapply to do the same thing (m(ultiple)apply)
# mapply(FUN,...,MoreArgs)
# FUN is the function to be used (note it is first in the list!)
# ... arguments to vectorize over (vectors or lists)
# MoreArgs bundled list of additional arguments
# applied to all iterations of FUN
df_out$s <- mapply(function(a, c, z) c*(a^z),
                   df$a,df$c,df$z)
head(df_out)

# the correct solution
# no need for a function at all!
# we can simply vectorize this operation

df_out$s <- df_out$c*(df_out$a^df_out$z)
head(df_out)
