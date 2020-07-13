%% READ IN DATA

clc
clear all
close all

load('F:\ANALYZED_DATA\MAT Files\2P\2P_Data.mat');
indices = load('F:\ANALYZED_DATA\MAT Files\2P\2PTrial_Indices.mat', 'Penetrators_Lumen_ALL');
indices = indices.Penetrators_Lumen_ALL;
maxBouts = 5;
bouts = cell(1,3);

%% SELECT BOUTS

fig = figure(1); fig.WindowState = 'maximized';

counter = 0;
counter2 = 0;

for i = indices
    counter2 = counter2 + 1;
    
    if(~isempty(TwoPhoton_All.TwoPhoton_Behavior{i}))
        counter = counter + 1;
        
        BehaviorID = [TwoPhoton_All.Image_ID{i} '_' TwoPhoton_All.Trial{i}];
        BehaviorTrace = resample(TwoPhoton_All.TwoPhoton_Behavior{i},704,size(TwoPhoton_All.TwoPhoton_Behavior{i},1));
        clf
        line1 = xline(30,'r','LineWidth',2);
        line2 = xline(60,'r','LineWidth',2);
        hold on; plot((1:704)/3.91,BehaviorTrace); hold off; xlim([0 180]); yLimits = ylim;

        title([int2str(counter2) ': ' BehaviorID],'Interpreter','None');
        
        for k = 1:maxBouts
            disp(['Bout: ' int2str(k)])
            [pointslist,xselect,~] = selectdata('SelectionMode','Rect','ignore',[line1 line2]);
            if(~isempty(pointslist))
                bouts{counter,1} = BehaviorID; %name
                bouts{counter,2} = [bouts{counter,2}; xselect(1) xselect(size(xselect,1))]; %endpoints
                if ((xselect(1) > 30) && (xselect(size(xselect,1)) < 60))
                    bouts{counter,3} = [bouts{counter,3};2];
                elseif (xselect(size(xselect,1)) < 30)
                    bouts{counter,3} = [bouts{counter,3};1];
                elseif (xselect(1) > 60)
                    bouts{counter,3} = [bouts{counter,3};3];
                else
                    bouts{counter,3} = [bouts{counter,3};0];
                end %states:0=Overlap;1=Baseline;2=Stim;3=Recovery;empty=Overlap
                pointslist = []; xselect = []; yselect =[];
            end
        end
    end
end

%% EXTRACT ENDPOINTS

clearvars -except maxBouts bouts TwoPhoton_All

[varTypes{1:maxBouts*size(bouts,1)}] = deal('double');
bouts_specs = table('Size',[4 maxBouts*size(bouts,1)],'VariableTypes',varTypes);

counter = 1;
for i = 1:size(bouts,1)
    if(~isempty(bouts{i,1}))
        colTitle = bouts{i,1};
        for j = 1:size(bouts{i,2},1)
            bouts_specs.Properties.VariableNames{counter} = [colTitle '_bout' int2str(j)];
            bouts_specs{2,counter} = bouts{i,2}(j,1); % onset
            bouts_specs{3,counter} = bouts{i,2}(j,2); % offset
            bouts_specs{1,counter} = bouts_specs{2,counter} - 10; % startpoint
            if(bouts_specs{1,counter} < 0)
                disp([bouts_specs.Properties.VariableNames{counter} ' UNDER'])
            end
            bouts_specs{4,counter} = bouts_specs{3,counter} + 10; % endpoint
            if(bouts_specs{4,counter} > 179.9)
                disp([bouts_specs.Properties.VariableNames{counter} ' OVER'])
            end
            counter = counter + 1;
        end
    end
end

bouts_specs = bouts_specs(:,~all(bouts_specs{:,:}==0));


%% EXTRACT TRACES OF BOUTS

%bouts_specs = bouts_specs_basal;
bouts_specs = bouts_specs_stim;
bouts_specs = table2struct(bouts_specs);
columns = fieldnames(bouts_specs);

