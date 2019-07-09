%% Combine input and class for app

training_total = [training_input training_class];
us_total_1_1 = [undersampled_training_input_1_1 undersampled_training_class_1_1];
us_total_4_1 = [undersampled_training_input_4_1 undersampled_training_class_4_1];

%%

model = us11_lin_SVM_sig_feats;

test_input_reduced = [testing_input(:,2:6) testing_input(:,8:9) testing_input(:,12)];
prediction = model.predictFcn(test_input_reduced);

C = confusionmat(testing_class,prediction);


