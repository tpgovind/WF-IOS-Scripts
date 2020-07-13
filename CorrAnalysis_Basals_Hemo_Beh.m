clc
clear all
close all
load('F:\ANALYZED_DATA\MAT Files\WF\Cross-correlation\WF_Basals.mat', 'HbO', 'Behavior');
HbO = HbO(1:1500,:); Behavior = Behavior(1:1500,:);

% Generate moving correlations

r = []; p = [];

for i = 1:size(HbO,2)
    
    [r_temp,p_temp] = movcorr(HbO(1:1500,i),Behavior(1:1500,i),60,'Endpoints','fill');
    r = [r r_temp]; p = [p p_temp];
    
end


% Sort by largest correlation - change sum term in sorts to make it only
% during stimulation period (but full time series makes more sense...)

r = r'; p = p';

% sortTraces = nansum(r(:,:),2);
% 
% r = [sortTraces r]; r = sortrows(r,'ascend');
% r = r(:,2:size(r,2));

% Generate correlograms
clims = [-1 0.5];

f1 = figure(1);
V = imagesc(r,'AlphaData',double(~isnan(r)),clims);
colormap(flipud(cividis)); cb = colorbar; set(gca,'color',0*[1 1 1]);
xticks([100 200 300 400 500 600 700 800 900 1000 1100 1200 1300 1400 1500]);
xticklabels({'10','20','30','40','50','60','70','80','90','100','110','120','130','140','150'});
xlabel('Time (s)','FontName', 'Abel', 'FontSize', 14,'FontWeight','bold','Interpreter','tex');
ylabel('Trials','FontName', 'Abel', 'FontSize', 14,'FontWeight','bold','Interpreter','tex');
ylabel(cb,'Correlation','FontName', 'Abel', 'FontSize', 16, 'FontWeight','bold')
title('Moving correlation of HbO and Behavior')
pbaspect([1.5 1 1])
set(gca, 'FontName', 'Abel', 'FontSize', 14)
set(gca,'linewidth',1.5)
box off

f1.WindowState = 'maximized';
%saveas(f1,'F:\ANALYZED_DATA\FIGURES v2\FIGURE 1 (Characterizing the stimulus-evoked response)\Basal_Behavior_ExampleTraces\HbO_HbR_correlation.svg')