for i = 1:numel(fieldnames((bouts_specs)))
    
    currentBoutColumn = columns{i,1};
    currentMainColumn = split(currentBoutColumn,'_');
    Image_ID = currentMainColumn{1,1};
    Trial = currentMainColumn{2,1};
   
    currentStartIndex = round(3.91*bouts_specs(1).(columns{i,1}));
    currentOnsetIndex = round(3.91*bouts_specs(2).(columns{i,1}));
    currentOffsetIndex = round(3.91*bouts_specs(3).(columns{i,1}));
    currentEndIndex = round(3.91*bouts_specs(4).(columns{i,1}));
    
    x = 1:currentEndIndex-currentStartIndex+1;
    
    try
    currentPenetratorCalcium = TwoPhoton_All{strcmp(TwoPhoton_All.Image_ID,Image_ID) &...
        strcmp(TwoPhoton_All.Trial,Trial) & strcmp(TwoPhoton_All.Compartment,'penetrator') &...
        strcmp(TwoPhoton_All.Channel,'calcium'),7}{1,1};
    bout_PenetratorCalcium(x) = currentPenetratorCalcium(currentStartIndex:currentEndIndex);
    bouts_specs(5).(columns{i,1}) = bout_PenetratorCalcium;
    catch
        currentPenetratorCalcium = [];
    end
    
    try
    currentFirstOrderCalcium = TwoPhoton_All{strcmp(TwoPhoton_All.Image_ID,Image_ID) &...
        strcmp(TwoPhoton_All.Trial,Trial) & strcmp(TwoPhoton_All.Compartment,'firstOrder') &...
        strcmp(TwoPhoton_All.Channel,'calcium'),7}{1,1};
    bout_FirstOrderCalcium(x) = currentFirstOrderCalcium(currentStartIndex:currentEndIndex);
    bouts_specs(6).(columns{i,1}) = bout_FirstOrderCalcium;
    catch
        currentFirstOrderCalcium = [];
    end
    
    try
    currentPenetratorLumen = TwoPhoton_All{strcmp(TwoPhoton_All.Image_ID,Image_ID) &...
        strcmp(TwoPhoton_All.Trial,Trial) & strcmp(TwoPhoton_All.Compartment,'penetrator') &...
        strcmp(TwoPhoton_All.Channel,'lumen'),7}{1,1};
    bout_PenetratorLumen(x) = currentPenetratorLumen(currentStartIndex:currentEndIndex);
    bouts_specs(7).(columns{i,1}) = bout_PenetratorLumen;
    catch
        currentPenetratorLumen = [];
    end
    
    try
    currentFirstOrderLumen = TwoPhoton_All{strcmp(TwoPhoton_All.Image_ID,Image_ID) &...
        strcmp(TwoPhoton_All.Trial,Trial) & strcmp(TwoPhoton_All.Compartment,'firstOrder') &...
        strcmp(TwoPhoton_All.Channel,'lumen'),7}{1,1};
    bout_FirstOrderLumen(x) = currentFirstOrderLumen(currentStartIndex:currentEndIndex);
    bouts_specs(8).(columns{i,1}) = bout_FirstOrderLumen;
    catch
        currentFirstOrderLumen = [];
    end
    
    try
    currentBehavior = TwoPhoton_All{strcmp(TwoPhoton_All.Image_ID,Image_ID) &...
        strcmp(TwoPhoton_All.Trial,Trial) & strcmp(TwoPhoton_All.Compartment,'penetrator') &...
        strcmp(TwoPhoton_All.Channel,'calcium'),8}{1,1}; %Behavior trace is same for all ROIs of an image, so use any one!
    currentBehavior = resample(currentBehavior,704,size(currentBehavior,1));
    bout_Behavior(x) = currentBehavior(currentStartIndex:currentEndIndex);
    bouts_specs(9).(columns{i,1}) = bout_Behavior;
    catch
        currentBehavior = [];
    end
    
    %bouts_specs_basal = bouts_specs;
    bouts_specs_stim = bouts_specs;
    
    clearvars -except basal_indices stim_indices TwoPhoton_All...
        bouts bouts_specs bouts_specs_basal bouts_specs_stim columns
    
end


%% EXTRACT SUBSET AND COMPILE

%bouts_specs = bouts_specs_basal;
bouts_specs = bouts_specs_stim;

fields = fieldnames(bouts_specs);

for i = 1:size(fields,1)
    
    temp = (bouts_specs(5).(fields{i}))';
    temp = temp./abs(mean(temp(19:39,1)));
    bouts_specs(5).(fields{i}) = temp;
    temp = (bouts_specs(6).(fields{i}))';
    temp = temp./abs(mean(temp(19:39,1)));
    bouts_specs(6).(fields{i}) = temp;
    temp = (bouts_specs(7).(fields{i}))';
    temp = temp./abs(mean(temp(19:39,1)));
    bouts_specs(7).(fields{i}) = temp;
    temp = (bouts_specs(8).(fields{i}))';
    temp = temp./abs(mean(temp(19:39,1)));
    bouts_specs(8).(fields{i}) = temp;
    temp = (bouts_specs(9).(fields{i}))';
    temp = temp./abs(mean(temp(19:39,1)));
    bouts_specs(9).(fields{i}) = temp;
    
end

%bouts_specs_basal = bouts_specs;
bouts_specs_stim = bouts_specs;

% penetratorCalcium_Full = zeros(1,78); firstOrderCalcium_Full = zeros(1,78);
% penetratorLumen_Full = zeros(1,78); firstOrderLumen_Full = zeros(1,78);
penetratorCalcium_Full = zeros(1,78); firstOrderCalcium_Full = zeros(1,78);
penetratorLumen_Full = zeros(1,78); firstOrderLumen_Full = zeros(1,78);

for i = 1:size(fields,1)
penetratorCalcium_Full = padconcat(penetratorCalcium_Full,(bouts_specs(5).(fields{i}))',1);
firstOrderCalcium_Full = padconcat(firstOrderCalcium_Full,(bouts_specs(6).(fields{i}))',1);
penetratorLumen_Full = padconcat(penetratorLumen_Full,(bouts_specs(7).(fields{i}))',1);
firstOrderLumen_Full = padconcat(firstOrderLumen_Full,(bouts_specs(8).(fields{i}))',1);
end

penetratorCalcium_Full(1,:) = []; firstOrderCalcium_Full(1,:) = [];
penetratorLumen_Full(1,:) = []; firstOrderLumen_Full(1,:) = [];

% basal_penetratorCalcium_Full = penetratorCalcium_Full;
% basal_firstOrderCalcium_Full = firstOrderCalcium_Full;
% basal_penetratorLumen_Full = penetratorLumen_Full;
% basal_firstOrderLumen_Full = firstOrderLumen_Full;
stim_penetratorCalcium_Full = penetratorCalcium_Full;
stim_firstOrderCalcium_Full = firstOrderCalcium_Full;
stim_penetratorLumen_Full = penetratorLumen_Full;
stim_firstOrderLumen_Full = firstOrderLumen_Full;
