rm(list = ls())

n <- 10

longl <- 121.026408
latd <- 30.662036
step1 <- (121.962232 - longl) / n
step2 <- (31.621866 - latd) / n

longr <- longl + step1
latu <- latd + step2
long <- c(longl, longr)
lat <- c(latu, latd)

while (longr < 121.962232) {
    longl <- longr
    longr <- longr + step1
    lt <- c(longl, longr)
    long <- rbind(long, lt)
}
#long[(n+1), 2] <- 121.962232

while (latu < 31.621866) {
    latd <- latu
    latu <- latu + step2
    
    lt <- c(latu, latd)
    lat <- rbind(lat, lt)
}
#lat[(n+1), 1] <- 31.621866

final <- c()

for (i in 1:n){
    for (j in 1:n){
        temp <- c(long[i, ], lat[j, ])
        final <- rbind(final, temp)
    }
}

dt <- read.csv("locations.csv", header = T)
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
