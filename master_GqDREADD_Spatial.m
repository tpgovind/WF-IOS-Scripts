clc
clear all
close all

%% PROCESS AND EXTRACT SIGNALS, AND SAVE

% Make tables and load masks and paths

[varTypes{1:214}] = deal('double');
varNames = {'M12_Trial1','M12_Trial2','M12_Trial3','M12_Trial4','M12_Trial5','M12_Trial6','M12_Trial7','M12_Trial8','M12_Trial9','M12_Trial10','M13_Trial1','M13_Trial2','M13_Trial3','M13_Trial4','M13_Trial5','M13_Trial6','M13_Trial7','M13_Trial8','M13_Trial9','M13_Trial10','M14_Trial1','M14_Trial2','M14_Trial3','M14_Trial4','M14_Trial5','M14_Trial6','M14_Trial7','M14_Trial8','M14_Trial9','M14_Trial10'};

WF_HbO_Basals_NAIVE_Parenchyma = ...
table('Size',[1799 17],'VariableTypes',varTypes2,'VariableNames',varNames2); % table1

WF_HbO_Basals_NAIVE_Vessels = ...
table('Size',[1799 17],'VariableTypes',varTypes2,'VariableNames',varNames2); % table2

WF_HbO_Basals_C21_Parenchyma = ...
table('Size',[1799 33],'VariableTypes',varTypes4,'VariableNames',varNames4); % table3

WF_HbO_Basals_C21_Vessels = ...
table('Size',[1799 33],'VariableTypes',varTypes4,'VariableNames',varNames4); % table4

WF_HbO_Trials_NAIVE_Parenchyma = ...
table('Size',[1799 30],'VariableTypes',varTypes1,'VariableNames',varNames1); % table5

WF_HbO_Trials_NAIVE_Vessels = ...
table('Size',[1799 30],'VariableTypes',varTypes1,'VariableNames',varNames1); % table6

WF_HbO_Trials_C21_Parenchyma = ...
table('Size',[1799 41],'VariableTypes',varTypes3,'VariableNames',varNames3); % table7

WF_HbO_Trials_C21_Vessels = ...
table('Size',[1799 41],'VariableTypes',varTypes3,'VariableNames',varNames3); % table8

WF_HbR_Basals_NAIVE_Parenchyma = ...
table('Size',[1799 17],'VariableTypes',varTypes2,'VariableNames',varNames2); % table9

WF_HbR_Basals_NAIVE_Vessels = ...
table('Size',[1799 17],'VariableTypes',varTypes2,'VariableNames',varNames2); % table10

WF_HbR_Basals_C21_Parenchyma = ...
table('Size',[1799 33],'VariableTypes',varTypes4,'VariableNames',varNames4); % table11

WF_HbR_Basals_C21_Vessels = ...
table('Size',[1799 33],'VariableTypes',varTypes4,'VariableNames',varNames4); % table12

WF_HbR_Trials_NAIVE_Parenchyma = ...
table('Size',[1799 30],'VariableTypes',varTypes1,'VariableNames',varNames1); % table13

WF_HbR_Trials_NAIVE_Vessels = ...
table('Size',[1799 30],'VariableTypes',varTypes1,'VariableNames',varNames1); % table14

WF_HbR_Trials_C21_Parenchyma = ...
table('Size',[1799 41],'VariableTypes',varTypes3,'VariableNames',varNames3); % table15

WF_HbR_Trials_C21_Vessels = ...
table('Size',[1799 41],'VariableTypes',varTypes3,'VariableNames',varNames3); % table16

WF_HbT_Basals_NAIVE_Parenchyma = ...
table('Size',[1799 17],'VariableTypes',varTypes2,'VariableNames',varNames2); % table17

WF_HbT_Basals_NAIVE_Vessels = ...
table('Size',[1799 17],'VariableTypes',varTypes2,'VariableNames',varNames2); % table18

WF_HbT_Basals_C21_Parenchyma = ...
table('Size',[1799 33],'VariableTypes',varTypes4,'VariableNames',varNames4); % table19

WF_HbT_Basals_C21_Vessels = ...
table('Size',[1799 33],'VariableTypes',varTypes4,'VariableNames',varNames4); % table20

WF_HbT_Trials_NAIVE_Parenchyma = ...
table('Size',[1799 30],'VariableTypes',varTypes1,'VariableNames',varNames1); % table21

WF_HbT_Trials_NAIVE_Vessels = ...
table('Size',[1799 30],'VariableTypes',varTypes1,'VariableNames',varNames1); % table22

