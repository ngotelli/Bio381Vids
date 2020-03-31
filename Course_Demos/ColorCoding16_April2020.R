
# --------------------------------------
# bar plot geoms and colors in ggplot
# 29 Mar 2020
# NJG
# --------------------------------------
#

# Preliminaries --------------------------------------
library(ggplot2)
library(ggthemes)
library(patchwork)
library(colorblindr)
library(cowplot)
library(colorspace)
library(ggsci)
library(wesanderson)
library(TeachingDemos)

char2seed("Dark Star")
d <- mpg
########################################

# working with black and white

# gray colors and grey functions

# built in grey colors (0 = black 100 = white)
my_greys <- c("grey20","grey50","grey80")
demoplot(my_greys,"bar")

my_greys2 <- gray(seq(from=0.1,
                      to=0.9,
                      length.out=10))

# grey()
print(my_greys2)
demoplot(my_greys2,"heatmap")

# convert color plots to black and white
p1 <- ggplot(d,aes(x=as.factor(cyl),
                   y=cty,
                   fill=as.factor(cyl))) + geom_boxplot()
plot(p1)

p1_des <- colorblindr::edit_colors(p1, desaturate)
plot(p1_des)

# desaturate with custom colors
p2 <- p1 + scale_fill_manual(values=c("red","blue","green","yellow"))
plot(p2)

p2_des <- colorblindr::edit_colors(p2, desaturate)
plot(p2_des)

# using alpha transparency for histogram
x1 <- rnorm(n=100,mean=0)
x2 <- rnorm(n=100,mean=2.7)
d_frame <- data.frame(v1=c(x1,x2))
lab <- rep(c("Control","Treatment"),each=100)
d_frame <- cbind(d_frame,lab)
str(d_frame)

h1 <- ggplot(d_frame,aes(x=v1,fill=lab))
h1 + geom_histogram(position="identity",
                    alpha=0.2,
                    color="black")
