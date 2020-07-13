%% Animal Averages: WF

clc
clear all
close all
load('F:\ANALYZED_DATA\MAT Files\WF\WF_Trials.mat')
load('F:\ANALYZED_DATA\MAT Files\WF\WFTrial_Indices.mat')
SF = 100/log(10);

colors = {[197/255 0 48/255],[1 159/255 184/255],...
    [0 137/255 192/255],[183/255 235/255 1],...
    [0 0 0],[190/255 190/255 190/255],...
    [0 165/255 104/255],[147/255 1 215/255],...
    [1 212/255 0],[1 247/255 204/255]}; %HbOx2, HbRx2, HbTx2, GCaMPx2, Stimx2

% HbO Fit
a1 = 0.5158; b1 = 36.49; c1 = 5.727;
a2 = 1.15; b2 = 56; c2 = 16;
syms x
y1 = SF*(eval('a1')*exp(-((x-eval('b1'))/eval('c1'))^2) + eval('a2')*exp(-((x-eval('b2'))/eval('c2'))^2));

% HbR Fit
a1 = 0.2152; b1 = 55.64; c1 = -14.37;
a2 = 0.1057; b2 = 36.03; c2 = 6.098;
syms x
y2 = SF*(eval('a1')*exp(-((x-eval('b1'))/eval('c1'))^2) + eval('a2')*exp(-((x-eval('b2'))/eval('c2'))^2)); y2 = -1*y2;


HbO = table(); HbR = table();

for i = Mural_Trials
    
    low = 20*(i-1)+1; high = 20*i;
    partialHbO = WF_HbO_Trials(:,low:high);
    partialHbR = WF_HbR_Trials(:,low:high);
    
    HbO = [HbO partialHbO];
    HbR = [HbR partialHbR];
    
end

HbO(:,all(ismissing(HbO)))=[]; HbR(:,all(ismissing(HbR)))=[];
HbO = table2array(HbO); HbR = table2array(HbR);
HbO(1800,:) = HbO(1799,:); HbR(1800,:) = HbR(1799,:);

for i = 1:size(HbO,2)
    
    HbO(:,i) = HbO(:,i) - mean(HbO(1:300,i));
    HbR(:,i) = HbR(:,i) - mean(HbR(1:300,i));
    
end

WF_Mural_Indices = [1 12; 13 22; 23 40; 41 52; 53 67; 68 77; 78 92; 93 104; 105 119; 120 129; 130 141; 142 156; 157 167; 168 179; 180 194; 195 214];

for i = 1:size(WF_Mural_Indices,1)
    start = WF_Mural_Indices(i,1); stop = WF_Mural_Indices(i,2);
    HbO_Animals(:,i) = mean(HbO(:,start:stop),2);
    HbR_Animals(:,i) = mean(HbR(:,start:stop),2);
end

X = (1:1500)/10;
HbO_Animals = SF.*HbO_Animals; HbR_Animals = SF.*HbR_Animals;
HbO_Animals(300:305,:) = NaN; HbR_Animals(300:305,:) = NaN;
U = {mean(HbO_Animals,2),mean(HbR_Animals,2)}; U{1}(300:305) = NaN; U{2}(300:305) = NaN;
SEM = {std(HbO_Animals,0,2)./sqrt(size(HbO_Animals,2)),...
    std(HbR_Animals,0,2)./sqrt(size(HbR_Animals,2))};  SEM{1}(300:305) = NaN; SEM{2}(300:305) = NaN;

f1 = figure(1); f1.WindowState = 'Maximized';
p = plot(X,HbO_Animals(1:1500,:),'Color',colors{6}); hold on;
H = shadedErrorBar(X,U{1}(1:1500),SEM{1}(1:1500),'lineprops',{':','Color',colors{1},'LineWidth',1.5,'LineJoin','round'},'transparent',1,'patchSaturation',0.25);
f = fplot(y1, [1 150], ...
    'Linewidth', 2, 'Color', colors{1});
hold off;

