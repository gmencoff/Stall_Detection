function [shuffledData] = shuffle(stallDataFile)
%% Takes stall data struct as input and shuffles by rows 
fields = {'Experiment','Run','Point','Iteration','Count_Data','PO2_Data','Usable_Flux','Stall','Index'} 
c = cell(length(fields),length(stallDataFile));
shuffledData = cell2struct(c,fields);

randIts = randperm(length(stallDataFile));

for i = randIts
    shuffledData(i).Experiment = stallDataFile(i).Experiment;
    shuffledData(i).Run = stallDataFile(i).Run;
    shuffledData(i).Point = stallDataFile(i).Point;
    shuffledData(i).Iteration = stallDataFile(i).Iteration;
    shuffledData(i).Count_Data = stallDataFile(i).Count_Data;
    shuffledData(i).PO2_Data = stallDataFile(i).PO2_Data;
    shuffledData(i).Usable_Flux = stallDataFile(i).Usable_Flux;
    shuffledData(i).Stall = stallDataFile(i).Stall;
    shuffledData(i).Index = stallDataFile(i).Index;
end
