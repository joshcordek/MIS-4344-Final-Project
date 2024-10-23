library(tidyverse)
nba_uncleaned_df <- read_csv("nbaplayersdraft.csv")
nba_cleaned_df <- nba_uncleaned_df %>%
  filter(!if_any(-college, is.na))
# Only need 4 main findings
