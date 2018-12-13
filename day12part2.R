here::here()
library(tidyverse)

input <- read_lines("data/day12.txt")
input <- str_replace_all(input, "#", "1")
input <- str_replace_all(input, "\\.", "0")


initial <- str_extract(input[1], "(?<=state:\\s).*")
rules <- input[-c(1, 2)]

rules <- rules %>% as.data.frame 
names(rules) <- "orig"

rules <- rules %>% transmute(
  patt = str_extract(orig, "\\d*(?=\\s=>\\s)"),
  nextgen = str_extract(orig, "(?<=\\s=>\\s)\\d")
)
positive <- rules %>% filter(nextgen == 1) %>% pull(patt)
plantscurrent <- paste0(paste0(rep("0", 5), collapse =""), initial, paste0(rep("0", 200), collapse =""), collapse = "") # add 0, to avoid negative references

plants <- list()
plantscurrent <- str_split(plantscurrent, "") %>% unlist
plantsnext <- plantscurrent

#start loop
i <- 1
while (i <=150) {

  for (char in 3:length(plantsnext)) {
    plantsnext[char] <- ifelse(paste(plantscurrent[(char-2):(char+2)], collapse = "") %in% positive,
      "1",
      "0"
    )
  }
  plantscurrent <- plantsnext
  plants[[i]] <- plantscurrent
#  print(which(plantscurrent == 1)[1])
  
  counts <- plantscurrent %>% as.integer %>% sum
  result <- sum(as.integer(plantscurrent)*-5:299)
  print(paste(i,": ", result))
  i <- i + 1
}

# some kind of pattern recognition needed, no way to simulate 50bn mutations ... 
# amount of plants stabilizes after 101 generations: 59 plants
# increase in sum(potnr with plant) also stabilizes after 101 generations: 59 per generation 
# -> movement of all plants to the right goes linear with generation

# solution: [result for 150. generation] + (50 bn - 150) * 59

result <- 10448 + (50000000000-150)*59
as.character(result)
