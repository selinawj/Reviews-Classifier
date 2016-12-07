#removing empty reviews
education_df <- na.omit(education_df)
finance_df <- na.omit(finance_df)
game_df <- na.omit(game_df)
social_df <- na.omit(social_df)
weather_df <- na.omit(weather_df)

#using a smaller subset of training and testing data
training_data_5000 <- rbind(education_df[1:1000,], finance_df[1:1000,], game_df[1:1000,], social_df[1:1000,], weather_df[1:1000,])
testing_data_1000 <- rbind(education_df[1001:1200,], finance_df[1001:1200,], game_df[1001:1200,], social_df[1001:1200,], weather_df[1001:1200,])
dataset_6000 <- rbind(training_data_5000, testing_data_1000)

dataset_pp <- dataset_6000
dataset_pp <- str_replace_all(dataset_pp[,1],"[^[:graph:]]", " ")
dataset_pp <- tolower(dataset_pp)
dataset_pp <- removeWords(dataset_pp, stopwords())
dataset_pp <- removePunctuation(dataset_pp)
dataset_pp <- removeNumbers(dataset_pp)
dataset_pp <- stemDocument(dataset_pp, language = "english")

#build dtm
dataset_pp <- as.data.frame(dataset_pp)
dtm <- create_matrix(dataset_pp[,1])
dtm <- removeSparseTerms(dtm, 0.998) 
dtm <- weightTfIdf(dtm, normalize = TRUE)
mat <- as.matrix(dtm)

#train the model
#naive bayes learning algorithm
nb_classifier = naiveBayes(mat[1:5000,], as.factor(dataset_6000[1:5000,2]))

#produce predictions
predicted = predict(nb_classifier, mat[5001:6000,])

#generate confusion matrix
confusion_matrix = table(dataset_6000[5001:6000, 2], predicted)
#          education finance game social weather
#education         4       0  177     13       6
#finance          20       3  151     14      12
#game              8       0  176      7       9
#social           16       0  155     17      12
#weather           3       0  173     14      10

#calculate recall_accuracy
recall_accuracy(dataset_6000[5001:6000, 2], predicted)
#0.21