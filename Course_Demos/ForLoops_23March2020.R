# --------------------------------------
# Basic anatomy and use of for loops
# 23 Mar 2020
# NJG
# --------------------------------------
#
# Anatomy of a for loop

# for (var in seq) { # start of the loop

# body of for loop

# } # end of loop

# var is a counter variable that hold the current value of the counter in the loop
#seq is an interger vector (or vector of character strings) thatdefines starting and ending values of the loop

# suggest using i,j,k for var (counter)

# how to NOT set up your for loops
my_dogs <- c("chow", "akita", "malamute", "husky", "samoyed")

for (i in my_dogs) {
  print(i)
}

# set it up this way instead
for (i in 1:length(my_dogs)) {
  cat("i =", i, "my_dogs[i] =", my_dogs[i], "\n")
}

# potential hazard: suppose our vector is empty!
my_bad_dogs <- NULL

for (i in 1:length(my_bad_dogs)){
  cat("i =", i, "my_bad_dogs[i] =", my_bad_dogs[i], "\n")
}

# safer way to code var in the for loop is use seq_along

for (i in seq_along(my_dogs)) {
  cat("i =", i, "my_dogs[i] =", my_dogs[i], "\n")
}

#handles the empty vector correctly!
for (i in seq_along(my_bad_dogs)){
  cat("i =", i, "my_bad_dogs[i] =", my_bad_dogs[i], "\n")
}

# could also define vector length from a constant
zz <- 5
for (i in seq_len(zz)) {
  cat("i =", i, "my_dogs[i] =", my_dogs[i], "\n")
}


# tip #1: do NOT change object dimensions inside a loop
# avoid these functions (cbind,rbind,c,list)

my_dat <- runif(1)
for (i in 2:10) {
  temp <- runif(1)
  my_dat <- c(my_dat,temp) # don't do this!
  cat("loop number =", i, "vector element =", my_dat[i],"\n")
}
print(my_dat)

# tip #2: Don't do things in a loop if you do not need to!

for (i in 1:length(my_dogs)) {
  my_dogs[i] <- toupper(my_dogs[i]) # don't do this in loop
  cat("i =", i, "my_dogs[i] =",my_dogs[i], "\n")
}
z <- c("dog","cat","pig")
toupper(z)

# tip #3: do not use a loop if you can vectorize!

my_dat <- seq(1:10)
for (i in seq_along(my_dat)) {
  my_dat[i] <- my_dat[i] + my_dat[i]^2
  cat("loop number =", i, "vector element =",my_dat[i],"\n")
}

# no loop needed here!
z <- 1:10
z <- z + z^2
print(z)

# tip #4: understand distinction between the counter variable i, and the vector element z[i]

z <- c(10,2,4)
for (i in seq_along(z)) {
  cat("i =",i,"z[i] =",z[i],"\n")
}

# what is the value of i at the end of the loop?
print(i)

# what is value of z at the end of the loop
print(z)

# tip #5 use next to skip certain elements in the loop

z <- 1:20
#suppose we want to work only odd-numbered elements?

for (i in seq_along(z)) {
  if (i %% 2==0) next
  print(i)
}

# another method, probably faster (why?)

z <- 1:20
z_sub <- z[z %% 2!=0] # contrast with logical expression in loop
length(z)
length(z_sub)
for (i in seq_along(z_sub)) {
  cat("i = ", i, "z_sub[i] = ", z_sub[i],"\n")
}

# tip #6: use break to set up a conditional to break out of a loop early

# create a simple random walk population model function

# --------------------------------------
# FUNCTION ran_walk
# description: stochastic random walk 
# inputs: times = number of time steps
#         n1 = initial population size (=n[1])
#         lambda = finite rate of increase
#         noise_sd = standard deviation of a normal
#                    distribution with mean 0
# outputs: vector n with population sizes > 0
#          until extinction, then NA values
########################################
library(tcltk)
library(ggplot2)
ran_walk <- function(times=100,
                     n1=50,
                     lambda=1.0,
                     noise_sd=10) {   #start of function
  n <- rep(NA,times)  # create output vector
  n[1] <- n1 # initialize starting population size
  noise <- rnorm(n=times,mean=0,sd=noise_sd) # create random noise vector
  
  for (i in 1:(times - 1)) { #start of for loop
      n[i + 1] <- n[i]*lambda + noise[i]
      if(n[i + 1] <= 0) { # start of if statement
        n[i + 1] <- NA
        cat("Population extinction at time", i, "\n")
        tkbell()
        break } # end of if statement
  } # end of for loop
return(n)
} # end of function
# -------------

# explore model parameters interactively 
# with simple graphics

pop <- ran_walk()
qplot(x=1:100,y=pop,geom="line")


# check out performance with no noise
pop <- ran_walk(noise_sd=5, lambda=0.98)
qplot(x=1:100,y=pop,geom="line")

# double for loops --------------------------------------

m <- matrix(round(runif(20),digits=2),nrow=5)

# loop over rows
for (i in 1:nrow(m)) {
  m[i,] <- m[i,] + i
}
print(m)

m <- matrix(round(runif(20),digits=2),nrow=5)
# loop over columns
for (j in 1:ncol(m)) {
  m[,j] <- m[,j] + j
}
print(m)

# loop over rows and columns with double for loop
m <- matrix(round(runif(20),digits=2),nrow=5)
for (i in 1:nrow(m)) { # start of outer (row) loop
  for (j in 1:ncol(m)) { # start of inner (column) loop
    m[i,j] <- m[i,j] + i + j
  } # end of inner (column) loop
} # end of outer (row) loop
print(m)

