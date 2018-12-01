library(tidyverse)

data <- read_file("data/day1part1.txt")

result <- data %>% 
  str_split(pattern = "[^[0-9]\\-\\+]") %>% 
  unlist %>%
  as.integer %>%
  sum(na.rm = TRUE)

result
