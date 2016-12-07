training_data <- rbind(education_df, finance_df, game_df, social_df, weather_df)

#using a smaller set of training data (large memory requirements)
training_data_50000 <- rbind(education_df[1:10000,], finance_df[1:10000,], game_df[1:10000,], social_df[1:10000,], weather_df[1:10000,])
testing_data_10000 <- rbind(education_df[10001:12000,], finance_df[10001:12000,], game_df[10001:12000,], social_df[10001:12000,], weather_df[10001:12000,])
dataset_60000 <- rbind(training_data_50000, testing_data_10000)

#build dtm
matrix <- create_matrix(dataset_60000[,1], language="english", removeStopwords=T, removeNumbers=T,stemWords=T, toLower=T, removePunctuation=T, removeSparseTerms=0.998, weighting = weightTfIdf)
mat = as.matrix(matrix)

#train the model
#naive bayes learning algorithm
nb_classifier = naiveBayes(mat[1:50000,], as.factor(dataset_60000[1:50000,2]))

#produce predictions
predicted = predict(nb_classifier, mat[50001:60000,])

#generate confusion matrix
confusion_matrix = table(dataset_60000[50001:60000, 2], predicted)
#          education finance game social weather
#education       119      16 1585     46     234
#finance         102     192 1047    135     524
#game             28      11 1771     33     157
#social           57      32 1494    142     275
#weather          44      27 1252     74     603

#calculate recall_accuracy
recall_accuracy(dataset_60000[50001:60000, 2], predicted)
#0.2827