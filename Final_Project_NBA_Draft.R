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

#We will predict the expected win share for a top 5 draft pick.
library(rpart)
library(rpart.plot)

top_5_picks <- nba_cleaned_df[nba_cleaned_df$overall_pick <= 5, ]

formula <- win_shares ~ points_per_game + average_assists + average_total_rebounds

top_5_tree <- rpart(formula, data = top_5_picks, method = "anova")
rpart.plot(top_5_tree, type = 2, extra = 101, under = TRUE, faclen = 0,
           main = "Decision Tree for Predicting Career Win Shares")
summary(top_5_tree)
