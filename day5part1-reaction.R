data <- "dabAcCaCBAcCcaDA"
data <- str_remove_all(read_file("data/day5.txt"), "[^[:alnum:]]")

elements <- utf8ToInt(data)



terminated <- FALSE

while (!terminated){
  i <- 1
  toDel <- NULL
  while (i < length(elements)) {
    if (abs(elements[i] - elements[i+1]) == 32) {
      toDel <- c(toDel, i, i+1)
      i <- i+1
      }
    i <- i+1
  }
  if (length(toDel) == 0) {break}
  elements <- elements[-toDel]
}
length(elements)
intToUtf8(elements)
