function [U_Widefield,SEM_Widefield,U_TwoPhoton,SEM_TwoPhoton] = graphWFGuided2PTrialTraces(Image_ID,Masks,ROI,Compartment,WFData,TwoPhotonData)

%Example 1: 
% load('F:\ANALYZED_DATA\MAT Files\WF-Guided-2P\WFGuided2P.mat');
% load('F:\ANALYZED_DATA\MAT Files\Spatial Analysis\CenterVsSurround\Masks\LiThreshold\CS_masks.mat');
% for i = 1:size(WFGuided2P_BEST_Indices,1)
% close all;
% [U_Widefield,SEM_Widefield,U_TwoPhoton,SEM_TwoPhoton] = graphWFGuided2PTrialTraces(...
% WFGuided2P_BEST_Indices.Image_ID(i),masks,WFGuided2P_BEST_Indices.ROI(i),{},...
% WFGuided2P_BEST_WFTrials,WFGuided2P_BEST_2PTrials);
% input('')
% end


xAxisTitle = 'Time(s)';
figureTitle_WF = ['WIDEFIELD: ' Image_ID '_' ROI]; leftYAxisTitle_WF = '\Deltac[HbO] (\muM)';
rightYAxisTitle_WF = '\Deltac[HbR] or \Deltac[HbT] (\muM)';
figureTitle_2P = ['2-PHOTON: ' Image_ID '_' ROI];  yAxisTitle_2P = '^{\DeltaF}/_{F_0}';

colors = {[197/255 0 48/255],[1 159/25 184/255],...
    [0 137/255 192/255],[183/255 235/25 1],...
    [0 0 0],[85/255 85/255 85/255],...
    [0 165/255 104/255],[147/255 1 215/255],...
    [1 212/255 0],[1 247/255 204/255]}; %HbOx2, HbRx2, HbTx2, GCaMPx2, Stimx2

%% CREATE DATA MASKS

Widefield_Mask = strcmp(WFData.Image_ID, Image_ID) & ...
    strcmp(WFData.ROI,ROI);

if(~isempty(Compartment))
    TwoPhoton_Mask = strcmp(TwoPhotonData.Image_ID, Image_ID) & ...
        strcmp(TwoPhotonData.ROI, currentROI) & strcmp(TwoPhotonData.Compartment, Compartment);
else
    TwoPhoton_Mask = strcmp(TwoPhotonData.Image_ID, Image_ID) & ...
        strcmp(TwoPhotonData.ROI,ROI);
end


%% COLLECT DATA

HbO = []; HbR = []; HbT = [];
Diameter = []; Calcium = [];
counter = 0;

for i = 1:size(Widefield_Mask,1)
    if(Widefield_Mask(i,1))
        counter = counter + 1;
        HbO = [HbO WFData.Raw_HbO_Trace{i,1}];
        HbR = [HbR WFData.Raw_HbR_Trace{i,1}];
        HbT = [HbT WFData.Raw_HbT_Trace{i,1}];
    end
end

for i = 1:size(HbO,2)
    HbO(:,i) = HbO(:,i) - mean(HbO(1:298,i));
    HbR(:,i) = HbR(:,i) - mean(HbR(1:298,i));
    HbT(:,i) = HbT(:,i) - mean(HbT(1:298,i));
end



for i = 1:size(TwoPhoton_Mask,1)
    if(TwoPhoton_Mask(i,1))
        counter = counter + 1;
        Diameter = [Diameter TwoPhotonData.TwoPhoton_Lumen{i,1}];
        Calcium = [Calcium TwoPhotonData.TwoPhoton_Calcium{i,1}];
    end
end

for i = 1:size(Diameter,2)
    Diameter(:,i) = Diameter(:,i)./abs(mean(Diameter(1:116,i)));
    if(~isempty(Calcium))
        Calcium(:,i) = Calcium(:,i)./abs(mean(Calcium(1:116,i)));
    end
end


%% SHOW LOCATION MASK

for i = 1:size(WFData,1)
    if(strcmp(WFData.Image_ID{i},Image_ID) && strcmp(WFData.ROI{i},ROI))
        WMask1 = (+WFData.Window_Mask{i})/3;
        WMap = WFData.Window_Map{i};
        WHeatmap_HbO = WFData.Window_Heatmap_HbO{i};
        WHeatmap_HbR = WFData.Window_Heatmap_HbR{i};
        WHeatmap_HbT = WFData.Window_Heatmap_HbT{i};
        break
    end
end

figure;
imshow(WMap,[],'InitialMagnification',800); colormap(gca,'gray');
title('WindowMap');
red = cat(3, ones(size(WMap)),zeros(size(WMap)),zeros(size(WMap)));
hold on
h = imshow(red);
hold off
set(h, 'AlphaData', WMask1)

figure;
for i = 1:size(Masks,1)
    if(strcmp(Masks{i,1},Image_ID))
        imshow(Masks{i,3},[],'InitialMagnification',600)
        WMask2 = (+Masks{i,2})/3;
        red = cat(3, ones(size(Masks{i,3})),zeros(size(Masks{i,3})),zeros(size(Masks{i,3})));
        hold on
        h = imshow(red);
        hold off
        set(h, 'AlphaData', WMask2)
    end
end
    
if(~isempty(WHeatmap_HbO))
    
    figure;
    imshow(normalize(WHeatmap_HbO),[],'InitialMagnification',800); colormap(gca,'cividis'); colorbar(gca);
    title('Normalized Avg HbO Response to Whisker Stim');
    figure;
    imshow(normalize(WHeatmap_HbR),[],'InitialMagnification',800); colormap(gca,'cividis'); colorbar(gca);
    title('Normalized Avg HbR Response to Whisker Stim');
    figure;
    imshow(normalize(WHeatmap_HbT),[],'InitialMagnification',800); colormap(gca,'cividis'); colorbar(gca);
    title('Normalized Avg HbT Response to Whisker Stim');
    
