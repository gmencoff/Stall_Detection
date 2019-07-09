function [model_input,class] = getFeatureArraywithdtw(stallDataFile,trainingstallDataFile)
% output a model input array and a class vector based on a stall data file
    feature_num = 13;
    [~,num_data_points] = size(stallDataFile);
    model_input = zeros(num_data_points,feature_num);
    class = zeros(num_data_points,1);
    
    for iData = 1:num_data_points
        count_data = stallDataFile(iData).Count_Data;
        po2 = stallDataFile(iData).PO2_Data;
        
        model_input(iData,1) = mean(count_data);
        model_input(iData,2) = std(count_data);
        model_input(iData,3) = po2;
        model_input(iData,4) = mean(pentropy(count_data,length(count_data)/4)); %spectral entropy
        model_input(iData,5) = snr(count_data);
        model_input(iData,6) = getFrequencyRangeAmplitude(count_data,[30 500],.3/1000); % fraction of power contained in lower frequencies
        
        %[model_input(iData,7),model_input(iData,8)] = averageDTWNN(count_data,trainingstallDataFile,100); % get the average dtw distance to the 5 nearest training samples with and without stall
        model_input(iData,9) = peak2rms(count_data);
        model_input(iData,10) = peak2peak(count_data);
        model_input(iData,11) = meanfreq(count_data);
        model_input(iData,12) = medfreq(count_data);
        
        class(iData)= stallDataFile(iData).Stall;
    end

end

function [power_fraction] = getFrequencyRangeAmplitude(Data,freq_range,tx)
%% getFrequencyRangeAmplitude function
%This function takes in a frequency range and dataset and outputs the
%amount of energy contained in that frequency range

% data = amp data
% freq_range = range of frequencies to measure energy, [30 500] seems like
% a good range for this dataset
% tx = the amount of time that passes between data points
L = length(Data);
tx = tx; % sampling period
centered_data = Data-mean(Data); % center the data at 0 to remove the DC freq
ft = fft(centered_data); % fourier transform of the data
ft_centered = fftshift(ft); % center the fourier transform
power = abs(ft_centered).^2; % gets the power of the signal at all frequencies

f_max = 1/tx; % get max freq
f_step = (1/(L/2))*f_max; % step size of f
num_data_points_bottom = round(freq_range(1)/f_step);
num_data_points_top = round(freq_range(2)/f_step); % calculate how many data points to count from 0 Hz to X Hz

power_in_range_desired = sum(power((L/2+1+num_data_points_bottom):(L/2+1+num_data_points_top)));% sum the power over the frequency ranges from 0-200 HZ
power_total = sum(power((L/2+1):L));
power_fraction = power_in_range_desired/power_total;

end

function [apen] = approx_entropy(n,r,a)
%% Code for computing approximate entropy for a time series: Approximate
% Entropy is a measure of complexity. It quantifies the unpredictability of
% fluctuations in a time series
% To run this function- type: approx_entropy('window length','similarity measure','data set')
% i.e  approx_entropy(5,0.5,a)
% window length= length of the window, which should be considered in each iteration
% similarity measure = measure of distance between the elements
% data set = data vector
% small values of apen (approx entropy) means data is predictable, whereas
% higher values mean that data is unpredictable
% concept boorowed from http://www.physionet.org/physiotools/ApEn/
% Author: Avinash Parnandi, parnandi@usc.edu, http://robotics.usc.edu/~parnandi/

data =a;
for m=n:n+1; % run it twice, with window size differing by 1
set = 0;
count = 0;
counter = 0;
window_correlation = zeros(1,(length(data)-m+1));
for i=1:(length(data))-m+1,
    current_window = data(i:i+m-1); % current window stores the sequence to be compared with other sequences
    
    for j=1:length(data)-m+1,
    sliding_window = data(j:j+m-1); % get a window for comparision with the current_window
    
    % compare two windows, element by element
    % can also use some kind of norm measure; that will perform better
    for k=1:m,
        if((abs(current_window(k)-sliding_window(k))>r) && set == 0)
            set = 1; % i.e. the difference between the two sequence is greater than the given value
        end
    end
    if(set==0) 
         count = count+1; % this measures how many sliding_windows are similar to the current_window
    end
    set = 0; % reseting 'set'
    
    end
   counter(i)=count/(length(data)-m+1); % we need the number of similar windows for every cuurent_window
   count=0;
i;
end  %  for i=1:(length(data))-m+1, ends here
counter;  % this tells how many similar windows are present for each window of length m
%total_similar_windows = sum(counter);
%window_correlation = counter/(length(data)-m+1);
correlation(m-n+1) = ((sum(counter))/(length(data)-m+1));
 end % for m=n:n+1; % run it twice   
   correlation(1);
   correlation(2);
apen = log(correlation(1)/correlation(2));
end