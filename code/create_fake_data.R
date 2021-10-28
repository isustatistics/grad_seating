library("tidyverse")


d <- data.frame(first = paste0("first", LETTERS[1:10]),
                last  = paste0("last",  LETTERS[1:10]),
                office = rep(paste0("office", LETTERS[1:2]), each = 5),
                seat = 1:5)

write_csv(d, file = "data/fake_data.csv")