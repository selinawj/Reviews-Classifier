#removing empty reviews
education_df <- na.omit(education_df)
finance_df <- na.omit(finance_df)
game_df <- na.omit(game_df)
social_df <- na.omit(social_df)
weather_df <- na.omit(weather_df)

#removing reviews that are less than 10 char long from the first 50,000 of each category
#EDUCATION
for (i in 1:50000) {
  edu = as.character(education_df[i,1])
  length = nchar(edu)
  if (length < 10) {
    education_df[i,] <- NA
  }
}

#FINANCE
for (i in 1:50000) {
  fin = as.character(finance_df[i,1])
  length = nchar(fin)
  if (length < 10) {
    finance_df[i,] <- NA
  }
}

#GAME
for (i in 1:50000) {
  game = as.character(game_df[i,1])
  length = nchar(game)
  if (length < 10) {
    game_df[i,] <- NA
  }
}

#SOCIAL
for (i in 1:50000) {
  soc = as.character(social_df[i,1])
  length = nchar(soc)
  if (length < 10) {
    social_df[i,] <- NA
  }
}

#WEATHER
for (i in 1:50000) {
  weather = as.character(weather_df[i,1])
  length = nchar(weather)
  if (length < 10) {
    weather_df[i,] <- NA
  }
}

education_df <- education_df[1:50000,]
education_df <- na.omit(education_df)
finance_df <- finance_df[1:50000,]
finance_df <- na.omit(finance_df)
game_df <- game_df[1:50000,]
game_df <- na.omit(game_df)
social_df <- social_df[1:50000,]
social_df <- na.omit(social_df)
weather_df <- weather_df[1:50000,]
weather_df <- na.omit(weather_df)

#using a smaller set of training data (large memory requirements)
training_data_50000 <- rbind(education_df[1:10000,], finance_df[1:10000,], game_df[1:10000,], social_df[1:10000,], weather_df[1:10000,])
testing_data_10000 <- rbind(education_df[10001:12000,], finance_df[10001:12000,], game_df[10001:12000,], social_df[10001:12000,], weather_df[10001:12000,])
dataset_60000 <- rbind(training_data_50000, testing_data_10000)

#removing non-words such as emoticons
dataset_pp <- dataset_60000
dataset_pp <- str_replace_all(dataset_pp[,1],"[^[:graph:]]", " ")

#change text to lower cases
dataset_pp <- tolower(dataset_pp)
#remove stop words
dataset_pp <- removeWords(dataset_pp, stopwords())
#remove punctuation
dataset_pp <- removePunctuation(dataset_pp)
#remove numbers
dataset_pp <- removeNumbers(dataset_pp)
#porter stemming
dataset_pp <- stemDocument(dataset_pp, language = "english")

#build dtm
dataset_pp <- as.data.frame(dataset_pp)
dtm <- create_matrix(dataset_pp[,1])

#remove sparse terms
dtm <- removeSparseTerms(dtm, 0.998) 
#weight by term freq
dtm <- weightTfIdf(dtm, normalize = TRUE)

#convert to matrix
mat <- as.matrix(dtm)

#train the model
#naive bayes learning algorithm
nb_classifier = naiveBayes(mat[1:50000,], as.factor(dataset_60000[1:50000,2]))

#produce predictions
predicted = predict(nb_classifier, mat[50001:60000,])

#generate confusion matrix
confusion_matrix = table(dataset_60000[50001:60000, 2], predicted)
#            education finance game social weather
#education       308      54 1155     19     464
#finance         144     248 1015     50     543
#game            105      42 1536     24     293
#social          102      95 1349    118     336
#weather          72      33 1275     19     601

#calculate recall_accuracy
recall_accuracy(dataset_60000[50001:60000, 2], predicted)
#0.2811