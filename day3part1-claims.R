library(tidyverse)


data <- read_lines("data/day3.txt")

data <- str_split(data, "\n") %>% unlist

df <- as.data.frame(data)
df <- df %>% mutate(id = as.numeric(str_extract(data, pattern = "(?<=\\#)(\\d+)(?=\\s.*)")),   ## easier: extract all numbers in ordered vector
              startx = as.numeric(str_extract(data, pattern = "(?<=\\@\\s)(\\d+)(?=[:punct:])")),
              starty = as.numeric(str_extract(data, pattern = "(?<=[:punct:])(\\d+)(?=\\:)")),
              width = as.numeric(str_extract(data, pattern = "(?<=\\:\\s)(\\d+)(?=x)")),
              height = as.numeric(str_extract(data, pattern = "(?<=x)(\\d+)"))
              )

createMatrix <- function(startx, starty, width, height) {
  m <- matrix(0, 1000, 1000)
  print(paste0("startx:",startx))
  m[(starty + 1):(starty + height), (startx + 1):(startx + width)] <- 1
  return(m)
}


result <- matrix(0, 1000, 1000)
for (id in seq_along(df$id)) {
  result = result + createMatrix(df$startx[id], df$starty[id], df$width[id], df$height[id])
}

result <- sum(result > 1)

result
