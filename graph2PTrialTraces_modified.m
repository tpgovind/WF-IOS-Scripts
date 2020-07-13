function [H,U,SEM] = graph2PTrialTraces_modified(indices,calciumTraces,lumenTraces,figureTitle,xAxisTitle,yAxisTitle)

%[H,U,SEM] = graph2PTrialTraces(1:upperIndex,TwoPhoton_Murals_firstOrder_Calcium_Sorted,'Activity Comparison','Time(s)','\Delta F/F_0 (%)');

colors = {[197/255 0 48/255],[1 159/255 184/255],...
    [0 137/255 192/255],[183/255 235/255 1],...
    [0 0 0],[85/255 85/255 85/255],...
    [0 165/255 104/255],[147/255 1 215/255],...
    [1 212/255 0],[1 247/255 204/255]}; %HbOx2, HbRx2, HbTx2, GCaMPx2, Stimx2

calciumData = []; lumenData = [];

for i = indices
    current1 = calciumTraces(:,i); current2 = lumenTraces(:,i);
    calciumData = [calciumData current1];
    lumenData = [lumenData current2];
end

fig = figure; hold on;
X = round((1:704)/3.91,2);

for i = 1:size(calciumData,2)
    calciumData(:,i) = calciumData(:,i)./abs(mean(calciumData(1:116,i)));
    lumenData(:,i) = lumenData(:,i)./abs(mean(lumenData(1:116,i)));
    %plot(X,data(:,i),'Color',[195/255 195/255 195/255]);
end

U{1} = mean(calciumData,2);
SEM{1} = std(calciumData,0,2)./sqrt(size(calciumData,2));
U{2} = mean(lumenData,2);
SEM{2} = std(lumenData,0,2)./sqrt(size(lumenData,2));

%clf
title(figureTitle,'FontWeight','bold','FontSize',14);
xlabel(xAxisTitle,'FontWeight','bold');
ylabel(yAxisTitle,'FontWeight','bold');

H(1) = shadedErrorBar(X,U{1},SEM{1},'lineprops',{'Color',colors{7},'LineWidth',1,'LineJoin','round'},'transparent',1,'patchSaturation',0.1);
H(2) = shadedErrorBar(X,U{2},SEM{2},'lineprops',{'Color',colors{1},'LineWidth',1,'LineJoin','round'},'transparent',1,'patchSaturation',0.1);

x1 = 30*ones(1,704);
x2 = 60*ones(1,704);
xP=[x1,fliplr(x2)];
yLimits = ylim;
xLimits = xlim;

y = linspace(yLimits(1),yLimits(2),704);
yP = [y,fliplr(y)];

xP(isnan(yP))=[];
yP(isnan(yP))=[];
patch(xP,yP,1,'HandleVisibility','off','EdgeColor','none','FaceColor',colors{9},'FaceAlpha',0.1);
ylim(yLimits)
xlim(xLimits)

end