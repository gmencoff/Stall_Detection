function [testing_prediction] = dtwNN(training_time_series,training_class,testing_time_series)
%This is an implementation of dynamic time warping 1NN

[testing_points,~] = size(testing_time_series);
[training_points,~] = size(training_time_series);
testing_prediction = zeros(testing_points,1);

% for each testing point, find the location of the kNN, and check the
% training class to classify
for itest = 1:testing_points
   test_series = testing_time_series(itest,:);
   test_dist = dtw(test_series,training_time_series(1,:));
   best_index = 1;
   
   % compare test time series to each training time series and find index
   % of best choice
   for itrain = 2:training_points
       train_series = training_time_series(itrain,:);
       new_test_dist = dtw(test_series,train_series);
       
       if new_test_dist < test_dist
          test_dist = new_test_dist;
          best_index = itrain;
       end
       
   end
   
   %set testing prediction to best_index
   testing_prediction(itest) = training_class(best_index);
end

end

