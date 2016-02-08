# install.packages("jpeg")
# install.packages("stringr")
# install.packages("fields")
# install.packages("yhatr")
library(jpeg)
library(stringr)
library(fields)
library(yhatr)

setwd("/home/user/workspace/przyklad")

source("createmap.R")  # importujemy funkcje

# my colors
colorRampPalette(c("transparent", "#85c87d", "#a8d27f", "#cbdc81", "#ede683", "#ffdd82", "#fdc07c", "#fca377", "#fa8671","#f8696b")) -> blues
blues_pal<-blues(5) # wybieram 5 z palety - kolorów musi byćo 1 mniej niż breaks
blues_pal_transp<-paste(blues_pal, "99", sep="") # ustawiam transparentość

# clean data
data <- read.csv("dane.csv", sep=";")

slice = prep_slice(data$heatmap)

img = readJPEG("przyklad.jpg")

create.map(slice, 
           img, 
           colors=blues_pal_transp,
           title="Co się podoba",
           breaks=c(.1,.2,.3,.4,.5,1.0)
)




