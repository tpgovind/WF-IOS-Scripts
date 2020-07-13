%% READ IN DATA

clc
clearvars -except indices fullHbO fullHbR fullBehavior maxBouts WFTrials
close all

HbO = table(); HbR = table(); Behavior = table();

IDs = {'M1','M2','M3','M4','M5','M6','M7','M9','M10','M11',...
    'M11_AFTER_C21','M12','M12_AFTER_1st_C21',...
    'M12_AFTER_2nd_C21','M12_AFTER_3rd_C21','M13',...
    'M13_AFTER_1st_C21','M13_AFTER_2nd_C21','M14',...
    'M14_AFTER_C21','M15','M15_AFTER_C21','M16','M16_AFTER_C21',...
    'M17','M18','M18_FITC','M19','M20','M21','M22','M23','M24',...
    'M25','M26','M28','M29','M29_FITC','M30','M31','M32','M33','M34',...
    'M35','M36','M37','M38','M39','M40','M41','M42','M43','M44','M45',...
    'M46','M48','M49','M50','M51','M52','M53','M54','M55','M56','M57',...
    'M58','M59'}';

colors = {[197/255 0 48/255],[1 159/25 184/255],...
    [0 137/255 192/255],[183/255 235/25 1],...
    [0 0 0],[85/255 85/255 85/255],...
    [0 165/255 104/255],[147/255 1 215/255],...
    [1 212/255 0],[1 247/255 204/255]}; %HbOx2, HbRx2, HbTx2, GCaMPx2, Stimx2

for i = indices
    
    low = 20*(i-1)+1; high = 20*i;
    partialHbO = fullHbO(:,low:high);
    partialHbR = fullHbR(:,low:high);
    partialBehavior = fullBehavior(:,low:high);
    HbO = [HbO partialHbO];
    HbR = [HbR partialHbR];
    Behavior = [Behavior partialBehavior];
    
end

if(WFTrials)
HbO(:,all(ismissing(HbO)))=[];
temp = HbO(300:598,:);
HbO = temp;
HbR(:,all(ismissing(HbR)))=[];
temp = HbR(300:598,:);
HbR = temp;
Behavior(:,all(ismissing(Behavior)))=[];
temp = Behavior(300:598,:);
Behavior = temp;
end

%% SELECT BOUTS

bouts = cell(maxBouts,2);

for i = 55:size(Behavior,2)
    clc
    if(WFTrials)
        plot((1:299)/10,table2array(Behavior(:,i))); title(strcat(int2str(i),{' :: '},strrep(HbO.Properties.VariableNames(i),'_',' - ')));
    else
        plot((1:1799)/10,table2array(Behavior(:,i))); title(strcat(int2str(i),{' :: '},strrep(HbO.Properties.VariableNames(i),'_',' - ')));
        xticks(0:10:180);
    end
    
    input('')
%     for k = 1:maxBouts
%         
%         disp(['Bout: ' int2str(k)])
%         [pointslist,xselect,~] = selectdata('SelectionMode','Rect');
%         
%         if(~isempty(pointslist))
%             bouts{i,1} = Behavior.Properties.VariableNames(i); %name
%             bouts{i,2} = [bouts{i,2}; xselect(1) xselect(size(xselect,1))]; %endpoints
%             pointslist = []; xselect = []; yselect =[];
%         end
%     end
end


%% EXTRACT ENDPOINTS

[varTypes{1:760}] = deal('double');
bouts_specs = table('Size',[4 760],'VariableTypes',varTypes);

