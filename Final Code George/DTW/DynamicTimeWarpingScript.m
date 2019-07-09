%% get undersampled data and try dtw for distance measure

[training_time_series_undersampled,training_class_undersampled] = undersampling(training_time_series,training_class,4);

[testing_prediction_undersampled] = dtwNN(training_time_series_undersampled,training_class_undersampled,testing_time_series);

C_undersampled = confusionmat(testing_class,testing_prediction_undersampled);
