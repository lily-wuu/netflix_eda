# Netflix EDA Analysis ----

library(tidyverse)
library(here)
library(DT)

netflix <- read_csv(here("data/titles.csv"))

# type distribution ----
netflix |>
  ggplot(aes(type, fill = type)) +
  geom_bar()

# runtime distribution ----
netflix |>
  ggplot(aes(runtime, fill = type)) +
  geom_bar(alpha = 0.5)

# score relationship ----
netflix |>
  ggplot(aes(imdb_score, imdb_votes)) +
  geom_point() 

netflix |>
  ggplot(aes(age_certification)) +
  geom_bar()

netflix |>
  ggplot(aes(age_certification, imdb_score)) +
  geom_boxplot()


# score relationship ----
netflix |>
  ggplot(aes(tmdb_popularity, tmdb_score)) +
  geom_point() 

netflix |>
  ggplot(aes(imdb_score, tmdb_score, color = type)) +
  geom_point(alpha = 0.25) +
  geom_smooth(method = loess, ) 

# table creation ----
netflix |>
  select(title, type, seasons, genres, imdb_score, tmdb_score) |>
  datatable()

skimr::skim_without_charts(netflix)

  

