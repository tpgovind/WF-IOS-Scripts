%% Multiple t-tests on segments of mural WF response

clc
clear all
close all

load('F:\ANALYZED_DATA\MAT Files\WF\WF_Trials.mat', 'WF_HbO_Trials', 'WF_HbR_Trials')
load('F:\ANALYZED_DATA\MAT Files\WF\WFTrial_Indices.mat', 'Mural_Trials')
HbO = table(); HbR = table();


SF = 100/log(10);

for i = Mural_Trials
    
    low = 20*(i-1)+1; high = 20*i;
    partialHbO = WF_HbO_Trials(:,low:high);
    partialHbR = WF_HbR_Trials(:,low:high);
    
    HbO = [HbO partialHbO];
    HbR = [HbR partialHbR];
    
end

HbO(:,all(ismissing(HbO)))=[]; HbR(:,all(ismissing(HbR)))=[];
HbO = table2array(HbO); HbR = table2array(HbR);
HbO(1800,:) = HbO(1799,:); HbR(1800,:) = HbR(1799,:);

HbO = SF.*HbO; HbR = SF.*HbR;

for i = 1:size(HbO,2)
    
    HbO(:,i) = HbO(:,i) - mean(HbO(1:300,i));
    HbR(:,i) = HbR(:,i) - mean(HbR(1:300,i));
    
end

WF_Mural_Indices = [1 12; 13 22; 23 40; 41 52; 53 67; 68 77; 78 92; 93 104; 105 119; 120 129; 130 141; 142 156; 157 167; 168 179; 180 194; 195 214];


for i = 1:size(WF_Mural_Indices,1)
    start = WF_Mural_Indices(i,1); stop = WF_Mural_Indices(i,2);
    HbO_temp(:,i) = mean(HbO(:,start:stop),2);
    HbR_temp(:,i) = mean(HbR(:,start:stop),2);
end
HbO = HbO_temp; HbR = HbR_temp;

HbO_BL = HbO(1:300,:); HbR_BL = HbR(1:300,:);
HbO_EARLY_STIM = HbO(305:350,:); HbR_EARLY_STIM = HbR(305:350,:); % Early component
HbO_LATE_STIM = HbO(501:600,:); HbR_LATE_STIM = HbR(501:600,:); % Late component
HbO_EARLY_REC = HbO(601:900,:); HbR_EARLY_REC = HbR(601:900,:);
HbO_LATE_REC = HbO(901:1500,:); HbR_LATE_REC = HbR(901:1500,:);

HbO_BL = mean(HbO_BL)'; HbR_BL = mean(HbR_BL)';
HbO_EARLY_STIM = mean(HbO_EARLY_STIM)'; HbR_EARLY_STIM = mean(HbR_EARLY_STIM)';
HbO_LATE_STIM = mean(HbO_LATE_STIM)'; HbR_LATE_STIM = mean(HbR_LATE_STIM)';
HbO_EARLY_REC = mean(HbO_EARLY_REC)'; HbR_EARLY_REC = mean(HbR_EARLY_REC)';
HbO_LATE_REC = mean(HbO_LATE_REC)'; HbR_LATE_REC = mean(HbR_LATE_REC)';

% Normality testing probability associated to the chi-squared statistic
%fprintf('D''Agostino-Pearson''s test to assessing normality: X2= %3.4f, df=%2i\n', X2,df);
%fprintf('Probability associated to the chi-squared statistic = %3.4f\n', P);
%fprintf('With a given significance = %3.3f\n', alpha);
alpha = 0.05;
HbO_normalities = {DagosPtest(HbO_BL,alpha),DagosPtest(HbO_EARLY_STIM,alpha),DagosPtest(HbO_LATE_STIM,alpha),DagosPtest(HbO_EARLY_REC,alpha),DagosPtest(HbO_LATE_REC,alpha)};
HbR_normalities = {DagosPtest(HbR_BL,alpha),DagosPtest(HbR_EARLY_STIM,alpha),DagosPtest(HbR_LATE_STIM,alpha),DagosPtest(HbR_EARLY_REC,alpha),DagosPtest(HbR_LATE_REC,alpha)};

U_HbO = [HbO_BL HbO_EARLY_STIM HbO_LATE_STIM HbO_EARLY_REC HbO_LATE_REC];
U_HbR = [HbR_BL HbR_EARLY_STIM HbR_LATE_STIM HbR_EARLY_REC HbR_LATE_REC];

%clearvars -except U_HbO U_HbR HbO_normalities HbR_normalities


%% Multiple t-tests on segments of mural 2P response

clc
clear all
close all

load('F:\ANALYZED_DATA\MAT Files\2P\2P_Data.mat')
load('F:\ANALYZED_DATA\MAT Files\2P\2PTrial_Indices.mat')

fullData = TwoPhoton_All;
indicesLumen = FirstOrder_Lumen_ALL;  %indicesLumen = Penetrators_Lumen_ALL;
indicesCalcium = FirstOrder_Calcium_ALL;  %indicesCalcium = Penetrators_Calcium_ALL;

lumenData = []; calciumData = [];
counter = 1;

for i = indicesLumen
    current = fullData.TwoPhoton_Trace{i,1};
    if (size(current,1) == 704)
        lumenData = [lumenData current];
        animalsLumen{1,counter} = fullData.Image_ID{i,1};
        counter = counter + 1;
    else
        current = resample(current,704,size(current,1));
        lumenData = [lumenData current];
        animalsLumen{1,counter} = fullData.Image_ID{i,1};
        counter = counter + 1;
    end
end

counter = 1;
for i = indicesCalcium
    current = fullData.TwoPhoton_Trace{i,1};
    if (size(current,1) == 704)
        calciumData = [calciumData current];
        animalsCalcium{1,counter} = fullData.Image_ID{i,1};
        counter = counter + 1;
    else
        current = resample(current,704,size(current,1));
        calciumData = [calciumData current];
        animalsCalcium{1,counter} = fullData.Image_ID{i,1};
        counter = counter + 1;
    end
end

for i = 1:size(lumenData,2)
    lumenData(:,i) = lumenData(:,i)./abs(mean(lumenData(1:116,i)));
end

for i = 1:size(calciumData,2)
    calciumData(:,i) = calciumData(:,i)./abs(mean(calciumData(1:116,i)));
end

%comparators = {'M17','M19','M20','M21','M22','M23','M25','M26','M28','M31','M32','M33'};
comparators = {'M17','M19','M20','M21','M22','M23','M25','M28','M31','M32','M33'};
temp1 = []; temp2 = [];
for i = 1:size(comparators,2)
    for j = 1:size(lumenData,2)
        if(strcmp(comparators{1,i},animalsLumen{1,j}))
            temp1 = [temp1 lumenData(:,j)];
        end
    end
    for j = 1:size(calciumData,2)
        if(strcmp(comparators{1,i},animalsCalcium{1,j}))
            temp2 = [temp2 calciumData(:,j)];
        end
    end
    temp1 = mean(temp1,2); temp2 = mean(temp2,2);
    lumenAverages(:,i) = temp1; calciumAverages(:,i) = temp2;
    temp1= []; temp2 = [];
