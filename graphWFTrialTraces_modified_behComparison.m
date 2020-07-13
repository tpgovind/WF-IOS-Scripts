function [H,U,SEM] = graphWFTrialTraces_modified_behComparison(high,low,high_color,low_color,figureTitle,xAxisTitle,yAxisTitle)

High = []; Low = [];

colors = {[197/255 0 48/255],[1 159/255 184/255],...
    [0 137/255 192/255],[183/255 235/255 1],...
    [0 0 0],[85/255 85/255 85/255],...
    [0 165/255 104/255],[147/255 1 215/255],...
    [1 212/255 0],[1 247/255 204/255]}; %HbOx2, HbRx2, HbTx2, GCaMPx2, Stimx2

for i = 1:size(high,2)
    partialHigh = high(:,i);
    High = [High partialHigh];
end

for i = 1:size(low,2)
    partialLow = low(:,i);
    Low = [Low partialLow];
end

%SF = 100/log(10);
High(:,all(ismissing(High)))=[];
%High = SF.*High;
Low(:,all(ismissing(Low)))=[];
%Low = SF.*Low;

for i = 1:size(High,2)
     High(:,i) = High(:,i) - mean(High(1:300,i));
end

for i = 1:size(Low,2)
     Low(:,i) = Low(:,i) - mean(Low(1:300,i));
end

X = (1:1500)/10;
U = {mean(High,2),mean(Low,2)}; U{1}(300:305) = NaN; U{2}(300:305) = NaN;
SEM = {std(High,0,2)./sqrt(size(High,2)),...
    std(Low,0,2)./sqrt(size(Low,2))}; SEM{1}(300:305) = NaN; SEM{2}(300:305) = NaN;

fig = figure; %fig.WindowState = 'maximized';
clf

ylabel(yAxisTitle,'FontWeight','bold');
H(1) = shadedErrorBar(X,U{1}(1:1500),SEM{1}(1:1500),'lineprops',{'Color',colors{high_color},'LineWidth',.5,'LineJoin','round'},'transparent',1,'patchSaturation',0.25);
H(2) = shadedErrorBar(X,U{2}(1:1500),SEM{2}(1:1500),'lineprops',{'Color',colors{low_color},'LineStyle','-','LineWidth',2,'LineJoin','round'},'transparent',1,'patchSaturation',0.25);

leg = legend([H(1).mainLine, H(1).patch, H(2).mainLine, H(2).patch],...
    ['\mu' '_{HIGH}'], ['\pmSEM' '_{HIGH}'], ['\mu' '_{LOW}'], ['\pmSEM' '_{LOW}'],...
    'Location', 'Northeast');
set(leg,'Interpreter','tex')

title(figureTitle,'FontWeight','bold','FontSize',14,'Interpreter','None');
xlabel(xAxisTitle,'FontWeight','bold');

x1 = 30*ones(1,1500);
x2 = 30*ones(1,1500);
xP=[x1,fliplr(x2)];
xLimitsRight = [1 150];
yLimitsRight = ylim;
y = linspace(yLimitsRight(1)-2,yLimitsRight(2)+2,1500);
yP = [y,fliplr(y)];

xP(isnan(yP))=[];
yP(isnan(yP))=[];
patch(xP,yP,1,'HandleVisibility','off','EdgeColor','none','FaceColor',colors{9},'FaceAlpha',0.1);
ylim(yLimitsRight)
xlim(xLimitsRight)
yticks(linspace(yLimitsRight(1),yLimitsRight(2),11));
xticks(10*(1:15));

set(gca, 'FontName', 'Abel', 'FontSize', 14)
set(gca,'linewidth',1.5)
legend boxoff
leg.FontSize = 14;
fig.WindowState = 'maximized';
pbaspect([1.5 1 1])

grid off

end