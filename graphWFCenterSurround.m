%% CREATE CENTER-SURROUND TRACES FROM SCRATCH

clc
clear all
close all
load('F:\ANALYZED_DATA\MAT Files\WF\WF Center Surround\startup.mat')

cHbOs = zeros(1800,214); sHbOs = zeros(1800,214);
cHbRs = zeros(1800,214); sHbRs = zeros(1800,214);

for i = 1:size(names,2)
    
    disp(['Trial ' int2str(i) ' of ' int2str(size(names,2))])
    
    current_ImageID = caHemoPaths{i,1};
    current_Path = caHemoPaths{i,2};
    current_ImageMode = caHemoPaths{i,3};
    current_ImageType = caHemoPaths{i,4};
    current_Manipulation = caHemoPaths{i,5};
    current_Number = caHemoPaths{i,6};
    
    [I,numChannels] = readImages(current_Path,current_ImageType);
    R = I{1,2}; G = I{2,2};
    B = zeros(size(R));
    
    for j = 1:size(windowMasks,1)
        
        if(strcmp(windowMasks{j,1},IDs{1,i}))
            windowMask = windowMasks{j,2};
            R = R .* windowMask; G = G .* windowMask;
        end
        
    end
    
    [HbO,HbR,~,~] = computeWidefieldSignals(R,G,B);
    HbO(~isfinite(HbO)) = 0; HbR(~isfinite(HbR)) = 0;
    
    for k = 1:size(centerSurroundMasks,1)
        
        if(strcmp(centerSurroundMasks{k,1},IDs{1,i}))
            
            centerMask = centerSurroundMasks{k,2};
            centerHbO = HbO .* centerMask; centerHbR = HbR .* centerMask;
            surroundMask = centerSurroundMasks{k,3};
            surroundHbO = HbO .* surroundMask; surroundHbR = HbR .* surroundMask;
            
            centerHbO(centerHbO==0) = NaN; centerHbR(centerHbR==0) = NaN;
            surroundHbO(surroundHbO==0) = NaN; surroundHbR(surroundHbR==0) = NaN;
            
            centerHbO = squeeze(nanmean2(centerHbO)); surroundHbO = squeeze(nanmean2(surroundHbO));
            centerHbR = squeeze(nanmean2(centerHbR)); surroundHbR = squeeze(nanmean2(surroundHbR));
            centerHbO(1800,1) = centerHbO(1799,1); centerHbR(1800,1) = centerHbR(1799,1);
            surroundHbO(1800,1) = surroundHbO(1799,1); surroundHbR(1800,1) = surroundHbR(1799,1);
            centerHbO = centerHbO - mean(centerHbO(1:300,1));
            centerHbR = centerHbR - mean(centerHbR(1:300,1));
            surroundHbO = surroundHbO - mean(surroundHbO(1:300,1));
            surroundHbR = surroundHbR - mean(surroundHbR(1:300,1));
            
        end
        
    end
    
    cHbOs(:,i) = centerHbO; sHbOs(:,i) = surroundHbO;
    cHbRs(:,i) = centerHbR; sHbRs(:,i) = surroundHbR;
    
    clearvars -except cHbOs sHbOs cHbRs sHbRs i j k IDs windowMasks centerSurroundMasks names SF caHemoPaths
    
end

clearvars -except cHbOs sHbOs cHbRs sHbRs
save('WFCenterSurround.mat')


%% GRAPH RESULTS

clc
clear all
close all
load('F:\ANALYZED_DATA\MAT Files\WF\WF Center Surround\WFCenterSurround.mat')

colors = {[197/255 0 48/255],[1 159/255 184/255],...
    [0 137/255 192/255],[183/255 235/255 1],...
    [0 0 0],[85/255 85/255 85/255],...
    [0 165/255 104/255],[147/255 1 215/255],...
    [1 212/255 0],[1 247/255 204/255]}; %HbOx2, HbRx2, HbTx2, GCaMPx2, Stimx2

X_WF = (1:1500)/10;
U_Widefield = {mean(cHbOs,2),mean(cHbRs,2),mean(sHbOs,2),mean(sHbRs,2)};
U_Widefield{1}(300:305) = NaN; U_Widefield{2}(300:305) = NaN; U_Widefield{3}(300:305) = NaN; U_Widefield{4}(300:305) = NaN;
SEM_Widefield = {std(cHbOs,0,2)./sqrt(size(cHbOs,2)),std(cHbRs,0,2)./sqrt(size(cHbRs,2)),...
    std(sHbOs,0,2)./sqrt(size(sHbOs,2)),std(sHbRs,0,2)./sqrt(size(sHbRs,2))};