end

Flow = lumenAverages; Calcium = calciumAverages;

Flow_BL = Flow(1:116,:); Calcium_BL = Calcium(1:116,:);
Flow_EARLY_STIM = Flow(120:156,:); Calcium_EARLY_STIM = Calcium(120:156,:);
Flow_LATE_STIM = Flow(157:234,:); Calcium_LATE_STIM = Calcium(157:234,:);
Flow_EARLY_REC = Flow(235:352,:); Calcium_EARLY_REC = Calcium(235:352,:);
Flow_LATE_REC = Flow(353:587,:); Calcium_LATE_REC = Calcium(353:587,:);

Flow_BL = mean(Flow_BL)'; Calcium_BL = mean(Calcium_BL)';
Flow_EARLY_STIM = mean(Flow_EARLY_STIM)'; Calcium_EARLY_STIM = mean(Calcium_EARLY_STIM)';
Flow_LATE_STIM = mean(Flow_LATE_STIM)'; Calcium_LATE_STIM = mean(Calcium_LATE_STIM)';
Flow_EARLY_REC = mean(Flow_EARLY_REC)'; Calcium_EARLY_REC = mean(Calcium_EARLY_REC)';
Flow_LATE_REC = mean(Flow_LATE_REC)'; Calcium_LATE_REC = mean(Calcium_LATE_REC)';

% Normality testing probability associated to the chi-squared statistic
%fprintf('D''Agostino-Pearson''s test to assessing normality: X2= %3.4f, df=%2i\n', X2,df);
%fprintf('Probability associated to the chi-squared statistic = %3.4f\n', P);
%fprintf('With a given significance = %3.3f\n', alpha);
alpha = 0.05;
Flow_normalities = {DagosPtest(Flow_BL,alpha),DagosPtest(Flow_EARLY_STIM,alpha),DagosPtest(Flow_LATE_STIM,alpha),DagosPtest(Flow_EARLY_REC,alpha),DagosPtest(Flow_LATE_REC,alpha)};
Calcium_normalities = {DagosPtest(Calcium_BL,alpha),DagosPtest(Calcium_EARLY_STIM,alpha),DagosPtest(Calcium_LATE_STIM,alpha),DagosPtest(Calcium_EARLY_REC,alpha),DagosPtest(Calcium_LATE_REC,alpha)};

U_Flow = [Flow_BL Flow_EARLY_STIM Flow_LATE_STIM Flow_EARLY_REC Flow_LATE_REC];
U_Calcium = [Calcium_BL Calcium_EARLY_STIM Calcium_LATE_STIM Calcium_EARLY_REC Calcium_LATE_REC];

clearvars -except U_Flow U_Calcium Flow_normalities Calcium_normalities


%% Compartmental analysis WF

clc
clear all
close all

load('F:\ANALYZED_DATA\MAT Files\Spatial Analysis\VesselVsParenchyma\CompartmentalAnalysis_MURALS_ONLY.mat')
HbO = table(); HbR = table(); SF = 100/log(10);
Compartment_Indices = [1 12; 13 22; 23 40; 41 52; 53 67; 68 77; 78 89; 90 99; 100 111; 112 126; 127 137; 138 149; 150 164; 165 184];

HbO_Arterioles = table2array(WF_HbO_Trials_Arterioles); HbO_Veins = table2array(WF_HbO_Trials_Veins); HbO_Parenchyma = table2array(WF_HbO_Trials_Parenchyma);
HbO_Arterioles = SF.*HbO_Arterioles; HbO_Veins = SF.*HbO_Veins; HbO_Parenchyma = SF.*HbO_Parenchyma;
for i = 1:size(HbO_Arterioles,2)
    HbO_Arterioles(:,i) = HbO_Arterioles(:,i) - mean(HbO_Arterioles(1:300,i));
    HbO_Veins(:,i) = HbO_Veins(:,i) - mean(HbO_Veins(1:300,i));
    HbO_Parenchyma(:,i) = HbO_Parenchyma(:,i) - mean(HbO_Parenchyma(1:300,i));
end

HbR_Arterioles = table2array(WF_HbR_Trials_Arterioles); HbR_Veins = table2array(WF_HbR_Trials_Veins); HbR_Parenchyma = table2array(WF_HbR_Trials_Parenchyma);
HbR_Arterioles = SF.*HbR_Arterioles; HbR_Veins = SF.*HbR_Veins; HbR_Parenchyma = SF.*HbR_Parenchyma;
for i = 1:size(HbR_Arterioles,2)
    HbR_Arterioles(:,i) = HbR_Arterioles(:,i) - mean(HbR_Arterioles(1:300,i));
    HbR_Veins(:,i) = HbR_Veins(:,i) - mean(HbR_Veins(1:300,i));
    HbR_Parenchyma(:,i) = HbR_Parenchyma(:,i) - mean(HbR_Parenchyma(1:300,i));
end

for i = 1:size(Compartment_Indices,1)
    start = Compartment_Indices(i,1); stop = Compartment_Indices(i,2);
    HbO_Arterioles_temp(:,i) = mean(HbO_Arterioles(:,start:stop),2);
    HbO_Veins_temp(:,i) = mean(HbO_Veins(:,start:stop),2);
    HbO_Parenchyma_temp(:,i) = mean(HbO_Parenchyma(:,start:stop),2);
    HbR_Arterioles_temp(:,i) = mean(HbR_Arterioles(:,start:stop),2);
    HbR_Veins_temp(:,i) = mean(HbR_Veins(:,start:stop),2);
    HbR_Parenchyma_temp(:,i) = mean(HbR_Parenchyma(:,start:stop),2);
end

% HbO_Arterioles = mean(HbO_Arterioles_temp(305:600,:),1); HbR_Arterioles = mean(HbR_Arterioles_temp(305:600,:),1);
% HbO_Veins = mean(HbO_Veins_temp(305:600,:),1); HbR_Veins = mean(HbR_Veins_temp(305:600,:),1);
% HbO_Parenchyma = mean(HbO_Parenchyma_temp(305:600,:),1); HbR_Parenchyma = mean(HbR_Parenchyma_temp(305:600,:),1);

HbO_Arterioles = mean(HbO_Arterioles_temp(305:350,:),1); HbR_Arterioles = mean(HbR_Arterioles_temp(305:350,:),1);
HbO_Veins = mean(HbO_Veins_temp(305:350,:),1); HbR_Veins = mean(HbR_Veins_temp(305:350,:),1);
HbO_Parenchyma = mean(HbO_Parenchyma_temp(305:350,:),1); HbR_Parenchyma = mean(HbR_Parenchyma_temp(305:350,:),1);