leg = legend([p(1) H.mainLine f],'Average traces for mice 1-16', 'Mean \pm SEM', 'Two-term Gaussian model (R^{2}_{adj}=0.98)', 'Location', 'Northeast');
set(leg,'Interpreter','tex')
pos = leg.Position; pos(3) = 1.5*pos(3); leg.Position = pos;

xlabel('Time (s)','FontWeight','bold','FontSize',14);
ylabel('\Deltac[Hb] in \muM','FontWeight','bold','FontSize',14);
x1 = 30*ones(1,1500);
x2 = 60*ones(1,1500);
xP=[x1,fliplr(x2)];
yLimits = [-20 120];
xLimits = [0 150];
y = linspace(yLimits(1)-2,yLimits(2)+2,1500);
yP = [y,fliplr(y)];
xP(isnan(yP))=[];
yP(isnan(yP))=[];
patch(xP,yP,1,'HandleVisibility','off','EdgeColor','none','FaceColor',colors{9},'FaceAlpha',0.1);
ylim(yLimits)
xlim(xLimits)
yticks(linspace(-20,120,8))
xticks(10*(1:15))
set(gca, 'FontName', 'Abel', 'FontSize', 14)
set(gca,'linewidth',1.5)
legend boxoff
leg.FontSize = 14;
grid off
pbaspect([1.5 1 1])



f2 = figure(2); f2.WindowState = 'Maximized';
p = plot(X,HbR_Animals(1:1500,:),'Color',colors{6}); hold on;
H = shadedErrorBar(X,U{2}(1:1500),SEM{2}(1:1500),'lineprops',{':','Color',colors{3},'LineWidth',1.5,'LineJoin','round'},'transparent',1,'patchSaturation',0.25);
f = fplot(y2, [1 150], ...
    'Linewidth', 2, 'Color', colors{3});
hold off;

leg = legend([p(1) H.mainLine f],'Average traces for mice 1-16', 'Mean \pm SEM', 'Two-term Gaussian model (R^{2}_{adj}=0.93)', 'Location', 'Northeast');
set(leg,'Interpreter','tex')
pos = leg.Position; pos(3) = 1.5*pos(3); leg.Position = pos;

xlabel('Time (s)','FontWeight','bold','FontSize',14);
ylabel('\Deltac[Hb] in \muM','FontWeight','bold','FontSize',14);
x1 = 30*ones(1,1500);
x2 = 60*ones(1,1500);
xP=[x1,fliplr(x2)];
yLimits = [-25 25];
xLimits = [0 150];
y = linspace(yLimits(1)-2,yLimits(2)+2,1500);
yP = [y,fliplr(y)];
xP(isnan(yP))=[];
yP(isnan(yP))=[];
patch(xP,yP,1,'HandleVisibility','off','EdgeColor','none','FaceColor',colors{9},'FaceAlpha',0.1);
ylim(yLimits)
xlim(xLimits)
yticks(linspace(-25,25,11))
xticks(10*(1:15))
set(gca, 'FontName', 'Abel', 'FontSize', 14)
set(gca,'linewidth',1.5)
legend boxoff
leg.FontSize = 14;
grid off
pbaspect([1.5 1 1])



%% Trial Averages: WF

clc
clear all
load('F:\ANALYZED_DATA\MAT Files\WF\WF_Trials.mat')
load('F:\ANALYZED_DATA\MAT Files\WF\WFTrial_Indices.mat')
SF = 100/log(10);

colors = {[197/255 0 48/255],[1 159/255 184/255],...
    [0 137/255 192/255],[183/255 235/255 1],...
    [0 0 0],[190/255 190/255 190/255],...
    [0 165/255 104/255],[147/255 1 215/255],...
    [1 212/255 0],[1 247/255 204/255]}; %HbOx2, HbRx2, HbTx2, GCaMPx2, Stimx2

% HbO Fit
a1 = 0.5158; b1 = 36.49; c1 = 5.727;
a2 = 1.15; b2 = 56; c2 = 16;
syms x
y1 = SF*(eval('a1')*exp(-((x-eval('b1'))/eval('c1'))^2) + eval('a2')*exp(-((x-eval('b2'))/eval('c2'))^2));

