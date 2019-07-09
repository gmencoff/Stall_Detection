function [average_no_stall_dist,average_stall_dist] = averageDTWNN(time_series,trainingstallDataFile,kNN)
% This function takes a time series, and gets average dtw distance from
% kNN/20 random stall and no stall time series

[~,data_num] = size(trainingstallDataFile);
training_class = zeros(data_num,1);
training_time_series = zeros(data_num,length(time_series));

% insert training points
for itrain = 1:data_num
   training_class(itrain) = trainingstallDataFile(itrain).Stall;
   training_time_series(itrain,:) = trainingstallDataFile(itrain).Count_Data;
end

% get the training time series for stalls and no stalls
stall_time_series = training_time_series(training_class==1,:);
no_stall_time_series = training_time_series(training_class==0,:);

[num_stalls,~] = size(stall_time_series);
[num_no_stalls,~] = size(no_stall_time_series);

% fill in dtw distances for kNN random samples
dtw_stall = zeros(kNN,1);
dtw_no_stall = zeros(kNN,1);

stall_rand_used = zeros(kNN,1);
no_stall_rand_used = zeros(kNN,1);

for i = 1:kNN
   rand_stall = randi([1 num_stalls],1,1);
   rand_no_stall = randi([1 num_no_stalls],1,1);
   
   while sum(stall_rand_used == rand_stall) > 0
       rand_stall = randi([1 num_stalls],1,1);
   end
   while sum(no_stall_rand_used == rand_no_stall) > 0
       rand_no_stall = randi([1 num_no_stalls],1,1);
   end
   
   stall_rand_used(i) = rand_stall;
   no_stall_rand_used(i) = rand_no_stall;
    
   dtw_stall(i) = dtw(time_series,stall_time_series(rand_stall,:));
   dtw_no_stall(i) = dtw(time_series,no_stall_time_series(rand_no_stall,:));
end

% sort the two arrays
dtw_stall = sort(dtw_stall);
dtw_no_stall = sort(dtw_no_stall);

%compute average no stall distance and stall distance
average_stall_dist = mean(dtw_stall(1:kNN/20));
average_no_stall_dist = mean(dtw_no_stall(1:kNN/20));



end