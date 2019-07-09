function [prediction_results] = predictionResults(predicted_class,actual_class)
% accepts a prediction vector and actual vector, outputs 
%[correct_positives false_positives correct_negatives false_negatives]

predicted_positives = sum(predicted_class);
predicted_negatives = length(predicted_class)-predicted_positives;

correct_positives = sum(((predicted_class==1)+(actual_class==1))==2);
correct_negatives = sum(((predicted_class==0)+(actual_class==0))==2);

false_positives = predicted_positives-correct_positives;
false_negatives = predicted_negatives-correct_negatives;

prediction_results = [correct_positives,false_positives,correct_negatives,false_negatives];
end
