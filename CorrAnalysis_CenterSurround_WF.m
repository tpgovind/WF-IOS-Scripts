clc
clear all
close all
load('F:\ANALYZED_DATA\MAT Files\WF-Guided-2P\corrSetup_CenterSurround_WF.mat');

% Generate moving correlations

r_Center = []; p_Center = [];
r_Surround = []; p_Surround = [];

for i = 1:size(HbO_Murals_Center,2)
    
    [r,p] = movcorr(HbO_Murals_Center(:,i),HbR_Murals_Center(:,i),60,'Endpoints','fill');
    r_Center = [r_Center r]; p_Center = [p_Center p];
    
end

for i = 1:size(HbO_Murals_Surround,2)
    
    [r,p] = movcorr(HbO_Murals_Surround(:,i),HbR_Murals_Surround(:,i),60,'Endpoints','fill');
    r_Surround = [r_Surround r]; p_Surround = [p_Surround p];
    
end


% Sort by largest correlation - change sum term in sorts to make it only
% during stimulation period (but full time series makes more sense...)

r_Center = r_Center'; p_Center = p_Center';
r_Surround = r_Surround'; p_Surround = p_Surround';

sort_Center = nansum(r_Center(:,:),2);
sort_Surround = nansum(r_Surround(:,:),2);

r_Center = [sort_Center r_Center]; r_Center = sortrows(r_Center,'ascend');
r_Surround = [sort_Surround r_Surround]; r_Surround = sortrows(r_Surround,'ascend');
r_Center = r_Center(:,2:size(r_Center,2));
r_Surround = r_Surround(:,2:size(r_Surround,2));



% Generate correlograms

%clims = [-1 1];
%clims = [-1 0];
clims = [-1 -0.75];

figure(1);
W = imagesc(r_Center,'AlphaData',double(~isnan(r_Center)),clims);
colormap(flipud(cividis)); cb = colorbar; set(gca,'color',0*[1 1 1]);
xticks([100 200 300 400 500 600 700 800 900 1000 1100 1200 1300 1400 1500]);
xticklabels({'10','20','30','40','50','60','70','80','90','100','110','120','130','140','150'});
xlabel('Time (s)','FontName', 'Abel', 'FontSize', 14,'FontWeight','bold','Interpreter','tex');
ylabel('Trials','FontName', 'Abel', 'FontSize', 14,'FontWeight','bold','Interpreter','tex');
ylabel(cb,'Correlation','FontName', 'Abel', 'FontSize', 16, 'FontWeight','bold')
title('Moving correlation of HbO and HbR: Center')
pbaspect([1.5 1 1])
set(gca, 'FontName', 'Abel', 'FontSize', 14)
set(gca,'linewidth',1.5)
box off


figure(2);
V = imagesc(r_Surround,'AlphaData',double(~isnan(r_Surround)),clims);
colormap(flipud(cividis)); cb = colorbar; set(gca,'color',0*[1 1 1]);
xticks([100 200 300 400 500 600 700 800 900 1000 1100 1200 1300 1400 1500]);
xticklabels({'10','20','30','40','50','60','70','80','90','100','110','120','130','140','150'});
xlabel('Time (s)','FontName', 'Abel', 'FontSize', 14,'FontWeight','bold','Interpreter','tex');
ylabel('Trials','FontName', 'Abel', 'FontSize', 14,'FontWeight','bold','Interpreter','tex');
ylabel(cb,'Correlation','FontName', 'Abel', 'FontSize', 16, 'FontWeight','bold')
title('Moving correlation of HbO and HbR: Surround')
pbaspect([1.5 1 1])
set(gca, 'FontName', 'Abel', 'FontSize', 14)
set(gca,'linewidth',1.5)
box off


