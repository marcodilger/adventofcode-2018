library(tidyverse)
library(datastructures)
devtools::install_github("eddelbuettel/rbenchmark")

data <- read_file("data/day1part1.txt")

changes <- data %>% 
  str_split(pattern = "[^[0-9]\\-\\+]") %>% 
  unlist %>%
  as.integer %>%
  na.omit

# create queue
changesQueue <- queue()

lastfreq <- 0
freqs <- NULL
result <- 0

while (result == 0) {
  #load queue
  sapply(changes, function(x) insert(changesQueue, x))

  while(size(changesQueue) > 0){
    lastfreq <- lastfreq + pop(changesQueue)
    if (lastfreq %in% freqs) {
    result <- lastfreq
    print('result found')
    break
    } else {
      freqs <- c(freqs, lastfreq) ## better: initlaize longer list in beginning
    }
  }
}


