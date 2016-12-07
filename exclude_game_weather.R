#removing empty reviews
education_df <- na.omit(education_df)
finance_df <- na.omit(finance_df)
social_df <- na.omit(social_df)
weather_df <- na.omit(weather_df)

#excluding game
training_data_40000 <- rbind(education_df[1:10000,], finance_df[1:10000,], social_df[1:10000,], weather_df[1:10000,])
testing_data_8000 <- rbind(education_df[10001:12000,], finance_df[10001:12000,], social_df[10001:12000,], weather_df[10001:12000,])
dataset_48000 <- rbind(training_data_40000, testing_data_8000)

#removing non-words such as emoticons
dataset_pp <- dataset_48000
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
nb_classifier = naiveBayes(mat[1:40000,], as.factor(dataset_48000[1:40000,2]))

#produce predictions
predicted = predict(nb_classifier, mat[40001:48000,])

#generate confusion matrix
confusion_matrix = table(dataset_48000[40001:48000, 2], predicted)
#            education finance social weather
#education       341      37    138    1484
#finance         263     173    243    1321
#social          154      64    263    1519
#weather         244      54    124    1578

#calculate recall_accuracy
recall_accuracy(dataset_48000[40001:48000, 2], predicted)
#0.294375

#excluding game & weather 
training_data_30000 <- rbind(education_df[1:10000,], finance_df[1:10000,], social_df[1:10000,])
testing_data_6000 <- rbind(education_df[10001:12000,], finance_df[10001:12000,], social_df[10001:12000,])
dataset_36000 <- rbind(training_data_30000, testing_data_6000)

#removing non-words such as emoticons
dataset_pp <- dataset_36000
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
nb_classifier = naiveBayes(mat[1:30000,], as.factor(dataset_36000[1:30000,2]))

#produce predictions
predicted = predict(nb_classifier, mat[30001:36000,])

#generate confusion matrix
confusion_matrix = table(dataset_36000[30001:36000, 2], predicted)
#            education finance social
#education      1358      91    551
#finance         929     355    716
#social         1164     167    669

#calculate recall_accuracy
recall_accuracy(dataset_36000[30001:36000, 2], predicted)
#0.397