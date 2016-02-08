create.map <- function(slice,             # list of vectors with coordinates
                       img,
                       title="Freq Map", # title  
                       colors=rainbow(5),# colors palette
                       dot_size=20,
                       breaks=NULL,
                       nlevel=64
) 
{
  
  idim = dim(img) # wymiary obrazka
  ileocen = as.integer(length(slice))
  
  x_dim=idim[2]/dot_size
  y_dim=idim[1]/dot_size
  
  #title = paste(title, "\nCzęstotliwość wskazań [%]\nn=", ileocen)
  title = title
  
  # matrix with 0:
  img_rpr = matrix(0, x_dim, y_dim)
  
  for (row in slice) {
    for (el in row){
      if (!is.na(el)) 
        # print(el)
        img_rpr[[as.integer(el)]] = img_rpr[[as.integer(el)]] + 1
    }
  }
  
  img_rpr = img_rpr[,ncol(img_rpr):1] # odwracamy kolumny
  img_rpr = img_rpr/52
  
  p = plot(1:1, 
           xlim=c(0, 1), 
           ylim=c(0, 1), 
           type='n', 
           main=title, 
           xaxs="i", 
           yaxs="i",
           axes = FALSE, 
           xlab="",
           ylab=""
           
  )
  
  lim <- par()
  
  if (!is.null(breaks))
    {brk<- quantile(breaks, probs=breaks)}
  
  
  out = p + 
    rasterImage(img, lim$usr[1], lim$usr[3], lim$usr[2], lim$usr[4]) + 
    image.plot(img_rpr, 
               add=TRUE,
               breaks=breaks,
               col=colors, 
               horizontal = T,
               #lab.breaks=T,
               lab.breaks=names(brk),
               graphics.reset=T
    )
  
  # todo: save.image(out, file="out.png" )
}


prep_slice <-function(slice) {
  slice = gsub("NoOpinion", "", str_trim(slice)) # NoOpinion na pusty string
  slice = strsplit(slice, ",")  
  slice = Filter(function(x) !identical(character(0), x), slice)
}