% HbR Fit
a1 = 0.2152; b1 = 55.64; c1 = -14.37;
a2 = 0.1057; b2 = 36.03; c2 = 6.098;
syms x
y2 = SF*(eval('a1')*exp(-((x-eval('b1'))/eval('c1'))^2) + eval('a2')*exp(-((x-eval('b2'))/eval('c2'))^2)); y2 = -1*y2;

HbO = table(); HbR = table();
trialSpecifier = 1:10;

counter = 0;
for j = 1:size(trialSpecifier,2)
    
    counter = counter + 1;
    
    for i = Mural_Trials
        
        low = 20*(i-1)+1; high = 20*i;
        partialHbO = WF_HbO_Trials(:,low:high);
        partialHbR = WF_HbR_Trials(:,low:high);
        
        if(j > 0)
            partialHbO = partialHbO(:,j);
            partialHbR = partialHbR(:,j);
        end
        
        HbO = [HbO partialHbO];
        HbR = [HbR partialHbR];
        
    end
    
    HbO(:,all(ismissing(HbO)))=[]; HbR(:,all(ismissing(HbR)))=[];
    HbO = table2array(HbO); HbR = table2array(HbR);
    HbO(1800,:) = HbO(1799,:); HbR(1800,:) = HbR(1799,:);
    
    for i = 1:size(HbO,2)
        HbO(:,i) = HbO(:,i) - mean(HbO(1:300,i));
        HbR(:,i) = HbR(:,i) - mean(HbR(1:300,i));
    end
    
    HbO_Trials(:,counter) = mean(HbO,2);
    HbR_Trials(:,counter) = mean(HbR,2);
    
    HbO = table();
    HbR = table();
    
end

X = (1:1500)/10;
HbO_Trials = SF.*HbO_Trials; HbR_Trials = SF.*HbR_Trials;
HbO_Trials(300:305,:) = NaN; HbR_Trials(300:305,:) = NaN;
U = {mean(HbO_Trials,2),mean(HbR_Trials,2)}; U{1}(300:305) = NaN; U{2}(300:305) = NaN;
SEM = {std(HbO_Trials,0,2)./sqrt(size(HbO_Trials,2)),...
    std(HbR_Trials,0,2)./sqrt(size(HbR_Trials,2))};  SEM{1}(300:305) = NaN; SEM{2}(300:305) = NaN;

f3 = figure(3); f3.WindowState = 'Maximized';
p = plot(X,HbO_Trials(1:1500,:),'Color',colors{6}); hold on;
H = shadedErrorBar(X,U{1}(1:1500),SEM{1}(1:1500),'lineprops',{':','Color',colors{1},'LineWidth',1.5,'LineJoin','round'},'transparent',1,'patchSaturation',0.25);
f = fplot(y1, [1 150], ...
    'Linewidth', 2, 'Color', colors{1});
hold off;

leg = legend([p(1) H.mainLine f],'Average traces for trials 1-10)', 'Mean \pm SEM', 'Two-term Gaussian model (R^{2}_{adj}=0.98)', 'Location', 'Northeast');
set(leg,'Interpreter','tex')
pos = leg.Position; pos(3) = 1.5*pos(3); leg.Position = pos;

xlabel('Time (s)','FontWeight','bold','FontSize',14);
ylabel('\Deltac[Hb] in \muM','FontWeight','bold','FontSize',14);
x1 = 30*ones(1,1500);
x2 = 60*ones(1,1500);
xP=[x1,fliplr(x2)];
yLimits = [-20 120];
xLimits = [0 150];
y = linspace(yLimits(1)-2,yLimits(2)+2,1500);
yP = [y,fliplr(y)];
xP(isnan(yP))=[];
yP(isnan(yP))=[];
patch(xP,yP,1,'HandleVisibility','off','EdgeColor','none','FaceColor',colors{9},'FaceAlpha',0.1);
ylim(yLimits)
xlim(xLimits)
yticks(linspace(-20,120,6))
xticks(10*(1:15))
set(gca, 'FontName', 'Abel', 'FontSize', 14)
set(gca,'linewidth',1.5)
legend boxoff
leg.FontSize = 14;
grid off
pbaspect([1.5 1 1])



