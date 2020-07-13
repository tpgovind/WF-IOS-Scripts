function [H,U,SEM] = graph2PTrialTraces(indicesLumen,indicesCalcium,plotSpecifier,fullData,figureTitle,xAxisTitle,yAxisTitle)

%[H,U,SEM] = graph2PTrialTraces(FirstOrder_Lumen_ALL,FirstOrder_Calcium_ALL,1,TwoPhoton_All,'','Time (s)',' \DeltaF/F');
% Let plot specifier be zero for PAs

colors = {[197/255 0 48/255],[1 159/25 184/255],...
    [0 137/255 192/255],[183/255 235/25 1],...
    [0 0 0],[85/255 85/255 85/255],...
    [0 165/255 104/255],[147/255 1 215/255],...
    [1 212/255 0],[1 247/255 204/255]}; %HbOx2, HbRx2, HbTx2, GCaMPx2, Stimx2

lumenData = []; calciumData = [];
counter = 1;

for i = indicesLumen
    current = fullData.TwoPhoton_Trace{i,1};
    if (size(current,1) == 704)
        lumenData = [lumenData current];
        dataNamesLumen{1,counter} = fullData.Recording{i,1};
        counter = counter + 1;
    else
        current = resample(current,704,size(current,1));
        lumenData = [lumenData current];
        dataNamesLumen{1,counter} = fullData.Recording{i,1};
        counter = counter + 1;
    end
end

counter = 1;
for i = indicesCalcium
    current = fullData.TwoPhoton_Trace{i,1};
    if (size(current,1) == 704)
        calciumData = [calciumData current];
        dataNamesCalcium{1,counter} = fullData.Recording{i,1};
        counter = counter + 1;
    else
        current = resample(current,704,size(current,1));
        calciumData = [calciumData current];
        dataNamesCalcium{1,counter} = fullData.Recording{i,1};
        counter = counter + 1;
    end
end

fig = figure;
X = round((1:587)/3.91,2);

for i = 1:size(lumenData,2)
    lumenData(:,i) = lumenData(:,i)./abs(mean(lumenData(1:116,i)));
end

for i = 1:size(calciumData,2)
    calciumData(:,i) = calciumData(:,i)./abs(mean(calciumData(1:116,i)));
end

U = {mean(lumenData,2),mean(calciumData,2)}; U{1}(117:119) = [NaN NaN NaN]; U{2}(117:119) = [NaN NaN NaN];
SEM = {std(lumenData,0,2)./sqrt(size(lumenData,2)),...
        std(calciumData,0,2)./sqrt(size(calciumData,2))}; SEM{1}(117:119) = [NaN NaN NaN]; SEM{2}(117:119) = [NaN NaN NaN];

%clf

if (plotSpecifier)
    H(1) = shadedErrorBar(X,U{1}(1:587),SEM{1}(1:587),'lineprops',{'Color',colors{1},'LineWidth',2,'LineJoin','round'},'transparent',1,'patchSaturation',0.25);
    H(2) = shadedErrorBar(X,U{2}(1:587),SEM{2}(1:587),'lineprops',{'Color',colors{7},'LineWidth',2,'LineJoin','round'},'transparent',1,'patchSaturation',0.25);
else
    H = shadedErrorBar(X,U{1}(1:587),SEM{1}(1:587),'lineprops',{'Color',colors{1},'LineWidth',2,'LineJoin','round'},'transparent',1,'patchSaturation',0.25);
end

if (plotSpecifier)
    leg = legend([H(1).mainLine, H(1).patch, H(2).mainLine, H(2).patch],...
        ['\mu' '_{Flow}'], ['\pmSEM' '_{Flow}'], ['\mu2' '_{Mural Ca2+}'], ['\pmSEM' '_{Mural Ca2+}'],...
        'Location', 'Northeast');
    set(leg,'Interpreter','tex','LineWidth',.5)    
else
    leg = legend([H.mainLine, H.patch],['\mu' '_{Flow}'], ['\pmSEM' '_{Flow}'],...
        'Location', 'Northeast');
    set(leg,'Interpreter','tex','LineWidth',.5)     
end

x1 = 30*ones(1,587);
x2 = 60*ones(1,587);
xP=[x1,fliplr(x2)];
yLimits = [0.74 1.12];
xLimits = [0 150];

y = linspace(yLimits(1),yLimits(2),587);
yP = [y,fliplr(y)];

xP(isnan(yP))=[];
yP(isnan(yP))=[];
patch(xP,yP,1,'HandleVisibility','off','EdgeColor','none','FaceColor',colors{9},'FaceAlpha',0.1);
ylim(yLimits)
xlim(xLimits)
yticks(linspace(0.74,1.14,11))
xticks(10*(1:15))

title(figureTitle,'FontWeight','bold','FontSize',14);
xlabel(xAxisTitle,'FontWeight','bold','Interpreter','tex','FontSize',14);
ylabel(yAxisTitle,'FontWeight','bold','Interpreter','tex','FontSize',14);
set(gca, 'FontName', 'Abel', 'FontSize', 14)
set(gca,'linewidth',1.5)
legend boxoff
leg.FontSize = 14;
pbaspect([1.5 1 1])

end