WF_HbT_Trials_C21_Parenchyma = ...
table('Size',[1799 41],'VariableTypes',varTypes3,'VariableNames',varNames3); % table23

WF_HbT_Trials_C21_Vessels = ...
table('Size',[1799 41],'VariableTypes',varTypes3,'VariableNames',varNames3); % table24


masks = {logical(imread('F:\ANALYZED_DATA\DATA STRUCTS\SPATIAL - SELECTED GQDREADD\M12_VesselMask.tif')),...
    logical(imread('F:\ANALYZED_DATA\DATA STRUCTS\SPATIAL - SELECTED GQDREADD\M12_ParenchymaMask.tif')),...
    logical(imread('F:\ANALYZED_DATA\DATA STRUCTS\SPATIAL - SELECTED GQDREADD\M13_VesselMask.tif')),...
    logical(imread('F:\ANALYZED_DATA\DATA STRUCTS\SPATIAL - SELECTED GQDREADD\M13_ParenchymaMask.tif')),...
    logical(imread('F:\ANALYZED_DATA\DATA STRUCTS\SPATIAL - SELECTED GQDREADD\M14_VesselMask.tif')),...
    logical(imread('F:\ANALYZED_DATA\DATA STRUCTS\SPATIAL - SELECTED GQDREADD\M14_ParenchymaMask.tif'))};

% caHemoPaths file order: 30x NAIVE_Trial, 17x Naive_Basal, 41x C21_Trial, 33x C21_Basal
load('F:\ANALYZED_DATA\MAT Files\GqDREADD\Vasomotion Analysis\WF\VesselVsParenchyma\filePaths.mat');

