%%

load('F:\ANALYZED_DATA\MAT Files\FlowVsDiameterComparison.mat');

for i = 1:size(FLOWvsDIAMETER,1)
    title(FLOWvsDIAMETER{i,1})
    yyaxis right
    plot(FLOWvsDIAMETER{i,2}{:})
    ylabel('FLOW')
    yyaxis left
    plot(FLOWvsDIAMETER{i,3}{:})
    ylabel('DIAMETER')
    input('')
end

for i = 1:size(FLOWvsDIAMETER,1)
    [max_corrs(i,1),~] = max(abs(xcorr(FLOWvsDIAMETER{i,2},FLOWvsDIAMETER{i,3},'normalized')));
end

%%
clc
clear all
close all
load('F:\ANALYZED_DATA\MAT Files\FlowVsDiameterComparison.mat');

colors = {[197/255 0 48/255],[1 159/25 184/255],...
    [0 137/255 192/255],[183/255 235/25 1],...
    [0 0 0],[85/255 85/255 85/255],...
    [0 165/255 104/255],[147/255 1 215/255],...
    [1 212/255 0],[1 247/255 204/255]}; %HbOx2, HbRx2, HbTx2, GCaMPx2, Stimx2

FlowData = [];
for i = 1:272
    current = FLOWvsDIAMETER.FlowData{i};
    current = current./abs(mean(current(1:116,1)));
    FlowData = [FlowData current];
end

DiameterData = [];
for i = 1:272
    current = FLOWvsDIAMETER.DiameterData{i};
    current = current./abs(mean(current(1:116,1)));
    DiameterData = [DiameterData current];
end

X = (1:704)/3.91;
U = {mean(FlowData,2),mean(DiameterData,2)};
SEM = {std(FlowData,0,2)./sqrt(size(FlowData,2)),...
    std(DiameterData,0,2)./sqrt(size(DiameterData,2))};

% figure; hold on;
% for i = 1:size(FlowData,2)
%     current = FlowData(:,i);
%     plot(current,'Color',colors{6})
% end
% plot(U{1},'k')
% hold off;

fig = figure; clf; %fig.WindowState = 'maximized'; 
figureTitle = 'Flow vs Diameter: Average Profile';
set(fig,'defaultAxesColorOrder',[colors{1}; colors{5}]);
xAxisTitle = 'Time(s)'; yAxisTitle = '\Delta F/F_0 (%)';

yyaxis left
ylabel(yAxisTitle,'FontWeight','bold');
H(1) = shadedErrorBar(X,U{1},SEM{1},'lineprops',{'Color',colors{1},'LineWidth',1,'LineJoin','round'},'transparent',1,'patchSaturation',0.1);

yyaxis right
ylabel(yAxisTitle,'FontWeight','bold');
H(2) = shadedErrorBar(X,U{2},SEM{2},'lineprops',{'Color',colors{5},'LineStyle','-','LineWidth',1,'LineJoin','round'},'transparent',1,'patchSaturation',0.1);

leg = legend([H(1).mainLine, H(1).patch, H(2).mainLine, H(2).patch],...
    ['\mu' '_{Flow}'], ['\pmSEM' '_{Flow}'], ['\mu2' '_{Diameter}'], ['\pmSEM' '_{Diameter}'],...
    'Location', 'Northeast');
set(leg,'Interpreter','tex')

title(figureTitle,'FontWeight','bold','FontSize',14,'Interpreter','None');
xlabel(xAxisTitle,'FontWeight','bold');

x1 = 29.9*ones(1,1799);
x2 = 59.9*ones(1,1799);
xP=[x1,fliplr(x2)];
yLimitsRight = ylim;
y = linspace(yLimitsRight(1)-2,yLimitsRight(2)+2,1799);
yP = [y,fliplr(y)];

xP(isnan(yP))=[];
yP(isnan(yP))=[];
patch(xP,yP,1,'HandleVisibility','off','EdgeColor','none','FaceColor',colors{9},'FaceAlpha',0.1);
ylim(yLimitsRight)
yticks(linspace(yLimitsRight(1),yLimitsRight(2),11))

grid on

figure;
S2N{1} = U{1}./SEM{1};
S2N{2} = U{2}./SEM{2};
plot(S2N{1},'r'); hold on; plot(S2N{2},'k'); hold off;
title('Flow vs Diameter: Signal/Noise');