% HbO

fig1 = figure(1);
ylabel('\Deltac[Hb] in \muM','FontWeight','bold');
H(1) = shadedErrorBar(X_WF,U_Widefield{1}(1:1500),SEM_Widefield{1}(1:1500),...
    'lineprops',{'Color',colors{1},'LineWidth',2,'LineJoin','round'},'transparent',1,'patchSaturation',0.25);
H(2) = shadedErrorBar(X_WF,U_Widefield{3}(1:1500),SEM_Widefield{3}(1:1500),...
    'lineprops',{':','Color',colors{2},'LineWidth',2,'LineJoin','round'},'transparent',1,'patchSaturation',0.25);
title('WF HbO: Center vs Surround','FontWeight','bold','FontSize',14,'Interpreter','None');
xlabel('Time (s)','FontWeight','bold','FontSize',14);
x1 = 30*ones(1,1500);
x2 = 60*ones(1,1500);
xP=[x1,fliplr(x2)];
yLimits = [-10 80];
y = linspace(yLimits(1)-2,yLimits(2)+2,1500);
yP = [y,fliplr(y)];
xP(isnan(yP))=[];
yP(isnan(yP))=[];
patch(xP,yP,1,'HandleVisibility','off','EdgeColor','none','FaceColor',colors{9},'FaceAlpha',0.1);
ylim(yLimits)
yticks(linspace(-10,80,10))
xticks(10*(1:15))
set(gca, 'FontName', 'Abel', 'FontSize', 14)
set(gca,'linewidth',1.5)
fig_WF.WindowState = 'maximized';
grid off
pbaspect([1.5 1 1])

% HbR

fig2 = figure(2);
X_WF = (1:1500)/10;
ylabel('\Deltac[Hb] in \muM','FontWeight','bold');
H(1) = shadedErrorBar(X_WF,U_Widefield{2}(1:1500),SEM_Widefield{2}(1:1500),...
    'lineprops',{'Color',colors{3},'LineWidth',2,'LineJoin','round'},'transparent',1,'patchSaturation',0.25);
H(2) = shadedErrorBar(X_WF,U_Widefield{4}(1:1500),SEM_Widefield{4}(1:1500),...
    'lineprops',{':','Color',colors{4},'LineWidth',2,'LineJoin','round'},'transparent',1,'patchSaturation',0.25);
title('WF HbR: Center vs Surround','FontWeight','bold','FontSize',14,'Interpreter','None');
xlabel('Time (s)','FontWeight','bold','FontSize',14);
x1 = 30*ones(1,1500);
x2 = 60*ones(1,1500);
xP=[x1,fliplr(x2)];
yLimits = [-14 4];
y = linspace(yLimits(1)-2,yLimits(2)+2,1500);
yP = [y,fliplr(y)];
xP(isnan(yP))=[];
yP(isnan(yP))=[];
patch(xP,yP,1,'HandleVisibility','off','EdgeColor','none','FaceColor',colors{9},'FaceAlpha',0.1);
ylim(yLimits)
yticks(linspace(-14,4,10))
xticks(10*(1:15))
set(gca, 'FontName', 'Abel', 'FontSize', 14)
set(gca,'linewidth',1.5)
fig_WF.WindowState = 'maximized';
grid off
pbaspect([1.5 1 1])

clearvars -except colors behaviors cHbOs cHbRs sHbOs sHbRs names

