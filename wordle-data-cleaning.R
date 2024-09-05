library(readxl)
library(tidyverse)
library(writexl)
wordledata <- read_excel("~/Documents/Wordle Game - Survey (Responses) _Redacted.xlsx")
View(wordledata)


wordledata2 <- wordledata %>%
  rename(results = "Paste game results here")


wordledata2 <- wordledata2 %>%
  # Convert the last column into a list of vectors
  mutate(results = strsplit(as.character(results), "---")) %>%
  # Unnest the list to create multiple rows
  unnest(results)


wordlesep <- wordledata2 %>%
  separate(results, into = c("Column1", "Column2", "Column3", "Column4", "Column5", "Column6", "Column7", "Column8", "Column9", "Column10", "Column11"), sep = ":", fill = "right")
