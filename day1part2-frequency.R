library(tidyverse)
library(datastructures)
devtools::install_github("eddelbuettel/rbenchmark")
library(rbenchmark)

data <- read_file("data/day1part1.txt")

changes <- data %>% 
  str_split(pattern = "[^[0-9]\\-\\+]") %>% 
  unlist %>%
  as.integer %>%
  na.omit

system.time({ # benchmark ## 79 sec

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

}) #end loop

## as loop

system.time({ # benchmark 

lastfreq <- 0
freqs <- NULL
result <- 0

while (result == 0) {
  for (i in seq_along(changes)){
    lastfreq <- lastfreq + changes[i]
    if (lastfreq %in% freqs) {
      result <- lastfreq
      print('result found')
      break
    } else {
      freqs <- c(freqs, lastfreq) ## better: initlaize longer list in beginning
    }
  }
}

}) #end benchmark
# 65 sec


## as loop, size of freqs pre allocated, not extended within loop

system.time({ # benchmark 
  
  lastfreq <- 0
  freqs <- NULL
  result <- 0
  pos <- 1
  
  while (result == 0) {
    freqs <- c(freqs, rep(0, length(changes)))
    
    for (i in seq_along(changes)){
      lastfreq <- lastfreq + changes[i]
      if (lastfreq %in% freqs) {
        result <- lastfreq
        print('result found')
        break
      } else {
        freqs[pos] <- lastfreq
        pos <- pos + 1
      }
    }
  }
  
}) #end benchmark: 57 sec