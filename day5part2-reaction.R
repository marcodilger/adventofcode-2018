data <- "dabAcCaCBAcCcaDA"
data <- str_remove_all(read_file("data/day5.txt"), "[^[:alnum:]]")

elements.orig <- utf8ToInt(data)

lowest <- length(elements.orig)
for (letter in 65:90) { # 65 = A, 90 = Z
  elements <- elements.orig[!elements.orig %in% c(letter, letter+32)]
  
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
  if (length(elements) < lowest) {
    lowest <- length(elements)
    lowestLetter <- intToUtf8(letter)
    }
}
lowest
lowestLetter