counter = 1;
for i = 1:95
    if(~isempty(bouts{i,1}))
        colTitle = bouts{i,1}{1,1};
        for j = 1:size(bouts{i,2},1)
            bouts_specs.Properties.VariableNames{counter} = [colTitle '_bout' int2str(j)];
            bouts_specs{2,counter} = bouts{i,2}(j,1); % onset
            bouts_specs{3,counter} = bouts{i,2}(j,2); % offset
            bouts_specs{1,counter} = bouts_specs{2,counter} - 10; % startpoint
            if(bouts_specs{1,counter} < 0)
                disp([bouts_specs.Properties.VariableNames{counter} 'UNDER'])
            end
            bouts_specs{4,counter} = bouts_specs{3,counter} + 10; % endpoint
            if(bouts_specs{4,counter} > 179.9)
                disp([bouts_specs.Properties.VariableNames{counter} 'OVER'])
            end
            counter = counter + 1;
        end
    end
end

bouts_specs = bouts_specs(:,~all(bouts_specs{:,:}==0));


%% EXTRACT TRACES OF BOUTS

clc
clear all
close all

mode = 'trials';

if(strcmp(mode,'basals'))
    load('F:\ANALYZED_DATA\MAT Files\WF\WF_Basals.mat', 'WF_Behavior_Basals', 'WF_HbO_Basals', 'WF_HbR_Basals')
    load('F:\ANALYZED_DATA\MAT Files\Behavioral State\WF_Basal_Bouts.mat', 'bouts_specs')
    HbO = WF_HbO_Basals; HbR = WF_HbR_Basals; Behavior = WF_Behavior_Basals;
else
    load('F:\ANALYZED_DATA\MAT Files\WF\WF_Trials.mat', 'WF_Behavior_Trials', 'WF_HbO_Trials', 'WF_HbR_Trials')
    load('F:\ANALYZED_DATA\MAT Files\Behavioral State\WF_Trial_Bouts.mat', 'bouts_specs')
    HbO = WF_HbO_Trials; HbR = WF_HbR_Trials; Behavior = WF_Behavior_Trials;
end

clearvars -except HbO HbR Behavior bouts_specs

%bouts_specs = table2struct(bouts_specs);
columns = fieldnames(bouts_specs);
SF = 100/log(10);

for i = 1:numel(fieldnames((bouts_specs)))
    
    currentBoutColumn = columns{i,1};
    currentMainColumn = split(currentBoutColumn,'_');
    currentMainColumn = strcat(currentMainColumn{1,1},'_',currentMainColumn{2,1});
    currentStartIndex = 10*bouts_specs(1).(columns{i,1});
    currentOnsetIndex = 10*bouts_specs(2).(columns{i,1});
    currentOffsetIndex = 10*bouts_specs(3).(columns{i,1});
    currentEndIndex = 10*bouts_specs(4).(columns{i,1});
    currentLength = currentEndIndex - currentStartIndex + 1;

    currentHbO = HbO.(currentMainColumn);
    currentHbR = HbR.(currentMainColumn);
    currentBehavior = Behavior.(currentMainColumn);
    
    if(currentStartIndex < 0)

        x0 = 1:abs(currentStartIndex)+1;
        x1 = abs(currentStartIndex)+1:abs(currentStartIndex)+currentEndIndex;
        
        bout_HbO_0(x0) = deal(currentHbO(1,1));
        bout_HbR_0(x0) = deal(currentHbR(1,1));
        bout_Behavior_0(x0) = deal(currentBehavior(1,1));
               
        bout_HbO_1(x1) = currentHbO(1:currentEndIndex);
        bout_HbO_1 = bout_HbO_1(bout_HbO_1 ~= 0);
        bout_HbR_1(x1) = currentHbR(1:currentEndIndex);
        bout_HbR_1 = bout_HbR_1(bout_HbR_1 ~= 0);
        bout_Behavior_1(x1) = currentBehavior(1:currentEndIndex);
        bout_Behavior_1 = bout_Behavior_1(bout_Behavior_1 ~= 0);
        
        bout_HbO = [bout_HbO_0 bout_HbO_1];
        bout_HbR = [bout_HbR_0 bout_HbR_1];
        bout_Behavior = [bout_Behavior_0 bout_Behavior_1];
        
    elseif(currentEndIndex > 1799)

        x0 = 1:1799-currentStartIndex+1;
        x1 = 1800:currentEndIndex;
        
        bout_HbO_0(x0) = currentHbO(currentStartIndex:1799);
        bout_HbR_0(x0) = currentHbR(currentStartIndex:1799);
        bout_Behavior_0(x0) = currentBehavior(currentStartIndex:1799);
        
        bout_HbO_1(x1) = deal(currentHbO(1799,1));
        bout_HbO_1 = bout_HbO_1(bout_HbO_1 ~= 0);
        bout_HbR_1(x1) = deal(currentHbR(1799,1));
        bout_HbR_1 = bout_HbR_1(bout_HbR_1 ~= 0);
        bout_Behavior_1(x1) = deal(currentBehavior(1799,1));
        bout_Behavior_1 = bout_Behavior_1(bout_Behavior_1 ~= 0);
        
        bout_HbO = [bout_HbO_0 bout_HbO_1];
        bout_HbR = [bout_HbR_0 bout_HbR_1];
        bout_Behavior = [bout_Behavior_0 bout_Behavior_1];
    
    else
        
        x = 1:currentEndIndex-currentStartIndex+1;
        bout_HbO(x) = currentHbO(currentStartIndex:currentEndIndex);
        bout_HbR(x) = currentHbR(currentStartIndex:currentEndIndex);
        bout_Behavior(x) = currentBehavior(currentStartIndex:currentEndIndex);
        
    end
    
    bouts_specs(5).(columns{i,1}) = SF.*bout_HbO;
    bouts_specs(6).(columns{i,1}) = SF.*bout_HbR;
    bouts_specs(7).(columns{i,1}) = bout_Behavior;
    
    clearvars -except indices fullHbO fullHbR fullBehavior maxBouts...
        HbO HbR Behavior bouts bouts_specs columns SF
    
