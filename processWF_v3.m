function [ dc_HbO, dc_HbR, dc_HbT, HbO_full, HbR_full , HbT_full ] = processWF_v3( inputDir, outputDir, num_blFrames, ID )

tic

disp('Processing:')
disp(ID)

%% Read in inputs

imgFiles = dir([inputDir 'Basler*']);
imgFiles = natsortfiles({imgFiles.name});

numImages = length(imgFiles);
numFrames = length(imgFiles)/2; % per channel
numRows = size(im2double(imread([inputDir imgFiles{3}])),1);
numCols = size(im2double(imread([inputDir imgFiles{3}])),2);

R = zeros(numRows,numCols,numFrames);
i = 0;
for n = 1:2:numImages
    i = i + 1;
    R(:,:,i) = im2double(imread([inputDir imgFiles{n}]));
end

G = zeros(numRows,numCols,numFrames);
i = 0;
for n = 2:2:numImages
    i = i + 1;
    G(:,:,i) = im2double(imread([inputDir imgFiles{n}]));
end

disp('Done reading inputs...')
toc


%% Register images

disp('Registering R...')
for i = 1:(numImages/2)
    tformEstimate = imregcorr(R(:,:,i),R(:,:,1),'translation');
    [optimizer, metric] = imregconfig('monomodal');
    R(:,:,i) = imregister(R(:,:,i), R(:,:,1),...
        'translation', optimizer, metric,'InitialTransformation',tformEstimate);
end

disp('Registering G...')
for i = 1:(numImages/2)
    tformEstimate = imregcorr(single(G(:,:,i)),single(G(:,:,1)),'translation');
    [optimizer, metric] = imregconfig('monomodal');
    G(:,:,i) = imregister(G(:,:,i), G(:,:,1),...
        'translation', optimizer, metric,'InitialTransformation',tformEstimate);
end

disp('Done registering images...')
toc

%% Compute changes to raw images relative to baseline

bl_R = mean(R(:,:,1:num_blFrames),3); % calculate baseline images
bl_G = mean(G(:,:,1:num_blFrames),3);

delta_R = zeros(size(R,1),size(R,2),numFrames);
delta_G = zeros(size(G,1),size(G,2),numFrames);

for n = 1:numFrames
    delta_R(:,:,n) = (R(:,:,n))./bl_R;
    delta_G(:,:,n) = (G(:,:,n))./bl_G;
end

disp('Done computing dR/R...')
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

%% Create and save processed ROI images

HbOdir = [outputDir ID '_HbO.tif'];
HbRdir = [outputDir ID '_HbR.tif'];
HbTdir = [outputDir ID '_HbT.tif'];

dcHbO_hist = histogram(dc_HbO(:,:,round(numFrames/2)));
dcHbO_limits = dcHbO_hist.BinLimits;
dcHbR_hist = histogram(dc_HbR(:,:,round(numFrames/2)));
dcHbR_limits = dcHbR_hist.BinLimits;
dcHbT_hist = histogram(dc_HbT(:,:,round(numFrames/2)));
dcHbT_limits = dcHbT_hist.BinLimits;

HbO_full = zeros(numRows,numCols,numFrames);
HbR_full = zeros(numRows,numCols,numFrames);
HbT_full = zeros(numRows,numCols,numFrames);

imwrite(uint16(65535*mat2gray(dc_HbO(:,:,1),dcHbO_limits)),HbOdir);
HbO_full(:,:,1) = uint16(65535*mat2gray(dc_HbO(:,:,1),dcHbO_limits));
for i = 2:numFrames
    HbO = uint16(65535*mat2gray(dc_HbO(:,:,i),dcHbO_limits));
    HbO_full(:,:,i) = HbO;
    imwrite(HbO,HbOdir,'WriteMode','append');
end

disp('Done saving HbO.')
toc

imwrite(uint16(65535*mat2gray(dc_HbR(:,:,1),dcHbR_limits)),HbRdir);
HbR_full(:,:,1) = uint16(65535*mat2gray(dc_HbR(:,:,1),dcHbR_limits));
for i = 2:numFrames
    HbR = uint16(65535*mat2gray(dc_HbR(:,:,i),dcHbR_limits));
    HbR_full(:,:,i) = HbR;
    imwrite(HbR,HbRdir,'WriteMode','append');
end

disp('Done saving HbR.')
toc

imwrite(uint16(65535*mat2gray(dc_HbT(:,:,1),dcHbT_limits)),HbTdir);
HbT_full(:,:,1) = uint16(65535*mat2gray(dc_HbT(:,:,1),dcHbT_limits));
for i = 2:numFrames
    HbT = uint16(65535*mat2gray(dc_HbT(:,:,i),dcHbT_limits));
    HbT_full(:,:,i) = HbT;
    imwrite(HbT,HbTdir,'WriteMode','append');
end

disp('Done saving HbT.')
toc

end