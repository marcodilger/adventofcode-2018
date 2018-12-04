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



df2 <- df %>% mutate(
  endx = startx + width,
  endy = starty + height
)



  
found <- FALSE
id <- 1
result <- NULL
while (!found & id <= length(df2$id)) {
  startx <- df2$startx[id]
  starty <- df2$starty[id]
  endx <- df2$endx[id]
  endy <- df2$endy[id]
  for (target in seq_along(df2$id)) {
    if (id != target){
     
    overlap <- !(
      (endx <= df2$startx[target] | df2$endx[target] <= startx) |
      (endy <= df2$starty[target] | df2$endy[target] <= starty )
                )
      
    if (overlap) {
      found <- FALSE
      break
      } else {
      found <- TRUE
      }
    }
  }
  if (found) {
    result <- id
    print(paste0("found result: ", id))
  }
  id <- id + 1
}


#result 235
