library(tidyverse)
start <- c(3, 7)
#input <- 10 # real input 330121
input <- 330121

# one time setup
recipes <- c(start, rep(-1, input+10)) # create vector with maximum possible length
lastrecipe <- 2 #pos of the last created recipe 
pos1 <- 1 #startingpos
pos2 <- 2 #startingpos

## repeat until...pos input+11 is not -1

while(recipes[input + 11] == -1) {
  
  recipes[lastrecipe + 1] <- recipes[pos1] + recipes[pos2]
  lastrecipe <- lastrecipe + 1
  
  if(recipes[lastrecipe] >= 10){
    recipes[lastrecipe + 1] <- recipes[lastrecipe] %% 10
    recipes[lastrecipe] <- 1
    lastrecipe <- lastrecipe + 1
  }
  # movement
  rawpos1 <- (recipes[pos1] + 1 + pos1) %% lastrecipe
  pos1 <- ifelse(rawpos1 == 0, lastrecipe, rawpos1)
  
  rawpos2 <- (recipes[pos2] + 1 + pos2) %% lastrecipe
  pos2 <- ifelse(rawpos2 == 0, lastrecipe, rawpos2) 
}

result <- paste(recipes[(input+1):(input+10)], collapse = "")
result