f4 = figure(4); f4.WindowState = 'Maximized';
p = plot(X,HbR_Trials(1:1500,:),'Color',colors{6}); hold on;
H = shadedErrorBar(X,U{2}(1:1500),SEM{2}(1:1500),'lineprops',{':','Color',colors{3},'LineWidth',1.5,'LineJoin','round'},'transparent',1,'patchSaturation',0.25);
f = fplot(y2, [1 150], ...
    'Linewidth', 2, 'Color', colors{3});
hold off;

leg = legend([p(1) H.mainLine f],'Average traces for trials 1-10)', 'Mean \pm SEM', 'Two-term Gaussian model (R^{2}_{adj}=0.92)', 'Location', 'Northeast');
set(leg,'Interpreter','tex')
pos = leg.Position; pos(3) = 1.5*pos(3); leg.Position = pos;

xlabel('Time (s)','FontWeight','bold','FontSize',14);
ylabel('\Deltac[Hb] in \muM','FontWeight','bold','FontSize',14);
x1 = 30*ones(1,1500);
x2 = 60*ones(1,1500);
xP=[x1,fliplr(x2)];
yLimits = [-25 25];
xLimits = [0 150];
y = linspace(yLimits(1)-2,yLimits(2)+2,1500);
yP = [y,fliplr(y)];
xP(isnan(yP))=[];
yP(isnan(yP))=[];
patch(xP,yP,1,'HandleVisibility','off','EdgeColor','none','FaceColor',colors{9},'FaceAlpha',0.1);
ylim(yLimits)
xlim(xLimits)
yticks(linspace(-25,25,11))
xticks(10*(1:15))
set(gca, 'FontName', 'Abel', 'FontSize', 14)
set(gca,'linewidth',1.5)
legend boxoff
leg.FontSize = 14;
grid off
pbaspect([1.5 1 1])



%% Animal Averages: 2P

clc
clear all
load('F:\ANALYZED_DATA\MAT Files\2P\2P_Data.mat')
load('F:\ANALYZED_DATA\MAT Files\2P\2PTrial_Indices.mat')

colors = {[197/255 0 48/255],[1 159/255 184/255],...
    [0 137/255 192/255],[183/255 235/255 1],...
    [0 0 0],[190/255 190/255 190/255],...
    [0 165/255 104/255],[147/255 1 215/255],...
    [1 212/255 0],[1 247/255 204/255]}; %HbOx2, HbRx2, HbTx2, GCaMPx2, Stimx2


% 2P First-order Ca2+ Fit
a = -1.016; b = 0.0009314;
a1 = 0.1246; b1 = 33.17; c1 = 1.86;
a2 = 0.1631; b2 = 55.09; c2 = 20.39;
syms x
y1 = eval('a')*exp(-1*eval('b')*x) + eval('a1')*exp(-((x-eval('b1'))/eval('c1'))^2) + eval('a2')*exp(-((x-eval('b2'))/eval('c2'))^2); y1 = -1*y1;

% 2P First-order Flow Fit
a = 1; b = 2.925e-05;
a1 = 0.01628; b1 = 43.59; c1 = 7.142;
a2 = 0.02905; b2 = 68.96; c2 = 18.85;
syms x
y2 = eval('a')*exp(-1*eval('b')*x) + eval('a1')*exp(-((x-eval('b1'))/eval('c1'))^2) + eval('a2')*exp(-((x-eval('b2'))/eval('c2'))^2);

indicesLumen = FirstOrder_Lumen_ALL;
indicesCalcium = FirstOrder_Calcium_ALL;

