#load libraries
library("e1071")
library("RTextTools")
library("stringr") 
library("tm")

#read education apps reviews data
setwd("~/Desktop/BT2101/Assignments/Assignment 2/training_data/education")
path <- "~/Desktop/BT2101/Assignments/Assignment 2/training_data/education"
education_files = list.files(path, pattern="*.csv")
education_tables <- lapply(education_files, read.csv, header = TRUE)
education_df <- do.call(rbind, education_tables)

#remove all columns except review
education_df$X <- NULL
education_df$author <- NULL
education_df$date <- NULL
education_df$rating <- NULL
education_df$title <- NULL

#append target column "education" to each review
cat <- rep("education", nrow(education_df))
education_df <- cbind(education_df, cat)


#read finance apps reviews data
setwd("~/Desktop/BT2101/Assignments/Assignment 2/training_data/finance")
path <- "~/Desktop/BT2101/Assignments/Assignment 2/training_data/finance"
finance_files = list.files(path, pattern="*.csv")
finance_tables <- lapply(finance_files, read.csv, header = TRUE)
finance_df <- do.call(rbind, finance_tables)

#remove all columns except review
finance_df$X <- NULL
finance_df$author <- NULL
finance_df$date <- NULL
finance_df$rating <- NULL
finance_df$title <- NULL

#append target column "finance" to each review
cat <- rep("finance", nrow(finance_df))
finance_df <- cbind(finance_df, cat)


#read game apps reviews data
setwd("~/Desktop/BT2101/Assignments/Assignment 2/training_data/game")
path <- "~/Desktop/BT2101/Assignments/Assignment 2/training_data/game"
game_files = list.files(path, pattern="*.csv")
game_tables <- lapply(game_files, read.csv, header = TRUE)
game_df <- do.call(rbind, game_tables)

#remove all columns except review
game_df$X <- NULL
game_df$author <- NULL
game_df$date <- NULL
game_df$rating <- NULL
game_df$title <- NULL

#append target column "game" to each review
cat <- rep("game", nrow(game_df))
game_df <- cbind(game_df, cat)


#read social apps reviews data
setwd("~/Desktop/BT2101/Assignments/Assignment 2/training_data/social")
path <- "~/Desktop/BT2101/Assignments/Assignment 2/training_data/social"
social_files = list.files(path, pattern="*.csv")
social_tables <- lapply(social_files, read.csv, header = TRUE)
social_df <- do.call(rbind, social_tables)

#remove all columns except review
social_df$X <- NULL
social_df$author <- NULL
social_df$date <- NULL
social_df$rating <- NULL
social_df$title <- NULL

#append target column "social" to each review
cat <- rep("social", nrow(social_df))
social_df <- cbind(social_df, cat)


#read weather apps reviews data
setwd("~/Desktop/BT2101/Assignments/Assignment 2/training_data/weather")
path <- "~/Desktop/BT2101/Assignments/Assignment 2/training_data/weather"
weather_files = list.files(path, pattern="*.csv")
weather_tables <- lapply(weather_files, read.csv, header = TRUE)
weather_df <- do.call(rbind, weather_tables)

#remove all columns except review
weather_df$X <- NULL
weather_df$author <- NULL
weather_df$date <- NULL
weather_df$rating <- NULL
weather_df$title <- NULL

#append target column "weather" to each review
cat <- rep("weather", nrow(weather_df))
weather_df <- cbind(weather_df, cat)
