library(tidyverse)
start <- c(3, 7)
#input <- "10" # real input 330121
input <- "330121" #needs to be string, otherwise may drop leading 0
inputlength <- str_split(input, "") %>% unlist %>% length

# one time setup
recipes <- c(start, rep(-1, inputlength)) # create vector with maximum possible length
lastrecipe <- 2 #pos of the last created recipe 
pos1 <- 1 #startingpos
pos2 <- 2 #startingpos

found <-  FALSE
while(found == FALSE) {

recipes <- c(recipes, rep(-1, length(recipes)))  
  
  while(!is.na(recipes[lastrecipe + 2])) {
    
    recipes[lastrecipe + 1] <- recipes[pos1] + recipes[pos2]
    lastrecipe <- lastrecipe + 1
    
    if(recipes[lastrecipe] >= 10) {
      recipes[lastrecipe + 1] <- recipes[lastrecipe] %% 10
      recipes[lastrecipe] <- 1
      lastrecipe <- lastrecipe + 1
      if (lastrecipe > inputlength) {
        if (as.numeric(paste(recipes[(lastrecipe - inputlength):(lastrecipe - 1)], collapse = "")) == as.numeric(input)) {
          found = TRUE
          break
        }
      }
    }
    
    if (lastrecipe > inputlength) {
      if (as.numeric(paste(recipes[(lastrecipe - inputlength + 1):(lastrecipe)], collapse = "")) == as.numeric(input)) {
        found = TRUE
        break
      }
    }
    rawpos1 <- (recipes[pos1] + 1 + pos1) %% lastrecipe
    pos1 <- ifelse(rawpos1 == 0, lastrecipe, rawpos1)
    
    rawpos2 <- (recipes[pos2] + 1 + pos2) %% lastrecipe
    pos2 <- ifelse(rawpos2 == 0, lastrecipe, rawpos2)
    
    
  }
}
result <- lastrecipe - inputlength #or 1 less
if (as.numeric(paste(recipes[(lastrecipe - inputlength):(lastrecipe - 1)], collapse = "")) == as.numeric(input) ) {
  result <- result - 1
}
result
