library(tidyverse)
nba_uncleaned_df <- read_csv("nbaplayersdraft.csv")
nba_cleaned_df <- nba_uncleaned_df %>%
  filter(!if_any(-college, is.na))
# Only need 4 main findings
#Based on a player's PPG, we can predict their average win_share for the season.
library(ggplot2)
ppg_winshare_model <- lm(win_shares ~ points_per_game, data = nba_cleaned_df)

summary(ppg_winshare_model)

ggplot(nba_cleaned_df, aes(x = points_per_game, y = win_shares)) +
  geom_point(alpha = 0.6) +
  geom_smooth(method = "lm", color = "blue", se = FALSE) +
  labs(
    title = "Prediction of Win Shares Based on Points per Game",
    x = "Points per Game (PPG)",
    y = "Career Win Shares"
  ) +
  theme_minimal()