counter1 = 0; counter2 = 0; counter3 = 0; counter4 = 0;
for i = 1:size(caHemoPaths,1)
%counter1 = 0; counter2 = 0; counter3 = 17; counter4 = 15;
%for i = 65:78 %104:116

    tic    
    current_ImageID = strsplit(caHemoPaths{i,1},'\'); current_ImageID = current_ImageID{1};
    current_Path = caHemoPaths{i,2};
    current_ImageMode = caHemoPaths{i,3};
    current_ImageType = caHemoPaths{i,4};
    current_Manipulation = caHemoPaths{i,5};
    current_Number = strsplit(caHemoPaths{i,6},'\'); current_Number = current_Number{1};
    
    if (strcmp(current_ImageID,'M12'))
        maskName = 'M12_Masks';
        vesselMask = masks{1};
        parenchymaMask = masks{2};
    elseif (strcmp(current_ImageID,'M13'))
        maskName = 'M13_Masks';        
        vesselMask = masks{3};
        parenchymaMask = masks{4};            
    elseif (strcmp(current_ImageID,'M14'))
        maskName = 'M14_Masks';        
        vesselMask = masks{5};
        parenchymaMask = masks{6};        
    end
    
    disp(strcat('Starting',{' '},int2str(i),{' '},'of',{' '},...
        int2str(size(caHemoPaths,1)),':',{' '},current_ImageID,'_',current_ImageMode,current_Number));
    disp(['Using: ' maskName]);
    
    [I,numChannels] = readImages(current_Path,current_ImageType);
    R = I{1,2}; G = I{2,2};
    B = zeros(size(R));
    
    disp('Computing vessel signals');
    [R_masked,G_masked,B_masked] = applyMasks(R,G,B,vesselMask);
    [HbO,HbR,HbT,~] = computeWidefieldSignals(R_masked,G_masked,B_masked);
    HbO(isinf(HbO)) = NaN; HbR(isinf(HbR)) = NaN; HbT(isinf(HbT)) = NaN;
    HbOTrace_Vessel = squeeze(nanmean2(HbO)); HbRTrace_Vessel = squeeze(nanmean2(HbR)); HbTTrace_Vessel = squeeze(nanmean2(HbT));

    disp('Computing parenchymal signals');    
    [R_masked,G_masked,B_masked] = applyMasks(R,G,B,parenchymaMask);
    [HbO,HbR,HbT,~] = computeWidefieldSignals(R_masked,G_masked,B_masked);
    HbO(isinf(HbO)) = NaN; HbR(isinf(HbR)) = NaN; HbT(isinf(HbT)) = NaN;
    HbOTrace_Parenchyma = squeeze(nanmean2(HbO)); HbRTrace_Parenchyma = squeeze(nanmean2(HbR)); HbTTrace_Parenchyma = squeeze(nanmean2(HbT));
    
    
    if (i < 31)
        disp('Regime: NAIVE_Trials');
        counter1 = counter1 + 1;
        WF_HbO_Trials_NAIVE_Parenchyma{:,counter1} = HbOTrace_Parenchyma;
        WF_HbR_Trials_NAIVE_Parenchyma{:,counter1} = HbRTrace_Parenchyma;
        WF_HbT_Trials_NAIVE_Parenchyma{:,counter1} = HbTTrace_Parenchyma;
        WF_HbO_Trials_NAIVE_Vessels{:,counter1} = HbOTrace_Vessel;        
        WF_HbR_Trials_NAIVE_Vessels{:,counter1} = HbRTrace_Vessel;
        WF_HbT_Trials_NAIVE_Vessels{:,counter1} = HbTTrace_Vessel;

    elseif (i < 48)
        disp('Regime: NAIVE_Basals');
        counter2 = counter2 + 1;
        WF_HbO_Basals_NAIVE_Parenchyma{:,counter2} = HbOTrace_Parenchyma;
        WF_HbR_Basals_NAIVE_Parenchyma{:,counter2} = HbRTrace_Parenchyma;
        WF_HbT_Basals_NAIVE_Parenchyma{:,counter2} = HbTTrace_Parenchyma;
        WF_HbO_Basals_NAIVE_Vessels{:,counter2} = HbOTrace_Vessel;        
        WF_HbR_Basals_NAIVE_Vessels{:,counter2} = HbRTrace_Vessel;
        WF_HbT_Basals_NAIVE_Vessels{:,counter2} = HbTTrace_Vessel;
        
    elseif (i < 89)
        disp('Regime: C21_Trials');
        counter3 = counter3 + 1;
        WF_HbO_Trials_C21_Parenchyma{:,counter3} = HbOTrace_Parenchyma;
        WF_HbR_Trials_C21_Parenchyma{:,counter3} = HbRTrace_Parenchyma;
        WF_HbT_Trials_C21_Parenchyma{:,counter3} = HbTTrace_Parenchyma;
        WF_HbO_Trials_C21_Vessels{:,counter3} = HbOTrace_Vessel;        
        WF_HbR_Trials_C21_Vessels{:,counter3} = HbRTrace_Vessel;
        WF_HbT_Trials_C21_Vessels{:,counter3} = HbTTrace_Vessel;
   
    else
        disp('Regime: C21_Basals');
        counter4 = counter4 + 1;
        WF_HbO_Basals_C21_Parenchyma{:,counter4} = HbOTrace_Parenchyma;
        WF_HbR_Basals_C21_Parenchyma{:,counter4} = HbRTrace_Parenchyma;
        WF_HbT_Basals_C21_Parenchyma{:,counter4} = HbTTrace_Parenchyma;
        WF_HbO_Basals_C21_Vessels{:,counter4} = HbOTrace_Vessel;        
        WF_HbR_Basals_C21_Vessels{:,counter4} = HbRTrace_Vessel;
        WF_HbT_Basals_C21_Vessels{:,counter4} = HbTTrace_Vessel;
    
    end
    
    toc
    clearvars -except caHemoPaths masks i counter1 counter2 counter3 counter4...
        WF_HbO_Trials_NAIVE_Parenchyma...
        WF_HbR_Trials_NAIVE_Parenchyma...
        WF_HbT_Trials_NAIVE_Parenchyma...
        WF_HbO_Trials_NAIVE_Vessels...
        WF_HbR_Trials_NAIVE_Vessels...
        WF_HbT_Trials_NAIVE_Vessels...
        WF_HbO_Basals_NAIVE_Parenchyma...
        WF_HbR_Basals_NAIVE_Parenchyma...
        WF_HbT_Basals_NAIVE_Parenchyma...
        WF_HbO_Basals_NAIVE_Vessels...
        WF_HbR_Basals_NAIVE_Vessels...
        WF_HbT_Basals_NAIVE_Vessels...
        WF_HbO_Trials_C21_Parenchyma...
        WF_HbR_Trials_C21_Parenchyma...
        WF_HbT_Trials_C21_Parenchyma...
        WF_HbO_Trials_C21_Vessels...
        WF_HbR_Trials_C21_Vessels...
        WF_HbT_Trials_C21_Vessels...
        WF_HbO_Basals_C21_Parenchyma...
        WF_HbR_Basals_C21_Parenchyma...
        WF_HbT_Basals_C21_Parenchyma...
        WF_HbO_Basals_C21_Vessels...
        WF_HbR_Basals_C21_Vessels...
        WF_HbT_Basals_C21_Vessels
    
end
