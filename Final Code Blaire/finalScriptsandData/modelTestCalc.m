%To make predictions on a new predictor column matrix, X, use:   
%yfit = c.predictFcn(X) replacing 'c' with the name of the variable that is this struct, e.g. 'trainedModel'.  
%X must contain exactly 12 columns because this model was trained using 12 predictors. 
%X must contain only predictor columns in exactly the same order and format as your training data.
%Do not include the response column or any columns you did not import into the app.  
%For more information, see <a href="matlab:helpview(fullfile(docroot, 'stats', 'stats.map'), 'appclassification_exportmodeltoworkspace')">How to predict using an exported model</a>.
%%
model_name = weightedKNN;
predicted_class = model_name.predictFcn(testing_input); 

results = predictionResults(predicted_class,actual_class);

function [prediction_results] = predictionResults(predicted_class,actual_class)
% accepts a prediction vector and actual vector, outputs 
%[correct_positives false_positives correct_negatives false_negatives]

predicted_positives = sum(predicted_class);
predicted_negatives = length(predicted_class)-predicted_positives;

true_positives = sum(((predicted_class==1)+(actual_class==1))==2);
true_negatives = sum(((predicted_class==0)+(actual_class==0))==2);

false_positives = predicted_positives-true_positives;
false_negatives = predicted_negatives-true_negatives;

prediction_results = [true_positives,false_positives,true_negatives,false_negatives];
end