% % 2P Penetrator Ca2+ Fit
% a = -1.001; b = 0.0002607;
% a1 = 0.1106; b1 = 32.71; c1 = 1.979;
% a2 = 0.1461; b2 = 52.48; c2 = 14.48;
% syms x
% y1 = eval('a')*exp(-1*eval('b')*x) + eval('a1')*exp(-((x-eval('b1'))/eval('c1'))^2) + eval('a2')*exp(-((x-eval('b2'))/eval('c2'))^2); y1 = -1*y1;
% 
% % 2P Penetrator Flow Fit
% a = 0.9984; b = -1.304e-05;
% a1 = 0.03999; b1 = 36.04; c1 = 4.334;
% a2 = 0.0974; b2 = 56.54; c2 = 18.15;
% syms x
% y2 = eval('a')*exp(-1*eval('b')*x) + eval('a1')*exp(-((x-eval('b1'))/eval('c1'))^2) + eval('a2')*exp(-((x-eval('b2'))/eval('c2'))^2);
% 
% indicesLumen = Penetrators_Lumen_ALL;
% indicesCalcium = Penetrators_Calcium_ALL;

lumenData = []; calciumData = [];
counter = 1;

for i = indicesLumen
    current = TwoPhoton_All.TwoPhoton_Trace{i,1};
    if (size(current,1) == 704)
        lumenData = [lumenData current];
        animalsLumen{1,counter} = TwoPhoton_All.Image_ID{i,1};
        counter = counter + 1;
    else
        current = resample(current,704,size(current,1));
        lumenData = [lumenData current];
        animalsLumen{1,counter} = TwoPhoton_All.Image_ID{i,1};
        counter = counter + 1;
    end
end

counter = 1;
for i = indicesCalcium
    current = TwoPhoton_All.TwoPhoton_Trace{i,1};
    if (size(current,1) == 704)
        calciumData = [calciumData current];
        animalsCalcium{1,counter} = TwoPhoton_All.Image_ID{i,1};
        counter = counter + 1;
    else
        current = resample(current,704,size(current,1));
        calciumData = [calciumData current];
        animalsCalcium{1,counter} = TwoPhoton_All.Image_ID{i,1};
        counter = counter + 1;
    end
end

for i = 1:size(lumenData,2)
    lumenData(:,i) = lumenData(:,i)./abs(mean(lumenData(1:116,i)));
end

for i = 1:size(calciumData,2)
    calciumData(:,i) = calciumData(:,i)./abs(mean(calciumData(1:116,i)));
end

comparators = {'M17','M19','M20','M21','M22','M23','M25','M28','M31','M32','M33'};
temp1 = []; temp2 = [];
for i = 1:size(comparators,2)
    for j = 1:size(lumenData,2)
        if(strcmp(comparators{1,i},animalsLumen{1,j}))
            temp1 = [temp1 lumenData(:,j)];
        end
    end
    for j = 1:size(calciumData,2)
        if(strcmp(comparators{1,i},animalsCalcium{1,j}))
            temp2 = [temp2 calciumData(:,j)];
        end
    end
    temp1 = mean(temp1,2); temp2 = mean(temp2,2);
    lumenAverages(:,i) = temp1; calciumAverages(:,i) = temp2;
    temp1= []; temp2 = [];
end

Flow_Animals = lumenAverages; Calcium_Animals = calciumAverages;

X = (1:587)/3.91;
Flow_Animals(117:119,:) = NaN; Calcium_Animals(117:119,:) = NaN;
U = {mean(Flow_Animals,2),mean(Calcium_Animals,2)}; U{1}(117:119) = NaN; U{2}(117:119) = NaN;
SEM = {std(Flow_Animals,0,2)./sqrt(size(Flow_Animals,2)),...
    std(Calcium_Animals,0,2)./sqrt(size(Calcium_Animals,2))};  SEM{1}(117:119) = NaN; SEM{2}(117:119) = NaN;

f5 = figure(5); f5.WindowState = 'Maximized';
p = plot(X,Flow_Animals(1:587,:),'Color',colors{6}); hold on;
H = shadedErrorBar(X,U{1}(1:587),SEM{1}(1:587),'lineprops',{':','Color',colors{1},'LineWidth',1.5,'LineJoin','round'},'transparent',1,'patchSaturation',0.25);
f = fplot(y2, [1 150], ...
    'Linewidth', 2, 'Color', colors{1});
hold off;