% HbO_Arterioles = mean(HbO_Arterioles_temp(501:600,:),1); HbR_Arterioles = mean(HbR_Arterioles_temp(501:600,:),1);
% HbO_Veins = mean(HbO_Veins_temp(501:600,:),1); HbR_Veins = mean(HbR_Veins_temp(501:600,:),1);
% HbO_Parenchyma = mean(HbO_Parenchyma_temp(501:600,:),1); HbR_Parenchyma = mean(HbR_Parenchyma_temp(501:600,:),1);

% Normality testing probability associated to the chi-squared statistic
%fprintf('D''Agostino-Pearson''s test to assessing normality: X2= %3.4f, df=%2i\n', X2,df);
%fprintf('Probability associated to the chi-squared statistic = %3.4f\n', P);
%fprintf('With a given significance = %3.3f\n', alpha);
alpha = 0.05;
HbO_normalities = {DagosPtest(HbO_Arterioles,alpha),DagosPtest(HbO_Veins,alpha),DagosPtest(HbO_Parenchyma,alpha)};
HbR_normalities = {DagosPtest(HbR_Arterioles,alpha),DagosPtest(HbR_Veins,alpha),DagosPtest(HbR_Parenchyma,alpha)};

HbO_out = [HbO_Arterioles' HbO_Veins' HbO_Parenchyma'];
HbR_out = [HbR_Arterioles' HbR_Veins' HbR_Parenchyma'];

out2 = [HbO_Arterioles HbR_Arterioles; HbO_Veins HbR_Veins; HbO_Parenchyma HbR_Parenchyma];

clearvars -except HbO_out HbR_out out2 HbO_normalities HbR_normalities


%% Compartmental analysis 2P

clc
clear all
close all

load('F:\ANALYZED_DATA\MAT Files\2P\2P_Data.mat')
load('F:\ANALYZED_DATA\MAT Files\2P\2PTrial_Indices.mat')

fullData = TwoPhoton_All;
indicesLumen = Penetrators_Lumen_ALL;
indicesCalcium = Penetrators_Calcium_ALL;
lumenData = []; calciumData = [];
counter = 1;

for i = indicesLumen
    current = fullData.TwoPhoton_Trace{i,1};
    if (size(current,1) == 704)
        lumenData = [lumenData current];
        animalsLumen{1,counter} = fullData.Image_ID{i,1};
        counter = counter + 1;
    else
        current = resample(current,704,size(current,1));
        lumenData = [lumenData current];
        animalsLumen{1,counter} = fullData.Image_ID{i,1};
        counter = counter + 1;
    end
end

counter = 1;
for i = indicesCalcium
    current = fullData.TwoPhoton_Trace{i,1};
    if (size(current,1) == 704)
        calciumData = [calciumData current];
        animalsCalcium{1,counter} = fullData.Image_ID{i,1};
        counter = counter + 1;
    else
        current = resample(current,704,size(current,1));
        calciumData = [calciumData current];
        animalsCalcium{1,counter} = fullData.Image_ID{i,1};
        counter = counter + 1;
    end
end

for i = 1:size(lumenData,2)
    lumenData(:,i) = lumenData(:,i)./abs(mean(lumenData(1:116,i)));
end

for i = 1:size(calciumData,2)
    calciumData(:,i) = calciumData(:,i)./abs(mean(calciumData(1:116,i)));
end

%comparators = {'M17','M19','M20','M21','M22','M23','M25','M26','M28','M31','M32','M33'};
comparators = {'M17','M19','M20','M21','M22','M23','M25','M28','M31','M32','M33'};
temp1 = []; temp2 = [];
for i = 1:size(comparators,2)
    for j = 1:size(lumenData,2)
        if(strcmp(comparators{1,i},animalsLumen{1,j}))
            temp1 = [temp1 lumenData(:,j)];
        end
    end
    for j = 1:size(calciumData,2)
        if(strcmp(comparators{1,i},animalsCalcium{1,j}))
            temp2 = [temp2 calciumData(:,j)];
        end
    end
    temp1 = mean(temp1,2); temp2 = mean(temp2,2);
    lumenAverages(:,i) = temp1; calciumAverages(:,i) = temp2;
    temp1= []; temp2 = [];
end

Penetrators_Flow = lumenAverages; Penetrators_Calcium = calciumAverages;
clearvars -except Penetrators_Flow Penetrators_Calcium

load('F:\ANALYZED_DATA\MAT Files\2P\2P_Data.mat')
load('F:\ANALYZED_DATA\MAT Files\2P\2PTrial_Indices.mat')

fullData = TwoPhoton_All;
indicesLumen = FirstOrder_Lumen_ALL;
indicesCalcium = FirstOrder_Calcium_ALL;
lumenData = []; calciumData = [];
counter = 1;

for i = indicesLumen
    current = fullData.TwoPhoton_Trace{i,1};
    if (size(current,1) == 704)
        lumenData = [lumenData current];
        animalsLumen{1,counter} = fullData.Image_ID{i,1};
        counter = counter + 1;
    else
        current = resample(current,704,size(current,1));
        lumenData = [lumenData current];
        animalsLumen{1,counter} = fullData.Image_ID{i,1};
        counter = counter + 1;
    end
end

counter = 1;
for i = indicesCalcium
    current = fullData.TwoPhoton_Trace{i,1};
    if (size(current,1) == 704)
        calciumData = [calciumData current];
        animalsCalcium{1,counter} = fullData.Image_ID{i,1};
        counter = counter + 1;
    else
        current = resample(current,704,size(current,1));
        calciumData = [calciumData current];
        animalsCalcium{1,counter} = fullData.Image_ID{i,1};
        counter = counter + 1;
    end
end

for i = 1:size(lumenData,2)
    lumenData(:,i) = lumenData(:,i)./abs(mean(lumenData(1:116,i)));
end

for i = 1:size(calciumData,2)
    calciumData(:,i) = calciumData(:,i)./abs(mean(calciumData(1:116,i)));
end

%comparators = {'M17','M19','M20','M21','M22','M23','M25','M26','M28','M31','M32','M33'};
comparators = {'M17','M19','M20','M21','M22','M23','M25','M28','M31','M32','M33'};
temp1 = []; temp2 = [];
for i = 1:size(comparators,2)
    for j = 1:size(lumenData,2)
        if(strcmp(comparators{1,i},animalsLumen{1,j}))
            temp1 = [temp1 lumenData(:,j)];
        end
    end
    for j = 1:size(calciumData,2)
        if(strcmp(comparators{1,i},animalsCalcium{1,j}))
            temp2 = [temp2 calciumData(:,j)];
        end
    end
    temp1 = mean(temp1,2); temp2 = mean(temp2,2);
    lumenAverages(:,i) = temp1; calciumAverages(:,i) = temp2;
    temp1= []; temp2 = [];
end

FirstOrder_Flow = lumenAverages; FirstOrder_Calcium = calciumAverages;
clearvars -except Penetrators_Flow Penetrators_Calcium FirstOrder_Flow FirstOrder_Calcium

Penetrators_Flow = mean(Penetrators_Flow(120:234,:),1); FirstOrder_Flow = mean(FirstOrder_Flow(120:234,:),1);
%Penetrators_Calcium = mean(Penetrators_Calcium(120:234,:),1); FirstOrder_Calcium = mean(FirstOrder_Calcium(120:234,:),1);
Penetrators_Calcium = mean(Penetrators_Calcium(235:587,:),1); FirstOrder_Calcium = mean(FirstOrder_Calcium(235:587,:),1);

% Normality testing probability associated to the chi-squared statistic
%fprintf('D''Agostino-Pearson''s test to assessing normality: X2= %3.4f, df=%2i\n', X2,df);
%fprintf('Probability associated to the chi-squared statistic = %3.4f\n', P);
%fprintf('With a given significance = %3.3f\n', alpha);
alpha = 0.05;
Flow_normalities = {DagosPtest(Penetrators_Flow,alpha),DagosPtest(FirstOrder_Flow,alpha)};
Calcium_normalities = {DagosPtest(Penetrators_Calcium,alpha),DagosPtest(FirstOrder_Calcium,alpha)};

Flow_out = [Penetrators_Flow' FirstOrder_Flow'];
Calcium_out = [Penetrators_Calcium' FirstOrder_Calcium'];

clearvars -except Flow_out Calcium_out Flow_normalities Calcium_normalities


%% COMPUTE HISTOGRAM MOMENTS (WF MURALS)

clc
clear all
close all
load('F:\ANALYZED_DATA\MAT Files\Spatial Analysis\VesselVsParenchyma\histograms.mat')

% Compute average histograms

for i = 1:size(histograms,1)
    
    HbO_BL_elems1 = []; HbO_BL_elems2 = []; HbO_BL_elems3 = []; HbO_BL_elems4 =[];
    HbO_STIM_elems1 = []; HbO_STIM_elems2 = []; HbO_STIM_elems3 = []; HbO_STIM_elems4 =[];
    HbO_REC_elems1 = []; HbO_REC_elems2 = []; HbO_REC_elems3 = []; HbO_REC_elems4 =[];
    HbR_BL_elems1 = []; HbR_BL_elems2 = []; HbR_BL_elems3 = []; HbR_BL_elems4 =[];
    HbR_STIM_elems1 = []; HbR_STIM_elems2 = []; HbR_STIM_elems3 = []; HbR_STIM_elems4 =[];
    HbR_REC_elems1 = []; HbR_REC_elems2 = []; HbR_REC_elems3 = []; HbR_REC_elems4 =[];
    
    for j = histograms{i,2}{:}
        
        HbO_BL_elem1 = histogram_HbO_BL{j,2}; HbO_BL_elems1 = [HbO_BL_elems1 HbO_BL_elem1']; HbO_BL_elems1 = mean(HbO_BL_elems1,2);
        HbO_BL_elem2 = histogram_HbO_BL{j,3}; HbO_BL_elems2 = [HbO_BL_elems2 HbO_BL_elem2']; HbO_BL_elems2 = mean(HbO_BL_elems2,2);
        HbO_BL_elem3 = histogram_HbO_BL{j,4}; HbO_BL_elems3 = [HbO_BL_elems3 HbO_BL_elem3']; HbO_BL_elems3 = mean(HbO_BL_elems3,2);
        HbO_BL_elem4 = histogram_HbO_BL{j,5}; HbO_BL_elems4 = [HbO_BL_elems4 HbO_BL_elem4']; HbO_BL_elems4 = mean(HbO_BL_elems4,2);
        
        HbO_STIM_elem1 = histogram_HbO_STIM{j,2}; HbO_STIM_elems1 = [HbO_STIM_elems1 HbO_STIM_elem1']; HbO_STIM_elems1 = mean(HbO_STIM_elems1,2);
        HbO_STIM_elem2 = histogram_HbO_STIM{j,3}; HbO_STIM_elems2 = [HbO_STIM_elems2 HbO_STIM_elem2']; HbO_STIM_elems2 = mean(HbO_STIM_elems2,2);
        HbO_STIM_elem3 = histogram_HbO_STIM{j,4}; HbO_STIM_elems3 = [HbO_STIM_elems3 HbO_STIM_elem3']; HbO_STIM_elems3 = mean(HbO_STIM_elems3,2);
        HbO_STIM_elem4 = histogram_HbO_STIM{j,5}; HbO_STIM_elems4 = [HbO_STIM_elems4 HbO_STIM_elem4']; HbO_STIM_elems4 = mean(HbO_STIM_elems4,2);
        
        HbO_REC_elem1 = histogram_HbO_REC{j,2}; HbO_REC_elems1 = [HbO_REC_elems1 HbO_REC_elem1']; HbO_REC_elems1 = mean(HbO_REC_elems1,2);
        HbO_REC_elem2 = histogram_HbO_REC{j,3}; HbO_REC_elems2 = [HbO_REC_elems2 HbO_REC_elem2']; HbO_REC_elems2 = mean(HbO_REC_elems2,2);
        HbO_REC_elem3 = histogram_HbO_REC{j,4}; HbO_REC_elems3 = [HbO_REC_elems3 HbO_REC_elem3']; HbO_REC_elems3 = mean(HbO_REC_elems3,2);
        HbO_REC_elem4 = histogram_HbO_REC{j,5}; HbO_REC_elems4 = [HbO_REC_elems4 HbO_REC_elem4']; HbO_REC_elems4 = mean(HbO_REC_elems4,2);
        
        HbR_BL_elem1 = histogram_HbR_BL{j,2}; HbR_BL_elems1 = [HbR_BL_elems1 HbR_BL_elem1']; HbR_BL_elems1 = mean(HbR_BL_elems1,2);
        HbR_BL_elem2 = histogram_HbR_BL{j,3}; HbR_BL_elems2 = [HbR_BL_elems2 HbR_BL_elem2']; HbR_BL_elems2 = mean(HbR_BL_elems2,2);
        HbR_BL_elem3 = histogram_HbR_BL{j,4}; HbR_BL_elems3 = [HbR_BL_elems3 HbR_BL_elem3']; HbR_BL_elems3 = mean(HbR_BL_elems3,2);
        HbR_BL_elem4 = histogram_HbR_BL{j,5}; HbR_BL_elems4 = [HbR_BL_elems4 HbR_BL_elem4']; HbR_BL_elems4 = mean(HbR_BL_elems4,2);
        
        HbR_STIM_elem1 = histogram_HbR_STIM{j,2}; HbR_STIM_elems1 = [HbR_STIM_elems1 HbR_STIM_elem1']; HbR_STIM_elems1 = mean(HbR_STIM_elems1,2);
        HbR_STIM_elem2 = histogram_HbR_STIM{j,3}; HbR_STIM_elems2 = [HbR_STIM_elems2 HbR_STIM_elem2']; HbR_STIM_elems2 = mean(HbR_STIM_elems2,2);
        HbR_STIM_elem3 = histogram_HbR_STIM{j,4}; HbR_STIM_elems3 = [HbR_STIM_elems3 HbR_STIM_elem3']; HbR_STIM_elems3 = mean(HbR_STIM_elems3,2);
        HbR_STIM_elem4 = histogram_HbR_STIM{j,5}; HbR_STIM_elems4 = [HbR_STIM_elems4 HbR_STIM_elem4']; HbR_STIM_elems4 = mean(HbR_STIM_elems4,2);
        
        HbR_REC_elem1 = histogram_HbR_REC{j,2}; HbR_REC_elems1 = [HbR_REC_elems1 HbR_REC_elem1']; HbR_REC_elems1 = mean(HbR_REC_elems1,2);
        HbR_REC_elem2 = histogram_HbR_REC{j,3}; HbR_REC_elems2 = [HbR_REC_elems2 HbR_REC_elem2']; HbR_REC_elems2 = mean(HbR_REC_elems2,2);
        HbR_REC_elem3 = histogram_HbR_REC{j,4}; HbR_REC_elems3 = [HbR_REC_elems3 HbR_REC_elem3']; HbR_REC_elems3 = mean(HbR_REC_elems3,2);
        HbR_REC_elem4 = histogram_HbR_REC{j,5}; HbR_REC_elems4 = [HbR_REC_elems4 HbR_REC_elem4']; HbR_REC_elems4 = mean(HbR_REC_elems4,2);
        
    end
    
    histograms.Avg_HbO_BL_histogram{i} = {HbO_BL_elems1 HbO_BL_elems2 HbO_BL_elems3 HbO_BL_elems4};
    histograms.Avg_HbO_STIM_histogram{i} = {HbO_STIM_elems1 HbO_STIM_elems2 HbO_STIM_elems3 HbO_STIM_elems4};
    histograms.Avg_HbO_REC_histogram{i} = {HbO_REC_elems1 HbO_REC_elems2 HbO_REC_elems3 HbO_REC_elems4};
    histograms.Avg_HbR_BL_histogram{i} = {HbR_BL_elems1 HbR_BL_elems2 HbR_BL_elems3 HbR_BL_elems4};
    histograms.Avg_HbR_STIM_histogram{i} = {HbR_STIM_elems1 HbR_STIM_elems2 HbR_STIM_elems3 HbR_STIM_elems4};
    histograms.Avg_HbR_REC_histogram{i} = {HbR_REC_elems1 HbR_REC_elems2 HbR_REC_elems3 HbR_REC_elems4};
    
end

clearvars -except histograms

% Extract direction and magnitude histogram counts for each animal, and
% calculate bin centers

counter = 0;

for i = 2:15
    
    counter = counter + 1;
    
    DirectionCounts_HbO_BL(:,counter) = histograms.Avg_HbO_BL_histogram{i,1}{1,2};
    DirectionCounts_HbO_STIM(:,counter) = histograms.Avg_HbO_STIM_histogram{i,1}{1,2};
    DirectionCounts_HbO_REC(:,counter) = histograms.Avg_HbO_REC_histogram{i,1}{1,2};
    DirectionCounts_HbR_BL(:,counter) = histograms.Avg_HbR_BL_histogram{i,1}{1,2};
    DirectionCounts_HbR_STIM(:,counter) = histograms.Avg_HbR_STIM_histogram{i,1}{1,2};
    DirectionCounts_HbR_REC(:,counter) = histograms.Avg_HbR_REC_histogram{i,1}{1,2};
    
    MagnitudeCounts_HbO_BL(:,counter) = histograms.Avg_HbO_BL_histogram{i,1}{1,4};
    MagnitudeCounts_HbO_STIM(:,counter) = histograms.Avg_HbO_STIM_histogram{i,1}{1,4};
    MagnitudeCounts_HbO_REC(:,counter) = histograms.Avg_HbO_REC_histogram{i,1}{1,4};
    MagnitudeCounts_HbR_BL(:,counter) = histograms.Avg_HbR_BL_histogram{i,1}{1,4};
    MagnitudeCounts_HbR_STIM(:,counter) = histograms.Avg_HbR_STIM_histogram{i,1}{1,4};
    MagnitudeCounts_HbR_REC(:,counter) = histograms.Avg_HbR_REC_histogram{i,1}{1,4};
    
end

DirectionEdges = rad2deg(histograms.Avg_HbO_BL_histogram{1,1}{1,1});
DirectionCenters = (DirectionEdges(1:end-1,:) + DirectionEdges(2:end,:)) / 2;
MagnitudeEdges = histograms.Avg_HbO_BL_histogram{1,1}{1,3};
MagnitudeCenters = (MagnitudeEdges(1:end-1,:) + MagnitudeEdges(2:end,:)) / 2;


% CALCULATE MOMENTS ( 1 = MEAN, 2 = VARIANCE, 3 = SKEWNESS, 4 = KURTOSIS

[temp(1,:), temp(2,:), temp(3,:), temp(4,:)] = histStat(DirectionCenters,DirectionCounts_HbO_BL); DirectionMoments_HbO_BL = temp;
[temp(1,:), temp(2,:), temp(3,:), temp(4,:)] = histStat(DirectionCenters,DirectionCounts_HbR_BL); DirectionMoments_HbR_BL = temp;
[temp(1,:), temp(2,:), temp(3,:), temp(4,:)] = histStat(DirectionCenters,DirectionCounts_HbO_STIM); DirectionMoments_HbO_STIM = temp;
[temp(1,:), temp(2,:), temp(3,:), temp(4,:)] = histStat(DirectionCenters,DirectionCounts_HbR_STIM); DirectionMoments_HbR_STIM = temp;
[temp(1,:), temp(2,:), temp(3,:), temp(4,:)] = histStat(DirectionCenters,DirectionCounts_HbO_REC); DirectionMoments_HbO_REC = temp;
[temp(1,:), temp(2,:), temp(3,:), temp(4,:)] = histStat(DirectionCenters,DirectionCounts_HbR_REC); DirectionMoments_HbR_REC = temp;

[temp(1,:), temp(2,:), temp(3,:), temp(4,:)] = histStat(MagnitudeCenters,MagnitudeCounts_HbO_BL); MagnitudeMoments_HbO_BL = temp;
[temp(1,:), temp(2,:), temp(3,:), temp(4,:)] = histStat(MagnitudeCenters,MagnitudeCounts_HbR_BL); MagnitudeMoments_HbR_BL = temp;
[temp(1,:), temp(2,:), temp(3,:), temp(4,:)] = histStat(MagnitudeCenters,MagnitudeCounts_HbO_STIM); MagnitudeMoments_HbO_STIM = temp;
[temp(1,:), temp(2,:), temp(3,:), temp(4,:)] = histStat(MagnitudeCenters,MagnitudeCounts_HbR_STIM); MagnitudeMoments_HbR_STIM = temp;
[temp(1,:), temp(2,:), temp(3,:), temp(4,:)] = histStat(MagnitudeCenters,MagnitudeCounts_HbO_REC); MagnitudeMoments_HbO_REC = temp;
[temp(1,:), temp(2,:), temp(3,:), temp(4,:)] = histStat(MagnitudeCenters,MagnitudeCounts_HbR_REC); MagnitudeMoments_HbR_REC = temp;

DirectionMomentsSummary = [DirectionMoments_HbO_BL DirectionMoments_HbO_STIM DirectionMoments_HbO_REC DirectionMoments_HbR_BL DirectionMoments_HbR_STIM DirectionMoments_HbR_REC];
MagnitudeMomentsSummary = [MagnitudeMoments_HbO_BL MagnitudeMoments_HbO_STIM MagnitudeMoments_HbO_REC MagnitudeMoments_HbR_BL MagnitudeMoments_HbR_STIM MagnitudeMoments_HbR_REC];

DirectionMoment1 = [DirectionMoments_HbO_BL(1,:)' DirectionMoments_HbO_STIM(1,:)' DirectionMoments_HbO_REC(1,:)' ...
    DirectionMoments_HbR_BL(1,:)' DirectionMoments_HbR_STIM(1,:)' DirectionMoments_HbR_REC(1,:)'];

DirectionMoment2 = [DirectionMoments_HbO_BL(2,:)' DirectionMoments_HbO_STIM(2,:)' DirectionMoments_HbO_REC(2,:)' ...
    DirectionMoments_HbR_BL(2,:)' DirectionMoments_HbR_STIM(2,:)' DirectionMoments_HbR_REC(2,:)'];

DirectionMoment3 = [DirectionMoments_HbO_BL(3,:)' DirectionMoments_HbO_STIM(3,:)' DirectionMoments_HbO_REC(3,:)' ...
    DirectionMoments_HbR_BL(3,:)' DirectionMoments_HbR_STIM(3,:)' DirectionMoments_HbR_REC(3,:)'];

DirectionMoment4 = [DirectionMoments_HbO_BL(4,:)' DirectionMoments_HbO_STIM(4,:)' DirectionMoments_HbO_REC(4,:)' ...
    DirectionMoments_HbR_BL(4,:)' DirectionMoments_HbR_STIM(4,:)' DirectionMoments_HbR_REC(4,:)'];


MagnitudeMoment1 = [MagnitudeMoments_HbO_BL(1,:)' MagnitudeMoments_HbO_STIM(1,:)' MagnitudeMoments_HbO_REC(1,:)' ...
    MagnitudeMoments_HbR_BL(1,:)' MagnitudeMoments_HbR_STIM(1,:)' MagnitudeMoments_HbR_REC(1,:)'];

MagnitudeMoment2 = [MagnitudeMoments_HbO_BL(2,:)' MagnitudeMoments_HbO_STIM(2,:)' MagnitudeMoments_HbO_REC(2,:)' ...
    MagnitudeMoments_HbR_BL(2,:)' MagnitudeMoments_HbR_STIM(2,:)' MagnitudeMoments_HbR_REC(2,:)'];

MagnitudeMoment3 = [MagnitudeMoments_HbO_BL(3,:)' MagnitudeMoments_HbO_STIM(3,:)' MagnitudeMoments_HbO_REC(3,:)' ...
    MagnitudeMoments_HbR_BL(3,:)' MagnitudeMoments_HbR_STIM(3,:)' MagnitudeMoments_HbR_REC(3,:)'];

MagnitudeMoment4 = [MagnitudeMoments_HbO_BL(4,:)' MagnitudeMoments_HbO_STIM(4,:)' MagnitudeMoments_HbO_REC(4,:)' ...
    MagnitudeMoments_HbR_BL(4,:)' MagnitudeMoments_HbR_STIM(4,:)' MagnitudeMoments_HbR_REC(4,:)'];


clearvars -except DirectionMoment1 DirectionMoment2 DirectionMoment3 DirectionMoment4 ...
    MagnitudeMoment1 MagnitudeMoment2 MagnitudeMoment3 MagnitudeMoment4



%% Locomotion context
% Measure here will be average between 3 and 5 seconds (i.e. 82nd-101th rows for WF, 33-41 for 2P)

clc
clear all
close all

load('F:\ANALYZED_DATA\MAT Files\Behavioral State\locomotionContext_WF_STATS.mat');

temp1 = mean(HbO_BASAL(82:101,:),1)';
temp2 = mean(HbO_TRIAL(82:101,:),1)';
temp3 = mean(HbR_BASAL(82:101,:),1)';
temp4 = mean(HbR_TRIAL(82:101,:),1)';

HbO_VoluntaryRun(1,1) = mean(temp1(1:9)); HbO_VoluntaryRun(12,1) = mean(temp1(101:107));
HbO_VoluntaryRun(2,1) = mean(temp1(10:32)); HbO_VoluntaryRun(13,1) = mean(temp1(108:116));
HbO_VoluntaryRun(3,1) = mean(temp1(33:34)); HbO_VoluntaryRun(14,1) = mean(temp1(117:121));
HbO_VoluntaryRun(4,1) = mean(temp1(35:36)); HbO_VoluntaryRun(15,1) = mean(temp1(122:129));
HbO_VoluntaryRun(5,1) = mean(temp1(37:40)); HbO_VoluntaryRun(16,1) = mean(temp1(130:135));
HbO_VoluntaryRun(6,1) = mean(temp1(41:45)); HbO_VoluntaryRun(17,1) = mean(temp1(136:139));
HbO_VoluntaryRun(7,1) = mean(temp1(46:49)); HbO_VoluntaryRun(18,1) = mean(temp1(140:150));
HbO_VoluntaryRun(8,1) = mean(temp1(50:70)); HbO_VoluntaryRun(19,1) = mean(temp1(151:173));
HbO_VoluntaryRun(9,1) = mean(temp1(71:72)); HbO_VoluntaryRun(20,1) = mean(temp1(174:177));
HbO_VoluntaryRun(10,1) = mean(temp1(73:90)); HbO_VoluntaryRun(21,1) = mean(temp1(178:190));
HbO_VoluntaryRun(11,1) = mean(temp1(91:100));

HbO_StimInducedRun(1,1) = mean(temp2(1:2)); HbO_StimInducedRun(6,1) = mean(temp2(11:12));
HbO_StimInducedRun(2,1) = mean(temp2(3:5)); HbO_StimInducedRun(7,1) = mean(temp2(13:14));
HbO_StimInducedRun(3,1) = mean(temp2(6:7)); HbO_StimInducedRun(8,1) = mean(temp2(15:18));
HbO_StimInducedRun(4,1) = mean(temp2(8)); HbO_StimInducedRun(9,1) = mean(temp2(19:28));
HbO_StimInducedRun(5,1) = mean(temp2(9:10));

HbR_VoluntaryRun(1,1) = mean(temp3(1:9)); HbR_VoluntaryRun(12,1) = mean(temp3(101:107));
HbR_VoluntaryRun(2,1) = mean(temp3(10:32)); HbR_VoluntaryRun(13,1) = mean(temp3(108:116));
HbR_VoluntaryRun(3,1) = mean(temp3(33:34)); HbR_VoluntaryRun(14,1) = mean(temp3(117:121));
HbR_VoluntaryRun(4,1) = mean(temp3(35:36)); HbR_VoluntaryRun(15,1) = mean(temp3(122:129));
HbR_VoluntaryRun(5,1) = mean(temp3(37:40)); HbR_VoluntaryRun(16,1) = mean(temp3(130:135));
HbR_VoluntaryRun(6,1) = mean(temp3(41:45)); HbR_VoluntaryRun(17,1) = mean(temp3(136:139));
HbR_VoluntaryRun(7,1) = mean(temp3(46:49)); HbR_VoluntaryRun(18,1) = mean(temp3(140:150));
HbR_VoluntaryRun(8,1) = mean(temp3(50:70)); HbR_VoluntaryRun(19,1) = mean(temp3(151:173));
HbR_VoluntaryRun(9,1) = mean(temp3(71:72)); HbR_VoluntaryRun(20,1) = mean(temp3(174:177));
HbR_VoluntaryRun(10,1) = mean(temp3(73:90)); HbR_VoluntaryRun(21,1) = mean(temp3(178:190));
HbR_VoluntaryRun(11,1) = mean(temp3(91:100));

HbR_StimInducedRun(1,1) = mean(temp4(1:2)); HbR_StimInducedRun(6,1) = mean(temp4(11:12));
HbR_StimInducedRun(2,1) = mean(temp4(3:5)); HbR_StimInducedRun(7,1) = mean(temp4(13:14));
HbR_StimInducedRun(3,1) = mean(temp4(6:7)); HbR_StimInducedRun(8,1) = mean(temp4(15:18));
HbR_StimInducedRun(4,1) = mean(temp4(8)); HbR_StimInducedRun(9,1) = mean(temp4(19:28));
HbR_StimInducedRun(5,1) = mean(temp4(9:10));

clearvars -except HbO_VoluntaryRun HbO_StimInducedRun HbR_VoluntaryRun HbR_StimInducedRun

%load('F:\ANALYZED_DATA\MAT Files\Behavioral State\locomotionContext_2P_STATS.mat');

% PenetratorCalcium_VoluntaryRun = mean(PenetratorCalcium_BASAL(33:41,:),1)';
% PenetratorCalcium_StimInducedRun = mean(PenetratorCalcium_TRIAL(33:41,:),1)';
% PenetratorFlow_VoluntaryRun = mean(PenetratorFlow_BASAL(33:41,:),1)';
% PenetratorFlow_StimInducedRun = mean(PenetratorFlow_TRIAL(33:41,:),1)';
%
% FirstOrderCalcium_VoluntaryRun = mean(FirstOrderCalcium_BASAL(33:41,:),1)';
% FirstOrderCalcium_StimInducedRun = mean(FirstOrderCalcium_TRIAL(33:41,:),1)';
% FirstOrderFlow_VoluntaryRun = mean(FirstOrderFlow_BASAL(33:41,:),1)';
% FirstOrderFlow_StimInducedRun = mean(FirstOrderFlow_TRIAL(33:41,:),1)';



%% Activity level
% 30-35s for early component; 50-60s for late component

clc
clear all
close all

mode = 'HbO';

sort_High = [54,9,17,19,21,23,26,28,30,34,35,41,42,50,3,43,55,1,2,5,6,10,...
    33,48,52,60,8,13,25,44,4,7,11,20,22,29,45,47,59,16,24,27,31,39,57,58,...
    14,15,18,40,37,32,36,56,12,38,46,49,51,53];
sort_Low = [27,30,32,35,38,6,19,25,31,42,45,46,47,56,59,8,23,24,28,18,26,...
    5,44,1,4,20,50,54,11,33,36,37,40,43,52,53,55,57,58,60,10,12,13,15,16,...
    29,41,48,51,2,3,14,17,22,7,9,21,34,39,49];

if (strcmp(mode,'HbO'))
    load('F:\ANALYZED_DATA\MAT Files\Behavioral State\HbO_HighLowActivity.mat')
    High = High(:,sort_High); Low = Low(:,sort_Low);
    H_S = mean(High(305:600,:),1); L_S = mean(Low(305:600,:),1);
    H_ES = mean(High(305:350,:),1); H_LS = mean(High(500:600,:),1);
    L_ES = mean(Low(305:350,:),1); L_LS = mean(Low(500:600,:),1);
    High_Stim = [mean(H_S(1,1)) mean(H_S(1,2:14)) mean(H_S(1,15:17)) mean(H_S(1,18:26)) ...
        mean(H_S(1,27:30)) mean(H_S(1,31:39)) mean(H_S(1,40:46)) mean(H_S(1,47:50)) ...
        mean(H_S(1,51)) mean(H_S(1,52:54)) mean(H_S(1,55:60))]';
    Low_Stim = [mean(L_S(1,1)) mean(L_S(1,2:14)) mean(L_S(1,15:17)) mean(L_S(1,18:26)) ...
        mean(L_S(1,27:30)) mean(L_S(1,31:39)) mean(L_S(1,40:46)) mean(L_S(1,47:50)) ...
        mean(L_S(1,51)) mean(L_S(1,52:54)) mean(L_S(1,55:60))]';
    High_EarlyStim = [mean(H_ES(1,1)) mean(H_ES(1,2:14)) mean(H_ES(1,15:17)) mean(H_ES(1,18:26)) ...
        mean(H_ES(1,27:30)) mean(H_ES(1,31:39)) mean(H_ES(1,40:46)) mean(H_ES(1,47:50)) ...
        mean(H_ES(1,51)) mean(H_ES(1,52:54)) mean(H_ES(1,55:60))]';
    High_LateStim = [mean(H_LS(1,1)) mean(H_LS(1,2:14)) mean(H_LS(1,15:17)) mean(H_LS(1,18:26)) ...
        mean(H_LS(1,27:30)) mean(H_LS(1,31:39)) mean(H_LS(1,40:46)) mean(H_LS(1,47:50)) ...
        mean(H_LS(1,51)) mean(H_LS(1,52:54)) mean(H_LS(1,55:60))]';
    Low_EarlyStim = [mean(L_ES(1,1)) mean(L_ES(1,2:14)) mean(L_ES(1,15:17)) mean(L_ES(1,18:26)) ...
        mean(L_ES(1,27:30)) mean(L_ES(1,31:39)) mean(L_ES(1,40:46)) mean(L_ES(1,47:50)) ...
        mean(L_ES(1,51)) mean(L_ES(1,52:54)) mean(L_ES(1,55:60))]';
    Low_LateStim = [mean(L_LS(1,1)) mean(L_LS(1,2:14)) mean(L_LS(1,15:17)) mean(L_LS(1,18:26)) ...
        mean(L_LS(1,27:30)) mean(L_LS(1,31:39)) mean(L_LS(1,40:46)) mean(L_LS(1,47:50)) ...
        mean(L_LS(1,51)) mean(L_LS(1,52:54)) mean(L_LS(1,55:60))]';
    clearvars -except mode High_Stim Low_Stim High_EarlyStim High_LateStim ...
        Low_EarlyStim Low_LateStim
    
else
    load('F:\ANALYZED_DATA\MAT Files\Behavioral State\HbR_HighLowActivity.mat')
    High = High(:,sort_High); Low = Low(:,sort_Low);
    H_S = mean(High(305:600,:),1); L_S = mean(Low(305:600,:),1);
    H_ES = mean(High(305:350,:),1); H_LS = mean(High(500:600,:),1);
    L_ES = mean(Low(305:350,:),1); L_LS = mean(Low(500:600,:),1);
    High_Stim = [mean(H_S(1,1)) mean(H_S(1,2:14)) mean(H_S(1,15:17)) mean(H_S(1,18:26)) ...
        mean(H_S(1,27:30)) mean(H_S(1,31:39)) mean(H_S(1,40:46)) mean(H_S(1,47:50)) ...
        mean(H_S(1,51)) mean(H_S(1,52:54)) mean(H_S(1,55:60))]';
    Low_Stim = [mean(L_S(1,1)) mean(L_S(1,2:14)) mean(L_S(1,15:17)) mean(L_S(1,18:26)) ...
        mean(L_S(1,27:30)) mean(L_S(1,31:39)) mean(L_S(1,40:46)) mean(L_S(1,47:50)) ...
        mean(L_S(1,51)) mean(L_S(1,52:54)) mean(L_S(1,55:60))]';
    High_EarlyStim = [mean(H_ES(1,1)) mean(H_ES(1,2:14)) mean(H_ES(1,15:17)) mean(H_ES(1,18:26)) ...
        mean(H_ES(1,27:30)) mean(H_ES(1,31:39)) mean(H_ES(1,40:46)) mean(H_ES(1,47:50)) ...
        mean(H_ES(1,51)) mean(H_ES(1,52:54)) mean(H_ES(1,55:60))]';
    High_LateStim = [mean(H_LS(1,1)) mean(H_LS(1,2:14)) mean(H_LS(1,15:17)) mean(H_LS(1,18:26)) ...
        mean(H_LS(1,27:30)) mean(H_LS(1,31:39)) mean(H_LS(1,40:46)) mean(H_LS(1,47:50)) ...
        mean(H_LS(1,51)) mean(H_LS(1,52:54)) mean(H_LS(1,55:60))]';
    Low_EarlyStim = [mean(L_ES(1,1)) mean(L_ES(1,2:14)) mean(L_ES(1,15:17)) mean(L_ES(1,18:26)) ...
        mean(L_ES(1,27:30)) mean(L_ES(1,31:39)) mean(L_ES(1,40:46)) mean(L_ES(1,47:50)) ...
        mean(L_ES(1,51)) mean(L_ES(1,52:54)) mean(L_ES(1,55:60))]';
    Low_LateStim = [mean(L_LS(1,1)) mean(L_LS(1,2:14)) mean(L_LS(1,15:17)) mean(L_LS(1,18:26)) ...
        mean(L_LS(1,27:30)) mean(L_LS(1,31:39)) mean(L_LS(1,40:46)) mean(L_LS(1,47:50)) ...
        mean(L_LS(1,51)) mean(L_LS(1,52:54)) mean(L_LS(1,55:60))]';
    clearvars -except mode High_Stim Low_Stim High_EarlyStim High_LateStim ...
        Low_EarlyStim Low_LateStim
    
end


%% CENTER-SURROUND

load('F:\ANALYZED_DATA\MAT Files\WF\WF Center Surround\WFCenterSurround.mat')
HbO_Center = [mean(cHbOs(:,1:12),2) mean(cHbOs(:,13:22),2) mean(cHbOs(:,23:40),2) mean(cHbOs(:,41:52),2) mean(cHbOs(:,53:64),2) mean(cHbOs(:,65:76),2) mean(cHbOs(:,77:88),2) mean(cHbOs(:,89:103),2)];
HbR_Center = [mean(cHbRs(:,1:12),2) mean(cHbRs(:,13:22),2) mean(cHbRs(:,23:40),2) mean(cHbRs(:,41:52),2) mean(cHbRs(:,53:64),2) mean(cHbRs(:,65:76),2) mean(cHbRs(:,77:88),2) mean(cHbRs(:,89:103),2)];
HbO_Surround = [mean(sHbOs(:,1:12),2) mean(sHbOs(:,13:22),2) mean(sHbOs(:,23:40),2) mean(sHbOs(:,41:52),2) mean(sHbOs(:,53:64),2) mean(sHbOs(:,65:76),2) mean(sHbOs(:,77:88),2) mean(sHbOs(:,89:103),2)];
HbR_Surround = [mean(sHbRs(:,1:12),2) mean(sHbRs(:,13:22),2) mean(sHbRs(:,23:40),2) mean(sHbRs(:,41:52),2) mean(sHbRs(:,53:64),2) mean(sHbRs(:,65:76),2) mean(sHbRs(:,77:88),2) mean(sHbRs(:,89:103),2)];

HbO_Center_S1 = mean(HbO_Center(305:350,:),1)'; HbO_Surround_S1 = mean(HbO_Surround(305:350,:),1)';
HbO_Center_S2 = mean(HbO_Center(500:600,:),1)'; HbO_Surround_S2 = mean(HbO_Surround(500:600,:),1)';
HbR_Center_S1 = mean(HbR_Center(305:350,:),1)'; HbR_Surround_S1 = mean(HbR_Surround(305:350,:),1)';
HbR_Center_S2 = mean(HbR_Center(500:600,:),1)'; HbR_Surround_S2 = mean(HbR_Surround(500:600,:),1)';

clearvars -except HbO_Center_S1 HbO_Surround_S1 HbO_Center_S2 HbO_Surround_S2 ...
                  HbR_Center_S1 HbR_Surround_S1 HbR_Center_S2 HbR_Surround_S2

