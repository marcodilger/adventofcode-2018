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
plantscurrent <- paste0(paste0(rep("0", 30), collapse =""), initial, paste0(rep("0", 30), collapse =""), collapse = "") # add 0, to avoid negative references

plants <- list()
# counts <- list() # misunderstanding
plantscurrent <- str_split(plantscurrent, "") %>% unlist
plantsnext <- plantscurrent
# counts[[21]] <- plantscurrent %>% as.integer %>% sum #misunderstanding
#start loop
i <- 1
while (i <= 20) {

  for (char in 3:length(plantsnext)) {
    plantsnext[char] <- ifelse(paste(plantscurrent[(char-2):(char+2)], collapse = "") %in% positive,
      "1",
      "0"
    )
  }
  plantscurrent <- plantsnext
  plants[[i]] <- plantscurrent
#  counts[[i]] <- plantscurrent %>% as.integer %>% sum # misunderstanding !
  i <- i + 1
}


result <- sum(as.numeric(plants[[20]])*-30:129)
result
