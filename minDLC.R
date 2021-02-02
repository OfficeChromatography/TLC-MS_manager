## minDLC to keep working without the DLC package

raster <- function(data,main='',Title.dim=F,interpolate = F,inv = F, xlim=NULL, ylim = NULL,...){ # a 3D array
  # par(mar=c(0,0,2,0),oma=c(0,0,2,0))
  if(length(dim(data))>2){if(dim(data)[3] > 3){data <- data[,,c(1,2,3)]}}
  # print('SOM.cluster.plot.picture')
  # print(dim(data))
  if(Title.dim == T){main=paste0('Dimensions: ',paste(dim(data),collapse='-'),'\n',main)}
  if(is.null(xlim)){
    xlim = c(0,dim(data)[2])
  }
  if(is.null(ylim)){
    ylim = if(inv){c(dim(data)[1],0)}else{c(0,dim(data)[1])}
  }
  plot(c(0,dim(data)[2]),if(inv){c(dim(data)[1],0)}else{c(0,dim(data)[1])}, type='n',ylab="",xlab="",main=main,
       ylim = ylim, xlim = xlim,...)
  
  rasterImage(data,
              xleft = 0,
              ybottom = if(inv){dim(data)[1]}else{0},
              xright = dim(data)[2],
              ytop = if(!inv){dim(data)[1]}else{0},
              interpolate=interpolate)
  
}

f.read.image<-function(source,height=NULL,Normalize=F,ls.format=F){
  ls <- list()
  for(i in source){
    data = NULL
    try(data<-readTIFF(i,native=F)) # we could use the magic number instead of try here
    try(data<-readJPEG(source=i,native=F))
    try(data<-readPNG(source=i,native=F))
    if(!is.null(data)){
      if(!is.null(height)){
        data <- redim.array(data,height)
      }
      if(Normalize == T){data <- data %>% normalize}
      ls[[i]]<- data
    }else{
      print("one file is not a tiff jpeg or png")
      return(NULL)
    }
  }
  if(ls.format == F){
    data <- abind(ls,along=2)
  }else{
    data <- ls
  }
  return(data)
}

redim.array = function (data, height.out, width.out = NULL)
{
  height.in = dim(data)[1]
  width.in = dim(data)[2]
  if(is.null(width.out)){
    width.out = ceiling(height.out/height.in * width.in)
  }
  if (length(dim(data)) == 3) {
    data <- data[floor(seq(1, height.in, length.out = height.out)), , ]
    data <- data[,floor(seq(1, width.in, length.out = width.out)),]
  }
  else {
    data <- data[floor(seq(1, height.in, length.out = height.out)),
                 floor(seq(1, width.in, length.out = width.out))]
  }
  return(data)
}