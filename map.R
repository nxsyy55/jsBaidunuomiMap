# get the data to draw the grids

rm(list = ls())
library(readr)

# CONSTANTS
n <- 45
longR <- 121.962232
longl <- 121.026408
latd <- 30.662036
latU <- 31.931866

# init.
step1 <- (longR- longl) / n
step2 <- (latU - latd) / n

vl <- toString(longl + step1 * (1:n))
hl <- toString(latd + step2 * (1:n))
str <- paste("var longl = [", longl, "];",
             "var longr = [", longR, "];",
             "var latd = [", latd, "];",
             "var latu = [", latU, "];",
             "var vl = [", vl, "];", 
             "var hl = [", hl, "];")
write(str, file = 'gridData.js')

longr <- longl + step1
latu <- latd + step2
long <- c(longl, longr)
lat <- c(latu, latd)

while (longr < longR) {
    longl <- longr
    longr <- longr + step1
    lt <- c(longl, longr)
    long <- rbind(long, lt)
}

while (latu < latU) {
    latd <- latu
    latu <- latu + step2
    
    lt <- c(latu, latd)
    lat <- rbind(lat, lt)
}

final <- c()

for (i in 1:n){
    for (j in 1:n){
        temp <- c(long[i, ], lat[j, ])
        final <- rbind(final, temp)
    }
}

dt <- read_csv("locations.csv")
names(dt) <- c('name', 'dist', 'address', 'long', 'lat')

final <- as.data.frame(final)
final$number <- 0
rownames(final) <- NULL

for (i in 1:(n*n)){
    longl <- final[i, 1]
    longr <- final[i, 2]
    latu <- final[i, 3]
    latd <- final[i, 4]
    final[i, 5] <- sum(dt$long < longr & dt$long > longl & dt$lat > latd & dt$lat < latu)
}
final$cl <- apply(final, 1, function(x) mean(x[1:2]))
final$cll <- apply(final, 1, function(x) mean(x[4:3]))
write.csv(final, file = paste0("finalResult", n, ".csv"))
head(final)
