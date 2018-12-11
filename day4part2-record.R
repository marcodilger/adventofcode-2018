library(tidyverse)

data <- read_lines("data/day4.txt")

data <- str_split(data, "\n") %>% unlist %>% as.data.frame
colnames(data) <- "full"

data <- data %>% mutate(time = str_extract(full, "(?<=\\[)(\\d.+)(?=\\])") %>% as.POSIXct) %>% arrange(time)

data <- data %>% mutate(guard = str_extract(full, "(?<=\\#)(\\d+)(?=\\s)"),
                        begin = str_detect(full, pattern = "begins"),
                        sleep = str_detect(full, "asleep"),
                        wakes = str_detect(full, "wakes")
                        ) %>% fill(guard)

library(lubridate)

data2 <- as.data.frame(data %>% filter(sleep) %>% pull(guard))
colnames(data2) <- "guard"
data2 <-  data2 %>% mutate(sleep = data %>% filter(sleep) %>% pull(time),
                 wakes = data %>% filter(wakes) %>% pull(time),
                 asleep = wakes-sleep) 


timematrix <- matrix(data = 0, nrow = nrow(data2), ncol = 60, dimnames = data2 %>% pull(guard) %>% list)

sleepVec <- data2 %>% pull(sleep) %>% minute
wakeVec <- data2 %>% pull(wakes) %>% minute


fillMatrix <- function(matrix, sleepVec, wakeVec) {
  for (shift in seq_along(sleepVec)) {
    for (minute in 1:60) {
      matrix[shift, minute] <- ifelse(minute > sleepVec[shift] & minute <= wakeVec[shift] , 1, 0)
    }
  }
  return(matrix)
}

timematrix2 <- fillMatrix(timematrix, sleepVec, wakeVec)
colnames(timematrix2) <- c(0:59)

sleepiestMinute <- function(matrix, guard){
  m <- matrix[row.names(matrix) == guard, ]
  result <- which(colSums(m) == max(colSums(m))) -1
  return(as.integer(result))
}  

asleepMin <- function(matrix, guard){
  m <- matrix[row.names(matrix) == guard, ]
  result <- max(colSums(m))
  return(as.integer(result))
}  


guardvec <- data2 %>% pull(guard) %>% unique

sleepmax <- 0
for (guard in guardvec) {
  asleepMinutes <-  asleepMin(timematrix2, guard)
  if (asleepMinutes > sleepmax) {
    sleepmax <- asleepMinutes
    sleepingGuard <- as.integer(guard)
  }
}
sleepmax
sleepingGuard

resultpart2 <- sleepiestMinute(timematrix2, sleepingGuard) * sleepingGuard
resultpart2
