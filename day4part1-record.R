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

sleepingGuard <- data2 %>% group_by(guard) %>% summarise(totalsleep = sum(asleep)) %>% 
  arrange(desc(totalsleep)) %>% 
  slice(1) %>%
  pull(guard) %>%
  as.character


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
timematrix2 <- timematrix2[row.names(timematrix2) == sleepingGuard, ]
colnames(timematrix2) <- c(0:59)

resultMin <- which(colSums(timematrix2) == max(colSums(timematrix2))) -1

result <- as.numeric(sleepingGuard) * resultMin[1] ## selection of first element should be unnecessary

