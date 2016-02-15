#make the gradient colors for the heatmap

col <- vector(length = 16)

for(i in 1:16){
    col[i] <- rgb(red = 0 + (i-1) * 15, 0, blue = 255 - (i-1)*15, maxColorValue = 255)
}