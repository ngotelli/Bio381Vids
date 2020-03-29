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
# bar plots
table(d$drv)

p1 <- ggplot(d,aes(x=drv)) +
  geom_bar(color="black",
           fill="cornsilk")
print(p1)

# aesthetic mapping for multiple groups in each bar

p1 <- ggplot(d,aes(x=drv,fill=fl)) +
      geom_bar()
print(p1)

# stacking with color transparency, adjust alpha
# which is color transparency of each bar
# alpha = 0 all colors invisible
# alpha = 1 all colors completely opaque
p1 <- ggplot(d,aes(x=drv,fill=fl)) +
  geom_bar(alpha=0.3,position="identity")
print(p1)

# better to use position = fill for stacking
# with constant height
p1 <- ggplot(d,aes(x=drv,fill=fl)) +
  geom_bar(position="fill")
print(p1)

# best to use position = dodge generate multiple bars
p1 <- ggplot(d,aes(x=drv,fill=fl)) +
  geom_bar(position="dodge",color="black",
           size=0.8)
print(p1)

# more typical bar plot has heights as values (mean, total)
d_tiny <- tapply(X=d$hwy,
                 INDEX=as.factor(d$fl),
                 FUN=mean)
d_tiny <- data.frame(hwy=d_tiny)
d_tiny <- cbind(fl=row.names(d_tiny),d_tiny)

p2 <- ggplot(d_tiny,aes(x=fl,y=hwy,fill=fl)) +
      geom_col()
print(p2)
                 


# much better for a box plot!
p2 <- ggplot(d,aes(x=fl,y=hwy,fill=fl)) +
  geom_boxplot()
print(p2)
                 
# overlay the raw data
p2 <- ggplot(d,aes(x=fl,y=hwy)) +
  geom_boxplot(fill="thistle",outlier.shape=NA) +
  geom_point()
print(p2)             
                 
# improve visualization of data
p2 <- ggplot(d,aes(x=fl,y=hwy)) +
  geom_boxplot(fill="thistle",outlier.shape=NA) +
  geom_point(position=position_jitter(width=0.1,
                                      height=0.7),
            color="gray60",size=2)
print(p2)                    
                 
                 