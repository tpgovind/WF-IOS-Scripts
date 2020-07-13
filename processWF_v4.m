function [ dc_HbO, dc_HbR, dc_HbT, dF ] = processWF_v4( inputDir, outputDir, num_blFrames, ID )

clc
clearvars -except inputDir outputDir num_blFrames ID
close all

tic

disp('Processing:')
disp(ID)

%% Read in inputs (skip first four frames)

imgFiles = dir([inputDir 'CaHemo*']);
imgFiles = natsortfiles({imgFiles.name});

numImages = length(imgFiles);
numFrames = length(imgFiles)/4; % per channel
numRows = size(im2double(imread([inputDir imgFiles{3}])),1);
numCols = size(im2double(imread([inputDir imgFiles{3}])),2);

R = zeros(numRows,numCols,numFrames);
i = 0;
for n = 5:4:numImages
    i = i + 1;
    R(:,:,i) = im2double(imread([inputDir imgFiles{n}]));
end

G = zeros(numRows,numCols,numFrames);
i = 0;
for n = 6:4:numImages
    i = i + 1;
    G(:,:,i) = im2double(imread([inputDir imgFiles{n}]));
end

B1 = zeros(numRows,numCols,numFrames);
B2 = zeros(numRows,numCols,numFrames);
B = zeros(numRows,numCols,numFrames);
i = 0;
for n = 7:4:numImages
    i = i + 1;
    B1(:,:,i) = im2double(imread([inputDir imgFiles{n}]));
end
i = 0;
for n = 8:4:numImages
    i = i + 1;
    B2(:,:,i) = im2double(imread([inputDir imgFiles{n}]));
end
for n = 1:numFrames
    B(:,:,n) = B1(:,:,n) + B2(:,:,n);
end

disp('Done reading inputs...')
toc


%% Register images

disp('Registering R...')
for i = 1:numFrames
    tformEstimate = imregcorr(R(:,:,i),R(:,:,1),'translation');
    [optimizer, metric] = imregconfig('monomodal');
    R(:,:,i) = imregister(R(:,:,i), R(:,:,1),...
        'translation', optimizer, metric,'InitialTransformation',tformEstimate);
end

disp('Registering G...')
for i = 1:numFrames
    tformEstimate = imregcorr(single(G(:,:,i)),single(G(:,:,1)),'translation');
    [optimizer, metric] = imregconfig('monomodal');
    G(:,:,i) = imregister(G(:,:,i), G(:,:,1),...
        'translation', optimizer, metric,'InitialTransformation',tformEstimate);
end

disp('Registering B...')
for i = 1:numFrames
    tformEstimate = imregcorr(single(B(:,:,i)),single(B(:,:,1)),'translation');
    [optimizer, metric] = imregconfig('monomodal');
    B(:,:,i) = imregister(B(:,:,i), B(:,:,1),...
        'translation', optimizer, metric,'InitialTransformation',tformEstimate);
end

disp('Done registering images...')
toc

%% Compute changes to raw images relative to baseline

bl_R = mean(R(:,:,1:num_blFrames),3); % calculate baseline images
bl_G = mean(G(:,:,1:num_blFrames),3);
bl_B = mean(B(:,:,1:num_blFrames),3);

delta_R = zeros(size(R,1),size(R,2),numFrames);
delta_G = zeros(size(G,1),size(G,2),numFrames);
delta_B = zeros(size(B,1),size(B,2),numFrames);

for n = 1:numFrames
    delta_R(:,:,n) = (R(:,:,n))./bl_R;
    delta_G(:,:,n) = (G(:,:,n))./bl_G;
    delta_B(:,:,n) = (B(:,:,n))./bl_B;
end

disp('Done computing dR/R0, dF/F0...')
toc

