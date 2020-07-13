clc
clear all
close all

%% IMPORT MAT FILES

load('F:\ANALYZED_DATA\MAT Files\masks.mat')
load('F:\ANALYZED_DATA\MAT Files\info.mat')

%% DEFINE FOLDER STRUCTURE FOR LOOPS

%{
source = {'D:\','G:\'};

imageID = {'M11\','M12\','M13\','M14\','M15\','M16\','M18\','M29\'};

manipulation = {'','AFTER_C21\','AFTER_1st_C21\','AFTER_2nd_C21\',...
    'AFTER_3rd_C21\','FITC\'};

imageMode = {'Basal','Trial'};

num = {'1\','2\','3\','4\','5\','6\','7\','8\','9\','10\','11\',...
    '12\','13\','14\','15\','16\','17\','18\','19\','20\','21\',...
    '22\','23\','24\','25\'};

imageType = {'CaHemo\','OpticalFlow\','CloseUp\'};
%}

source = {'D:\','G:\'};
imageID = {'M9\','M10\','M29\','M46\','M57\'};
manipulation = {''};
imageMode = {'Trial'};
num = {'1\','2\','3\','4\','5\','6\','7\','8\','9\','10\','11\',...
    '12\','13\','14\','15\','16\','17\','18\','19\','20\','21\',...
    '22\','23\','24\','25\'};
imageType = {'CaHemo\'};

p = 1;
e = 1;
r = 1;

for g = 1:length(source)
    for o = 1:length(imageID)
        for v = 1:length(manipulation)
            for i = 1:length(imageMode)
                for n = 1:length(num)
                    for d = 1:length(imageType)
                        path = strcat(source{g},imageID{o},manipulation{v},imageMode{i},{' '},num{n},imageType{d});
                        if(exist(path{1,1},'dir') > 0)
                            if(d==1)
                                caHemoPaths{p,1} = imageID{o}; % Image_ID
                                caHemoPaths{p,2} = path{1,1}; % Location
                                caHemoPaths{p,3} = imageMode{i}; % Mode
                                caHemoPaths{p,4} = imageType{d}; % Type
                                caHemoPaths{p,5} = manipulation{v}; % Manipulation
                                caHemoPaths{p,6} = num{n}; % Number
                                
                                p = p + 1;
                            end
                            if(d==2)
                                opticalFlowPaths{e,1} = imageID{o}; % Image_ID
                                opticalFlowPaths{e,2} = path{1,1}; % Location
                                opticalFlowPaths{e,3} = imageMode{i}; % Mode
                                opticalFlowPaths{e,4} = imageType{d}; % Type
                                opticalFlowPaths{e,5} = manipulation{v}; % Type
                                opticalFlowPaths{e,6} = num{n}; % Number
                                
                                e = e + 1;
                            end
                            if(d==3)
                                closeUpPaths{r,1} = imageID{o}; % Image_ID
                                closeUpPaths{r,2} = path{1,1}; % Location
                                closeUpPaths{r,3} = imageMode{i}; % Mode
                                closeUpPaths{r,4} = imageType{d}; % Type
                                closeUpPaths{r,5} = manipulation{v}; % Type
                                closeUpPaths{r,6} = num{n}; % Number
                                
                                r = r + 1;
                            end
                        end
                    end
                end
            end
        end
    end
end


if (exist('closeUpPaths','var'))
    last_CloseUp = size(closeUpPaths,1) + 1;
    last_OpticalFlow = size(opticalFlowPaths,1);
    for a = last_CloseUp:last_OpticalFlow
        closeUpPaths{a,1} = opticalFlowPaths{a,1};
        closeUpPaths{a,2} = opticalFlowPaths{a,2};
        closeUpPaths{a,3} = opticalFlowPaths{a,3};
        closeUpPaths{a,4} = opticalFlowPaths{a,4};
    end
    clearvars -except caHemoPaths opticalFlowPaths closeUpPaths Masks_Data Info_Data
else
    clearvars -except caHemoPaths opticalFlowPaths Masks_Data Info_Data
end

%% PROCESS AND EXTRACT SIGNALS, AND SAVE

counter = 0;

for i = 1:size(caHemoPaths,1)
    
    tic
    
    % WIDEFIELD SIGNALS
    
    current_ImageID = caHemoPaths{i,1};
    current_Path = caHemoPaths{i,2};
    current_ImageMode = caHemoPaths{i,3};
    current_ImageType = caHemoPaths{i,4};
    current_Manipulation = caHemoPaths{i,5};
    current_Number = caHemoPaths{i,6};
    
    % Info
    info_ID = find(strcmp(strcat(Info_Data(:,1),'\'), current_ImageID));
    animal_ID = Info_Data{info_ID,2};
    strain = Info_Data{info_ID,3};
    genotype = Info_Data{info_ID,4};
    gender = Info_Data{info_ID,5};
    sex = Info_Data{info_ID,6};
    age = Info_Data{info_ID,7};
    pharmacology = Info_Data{info_ID,8};
    windowMap1 = Info_Data{info_ID,9};
    windowMap2 = Info_Data{info_ID,10};
    
    [I,numChannels] = readImages(current_Path,current_ImageType);
    R = I{1,2}; G = I{2,2};
    B = zeros(size(R));
    
    %Mask
    mask_ID = find(strcmp(strcat(Masks_Data(:,1),'\'), current_ImageID));
    mask = Masks_Data{mask_ID,2};
    [R,G,B] = applyMasks(R,G,B,mask);
    
    [HbO,HbR,HbT,Fluo] = computeWidefieldSignals(R,G,B);
    
    % LOCOMOTION TRACES
    
    current_ImageID = opticalFlowPaths{i,1};
    current_Path = opticalFlowPaths{i,2};
    current_ImageMode = opticalFlowPaths{i,3};
    current_ImageType = opticalFlowPaths{i,4};
    current_Manipulation = opticalFlowPaths{i,5};
    current_Number = opticalFlowPaths{i,6};
    
    [I,~] = readImages(current_Path,current_ImageType);
    locomotionTrace = computeLocomotionTraces(I);
    
    % SAVE DATA TO FILE
    
    S = struct;
    
    S.Info.ImageID = strtok(caHemoPaths{i,1},'\'); S.Info.Manipulation = strtok(caHemoPaths{i,5},'\');
    S.Info.ImageMode = caHemoPaths{i,3}; S.Info.Number = strtok(caHemoPaths{i,6},'\');
    S.Info.ImageType = strtok(caHemoPaths{i,4},'\'); S.Info.animal_ID = Info_Data{info_ID,2};
    S.Info.Strain = Info_Data{info_ID,3}; S.Info.Genotype = Info_Data{info_ID,4};
    S.Info.Sex = Info_Data{info_ID,5}; S.Info.Age = Info_Data{info_ID,6};
    S.Info.SurgicalPreparation = Info_Data{info_ID,7}; S.Info.Pharmacology = Info_Data{info_ID,8};
    S.Info.WindowMap1 = Info_Data{info_ID,9}; S.Info.WindowMap2 = Info_Data{info_ID,10};
    
    S.Masks.R = R; S.Masks.G = G; S.Masks.B = B;
    
    S.WFSignals.Raw.R = R;  S.WFSignals.Raw.G = G;  S.WFSignals.Processed.B = B;
    S.WFSignals.Processed.HbO = HbO;  S.WFSignals.Processed.HbR = HbR;
    S.WFSignals.Processed.HbT = HbT; S.WFSignals.Processed.Fluo = Fluo;
    S.WFBehavior.LocomotionTrace = locomotionTrace;
    
    dumvar = 0;
    filename = strcat('F:\ANALYZED_DATA\DATA STRUCTS\',Info_Data{info_ID,1},{'-'},strtok(caHemoPaths{i,5},'\'),{'-'},caHemoPaths{i,3},...
        strtok(caHemoPaths{i,6},'\'),'.mat');
    
    if(strcmp(caHemoPaths{i,5},''))
        filename = strcat('F:\ANALYZED_DATA\DATA STRUCTS\',Info_Data{info_ID,1},{'-'},caHemoPaths{i,3},...
            strtok(caHemoPaths{i,6},'\'),'.mat');
    end
    
    save(filename{1,1},'dumvar','S','-v7.3');
    
%     try
%         save(filename{1,1},'S');
%     catch
%         err = lasterror;
%         switch err.identifier
%             case 'MATLAB:save:sizeTooBigForMATFile'
%                 save(filename{1,1},'dumvar','S','-v7.3');
%         end
%     end
    
    if(strcmp(caHemoPaths{i,5},''))
        update = strcat(int2str(i),{' '},'of',{' '},int2str(size(caHemoPaths,1)),{' '},'(',S.Info.ImageID,'-',caHemoPaths{i,3},...
            strtok(caHemoPaths{i,6},'\'),')',{' '},'...','DONE!');
    else
        update = strcat(int2str(i),{' '},'of',{' '},int2str(size(caHemoPaths,1)),{' '},'(',S.Info.ImageID,'-',strtok(caHemoPaths{i,5},'\'),'-',caHemoPaths{i,3},...
            strtok(caHemoPaths{i,6},'\'),')',{' '},'...','DONE!');
    end
    
    disp(update)
    toc
    
    if (exist('closeUpPaths','var'))
        clearvars -except caHemoPaths opticalFlowPaths closeUpPaths Masks_Data Info_Data i warnings counter
    else
        clearvars -except caHemoPaths opticalFlowPaths Masks_Data Info_Data i warnings counter
    end
end