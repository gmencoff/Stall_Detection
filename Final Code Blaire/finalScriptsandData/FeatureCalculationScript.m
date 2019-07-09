%% generate training and testing data

[training_input,training_class] = getFeatureArraywithdtw(stallTrainingData,stallTrainingData);
[testing_input,testing_class] = getFeatureArraywithdtw(stallTestingData,stallTrainingData);

%% generate undersampled data

[undersampled_training_input_1_1,undersampled_training_class_1_1] = undersampling(training_input,training_class,1);
[undersampled_training_input_4_1,undersampled_training_class_4_1] = undersampling(training_input,training_class,4);