leg = legend([p(1) H.mainLine f],'Average traces for mice 1-11', 'Mean \pm SEM', 'Two-term Gaussian model (R^{2}_{adj}=0.54)', 'Location', 'Northeast');
set(leg,'Interpreter','tex')
pos = leg.Position; pos(3) = 1.5*pos(3); leg.Position = pos;

xlabel('Time (s)','FontWeight','bold','FontSize',14);
ylabel(' \DeltaF/F','FontWeight','bold','FontSize',14);
x1 = 30*ones(1,587);
x2 = 60*ones(1,587);
xP=[x1,fliplr(x2)];
yLimits = [0.6 1.3];
xLimits = [0 150];
y = linspace(yLimits(1)-2,yLimits(2)+2,587);
yP = [y,fliplr(y)];
xP(isnan(yP))=[];
yP(isnan(yP))=[];
patch(xP,yP,1,'HandleVisibility','off','EdgeColor','none','FaceColor',colors{9},'FaceAlpha',0.1);
ylim(yLimits)
xlim(xLimits)
yticks(linspace(0.6,1.3,15))
xticks(10*(1:15))
set(gca, 'FontName', 'Abel', 'FontSize', 14)
set(gca,'linewidth',1.5)
legend boxoff
leg.FontSize = 14;
grid off
pbaspect([1.5 1 1])



f6 = figure(6); f6.WindowState = 'Maximized';
p = plot(X,Calcium_Animals(1:587,:),'Color',colors{6}); hold on;
H = shadedErrorBar(X,U{2}(1:587),SEM{2}(1:587),'lineprops',{':','Color',colors{7},'LineWidth',1.5,'LineJoin','round'},'transparent',1,'patchSaturation',0.25);
f = fplot(y1, [1 150], ...
    'Linewidth', 2, 'Color', colors{7});
hold off;

leg = legend([p(1) H.mainLine f],'Average traces for mice 1-11', 'Mean \pm SEM', 'Two-term Gaussian model (R^{2}_{adj}=0.79)', 'Location', 'Northeast');
set(leg,'Interpreter','tex')
pos = leg.Position; pos(3) = 1.5*pos(3); leg.Position = pos;

xlabel('Time (s)','FontWeight','bold','FontSize',14);
ylabel(' \DeltaF/F','FontWeight','bold','FontSize',14);
x1 = 30*ones(1,587);
x2 = 60*ones(1,587);
xP=[x1,fliplr(x2)];
yLimits = [0.5 1.2];
xLimits = [0 150];
y = linspace(yLimits(1)-2,yLimits(2)+2,587);
yP = [y,fliplr(y)];
xP(isnan(yP))=[];
yP(isnan(yP))=[];
patch(xP,yP,1,'HandleVisibility','off','EdgeColor','none','FaceColor',colors{9},'FaceAlpha',0.1);
ylim(yLimits)
xlim(xLimits)
yticks(linspace(0.5,1.2,15))
xticks(10*(1:15))
set(gca, 'FontName', 'Abel', 'FontSize', 14)
set(gca,'linewidth',1.5)
legend boxoff
leg.FontSize = 14;
grid off
pbaspect([1.5 1 1])


%% Trial Averages: 2P

clc
clear all
load('F:\ANALYZED_DATA\MAT Files\2P\2P_Data.mat')
load('F:\ANALYZED_DATA\MAT Files\2P\2PTrial_Indices.mat')

colors = {[197/255 0 48/255],[1 159/255 184/255],...
    [0 137/255 192/255],[183/255 235/255 1],...
    [0 0 0],[190/255 190/255 190/255],...
    [0 165/255 104/255],[147/255 1 215/255],...
    [1 212/255 0],[1 247/255 204/255]}; %HbOx2, HbRx2, HbTx2, GCaMPx2, Stimx2


% 2P First-order Ca2+ Fit
a = -1.016; b = 0.0009314;
a1 = 0.1246; b1 = 33.17; c1 = 1.86;
a2 = 0.1631; b2 = 55.09; c2 = 20.39;
syms x
y1 = eval('a')*exp(-1*eval('b')*x) + eval('a1')*exp(-((x-eval('b1'))/eval('c1'))^2) + eval('a2')*exp(-((x-eval('b2'))/eval('c2'))^2); y1 = -1*y1;

