library(readxl)
library(tidyverse)
library(writexl)
library(openxlsx)

wordledata <- read_xlsx("~/Documents/Summer-Internship--24/Wordle Game - Survey (Responses) _Redacted.xlsx")
View(wordledata)

wordledata <- wordledata %>%
  rename(results = "Paste game results here")

# separate into proper rows
wordledata2 <- wordledata2 %>%
  # Convert the last column into a list of vectors
  mutate(results = strsplit(as.character(results), "---")) %>%
  # Unnest the list to create multiple rows
  unnest(results)

# break into columns (to be renamed later)
wordlesep <- wordledata2 %>%
  separate(results, into = c("Column1", "Column2", "Column3", "Column4", "Column5", 
                             "Column6", "Column7", "Column8", "Column9", "Column10", 
                             "Column11", "column12"), sep = ":", fill = "right") %>%
  filter(!is.na(Column3))


# remove rows w inconsistent data
wordlesep2 <- wordlesep[-c(63:72, 144, 187, 194, 197, 230:236, 281), ]

# remove extra characters from elements
wordlesep3 <- wordlesep2 %>%
  mutate(Column2 = substr(Column2, 7, nchar(Column2) - 6),
         Column3 = substr(Column3, 1, nchar(Column3) - 10),
         Column4 = substr(Column4, 1, nchar(Column4) - 6),
         Column5 = substr(Column5, 1, nchar(Column5) - 6),
         Column9 = substr(Column9, 1, nchar(Column9) - 17),
         Column10 = substr(Column10, 1, nchar(Column10) - 9)) %>%
  rename(class = "What class are you in of Dr. Williams?")
  
  
# renaming columns 
wordleclean <- wordlesep3 %>%
  select(Timestamp, ID, class, Column2, Column3, Column4, Column5, Column9, Column10, Column11) %>%
  rename(UserID = Column2,
         Word = Column3,
         Attempts = Column4,
         Date = Column5,
         Duration = Column9,
         Sequence.num = Column10,
         Guesses = Column11)

view(wordleclean)

# write.csv(wordleclean,"~/Documents/summer-2024-project/wordleclean.csv", row.names = TRUE)
# write.xlsx(wordleclean,"~/Documents/summer-2024-project/wordleclean.xlsx", rowNames = TRUE)