%% COMPUTE WF SIGNALS

clear all

disp('M12: PRE-BASAL')
load('F:\ANALYZED_DATA\MAT Files\masks.mat');
[I,numChannels] = readImages_BasalStitching('D:\M12\PRE-BASAL\','CaHemo\');
R = I{1,2}; G = I{2,2}; B = zeros(size(R));
mask = Masks_Data{5,2};
[R_masked,G_masked,B_masked] = applyMasks(R,G,B,mask);
[HbO,HbR,HbT,~] = computeWidefieldSignals(R_masked,G_masked,B_masked);
save('F:\ANALYZED_DATA\MAT Files\GqDREADD\M12_PREBASAL.mat','HbO','HbR','HbT');
clear all

disp('M12: 1st C21')
load('F:\ANALYZED_DATA\MAT Files\masks.mat');
[I,numChannels] = readImages_BasalStitching('D:\M12\AFTER_1st_C21\BASAL\','CaHemo\');
R = I{1,2}; G = I{2,2}; B = zeros(size(R));
mask = Masks_Data{5,2};
[R_masked,G_masked,B_masked] = applyMasks(R,G,B,mask);
[HbO,HbR,HbT,~] = computeWidefieldSignals(R_masked,G_masked,B_masked);
save('F:\ANALYZED_DATA\MAT Files\GqDREADD\M12_1st_C21.mat','HbO','HbR','HbT');
clear all

disp('M12: 2nd C21')
load('F:\ANALYZED_DATA\MAT Files\masks.mat');
[I,numChannels] = readImages_BasalStitching('D:\M12\AFTER_2nd_C21\BASAL\','CaHemo\');
R = I{1,2}; G = I{2,2}; B = zeros(size(R));
mask = Masks_Data{5,2};
[R_masked,G_masked,B_masked] = applyMasks(R,G,B,mask);
[HbO,HbR,HbT,~] = computeWidefieldSignals(R_masked,G_masked,B_masked);
save('F:\ANALYZED_DATA\MAT Files\GqDREADD\M12_2nd_C21.mat','HbO','HbR','HbT');
clear all

disp('M12: 3rd C21')
load('F:\ANALYZED_DATA\MAT Files\masks.mat');
[I,numChannels] = readImages_BasalStitching('D:\M12\AFTER_3rd_C21\BASAL\','CaHemo\');
R = I{1,2}; G = I{2,2}; B = zeros(size(R));
mask = Masks_Data{5,2};
[R_masked,G_masked,B_masked] = applyMasks(R,G,B,mask);
[HbO,HbR,HbT,~] = computeWidefieldSignals(R_masked,G_masked,B_masked);
save('F:\ANALYZED_DATA\MAT Files\GqDREADD\M12_3rd_C21.mat','HbO','HbR','HbT');
clear all

disp('M13: PRE-BASAL')
load('F:\ANALYZED_DATA\MAT Files\masks.mat');
[I,numChannels] = readImages_BasalStitching('D:\M13\PRE-BASAL\','CaHemo\');
R = I{1,2}; G = I{2,2}; B = zeros(size(R));
mask = Masks_Data{6,2};
[R_masked,G_masked,B_masked] = applyMasks(R,G,B,mask);
[HbO,HbR,HbT,~] = computeWidefieldSignals(R_masked,G_masked,B_masked);
save('F:\ANALYZED_DATA\MAT Files\GqDREADD\M13_PREBASAL.mat','HbO','HbR','HbT');
clear all

disp('M13: 1st C21')
load('F:\ANALYZED_DATA\MAT Files\masks.mat');
[I,numChannels] = readImages_BasalStitching('D:\M13\AFTER_1st_C21\BASAL\','CaHemo\');
R = I{1,2}; G = I{2,2}; B = zeros(size(R));
mask = Masks_Data{6,2};
[R_masked,G_masked,B_masked] = applyMasks(R,G,B,mask);
[HbO,HbR,HbT,~] = computeWidefieldSignals(R_masked,G_masked,B_masked);
save('F:\ANALYZED_DATA\MAT Files\GqDREADD\M13_1st_C21.mat','HbO','HbR','HbT');
clear all

disp('M14: PRE-BASAL')
load('F:\ANALYZED_DATA\MAT Files\masks.mat');
[I,numChannels] = readImages_BasalStitching('D:\M14\PRE-BASAL\','CaHemo\');
R = I{1,2}; G = I{2,2}; B = zeros(size(R));
mask = Masks_Data{7,2};
[R_masked,G_masked,B_masked] = applyMasks(R,G,B,mask);
[HbO,HbR,HbT,~] = computeWidefieldSignals(R_masked,G_masked,B_masked);
save('F:\ANALYZED_DATA\MAT Files\GqDREADD\M14_PREBASAL.mat','HbO','HbR','HbT');
clear all

disp('M14: C21')
load('F:\ANALYZED_DATA\MAT Files\masks.mat');
[I,numChannels] = readImages_BasalStitching('D:\M14\AFTER_C21\BASAL\','CaHemo\');
R = I{1,2}; G = I{2,2}; B = zeros(size(R));
mask = Masks_Data{7,2};
[R_masked,G_masked,B_masked] = applyMasks(R,G,B,mask);
[HbO,HbR,HbT,~] = computeWidefieldSignals(R_masked,G_masked,B_masked);
save('F:\ANALYZED_DATA\MAT Files\GqDREADD\M14_C21.mat','HbO','HbR','HbT');
clear all


%% MAKE WF TRACES

parpool;

clear all
load('F:\ANALYZED_DATA\MAT Files\GqDREADD\M12_PREBASAL.mat');
disp('Starting M12_PREBASAL')
tic
ppm = ParforProgMon('Progress (M12_PREBASAL): ', 8999);
parfor i = 1:size(HbO,3)
currentHbO = HbO(:,:,i); currentHbR = HbR(:,:,i); currentHbT = HbT(:,:,i);
HbO_Trace(i,1) = nanmean(currentHbO,'all'); HbR_Trace(i,1) = nanmean(currentHbR,'all'); HbT_Trace(i,1) = nanmean(currentHbT,'all');
ppm.increment();
end
toc
clear ppm
save('F:\ANALYZED_DATA\MAT Files\GqDREADD\M12_PREBASAL.mat');

clear all
load('F:\ANALYZED_DATA\MAT Files\GqDREADD\M12_1st_C21.mat');
disp('Starting M12_1st_C21')
tic
ppm = ParforProgMon('Progress (M12_1st_C21): ', 8999);
parfor i = 1:size(HbO,3)
currentHbO = HbO(:,:,i); currentHbR = HbR(:,:,i); currentHbT = HbT(:,:,i);
HbO_Trace(i,1) = nanmean(currentHbO,'all'); HbR_Trace(i,1) = nanmean(currentHbR,'all'); HbT_Trace(i,1) = nanmean(currentHbT,'all');
ppm.increment();
end
toc
clear ppm
save('F:\ANALYZED_DATA\MAT Files\GqDREADD\M12_1st_C21.mat');

clear all
load('F:\ANALYZED_DATA\MAT Files\GqDREADD\M12_2nd_C21.mat');
disp('Starting M12_2nd_C21')
tic
ppm = ParforProgMon('Progress (M12_2nd_C21): ', 8999);
parfor i = 1:size(HbO,3)
currentHbO = HbO(:,:,i); currentHbR = HbR(:,:,i); currentHbT = HbT(:,:,i);
HbO_Trace(i,1) = nanmean(currentHbO,'all'); HbR_Trace(i,1) = nanmean(currentHbR,'all'); HbT_Trace(i,1) = nanmean(currentHbT,'all');
ppm.increment();
end
toc
clear ppm
save('F:\ANALYZED_DATA\MAT Files\GqDREADD\M12_2nd_C21.mat');

clear all
load('F:\ANALYZED_DATA\MAT Files\GqDREADD\M12_3rd_C21.mat');
disp('Starting M12_3rd_C21')
tic
ppm = ParforProgMon('Progress (M12_3rd_C21): ', 8999);
parfor i = 1:size(HbO,3)
currentHbO = HbO(:,:,i); currentHbR = HbR(:,:,i); currentHbT = HbT(:,:,i);
HbO_Trace(i,1) = nanmean(currentHbO,'all'); HbR_Trace(i,1) = nanmean(currentHbR,'all'); HbT_Trace(i,1) = nanmean(currentHbT,'all');
ppm.increment();
end
toc
clear ppm
save('F:\ANALYZED_DATA\MAT Files\GqDREADD\M12_3rd_C21.mat');

clear all
load('F:\ANALYZED_DATA\MAT Files\GqDREADD\M13_PREBASAL.mat');
disp('Starting M13_PREBASAL')
tic
ppm = ParforProgMon('Progress (M13_PREBASAL): ', 8999);
parfor i = 1:size(HbO,3)
currentHbO = HbO(:,:,i); currentHbR = HbR(:,:,i); currentHbT = HbT(:,:,i);
HbO_Trace(i,1) = nanmean(currentHbO,'all'); HbR_Trace(i,1) = nanmean(currentHbR,'all'); HbT_Trace(i,1) = nanmean(currentHbT,'all');
ppm.increment();
end
toc
clear ppm
save('F:\ANALYZED_DATA\MAT Files\GqDREADD\M13_PREBASAL.mat');

clear all
load('F:\ANALYZED_DATA\MAT Files\GqDREADD\M13_1st_C21.mat');
disp('Starting M13_1st_C21')
tic
ppm = ParforProgMon('Progress (M13_1st_C21): ', 8999);
parfor i = 1:size(HbO,3)
currentHbO = HbO(:,:,i); currentHbR = HbR(:,:,i); currentHbT = HbT(:,:,i);
HbO_Trace(i,1) = nanmean(currentHbO,'all'); HbR_Trace(i,1) = nanmean(currentHbR,'all'); HbT_Trace(i,1) = nanmean(currentHbT,'all');
ppm.increment();
end
toc
clear ppm
save('F:\ANALYZED_DATA\MAT Files\GqDREADD\M13_1st_C21.mat');

clear all
load('F:\ANALYZED_DATA\MAT Files\GqDREADD\M14_PREBASAL.mat');
disp('Starting M14_PREBASAL')
tic
ppm = ParforProgMon('Progress (M14_PREBASAL): ', 8999);
parfor i = 1:size(HbO,3)
currentHbO = HbO(:,:,i); currentHbR = HbR(:,:,i); currentHbT = HbT(:,:,i);
HbO_Trace(i,1) = nanmean(currentHbO,'all'); HbR_Trace(i,1) = nanmean(currentHbR,'all'); HbT_Trace(i,1) = nanmean(currentHbT,'all');
ppm.increment();
end
toc
clear ppm
save('F:\ANALYZED_DATA\MAT Files\GqDREADD\M14_PREBASAL.mat');

clear all
load('F:\ANALYZED_DATA\MAT Files\GqDREADD\M14_C21.mat');
disp('Starting M14_C21')
tic
ppm = ParforProgMon('Progress (M14_C21): ', 8999);
parfor i = 1:size(HbO,3)
currentHbO = HbO(:,:,i); currentHbR = HbR(:,:,i); currentHbT = HbT(:,:,i);
HbO_Trace(i,1) = nanmean(currentHbO,'all'); HbR_Trace(i,1) = nanmean(currentHbR,'all'); HbT_Trace(i,1) = nanmean(currentHbT,'all');
ppm.increment();
end
toc
clear ppm
save('F:\ANALYZED_DATA\MAT Files\GqDREADD\M14_C21.mat');


%% PLOT TRACES

clear all
close all
clc

HbO_Traces(:,1) = load('F:\ANALYZED_DATA\MAT Files\GqDREADD\M12_PREBASAL.mat','HbO_Trace');
HbO_Traces(:,2) = load('F:\ANALYZED_DATA\MAT Files\GqDREADD\M12_1st_C21.mat','HbO_Trace');
HbO_Traces(:,3) = load('F:\ANALYZED_DATA\MAT Files\GqDREADD\M12_2nd_C21.mat','HbO_Trace');
HbO_Traces(:,4) = load('F:\ANALYZED_DATA\MAT Files\GqDREADD\M12_3rd_C21.mat','HbO_Trace');
HbO_Traces(:,5) = load('F:\ANALYZED_DATA\MAT Files\GqDREADD\M13_PREBASAL.mat','HbO_Trace');
HbO_Traces(:,6) = load('F:\ANALYZED_DATA\MAT Files\GqDREADD\M13_1st_C21.mat','HbO_Trace');
HbO_Traces(:,7) = load('F:\ANALYZED_DATA\MAT Files\GqDREADD\M14_PREBASAL.mat','HbO_Trace');
HbO_Traces(:,8) = load('F:\ANALYZED_DATA\MAT Files\GqDREADD\M14_C21.mat','HbO_Trace');

HbR_Traces(:,1) = load('F:\ANALYZED_DATA\MAT Files\GqDREADD\M12_PREBASAL.mat','HbR_Trace');
HbR_Traces(:,2) = load('F:\ANALYZED_DATA\MAT Files\GqDREADD\M12_1st_C21.mat','HbR_Trace');
HbR_Traces(:,3) = load('F:\ANALYZED_DATA\MAT Files\GqDREADD\M12_2nd_C21.mat','HbR_Trace');
HbR_Traces(:,4) = load('F:\ANALYZED_DATA\MAT Files\GqDREADD\M12_3rd_C21.mat','HbR_Trace');
HbR_Traces(:,5) = load('F:\ANALYZED_DATA\MAT Files\GqDREADD\M13_PREBASAL.mat','HbR_Trace');
HbR_Traces(:,6) = load('F:\ANALYZED_DATA\MAT Files\GqDREADD\M13_1st_C21.mat','HbR_Trace');
HbR_Traces(:,7) = load('F:\ANALYZED_DATA\MAT Files\GqDREADD\M14_PREBASAL.mat','HbR_Trace');
HbR_Traces(:,8) = load('F:\ANALYZED_DATA\MAT Files\GqDREADD\M14_C21.mat','HbR_Trace');

titles = {'M12_PREBASAL','M12_1st_C21','M12_2nd_C21','M12_3rd_C21','M13_PREBASAL','M13_1st_C21','M14_PREBASAL','M14_C21'};
for i = 1:size(HbO_Traces,2)
    HbO_Traces(i).HbO_Trace = HbO_Traces(i).HbO_Trace - mean(HbO_Traces(i).HbO_Trace);
    HbR_Traces(i).HbR_Trace = HbR_Traces(i).HbR_Trace - mean(HbR_Traces(i).HbR_Trace);
%     subplot(2,1,1)
%     plot(HbO_Traces(i).HbO_Trace); title('HbO');
%     subplot(2,1,2)
%     plot(HbR_Traces(i).HbR_Trace); title('HbR');
%     subplot(2,1,3)
%     input('');
end

% PLOT PRE-BASAL TRACES

Indices_Select = [1 5 7]; HbO_Traces_Select = []; HbR_Traces_Select = []; % 1 5 7

for i = Indices_Select
    HbO_Traces_Select = [HbO_Traces_Select HbO_Traces(i).HbO_Trace];
    HbR_Traces_Select = [HbR_Traces_Select HbR_Traces(i).HbR_Trace];
end

X = (1:8999)/10;
U = {mean(HbO_Traces_Select,2),mean(HbR_Traces_Select,2)};
SEM = {std(HbO_Traces_Select,0,2)./sqrt(size(HbO_Traces_Select,2)),...
     std(HbR_Traces_Select,0,2)./sqrt(size(HbR_Traces_Select,2))};

U_Before = U;
SEM_Before = SEM;
HbO_Traces_Before = HbO_Traces_Select;
HbR_Traces_Before = HbR_Traces_Select;
 
fig1 = figure; %fig.WindowState = 'maximized';
colors = {[197/255 0 48/255],[1 159/25 184/255],...
    [0 137/255 192/255],[183/255 235/25 1],...
    [0 0 0],[85/255 85/255 85/255],...
    [0 165/255 104/255],[147/255 1 215/255],...
    [1 212/255 0],[1 247/255 204/255]}; %HbOx2, HbRx2, HbTx2, GCaMPx2, Stimx2
clf

ylabel('Normalized \Deltac[Hb] (%)','FontWeight','bold');
H(1) = shadedErrorBar(X,U{1},SEM{1},'lineprops',{'Color',colors{1},'LineWidth',1,'LineJoin','round'},'transparent',1,'patchSaturation',0.1);
H(2) = shadedErrorBar(X,U{2},SEM{2},'lineprops',{'Color',colors{3},'LineStyle','-','LineWidth',1,'LineJoin','round'},'transparent',1,'patchSaturation',0.1);

leg = legend([H(1).mainLine, H(1).patch, H(2).mainLine, H(2).patch],...
    ['\mu' '_{HbO}'], ['\pmSEM' '_{HbO}'], ['\mu2' '_{HbR}'], ['\pmSEM' '_{HbR}'],...
    'Location', 'Northeast');
set(leg,'Interpreter','tex')

title('GqDREADD_PRE_BASAL','FontWeight','bold','FontSize',14,'Interpreter','None');
xlabel('Time(s)','FontWeight','bold');

clear Indices_Select HbO_Traces_Select HbR_Traces_Select X U SEM H leg colors

% PLOT C21 TRACES

Indices_Select = [2 6 8]; HbO_Traces_Select = []; HbR_Traces_Select = [];

for i = Indices_Select
    HbO_Traces_Select = [HbO_Traces_Select HbO_Traces(i).HbO_Trace];
    HbR_Traces_Select = [HbR_Traces_Select HbR_Traces(i).HbR_Trace];
end

X = (1:8999)/10;
U = {mean(HbO_Traces_Select,2),mean(HbR_Traces_Select,2)};
SEM = {std(HbO_Traces_Select,0,2)./sqrt(size(HbO_Traces_Select,2)),...
     std(HbR_Traces_Select,0,2)./sqrt(size(HbR_Traces_Select,2))};

fig2 = figure; %fig.WindowState = 'maximized';
colors = {[197/255 0 48/255],[1 159/25 184/255],...
    [0 137/255 192/255],[183/255 235/25 1],...
    [0 0 0],[85/255 85/255 85/255],...
    [0 165/255 104/255],[147/255 1 215/255],...
    [1 212/255 0],[1 247/255 204/255]}; %HbOx2, HbRx2, HbTx2, GCaMPx2, Stimx2
clf

ylabel('Normalized \Deltac[Hb] (%)','FontWeight','bold');
H(1) = shadedErrorBar(X,U{1},SEM{1},'lineprops',{'Color',colors{1},'LineWidth',1,'LineJoin','round'},'transparent',1,'patchSaturation',0.1);
H(2) = shadedErrorBar(X,U{2},SEM{2},'lineprops',{'Color',colors{3},'LineStyle','-','LineWidth',1,'LineJoin','round'},'transparent',1,'patchSaturation',0.1);

leg = legend([H(1).mainLine, H(1).patch, H(2).mainLine, H(2).patch],...
    ['\mu' '_{HbO}'], ['\pmSEM' '_{HbO}'], ['\mu2' '_{HbR}'], ['\pmSEM' '_{HbR}'],...
    'Location', 'Northeast');
set(leg,'Interpreter','tex')

title('GqDREADD_C21_BASAL','FontWeight','bold','FontSize',14,'Interpreter','None');
xlabel('Time(s)','FontWeight','bold');

U_After = U;
SEM_After = SEM;
HbO_Traces_After = HbO_Traces_Select;
HbR_Traces_After = HbR_Traces_Select;
