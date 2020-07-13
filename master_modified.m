clc
clear all
close all

%% IMPORT MAT FILES

load('F:\ANALYZED_DATA\masks_WF-guided-2P.mat')
load('F:\ANALYZED_DATA\info.mat')

%% DEFINE FOLDER STRUCTURE FOR LOOPS


source = {'D:\','G:\'};
imageID = {'GQ1\','GQ4\','GQ12\'};
manipulation = {''};
imageMode = {'Trial'};
num = {'1\','2\','3\','4\','5\','6\','7\','8\','9\','10\','11\',...
    '12\','13\','14\','15\','16\','17\','18\','19\','20\','21\',...
    '22\','23\','24\','25\'};
imageType = {'CaHemo\'};
locs = {'Loc0','Loc1','Loc2','Loc3','Loc4','Loc5','Loc6'};


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
                        end
                    end
                end
            end
        end
    end
end

clearvars -except caHemoPaths opticalFlowPaths Masks_Data Info_Data locs

%% PROCESS AND EXTRACT SIGNALS, AND SAVE

counter = 0;

for i = 1:size(caHemoPaths,1)
    
    tic
    
    current_ImageID = strsplit(caHemoPaths{i,1},'\'); current_ImageID = current_ImageID{1};
    current_Path = caHemoPaths{i,2};
    current_ImageMode = caHemoPaths{i,3};
    current_ImageType = caHemoPaths{i,4};
    current_Manipulation = caHemoPaths{i,5};
    current_Number = strsplit(caHemoPaths{i,6},'\'); current_Number = current_Number{1};
    
    disp(strcat('Starting',{' '},int2str(i),{' '},'of',{' '},...
        int2str(size(caHemoPaths,1)),':',{' '},current_ImageID,'_',current_ImageMode,current_Number));
    
    [I,numChannels] = readImages(current_Path,current_ImageType);
    R = I{1,2}; G = I{2,2};
    B = zeros(size(R));
    
    for j = 1:size(locs,2)
        
        mask_index = find(strcmp(strcat(current_ImageID,'_',locs(j)),Masks_Data(:,1)));
        
        if(~isempty(mask_index))
            
            counter = counter + 1;
            prefix = Masks_Data{mask_index,1};
            suffix = strcat('_',current_ImageMode,current_Number);
            mask = Masks_Data{mask_index,2};
                       
            [R_masked,G_masked,B_masked] = applyMasks(R,G,B,mask);
            [HbO,HbR,HbT,~] = computeWidefieldSignals(R_masked,G_masked,B_masked);
            
            HeaderLines{counter,1} = strcat(prefix,suffix);
            Data{counter,1} = HbO; Data{counter,2} = HbR; Data{counter,3} = HbT;
            
            disp(strcat(prefix,suffix,' ... complete!'));
        end
        
    end
    
    toc
    clearvars -except caHemoPaths Masks_Data i locs HeaderLines Data counter
end