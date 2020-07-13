function [H,U,SEM] = test(indices,trialSpecifier,fullHbO,fullHbR,fullBehavior,figureTitle,xAxisTitle,yAxisTitle)
% Example:
%[H,U,SEM] = graphWFTrialTraces(Mural_Trials,0,WF_HbO_Trials,WF_HbR_Trials,'','Time (s)','\Deltac[Hb] in \muM'); % MURALS
%[H,U,SEM] = graphWFTrialTraces([12 16 19],0,WF_HbO_Trials,WF_HbR_Trials,'','Time (s)','\Deltac[Hb] in \muM'); %PRE-C21_TRIALS
%[H,U,SEM] = graphWFTrialTraces([13 17 20],0,WF_HbO_Trials,WF_HbR_Trials,'','Time (s)','\Deltac[Hb] in \muM'); %POST-C21_TRIALS

HbO = table(); HbR = table(); Behavior = table();

IDs = {'M1','M2','M3','M4','M5','M6','M7','M9','M10','M11',...
    'M11_AFTER_C21','M12','M12_AFTER_1st_C21',...
    'M12_AFTER_2nd_C21','M12_AFTER_3rd_C21','M13',...
    'M13_AFTER_1st_C21','M13_AFTER_2nd_C21','M14',...
    'M14_AFTER_C21','M15','M15_AFTER_C21','M16','M16_AFTER_C21',...
    'M17','M18','M18_FITC','M19','M20','M21','M22','M23','M24',...
    'M25','M26','M28','M29','M29_FITC','M30','M31','M32','M33','M34',...
    'M35','M36','M37','M38','M39','M40','M41','M42','M43','M44','M45',...
    'M46','M48','M49','M50','M51','M52','M53','M54','M55','M56','M57',...
    'M58','M59','GQ1','GQ4','GQ12'}';

colors = {[197/255 0 48/255],[1 159/255 184/255],...
    [0 137/255 192/255],[183/255 235/255 1],...
    [0 0 0],[85/255 85/255 85/255],...
    [0 165/255 104/255],[147/255 1 215/255],...
    [1 212/255 0],[1 247/255 204/255]}; %Red, Blue, Black, Green, Yellow

for i = indices
    
    low = 20*(i-1)+1; high = 20*i;
    partialHbO = fullHbO(:,low:high);
    partialHbR = fullHbR(:,low:high);
    partialBehavior = fullBehavior(:,low:high);
    
    if(trialSpecifier > 0)
        partialHbO = partialHbO(:,trialSpecifier);
        partialHbR = partialHbR(:,trialSpecifier);
        partialBehavior = partialBehavior(:,trialSpecifier);
    end
    
    HbO = [HbO partialHbO];
    HbR = [HbR partialHbR];
    Behavior = [Behavior partialBehavior];
    
end

HbO(:,all(ismissing(HbO)))=[]; HbR(:,all(ismissing(HbR)))=[]; Behavior(:,all(ismissing(Behavior)))=[];
HbO = table2array(HbO); HbR = table2array(HbR); Behavior = table2array(Behavior);
HbO(1800,:) = HbO(1799,:); HbR(1800,:) = HbR(1799,:); Behavior(1800,:) = Behavior(1799,:);
SF = 100/log(10); % Widefield correction scale factor (due to erroneous coeffs)!
HbO = SF.*HbO; HbR = SF.*HbR;


for i = 1:size(HbO,2)
     
     %HbO(:,i) = HbO(:,i) - mean(HbO(1:300,i));
     %HbR(:,i) = HbR(:,i) - mean(HbR(1:300,i));
     HbO(:,i) = HbO(:,i) - mean(HbO(:,i));
     HbR(:,i) = HbR(:,i) - mean(HbR(:,i));

end

X = (1:1500)/10;
U = {mean(HbO,2),mean(HbR,2)}; U{1}(300:305) = NaN; U{2}(300:305) = NaN;
SEM = {std(HbO,0,2)./sqrt(size(HbO,2)),...
    std(HbR,0,2)./sqrt(size(HbR,2))};  SEM{1}(300:305) = NaN; SEM{2}(300:305) = NaN;



fig = figure;

ylabel(yAxisTitle,'FontWeight','bold');
H(1) = shadedErrorBar(X,U{1}(1:1500),SEM{1}(1:1500),'lineprops',{'Color',colors{1},'LineWidth',2,'LineJoin','round'},'transparent',1,'patchSaturation',0.25);
H(2) = shadedErrorBar(X,U{2}(1:1500),SEM{2}(1:1500),'lineprops',{'Color',colors{3},'LineWidth',2,'LineJoin','round'},'transparent',1,'patchSaturation',0.25);

leg = legend([H(1).mainLine, H(1).patch, H(2).mainLine, H(2).patch],...
    ['\mu' '_{HbO}'], ['\pmSEM' '_{HbO}'], ['\mu' '_{HbR}'], ['\pmSEM' '_{HbR}'],...
    'Location', 'Northeast');
set(leg,'Interpreter','tex')

title(figureTitle,'FontWeight','bold','FontSize',14,'Interpreter','None');
xlabel(xAxisTitle,'FontWeight','bold','FontSize',14);

x1 = 30*ones(1,1500);
x2 = 60*ones(1,1500);
xP=[x1,fliplr(x2)];
yLimits = [-60 60]; %ylim; [-20 70]
%yLimits = ylim;
y = linspace(yLimits(1)-2,yLimits(2)+2,1500);
yP = [y,fliplr(y)];

xP(isnan(yP))=[];
yP(isnan(yP))=[];
patch(xP,yP,1,'HandleVisibility','off','EdgeColor','none','FaceColor',colors{9},'FaceAlpha',0.1);
ylim(yLimits)
%yticks(linspace(-12,52,17))
xticks(10*(1:15))

set(gca, 'FontName', 'Abel', 'FontSize', 14)
set(gca,'linewidth',1.5)
legend boxoff
leg.FontSize = 14;
fig.WindowState = 'maximized';

grid off
pbaspect([1.5 1 1])

end