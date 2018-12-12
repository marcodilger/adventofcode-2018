library(tidyverse)

data <- read_lines("data/day10.txt")
data <- str_split(data, "\n") %>% unlist %>% as.data.frame
colnames(data) <- "orig"

data <- data %>% transmute(
  posx = str_extract(orig, "(?<=position=<\\s?)((\\-)?\\d*)(?=\\,)") %>% as.integer, #careful for positions with >2 digits!!!
  posy = str_extract(orig, "(?<=\\,\\s{1,2})((\\-)?\\d*)(?=>)") %>% as.integer,
  velx = str_extract(orig, "(?<=velocity=<\\s?)((\\-)?\\d*)(?=\\,)") %>% as.integer,
  vely = str_extract(orig, "(?<=velocity=<.\\d{1,3}.\\s)(.?\\d*)(?=>)") %>% as.integer
)

# parsing ok


#treat coords as pixels, display message as image
#hypothesis: max(colSums) maximizes when message appears

# reposition pixels
minx <- data %>% pull(posx) %>% min
maxx <- data %>% pull(posx) %>% max
miny <- data %>% pull(posy) %>% min
maxy <- data %>% pull(posy) %>% max

dataStart <- data %>% mutate(
  posx = posx + abs(minx),
  posy = posy + abs(miny),
  velx = velx,
  vely = vely
)


l <- list()
uniques <- list()
i <- 1
stop <- FALSE
data <- dataStart

while(stop == FALSE & i < 20000) { #20000 = arbitrary guess (50000 / ~2 moves/sec)
#remove out of bounds particles

data <- data %>% filter(posx < 106000 & posx > 0) %>%
  filter(posy < 106000 & posx > 0) %>%
  mutate(posx = posx + velx,
         posy = posy + vely)

if (nrow(data) < 50) {
  stop <- TRUE
} 

l[[i]] <- data
uniques[[i]] <- nrow(data)-nrow(unique(data['posx']))

i <- i+1

}

result <- l[[which(unlist(uniques) == max(unlist(uniques)))]]

result.minx <- result %>% pull(posx) %>% min
result.miny <- result %>% pull(posy) %>% min

result <- result %>% transmute(
  posx = posx - result.minx +1,
  posy = posy - result.miny +1
)

m <- matrix(0, nrow = 10, ncol = 70)
for (i in 1:nrow(result)) {
  m[result[i, 'posy'], result[i, 'posx']] <- 1
  print(m[result[i, 'posy'], result[i, 'posx']])
}

image(m) # needs rotate
rotate <- function(x) t(apply(x, 2, rev))

image(rotate(m))

# part2

which(unlist(uniques) == max(unlist(uniques)))