% 2P First-order Flow Fit
a = 1; b = 2.925e-05;
a1 = 0.01628; b1 = 43.59; c1 = 7.142;
a2 = 0.02905; b2 = 68.96; c2 = 18.85;
syms x
y2 = eval('a')*exp(-1*eval('b')*x) + eval('a1')*exp(-((x-eval('b1'))/eval('c1'))^2) + eval('a2')*exp(-((x-eval('b2'))/eval('c2'))^2);

indicesLumen = FirstOrder_Lumen_ALL;
indicesCalcium = FirstOrder_Calcium_ALL;

% % 2P Penetrator Ca2+ Fit
% a = -1.001; b = 0.0002607;
% a1 = 0.1106; b1 = 32.71; c1 = 1.979;
% a2 = 0.1461; b2 = 52.48; c2 = 14.48;
% syms x
% y1 = eval('a')*exp(-1*eval('b')*x) + eval('a1')*exp(-((x-eval('b1'))/eval('c1'))^2) + eval('a2')*exp(-((x-eval('b2'))/eval('c2'))^2); y1 = -1*y1;
% 
% % 2P Penetrator Flow Fit
% a = 0.9984; b = -1.304e-05;
% a1 = 0.03999; b1 = 36.04; c1 = 4.334;
% a2 = 0.0974; b2 = 56.54; c2 = 18.15;
% syms x
% y2 = eval('a')*exp(-1*eval('b')*x) + eval('a1')*exp(-((x-eval('b1'))/eval('c1'))^2) + eval('a2')*exp(-((x-eval('b2'))/eval('c2'))^2);
% 
% indicesLumen = Penetrators_Lumen_ALL;
% indicesCalcium = Penetrators_Calcium_ALL;

lumenData = []; calciumData = [];
counter = 1;

for i = indicesLumen
    current = TwoPhoton_All.TwoPhoton_Trace{i,1};
    if (size(current,1) == 704)
        lumenData = [lumenData current];
        trialsLumen{1,counter} = TwoPhoton_All.Trial{i,1};
        counter = counter + 1;
    else
        current = resample(current,704,size(current,1));
        lumenData = [lumenData current];
        trialsLumen{1,counter} = TwoPhoton_All.Trial{i,1};
        counter = counter + 1;
    end
end

counter = 1;
for i = indicesCalcium
    current = TwoPhoton_All.TwoPhoton_Trace{i,1};
    if (size(current,1) == 704)
        calciumData = [calciumData current];
        trialsCalcium{1,counter} = TwoPhoton_All.Trial{i,1};
        counter = counter + 1;
    else
        current = resample(current,704,size(current,1));
        calciumData = [calciumData current];
        trialsCalcium{1,counter} = TwoPhoton_All.Trial{i,1};
        counter = counter + 1;
    end
end

for i = 1:size(lumenData,2)
    lumenData(:,i) = lumenData(:,i)./abs(mean(lumenData(1:116,i)));
end

for i = 1:size(calciumData,2)
    calciumData(:,i) = calciumData(:,i)./abs(mean(calciumData(1:116,i)));
end

comparators = {'001','002','003','004','005','006','007','008','009','010'};
temp1 = []; temp2 = [];
for i = 1:size(comparators,2)
    for j = 1:size(lumenData,2)
        if(strcmp(comparators{1,i},trialsLumen{1,j}))
            temp1 = [temp1 lumenData(:,j)];
        end
    end
    for j = 1:size(calciumData,2)
        if(strcmp(comparators{1,i},trialsCalcium{1,j}))
            temp2 = [temp2 calciumData(:,j)];
        end
    end
    temp1 = mean(temp1,2); temp2 = mean(temp2,2);
    lumenAverages(:,i) = temp1; calciumAverages(:,i) = temp2;
    temp1= []; temp2 = [];
end

Flow_Animals = lumenAverages; Calcium_Animals = calciumAverages;

