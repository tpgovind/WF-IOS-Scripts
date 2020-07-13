%% 1. Open data
%clear all
close all
clc

inputDir = 'D:\';

limits = [1 1];
trials = 1000;

[file,rep] = uigetfile([inputDir '*.tif']); % select file
SF = 10; % sampling freq
file = [rep file];
info = imfinfo(file); % open file info
F = length(info); % number of frame

I = zeros(info(1).Width,info(1).Height,F,'uint16'); % data matrix
for i = 1:F
    I(:,:,i) = imread(file,'Index',i,'Info',info);
end

I = reshape(single(I),size(I,1)*size(I,2),size(I,3));

TT = squeeze(mean(I,1));
TT = TT / mean(TT); % global activity
C = zeros(size(I),'single'); % correction matrix
MMM = imresize(mean(I,2),[size(I,1) size(I,2)]);
TTT = imresize(TT,[size(I,1) size(I,2)]);
I = I - (MMM.*TTT); % substraction of the normalized global activity

% [b,a] = cheby1(2,0.5,2*[1 4]/SF); % band pass (1 to 10Hz) filtering
% for i = 1:size(I,1)
%     I(i,:) = single(filtfilt(b,a,double(I(i,:))));
% end


%% 2. Seed pixel correlation

CM = zeros(info(1).Width,info(1).Height,'single'); %correlation matrix

for i = 1:trials
     imshow(CM,limits,'InitialMagnification',600)
     colormap jet
     colorbar
     try
         hold on
         plot(x,y,'wo');
         hold off
     end
     [x,y]=ginput(1);
     x = round(x);
     y = round(y);
     disp(strcat("[",int2str(x),",",int2str(y),"]"))
     CM = corr(squeeze(I((x-1)*info(1).Width+y,:))',I'); %pixelwise correlation
     CM = reshape(CM,info(1).Width,info(1).Height);
     normCM = CM - min(CM(:));
     normCM = normCM ./ max(normCM(:));
end