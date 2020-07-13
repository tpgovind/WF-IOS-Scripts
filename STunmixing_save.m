%% 1. Open data
clear all
close all
clc

dGdir = 'D:\DATA\STDynamicsProject\WF\ANALYSIS\Outputs\a3_Thinned_WhiskerStim_dG-div-G0.tif';
HbOdir = 'D:\DATA\STDynamicsProject\WF\ANALYSIS\Outputs\a3_Thinned_WhiskerStim_HbO.tif';
HbRdir = 'D:\DATA\STDynamicsProject\WF\ANALYSIS\Outputs\a3_Thinned_WhiskerStim_HbR.tif';
animal = 'c1';
dG_seeds = {}; %specify as [x,y]
dHbO_seeds = {[21 62],[16 36],[41 69],[41 63],[50 38],[49 9]};
dHbR_seeds = {[29 27],[51 43],[58 49]};
corr_limits = [0.25 0.75];

SF = 10;
dG_info = imfinfo(dGdir);
HbO_info = imfinfo(HbOdir);
HbR_info = imfinfo(HbRdir);
F = length(HbO_info); % number of frame

dG_img = zeros(dG_info(1).Width,dG_info(1).Height,F,'uint16'); % data matrix
dHbO_img = zeros(HbO_info(1).Width,HbO_info(1).Height,F,'uint16'); % data matrix
dHbR_img = zeros(HbR_info(1).Width,HbR_info(1).Height,F,'uint16'); % data matrix

for i = 1:F
    dG_img(:,:,i) = imread(dGdir,'Index',i,'Info',dG_info);
    dHbO_img(:,:,i) = imread(HbOdir,'Index',i,'Info',HbO_info);
    dHbR_img(:,:,i) = imread(HbRdir,'Index',i,'Info',HbR_info);
end

dG_img = reshape(single(dG_img),size(dG_img,1)*size(dG_img,2),size(dG_img,3));
dHbO_img = reshape(single(dHbO_img),size(dHbO_img,1)*size(dHbO_img,2),size(dHbO_img,3));
dHbR_img = reshape(single(dHbR_img),size(dHbR_img,1)*size(dHbR_img,2),size(dHbR_img,3));

TT_dG = squeeze(mean(dG_img,1));
TT_dG = TT_dG / mean(TT_dG); % global activity
C_dG = zeros(size(dG_img),'single'); % correction matrix
MMM_dG = imresize(mean(dG_img,2),[size(dG_img,1) size(dG_img,2)]);
TTT_dG = imresize(TT_dG,[size(dG_img,1) size(dG_img,2)]);
dG_img = dG_img - (MMM_dG.*TTT_dG); % substraction of the normalized global activity

TT_HbO = squeeze(mean(dHbO_img,1));
TT_HbO = TT_HbO / mean(TT_HbO); % global activity
C_HbO = zeros(size(dHbO_img),'single'); % correction matrix
MMM_HbO = imresize(mean(dHbO_img,2),[size(dHbO_img,1) size(dHbO_img,2)]);
TTT_HbO = imresize(TT_HbO,[size(dHbO_img,1) size(dHbO_img,2)]);
dHbO_img = dHbO_img - (MMM_HbO.*TTT_HbO); % substraction of the normalized global activity

TT_HbR = squeeze(mean(dHbR_img,1));
TT_HbR = TT_HbR / mean(TT_HbR); % global activity
C_HbR = zeros(size(dHbR_img),'single'); % correction matrix
MMM_HbR = imresize(mean(dHbR_img,2),[size(dHbR_img,1) size(dHbR_img,2)]);
TTT_HbR = imresize(TT_HbR,[size(dHbR_img,1) size(dHbR_img,2)]);
dHbR_img = dHbR_img - (MMM_HbR.*TTT_HbR); % substraction of the normalized global activity


%% 2. Seed pixel correlation

CM = zeros(HbO_info(1).Width,HbO_info(1).Height,'single'); %correlation matrix
images = {dG_img,dHbO_img,dHbR_img};
compartments = {'parenchyma','arterioles','veins'};
seedGroups = {dG_seeds,dHbO_seeds,dHbR_seeds};

for i = 1:length(seedGroups)
    I = images{i};
    seeds = seedGroups{i};
    string1 = strcat('Seed group:',' ',int2str(i));
    disp(string1)
    for n = 1:length(seeds)
        string2 = strcat('Seed:',int2str(n),' of ',int2str(length(seeds)),':');
        disp(strcat(string2))
        x = seeds{n}(1);
        y = seeds{n}(2);
        CM = corr(squeeze(I((x-1)*HbO_info(1).Width+y,:))',I'); %pixelwise correlation
        CM = reshape(CM,HbO_info(1).Width,HbO_info(1).Height);
        normCM = CM - min(CM(:));
        normCM = normCM ./ max(normCM(:));
        imwrite(uint16(65535*mat2gray(CM,corr_limits)),['D:\DATA\STDynamicsProject\WF\ANALYSIS\Outputs\Spatiotemporal unmixing\' animal '_' compartments{i} '_' int2str(n) '.tif']);
    end
end

disp('DONE')