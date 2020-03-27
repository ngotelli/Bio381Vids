# --------------------------------------
# Basics of ggplot grammar and graphics
# 27 Mar 2020
# NJG
# --------------------------------------
#

# 1. data (in a data frame)
# 2. aesthetic mapping (variables are mapped to an aesthetic)
# 3. geom (geometric object used to draw the layer; points, bars polygons, etc.)
# 4. stat (raw data and transforms it for something useful in a plot)
# 5. position (adjust points for overplotting)
# 6. facet function 

# Template for ggplot components --------------------------------------

# p1 <- ggplot(data= <DATA>,
#              mapping=aes(<MAPPING>)) +
#      <GEOM_FUNCTION(mapping=aes(<MAPPING>),
#                    stat=<STAT>,
#                    position=<POSITION>) +
#       <COORDINATE_FUNCTION> +
#       <FACET_FUNCTION>
#  print(p1)
# ggsave(plot=p1,
#        filename="MyPlot",
#        width=5,
#        height=3,
#        units="in",
#        device="pdf")

# Preliminaries --------------------------------------
library(ggplot2)
library(ggthemes)
library(patchwork)
library(TeachingDemos)
char2seed("doubling time")

d <- mpg # use built in data set on car performance
str(d)
table(d$fl)

# fast plotting with qplot --------------------------------------

# basic histogram
qplot(x=d$hwy)
qplot(x=d$hwy, fill=I("tan"), color=I("black"))

# make your own custom histogram function
my_histo <- function(x_var,fil_col="goldenrod"){
  qplot(x=x_var,color=I("black"),fill=I(fil_col))}

my_histo(d$hwy)
my_histo(d$hwy,"thistle")

# basic density plot
qplot(x=d$hwy,geom="density")

# basic scatter plot
qplot(x=d$displ,
      y=d$hwy,
      geom=c("smooth","point"))

# basic scatterplot with linear regression line
qplot(x=d$displ,
      y=d$hwy,
      geom=c("smooth","point"),method="lm")

# basic boxplot
qplot(x=d$fl, y=d$cty, geom="boxplot", fill=I("tan"))

# basic barplot ("long format")
qplot(x=d$fl,geom="bar",fill=I("tan"))

# common mistake
qplot(x=d$fl,geom="bar",fill="tan")

# bar plot with specified counts or means ("short format")
x_treatment = c("Control","Low", "High")
y_response = c(12,2.5, 22.9)
qplot(x=x_treatment, y=y_response,geom="col", fill=I(c("grey20", "grey50", "grey90")))

# basic curves and functions
my_vec <- seq(1,100,by=0.1)
head(my_vec)
my_fun <- function(x) sin(x) + 0.1*x
qplot(x=my_vec,y=sin(my_vec),geom="line") # built in function
qplot(x=my_vec,y=dgamma(my_vec,shape=5,scale=3),
      geom="line") # density functions for stats

qplot(x=my_vec,y=my_fun(my_vec),geom="line") #user defined function
