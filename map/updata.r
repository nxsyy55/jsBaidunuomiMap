library(readr)
dat <- read_csv("locations.csv")
long <- toString(dat[, 4])
lat <- toString(dat[, 5])
str <- paste("var long = [", long, "];", "var lat = [", lat, "];")
write(str, file = 'dataDetail.js')


dat2 <- read_csv("finalResult20.csv")
long <- toString(dat2[, 7])
lat <- toString(dat2[, 8])
number <- toString(dat2[, 6])
str <- paste("var long = [", long, "];", "var lat = [", lat, "];", 
             "var numbers = [", number, "];")
write(str, file = 'data20.js')

dat2 <- read_csv("finalResult10.csv")
long <- toString(dat2[, 7])
lat <- toString(dat2[, 8])
number <- toString(dat2[, 6])
str <- paste("var long = [", long, "];", "var lat = [", lat, "];", 
             "var numbers = [", number, "];")
write(str, file = 'data.js')
