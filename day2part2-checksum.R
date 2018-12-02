library(tidyverse)
library(stringdist)

data <- read_lines("data/day2.txt")
which(stringdistmatrix(data, data, method = "lcs") == 2)

ids <- data[which(adist(x = data[1:250], y = data[1:250]) == 1, arr.ind=TRUE)[1:2]]
ids_split <- str_split(ids, "")




toremove <- setdiff(ids_split[[1]], ids_split[[2]])

result <- ids_split[[1]][ids_split[[1]] != toremove] %>% paste0(collapse = "")