X = (1:587)/3.91;
Flow_Animals(117:119,:) = NaN; Calcium_Animals(117:119,:) = NaN;
U = {mean(Flow_Animals,2),mean(Calcium_Animals,2)}; U{1}(117:119) = NaN; U{2}(117:119) = NaN;
SEM = {std(Flow_Animals,0,2)./sqrt(size(Flow_Animals,2)),...
    std(Calcium_Animals,0,2)./sqrt(size(Calcium_Animals,2))};  SEM{1}(117:119) = NaN; SEM{2}(117:119) = NaN;

f7 = figure(7); f7.WindowState = 'Maximized';
p = plot(X,Flow_Animals(1:587,:),'Color',colors{6}); hold on;
H = shadedErrorBar(X,U{1}(1:587),SEM{1}(1:587),'lineprops',{':','Color',colors{1},'LineWidth',1.5,'LineJoin','round'},'transparent',1,'patchSaturation',0.25);
f = fplot(y2, [1 150], ...
    'Linewidth', 2, 'Color', colors{1});
hold off;

leg = legend([p(1) H.mainLine f],'Average traces for trials 1-10)', 'Mean \pm SEM', 'Two-term Gaussian model (R^{2}_{adj}=0.45)', 'Location', 'Northeast');
set(leg,'Interpreter','tex')
pos = leg.Position; pos(3) = 1.5*pos(3); leg.Position = pos;

xlabel('Time (s)','FontWeight','bold','FontSize',14);
ylabel(' \DeltaF/F','FontWeight','bold','FontSize',14);
x1 = 30*ones(1,587);
x2 = 60*ones(1,587);
xP=[x1,fliplr(x2)];
yLimits = [0.6 1.3];
xLimits = [0 150];
y = linspace(yLimits(1)-2,yLimits(2)+2,587);
yP = [y,fliplr(y)];
xP(isnan(yP))=[];
yP(isnan(yP))=[];
patch(xP,yP,1,'HandleVisibility','off','EdgeColor','none','FaceColor',colors{9},'FaceAlpha',0.1);
ylim(yLimits)
xlim(xLimits)
yticks(linspace(0.6,1.3,15))
xticks(10*(1:15))
set(gca, 'FontName', 'Abel', 'FontSize', 14)
set(gca,'linewidth',1.5)
legend boxoff
leg.FontSize = 14;
grid off
pbaspect([1.5 1 1])



f8 = figure(8); f8.WindowState = 'Maximized';
p = plot(X,Calcium_Animals(1:587,:),'Color',colors{6}); hold on;
H = shadedErrorBar(X,U{2}(1:587),SEM{2}(1:587),'lineprops',{':','Color',colors{7},'LineWidth',1.5,'LineJoin','round'},'transparent',1,'patchSaturation',0.25);
f = fplot(y1, [1 150], ...
    'Linewidth', 2, 'Color', colors{7});
hold off;

leg = legend([p(1) H.mainLine f],'Average traces for trials 1-10)', 'Mean \pm SEM', 'Two-term Gaussian model (R^{2}_{adj}=0.90)', 'Location', 'Northeast');
set(leg,'Interpreter','tex')
pos = leg.Position; pos(3) = 1.5*pos(3); leg.Position = pos;

xlabel('Time (s)','FontWeight','bold','FontSize',14);
ylabel(' \DeltaF/F','FontWeight','bold','FontSize',14);
x1 = 30*ones(1,587);
x2 = 60*ones(1,587);
xP=[x1,fliplr(x2)];
yLimits = [0.5 1.2];
xLimits = xlim;
y = linspace(yLimits(1)-2,yLimits(2)+2,587);
yP = [y,fliplr(y)];
xP(isnan(yP))=[];
yP(isnan(yP))=[];
patch(xP,yP,1,'HandleVisibility','off','EdgeColor','none','FaceColor',colors{9},'FaceAlpha',0.1);
ylim(yLimits)
xlim(xLimits)
yticks(linspace(0.5,1.2,15))
xticks(10*(1:15))
set(gca, 'FontName', 'Abel', 'FontSize', 14)
set(gca,'linewidth',1.5)
legend boxoff
leg.FontSize = 14;
grid off
pbaspect([1.5 1 1])