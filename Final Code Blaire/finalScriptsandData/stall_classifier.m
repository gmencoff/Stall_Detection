train_features = zeros(length(Stall_training),11);
test_features = zeros(length(Stall_test),11);

for u = 1:length(Stall_training)
    u
    train_features(u,1) = peak2rms(photonCount_training(u,:));
    train_features(u,2) = peak2peak(photonCount_training(u,:));
    train_features(u,3) = meanfreq(photonCount_training(u,:));
    train_features(u,4) = medfreq(photonCount_training(u,:));
    train_features(u,5) = pO2_training(u);
    train_features(u,6) = mean(photonCount_training(u,:));
    train_features(u,7) = std(photonCount_training(u,:));
    train_features(u,8) = mean(pentropy(photonCount_training(u,:),length(photonCount_training(u,:))/4)); %spectral entropy
%   train_features(u,9) = log(wentropy(photonCount_training(u,:),'shannon')); %shanon entropy
%   training_features(u,8) = approx_entropy(length(photonCount_training(u,:))/4,0.5,photonCount_training(u,:)); %using 1000/4 which means its 75ms window
    train_features(u,10) = snr(photonCount_training(u,:));
    train_features(u,11) = getFrequencyRangeAmplitude(photonCount_training(u,:),[30 500],.3/1000); %power
    train_features(u,12) = ar(photonCount_training(u,:),4);
end


for u = 1:length(Stall_test)
    u
    test_features(u,1) = peak2rms(photonCount_test(u,:));
    test_features(u,2) = peak2peak(photonCount_test(u,:));
    test_features(u,3) = meanfreq(photonCount_test(u,:));
    test_features(u,4) = medfreq(photonCount_test(u,:));
    test_features(u,5) = pO2_test(u);
    test_features(u,6) = mean(photonCount_test(u,:));
    test_features(u,7) = std(photonCount_test(u,:));
    test_features(u,8) = mean(pentropy(photonCount_test(u,:),length(photonCount_test(u,:))/4)); %spectral entropy
%   test_features(u,9) = wentropy(photonCount_test(u,:),'shannon'); %shanon entropy
%   test_features(u,8) = approx_entropy(length(photonCount_test(u,:))/4,0.5,photonCount_test(u,:)); %using 1000/4 which means its 75ms windows
    test_features(u,10) = snr(photonCount_test(u,:));
    test_features(u,11) = getFrequencyRangeAmplitude(photonCount_test(u,:),[30 500],.3/1000); %power?
    test_features(u,12) = ar(photonCount_test(u,:),4);
end


%% gets rid of all the NaN iterations 

idx_nan = find(isnan(train_features(:,1)) | isnan(train_features(:,2)) | isnan(train_features(:,3)) | isnan(train_features(:,4))|isnan(train_features(:,6)) | isnan(train_features(:,7)) | isnan(train_features(:,8)) | isnan(train_features(:,9))| isnan(train_features(:,10))| isnan(train_features(:,11)));
final_training_features = train_features;
final_training_features(idx_nan,:) = [];
final_Stall_training = Stall_training;
final_Stall_training(idx_nan) = [];

idx_nan = find(isnan(test_features(:,1)) | isnan(test_features(:,2)) | isnan(test_features(:,3)) | isnan(test_features(:,4))| isnan(test_features(:,6)) | isnan(test_features(:,7)) | isnan(test_features(:,8))| isnan(test_features(:,9)) | isnan(test_features(:,10)) | isnan(test_features(:,11)));
final_test_features = test_features;
final_test_features(idx_nan,:) = [];
final_Stall_test = Stall_test;
final_Stall_test(idx_nan) = [];

%% for generating toolbox data that includes both training and testing data 
all_training_data = [final_training_features; final_test_features];

all_prediction_data = [final_Stall_training; final_Stall_test];

normalize_all_data = all_training_data./max(all_training_data,[],1);

alltoolboxdata = [normalize_all_data all_prediction_data];

%% for generating toolbox data that only has training fdata
% all_training_data = [final_training_features];
% 
% all_prediction_data = [final_Stall_training];
% 
% normalize_all_data = all_training_data./max(all_training_data,[],1);
% 
% alltoolboxdata = [normalize_all_data all_prediction_data];