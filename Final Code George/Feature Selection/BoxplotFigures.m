total_data = [training_input;testing_input];
total_class = [training_class;testing_class];

data_labels = {};

% create data labels
for i = 1:length(total_class)
    if total_class(i) == 1
        data_labels = [data_labels;['Stall']];
    else
        data_labels = [data_labels;['No Stall']];
    end
end

feature_list = {'Mean','Standard Deviation','PO2 Value','Mean Spectral Entropy','Signal to Noise Ratio','Power 30-500 Hz','DTW Non Stall','DTW Stall','Peak To RMS','Signal Amplitude','Average Frequency','Median Frequency'};
p = zeros(length(feature_list),1);

for i = 1:length(feature_list)
   subplot(4,3,i)
   h = boxplot(total_data(:,i),data_labels,'notch','on');
   title(feature_list{i},'FontSize',16)
end
for i = 1:length(feature_list)
   p(i) = anova1(total_data(:,i),data_labels);
end