% Behavior (heatmap)
fig3 = figure(3);
WF_Data = behaviors; sumStimWF = sum(WF_Data(:,300:600),2); sort_WF = 1:103;
WF_Data = [sumStimWF sort_WF' WF_Data]; names = [num2cell(sumStimWF) names];
WF_Data = sortrows(WF_Data,'descend'); names = sortrows(names,'descend');
sort_WF = WF_Data(:,2);
WF_Data = WF_Data(:,3:1502); names = names(:,2);
imagesc(WF_Data,[0 3]); colormap(cividis); cb = colorbar; title('WF');
names_high = names(1:51); names_low = names(53:103);
counter = 0;
WF_high = sort_WF(1:51); WF_low = sort_WF(53:103);
for i = 1:size(WF_high)
    counter = counter + 1;
    High_HbO_Center(counter,:) = cHbOs(:,WF_high(i)); High_HbR_Center(counter,:) = cHbRs(:,WF_high(i));
    High_HbO_Surround(counter,:) = sHbOs(:,WF_high(i)); High_HbR_Surround(counter,:) = sHbRs(:,WF_high(i));
    Low_HbO_Center(counter,:) = cHbOs(:,WF_low(i)); Low_HbR_Center(counter,:) = cHbRs(:,WF_low(i));
    Low_HbO_Surround(counter,:) = sHbOs(:,WF_low(i)); Low_HbR_Surround(counter,:) = sHbRs(:,WF_low(i));
end
cHbOs = cHbOs'; cHbRs = cHbRs'; sHbOs = sHbOs'; sHbRs = sHbRs';
clearvars -except colors behaviors cHbOs cHbRs sHbOs sHbRs High_HbO_Center High_HbR_Center...
    High_HbO_Surround High_HbR_Surround Low_HbO_Center Low_HbR_Center...
    Low_HbO_Surround Low_HbR_Surround

High_HbO_Center = High_HbO_Center'; Low_HbO_Center = Low_HbO_Center';
High_HbO_Surround = High_HbO_Surround'; Low_HbO_Surround = Low_HbO_Surround';
High_HbR_Center = High_HbR_Center'; Low_HbR_Center = Low_HbR_Center';
High_HbR_Surround = High_HbR_Surround'; Low_HbR_Surround = Low_HbR_Surround';

% HbO Center : High vs Low
fig4 = figure(4);
X_WF = (1:1500)/10;
U_High = mean(High_HbO_Center(1:1500,:),2); SEM_High = std(High_HbO_Center(1:1500,:),0,2)./sqrt(size(High_HbO_Center(1:1500,:),2));
U_Low = mean(Low_HbO_Center(1:1500,:),2); SEM_Low = std(Low_HbO_Center(1:1500,:),0,2)./sqrt(size(Low_HbO_Center(1:1500,:),2));
ylabel('\Deltac[Hb] in \muM','FontWeight','bold');
H(1) = shadedErrorBar(X_WF,U_High,SEM_High,...
    'lineprops',{'Color',colors{1},'LineWidth',2,'LineJoin','round'},'transparent',1,'patchSaturation',0.25);
H(2) = shadedErrorBar(X_WF,U_Low,SEM_Low,...
    'lineprops',{':','Color',colors{2},'LineWidth',2,'LineJoin','round'},'transparent',1,'patchSaturation',0.25);
title('WF HbO Center: High vs Low','FontWeight','bold','FontSize',14,'Interpreter','None');
xlabel('Time (s)','FontWeight','bold','FontSize',14);
x1 = 30*ones(1,1500);
x2 = 60*ones(1,1500);
xP=[x1,fliplr(x2)];
yLimits = [-20 100];
y = linspace(yLimits(1)-2,yLimits(2)+2,1500);
yP = [y,fliplr(y)];
xP(isnan(yP))=[];
yP(isnan(yP))=[];
patch(xP,yP,1,'HandleVisibility','off','EdgeColor','none','FaceColor',colors{9},'FaceAlpha',0.1);
ylim(yLimits)
yticks(linspace(-20,100,7))
xticks(10*(1:15))
set(gca, 'FontName', 'Abel', 'FontSize', 14)
set(gca,'linewidth',1.5)
fig_WF.WindowState = 'maximized';
grid off
pbaspect([1.5 1 1])

% HbO Surround : High vs Low
fig5 = figure(5);
X_WF = (1:1500)/10;
U_High = mean(High_HbO_Surround(1:1500,:),2); SEM_High = std(High_HbO_Surround(1:1500,:),0,2)./sqrt(size(High_HbO_Surround(1:1500,:),2));
U_Low = mean(Low_HbO_Surround(1:1500,:),2); SEM_Low = std(Low_HbO_Surround(1:1500,:),0,2)./sqrt(size(Low_HbO_Surround(1:1500,:),2));
ylabel('\Deltac[Hb] in \muM','FontWeight','bold');
H(1) = shadedErrorBar(X_WF,U_High,SEM_High,...
    'lineprops',{'Color',colors{1},'LineWidth',2,'LineJoin','round'},'transparent',1,'patchSaturation',0.25);
H(2) = shadedErrorBar(X_WF,U_Low,SEM_Low,...
    'lineprops',{':','Color',colors{2},'LineWidth',2,'LineJoin','round'},'transparent',1,'patchSaturation',0.25);
title('WF HbO Surround: High vs Low','FontWeight','bold','FontSize',14,'Interpreter','None');
xlabel('Time (s)','FontWeight','bold','FontSize',14);
x1 = 30*ones(1,1500);
x2 = 60*ones(1,1500);
xP=[x1,fliplr(x2)];
yLimits = [-20 70];
y = linspace(yLimits(1)-2,yLimits(2)+2,1500);
yP = [y,fliplr(y)];
xP(isnan(yP))=[];
yP(isnan(yP))=[];
patch(xP,yP,1,'HandleVisibility','off','EdgeColor','none','FaceColor',colors{9},'FaceAlpha',0.1);
ylim(yLimits)
yticks(linspace(-20,70,5))
xticks(10*(1:15))
set(gca, 'FontName', 'Abel', 'FontSize', 14)
set(gca,'linewidth',1.5)
fig_WF.WindowState = 'maximized';
grid off
pbaspect([1.5 1 1])

% HbR Center : High vs Low
fig6 = figure(6);
X_WF = (1:1500)/10;
U_High = mean(High_HbR_Center(1:1500,:),2); SEM_High = std(High_HbR_Center(1:1500,:),0,2)./sqrt(size(High_HbR_Center(1:1500,:),2));
U_Low = mean(Low_HbR_Center(1:1500,:),2); SEM_Low = std(Low_HbR_Center(1:1500,:),0,2)./sqrt(size(Low_HbR_Center(1:1500,:),2));
ylabel('\Deltac[Hb] in \muM','FontWeight','bold');
H(1) = shadedErrorBar(X_WF,U_High,SEM_High,...
    'lineprops',{'Color',colors{3},'LineWidth',2,'LineJoin','round'},'transparent',1,'patchSaturation',0.25);
H(2) = shadedErrorBar(X_WF,U_Low,SEM_Low,...
    'lineprops',{':','Color',colors{4},'LineWidth',2,'LineJoin','round'},'transparent',1,'patchSaturation',0.25);
title('WF HbR Center: High vs Low','FontWeight','bold','FontSize',14,'Interpreter','None');
xlabel('Time (s)','FontWeight','bold','FontSize',14);
x1 = 30*ones(1,1500);
x2 = 60*ones(1,1500);
xP=[x1,fliplr(x2)];
yLimits = [-18 3];
y = linspace(yLimits(1)-2,yLimits(2)+2,1500);
yP = [y,fliplr(y)];
xP(isnan(yP))=[];
yP(isnan(yP))=[];
patch(xP,yP,1,'HandleVisibility','off','EdgeColor','none','FaceColor',colors{9},'FaceAlpha',0.1);
ylim(yLimits)
yticks(linspace(-18,3,8))
xticks(10*(1:15))
set(gca, 'FontName', 'Abel', 'FontSize', 14)
set(gca,'linewidth',1.5)
fig_WF.WindowState = 'maximized';
grid off
pbaspect([1.5 1 1])

% HbR Surround : High vs Low
fig7 = figure(7);
X_WF = (1:1500)/10;
U_High = mean(High_HbR_Surround(1:1500,:),2); SEM_High = std(High_HbR_Surround(1:1500,:),0,2)./sqrt(size(High_HbR_Surround(1:1500,:),2));
U_Low = mean(Low_HbR_Surround(1:1500,:),2); SEM_Low = std(Low_HbR_Surround(1:1500,:),0,2)./sqrt(size(Low_HbR_Surround(1:1500,:),2));
ylabel('\Deltac[Hb] in \muM','FontWeight','bold');
H(1) = shadedErrorBar(X_WF,U_High,SEM_High,...
    'lineprops',{'Color',colors{3},'LineWidth',2,'LineJoin','round'},'transparent',1,'patchSaturation',0.25);
H(2) = shadedErrorBar(X_WF,U_Low,SEM_Low,...
    'lineprops',{':','Color',colors{4},'LineWidth',2,'LineJoin','round'},'transparent',1,'patchSaturation',0.25);
title('WF HbR Surround: High vs Low','FontWeight','bold','FontSize',14,'Interpreter','None');
xlabel('Time (s)','FontWeight','bold','FontSize',14);
x1 = 30*ones(1,1500);
x2 = 60*ones(1,1500);
xP=[x1,fliplr(x2)];
yLimits = [-15 5];
y = linspace(yLimits(1)-2,yLimits(2)+2,1500);
yP = [y,fliplr(y)];
xP(isnan(yP))=[];
yP(isnan(yP))=[];
patch(xP,yP,1,'HandleVisibility','off','EdgeColor','none','FaceColor',colors{9},'FaceAlpha',0.1);
ylim(yLimits)
yticks(linspace(-15,5,5))
xticks(10*(1:15))
set(gca, 'FontName', 'Abel', 'FontSize', 14)
set(gca,'linewidth',1.5)
fig_WF.WindowState = 'maximized';
grid off
pbaspect([1.5 1 1])