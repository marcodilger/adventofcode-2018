library(tidyverse)


data <- read_lines("data/day2.txt")

chars <- lapply(str_split(data, ""), table)

chars2 <- lapply(chars, function(x) any(x == 2)) %>%
  unlist %>% sum

chars3 <- lapply(chars, function(x) any(x == 3)) %>%
  unlist %>% sum

result <- chars2 * chars3
result