%% Compute perfusion changes
% wl1 = 528, wl2 = 660
% corrected, ua*10
ua_hbo_r = 10*319.6/1e6; % ep_HbO_wl2
ua_hbo_g = 10*35990/1e6; % ep_HbO_wl1
ua_hb_r = 10*3226.56/1e6; % ep_Hb_wl2
ua_hb_g = 10*37490/1e6; % ep_Hb_wl1
d_ua_r = -log(delta_R)/4.535122; % -ln(delta_wl2)/pathlength_wl2 = delta_ua_wl2
d_ua_g = -log(delta_G)/0.410981; % Eq 2.4, RHS. Delta_ua. -ln(delta_wl1)/pathlength_wl1 = delta_ua_wl1

dc_HbR = (ua_hbo_g*d_ua_r - ua_hbo_r*d_ua_g)/(ua_hbo_g*ua_hb_r - ua_hbo_r*ua_hb_g); % delta_Hbr
dc_HbO = (ua_hb_g*d_ua_r - ua_hb_r*d_ua_g)/(ua_hb_g*ua_hbo_r - ua_hb_r*ua_hbo_g); % delta_HbO
dc_HbT = dc_HbO + dc_HbR;

disp('Done computing perfusion estimates...')
toc

%% Compute hemodynamics-corrected GCaMP changes

ua_em_hbo = 24174.8/1e6;% 488
ua_em_hb = 15898/1e6;
ua_ex_hbo = 39956.8/1e6;% 530
ua_ex_hb = 39036.4/1e6;
Xest_ex = 0.56;
Xest_em = 0.57;

d_ua_ex_em_X = (ua_ex_hbo*dc_HbO + ua_ex_hb*dc_HbR)*Xest_ex...
    + (ua_em_hbo*dc_HbO + ua_em_hb*dc_HbR)*Xest_em;
ln_d_GCaMP = log(delta_B) - d_ua_ex_em_X;
dF = exp(ln_d_GCaMP);

disp('Done correcting GCaMP changes...')
toc

%% Create and save processed ROI images

HbOdir = [outputDir ID '_HbO.tif'];
HbRdir = [outputDir ID '_HbR.tif'];
HbTdir = [outputDir ID '_HbT.tif'];
Fdir = [outputDir ID '_F.tif'];

dcHbO_hist = histogram(dc_HbO(:,:,round(numFrames/2)));
dcHbO_limits = dcHbO_hist.BinLimits;
dcHbR_hist = histogram(dc_HbR(:,:,round(numFrames/2)));
dcHbR_limits = dcHbR_hist.BinLimits;
dcHbT_hist = histogram(dc_HbT(:,:,round(numFrames/2)));
dcHbT_limits = dcHbT_hist.BinLimits;
dF_hist = histogram(dF(:,:,round(numFrames/2)));
dF_limits = dF_hist.BinLimits;

imwrite(uint16(65535*mat2gray(dc_HbO(:,:,1),dcHbO_limits)),HbOdir);
for i = 2:numFrames
    HbO = uint16(65535*mat2gray(dc_HbO(:,:,i),dcHbO_limits));
    imwrite(HbO,HbOdir,'WriteMode','append');
end

disp('Done saving HbO.')
toc

imwrite(uint16(65535*mat2gray(dc_HbR(:,:,1),dcHbR_limits)),HbRdir);
for i = 2:numFrames
    HbR = uint16(65535*mat2gray(dc_HbR(:,:,i),dcHbR_limits));
    imwrite(HbR,HbRdir,'WriteMode','append');
end

disp('Done saving HbR.')
toc

imwrite(uint16(65535*mat2gray(dc_HbT(:,:,1),dcHbT_limits)),HbTdir);
for i = 2:numFrames
    HbT = uint16(65535*mat2gray(dc_HbT(:,:,i),dcHbT_limits));
    imwrite(HbT,HbTdir,'WriteMode','append');
end

disp('Done saving HbT.')
toc

imwrite(uint16(65535*mat2gray(dF(:,:,1),dF_limits)),Fdir);
for i = 2:numFrames
    F = uint16(65535*mat2gray(dF(:,:,i),dF_limits));
    imwrite(F,Fdir,'WriteMode','append');
end

disp('Done saving F.')
toc

disp('ALL DONE')
end