function [undersampled_training_input,undersampled_training_class] = undersampling(training_input,training_class,Ratio)
% create a training input with even number of 1 and 0 (undersampling) sampled randomly

stall_inputs = training_input(training_class==1,:);
[num_stall,~] = size(stall_inputs);

no_stall_inputs = training_input(training_class==0,:);
[num_no_stall,~] = size(no_stall_inputs);

undersampled_training_class = ones(num_stall,1);
undersampled_training_input = training_input(training_class==1,:);

no_stall_array = randi([1 num_no_stall],num_stall*Ratio,1);

% ensure no duplicates
for i = 1:num_stall*Ratio
   while sum(no_stall_array==no_stall_array(i)) > 1
      no_stall_array(i) = randi([1 num_no_stall],1,1);
   end
end

undersampled_training_input = [undersampled_training_input;training_input(no_stall_array,:)];
undersampled_training_class = [undersampled_training_class;zeros(num_stall*Ratio,1)];
end

