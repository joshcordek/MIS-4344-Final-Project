library(tidyverse)
uncleaned_df <- read_csv("nbaplayersdraft.csv")
cleaned_df <- na.omit(uncleaned_df)