end

fields = fieldnames(bouts_specs);
for i = 1:size(fields,1)
    
    temp = (bouts_specs(5).(fields{i}))'; temp = temp - mean(temp(50:100,1));
    bouts_specs(5).(fields{i}) = temp;
    temp = (bouts_specs(6).(fields{i}))'; temp = temp - mean(temp(50:100,1));
    bouts_specs(6).(fields{i}) = temp;
    temp = (bouts_specs(7).(fields{i}))'; temp = temp - mean(temp(50:100,1));
    bouts_specs(7).(fields{i}) = temp;
    
    % Time
    bouts_specs(8).(fields{i}) = ((10*(bouts_specs(1).(fields{i})):10*(bouts_specs(4).(fields{i}))) - 10*bouts_specs(2).(fields{i}))';
    bouts_specs(8).(fields{i}) = bouts_specs(8).(fields{i})(50:150);
    
    % HbO
    bouts_specs(9).(fields{i}) = bouts_specs(5).(fields{i})(50:150);
    
    % HbR
    bouts_specs(10).(fields{i}) = bouts_specs(6).(fields{i})(50:150);
    
    % Behavior
    bouts_specs(11).(fields{i}) = bouts_specs(7).(fields{i})(50:150);
        
end
clearvars -except bouts_specs fields

timeVector = bouts_specs(8).(fields{1});
for i = 1:size(fields,1)   
    HbO(:,i) = bouts_specs(9).(fields{i});
    HbR(:,i) = bouts_specs(10).(fields{i});
    Behavior(:,i) = bouts_specs(11).(fields{i});
end

U{1,1} = mean(HbO,2); U{1,2} = mean(HbR,2); U{1,3} = mean(Behavior,2);
SEM{1,1} = std(HbO,0,2)./sqrt(size(HbO,2));
SEM{1,2} = std(HbR,0,2)./sqrt(size(HbR,2));
SEM{1,3} = std(Behavior,0,2)./sqrt(size(Behavior,2));

clearvars -except bouts_specs HbO HbR U SEM timeVector
