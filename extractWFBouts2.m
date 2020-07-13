%% READ IN DATA

clc
clearvars -except indices fullHbO fullHbR fullHbT fullBehavior maxBouts
close all

HbO = table(); HbR = table(); HbT = table(); Behavior = table();

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
    partialHbT = fullHbT(:,low:high);
    partialBehavior = fullBehavior(:,low:high);
    HbO = [HbO partialHbO];
    HbR = [HbR partialHbR];
    HbT = [HbT partialHbT];
    Behavior = [Behavior partialBehavior];
    
end

HbO(:,all(ismissing(HbO)))=[];
% temp = HbO(199:599,:);
% HbO = temp;
HbR(:,all(ismissing(HbR)))=[];
% temp = HbR(199:599,:);
% HbR = temp;
HbT(:,all(ismissing(HbT)))=[];
% temp = HbT(199:599,:);
% HbT = temp;
Behavior(:,all(ismissing(Behavior)))=[];
% temp = Behavior(199:599,:);
% Behavior = temp;

%% SELECT BOUTS

bouts = cell(maxBouts,2);
indices2 = [13 19 23 30 31 32 36 37 38 47 52 53 70 77 120 123 129 142 144 180 181 185 194 195 197 198 199 201 202 203 205 206 210];

for i = 1:size(Behavior,2)
    clc
    plot((199:699)/10,table2array(Behavior(199:699,i))); title(strcat(int2str(i),{' :: '},strrep(HbO.Properties.VariableNames(i),'_',' - ')));
    xticks(20:5:69)
    xlim([199/10 699/10])
    
%     for k = 1:maxBouts
%         disp(['Bout: ' int2str(k)])
%         [pointslist,xselect,~] = selectdata('SelectionMode','Rect');
%         if(~isempty(pointslist))
%             bouts{i,1} = Behavior.Properties.VariableNames(i); %name
%             bouts{i,2} = [bouts{i,2}; xselect(1) xselect(size(xselect,1))]; %endpoints
%             pointslist = []; xselect = []; yselect =[];
%         end
%     end
    
    input('')
end


%% EXTRACT ENDPOINTS

[varTypes{1:760}] = deal('double');
bouts_specs = table('Size',[4 760],'VariableTypes',varTypes);

counter = 1;
for i = 1:210
    if(~isempty(bouts{i,1}))
        colTitle = bouts{i,1}{1,1};
        for j = 1:size(bouts{i,2},1)
            bouts_specs.Properties.VariableNames{counter} = [colTitle '_bout' int2str(j)];
            bouts_specs{2,counter} = 30; % onset
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

bouts_specs = table2struct(bouts_specs);
columns = fieldnames(bouts_specs);

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
    currentHbT = HbT.(currentMainColumn);
    currentBehavior = Behavior.(currentMainColumn);
    
    x = 1:currentEndIndex-currentStartIndex+1;
    bout_HbO(x) = currentHbO(currentStartIndex:currentEndIndex);
    bout_HbR(x) = currentHbR(currentStartIndex:currentEndIndex);
    bout_HbT(x) = currentHbT(currentStartIndex:currentEndIndex);
    bout_Behavior(x) = currentBehavior(currentStartIndex:currentEndIndex);
    
    bouts_specs(5).(columns{i,1}) = bout_HbO;
    bouts_specs(6).(columns{i,1}) = bout_HbR;
    bouts_specs(7).(columns{i,1}) = bout_HbT;
    bouts_specs(8).(columns{i,1}) = bout_Behavior;
    
    clearvars -except indices fullHbO fullHbR fullHbT fullBehavior maxBouts...
        HbO HbR HbT Behavior bouts bouts_specs columns
    
end