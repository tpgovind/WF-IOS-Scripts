%% PENETRATORS

clc
clear all
load('F:\ANALYZED_DATA\MAT Files\WF-Guided-2P\corrSetup_CenterSurround_2P.mat');

% Generate moving correlations

r_Center = []; p_Center = [];
r_Surround = []; p_Surround = [];

for i = 1:size(Center_Penetrator_Calcium,2)
    
    [r,p] = movcorr(Center_Penetrator_Calcium(1:587,i),Center_Penetrator_Diameter(1:587,i),60,'Endpoints','fill');
    r_Center = [r_Center r]; p_Center = [p_Center p];
    
end

for i = 1:size(Surround_Penetrator_Calcium,2)
    
    [r,p] = movcorr(Surround_Penetrator_Calcium(1:587,i),Surround_Penetrator_Diameter(1:587,i),60,'Endpoints','fill');
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
clims = [-1 0];

figure(1); 
W = imagesc(r_Center,'AlphaData',double(~isnan(r_Center)),clims);
colormap(flipud(cividis)); cb = colorbar; set(gca,'color',0*[1 1 1]);
xticks([39.1 78.2 117.3 156.4 195.5 234.6 273.7 312.8 351.9 391.0 430.1 469.2 508.3 547.4 586.5]);
xticklabels({'10','20','30','40','50','60','70','80','90','100','110','120','130','140','150'});
xlabel('Time (s)','FontName', 'Abel', 'FontSize', 14,'FontWeight','bold','Interpreter','tex');
ylabel('Trials','FontName', 'Abel', 'FontSize', 14,'FontWeight','bold','Interpreter','tex');
ylabel(cb,'Correlation','FontName', 'Abel', 'FontSize', 16, 'FontWeight','bold')
title('Moving correlation of Ca2+ and Diameter: Center (Penetrators)')
pbaspect([1.5 1 1])
set(gca, 'FontName', 'Abel', 'FontSize', 14)
set(gca,'linewidth',1.5)
box off

figure(2);
V = imagesc(r_Surround,'AlphaData',double(~isnan(r_Surround)),clims);
colormap(flipud(cividis)); cb = colorbar; set(gca,'color',0*[1 1 1]);
xticks([39.1 78.2 117.3 156.4 195.5 234.6 273.7 312.8 351.9 391.0 430.1 469.2 508.3 547.4 586.5]);
xticklabels({'10','20','30','40','50','60','70','80','90','100','110','120','130','140','150'});
xlabel('Time (s)','FontName', 'Abel', 'FontSize', 14,'FontWeight','bold','Interpreter','tex');
ylabel('Trials','FontName', 'Abel', 'FontSize', 14,'FontWeight','bold','Interpreter','tex');
ylabel(cb,'Correlation','FontName', 'Abel', 'FontSize', 16, 'FontWeight','bold')
title('Moving correlation of Ca2+ and Diameter: Surround (Penetrators)')
pbaspect([1.5 1 1])
set(gca, 'FontName', 'Abel', 'FontSize', 14)
set(gca,'linewidth',1.5)
box off


%% FIRST-ORDERS

clc
clearvars -except clims
load('F:\ANALYZED_DATA\MAT Files\WF-Guided-2P\corrSetup_CenterSurround_2P.mat');

% Generate moving correlations

r_Center = []; p_Center = [];
r_Surround = []; p_Surround = [];

for i = 1:size(Center_firstOrder_Calcium,2)
    
    [r,p] = movcorr(Center_firstOrder_Calcium(1:587,i),Center_firstOrder_Diameter(1:587,i),60,'Endpoints','fill');
    r_Center = [r_Center r]; p_Center = [p_Center p];
    
end

for i = 1:size(Surround_firstOrder_Calcium,2)
    
    [r,p] = movcorr(Surround_firstOrder_Calcium(1:587,i),Surround_firstOrder_Diameter(1:587,i),60,'Endpoints','fill');
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

figure(3);
W = imagesc(r_Center,'AlphaData',double(~isnan(r_Center)),clims);
colormap(flipud(cividis)); cb = colorbar; set(gca,'color',0*[1 1 1]);
xticks([39.1 78.2 117.3 156.4 195.5 234.6 273.7 312.8 351.9 391.0 430.1 469.2 508.3 547.4 586.5]);
xticklabels({'10','20','30','40','50','60','70','80','90','100','110','120','130','140','150'});
xlabel('Time (s)','FontName', 'Abel', 'FontSize', 14,'FontWeight','bold','Interpreter','tex');
ylabel('Trials','FontName', 'Abel', 'FontSize', 14,'FontWeight','bold','Interpreter','tex');
ylabel(cb,'Correlation','FontName', 'Abel', 'FontSize', 16, 'FontWeight','bold')
title('Moving correlation of Ca2+ and Diameter: Center (First Orders)')
pbaspect([1.5 1 1])
set(gca, 'FontName', 'Abel', 'FontSize', 14)
set(gca,'linewidth',1.5)
box off


figure(4);
V = imagesc(r_Surround,'AlphaData',double(~isnan(r_Surround)),clims);
colormap(flipud(cividis)); cb = colorbar; set(gca,'color',0*[1 1 1]);
xticks([39.1 78.2 117.3 156.4 195.5 234.6 273.7 312.8 351.9 391.0 430.1 469.2 508.3 547.4 586.5]);
xticklabels({'10','20','30','40','50','60','70','80','90','100','110','120','130','140','150'});
xlabel('Time (s)','FontName', 'Abel', 'FontSize', 14,'FontWeight','bold','Interpreter','tex');
ylabel('Trials','FontName', 'Abel', 'FontSize', 14,'FontWeight','bold','Interpreter','tex');
ylabel(cb,'Correlation','FontName', 'Abel', 'FontSize', 16, 'FontWeight','bold')
title('Moving correlation of Ca2+ and Diameter: Surround (First Orders)')
pbaspect([1.5 1 1])
set(gca, 'FontName', 'Abel', 'FontSize', 14)
set(gca,'linewidth',1.5)
box off