end

%% PLOT WF DATA

fig_WF = figure; hold on;
X_WF = (1:1799)/10;
U_Widefield = {mean(HbO,2),mean(HbR,2),mean(HbT,2)};
SEM_Widefield = {std(HbO,0,2)./sqrt(size(HbO,2)),std(HbR,0,2)./sqrt(size(HbR,2)),...
    std(HbT,0,2)./sqrt(size(HbT,2))};

set(fig_WF,'defaultAxesColorOrder',[[197/255 0 48/255]; [0 65/255 90/255]]);
clf

yyaxis left
ylabel(leftYAxisTitle_WF,'FontWeight','bold');
H(1) = shadedErrorBar(X_WF,U_Widefield{1},SEM_Widefield{1},'lineprops',{'Color',colors{1},'LineWidth',1,'LineJoin','round'},'transparent',1,'patchSaturation',0.1);
yLimitsLeft = ylim;

yyaxis right
ylabel(rightYAxisTitle_WF,'FontWeight','bold');
H(2) = shadedErrorBar(X_WF,U_Widefield{2},SEM_Widefield{2},'lineprops',{'Color',colors{3},'LineStyle','-','LineWidth',1,'LineJoin','round'},'transparent',1,'patchSaturation',0.1);
H(3) = shadedErrorBar(X_WF,U_Widefield{3},SEM_Widefield{3},'lineprops',{'Color',colors{5},'LineStyle','-','LineWidth',1,'LineJoin','round'},'transparent',1,'patchSaturation',0.1);

leg = legend([H(1).mainLine, H(1).patch, H(3).mainLine, H(3).patch, H(2).mainLine, H(2).patch],...
    ['\mu' '_{HbO}'], ['\pmSEM' '_{HbO}'], ['\mu2' '_{HbT}'], ['\pmSEM' '_{HbT}'], ['\mu2' '_{HbR}'], ['\pmSEM' '_{HbR}'],...
    'Location', 'Northeast');
set(leg,'Interpreter','tex')

title(figureTitle_WF,'FontWeight','bold','FontSize',14,'Interpreter','None');
xlabel(xAxisTitle,'FontWeight','bold');

x1 = 29.9*ones(1,1799);
x2 = 59.9*ones(1,1799);
xP=[x1,fliplr(x2)];
yLimitsRight = ylim;
y = linspace(yLimitsRight(1),yLimitsRight(2),1799);
yP = [y,fliplr(y)];

xP(isnan(yP))=[];
yP(isnan(yP))=[];
patch(xP,yP,1,'HandleVisibility','off','EdgeColor','none','FaceColor',colors{9},'FaceAlpha',0.1);
ylim(yLimitsRight)
xlim([1 180])
% n = size(indices,2); t = size(HbO,2);
% annotation('textbox','String',['n = ' int2str(n) newline 't = ' int2str(t)],...
%     'LineStyle','none','Position',[.79 .11 .1 .1]);


%% PLOT 2P DATA

fig_2P = figure; hold on;
X_2P = round((1:704)/3.91,2);
U_TwoPhoton = {mean(Diameter,2),mean(Calcium,2)};
SEM_TwoPhoton = {std(Diameter,0,2)./sqrt(size(Diameter,2)),std(Calcium,0,2)./sqrt(size(Calcium,2))};

clf
set(fig_2P,'defaultAxesColorOrder',[colors{1}; colors{7}]);

title(figureTitle_2P,'FontWeight','bold','FontSize',14,'Interpreter','None');
xlabel(xAxisTitle,'FontWeight','bold');

yyaxis left
ylabel(yAxisTitle_2P,'FontWeight','bold');
H(1) = shadedErrorBar(X_2P,U_TwoPhoton{1},SEM_TwoPhoton{1},'lineprops',{'Color',colors{1},'LineWidth',1,'LineJoin','round'},'transparent',1,'patchSaturation',0.1);
yLimitsLeft = ylim;

if(~isempty(Calcium))
    yyaxis right
    ylabel(yAxisTitle_2P,'FontWeight','bold');
    H(2) = shadedErrorBar(X_2P,U_TwoPhoton{2},SEM_TwoPhoton{2},'lineprops',{'Color',colors{7},'LineWidth',1,'LineJoin','round'},'transparent',1,'patchSaturation',0.1);
    
    leg = legend([H(1).mainLine, H(1).patch, H(2).mainLine, H(2).patch],...
        ['\mu' '_{Diameter}'], ['\pmSEM' '_{Diameter}'], ['\mu2' '_{GCaMP}'], ['\pmSEM' '_{GCaMP}'],...
        'Location', 'Northeast');
    set(leg,'Interpreter','tex')
    
    yLimitsRight = ylim;
    y = linspace(yLimitsRight(1),yLimitsRight(2),704);
    yP = [y,fliplr(y)];
else
    y = linspace(yLimitsLeft(1),yLimitsLeft(2),704);
    yP = [y,fliplr(y)];
end

x1 = 30*ones(1,704);
x2 = 60*ones(1,704);
xP=[x1,fliplr(x2)];
xLimits = xlim;

xP(isnan(yP))=[];
yP(isnan(yP))=[];
patch(xP,yP,1,'HandleVisibility','off','EdgeColor','none','FaceColor',colors{9},'FaceAlpha',0.1);
if(~isempty(Calcium))
    ylim(yLimitsRight)
else
    ylim(yLimitsLeft)
end
xlim([1 180])

autoArrangeFigures(2,4,1);

end