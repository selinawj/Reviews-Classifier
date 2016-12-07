#removing empty reviews
education_df <- na.omit(education_df)
finance_df <- na.omit(finance_df)
game_df <- na.omit(game_df)
social_df <- na.omit(social_df)
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

#remove additional list of stop words
newStopWords <- readLines('http://jmlr.csail.mit.edu/papers/volume5/lewis04a/a11-smart-stop-list/english.stop')
myStopWords <- c(stopwords(), newStopWords)
dataset_pp <- removeWords(dataset_pp, myStopWords)

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
#education        86      14 1624     14     262
#finance          86      86 1242     67     519
#game             24       8 1859     11      98
#social           28      22 1631     72     247
#weather          47       5 1450     33     465

#calculate recall_accuracy
recall_accuracy(dataset_60000[50001:60000, 2], predicted)
#0.2568

colnames(mat)