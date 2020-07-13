%% WF HbO

clc
clear all
close all

SF = 100/log(10);

load('F:\ANALYZED_DATA\MAT Files\Curve-fitting\Murals_AverageTraces.mat')
colors = {[197/255 0 48/255],[1 159/255 184/255],...
    [0 137/255 192/255],[183/255 235/255 1],...
    [0 0 0],[85/255 85/255 85/255],...
    [0 165/255 104/255],[147/255 1 215/255],...
    [1 212/255 0],[1 247/255 204/255]}; %HbOx2, HbRx2, HbTx2, GCaMPx2, Stimx2

f1 = figure; f1.WindowState = 'Maximized';
a1 = 0.5158; b1 = 36.49; c1 = 5.727;
a2 = 1.15; b2 = 56; c2 = 16;

syms x
y1 = SF.*(eval('a1')*exp(-((x-eval('b1'))/eval('c1'))^2) + eval('a2')*exp(-((x-eval('b2'))/eval('c2'))^2));
y1_prime = diff(y1); y1_doubleprime = diff(y1,2);
extrema(1) = vpasolve(y1_prime == 0, x, 35); % specify initial guess close to the solution
extrema(2) = vpasolve(y1_prime == 0, x, 45);
extrema(3) = vpasolve(y1_prime == 0, x, 60);
inflections(1) = vpasolve(y1_doubleprime == 0, x, 35);
inflections(2) = vpasolve(y1_doubleprime == 0, x, 40);
inflections(3) = vpasolve(y1_doubleprime == 0, x, 45);
inflections(4) = vpasolve(y1_doubleprime == 0, x, 60);
s = scatter((1:1500)/10,SF.*WF_HbO,5,'o','MarkerEdgeColor',colors{2}); 
hold on;
f = fplot(y1, [1 150], ...
    'Linewidth', 2, 'Color', colors{1});
for i = 1:size(extrema,2)
    p1 = plot(extrema, subs(y1,extrema), 'k.', 'MarkerSize', 20, 'MarkerEdgeColor',colors{5});
end
for i = 1:size(inflections,2)
    p2 = plot(inflections, subs(y1,inflections), 'k*', 'MarkerSize', 9, 'MarkerEdgeColor',colors{5});
end
hold off

leg = legend([s f p1 p2],'\mu_{HbO}', 'Two-term Gaussian model (R^{2}_{adj}=0.98)', 'Extrema', 'Inflection points','Location', 'Northeast');
set(leg,'Interpreter','tex')
pos = leg.Position; pos(3) = 1.5*pos(3); pos(4) = 1.2*pos(4); leg.Position = pos;

xlabel('Time (s)','FontWeight','bold','FontSize',14);
ylabel('\Deltac[Hb] in \muM','FontWeight','bold','FontSize',14);

x1 = 30*ones(1,1500);
x2 = 60*ones(1,1500);
xP=[x1,fliplr(x2)];
yLimits = [-12 52];
y = linspace(yLimits(1)-2,yLimits(2)+2,1500);
yP = [y,fliplr(y)];

xP(isnan(yP))=[];
yP(isnan(yP))=[];
patch(xP,yP,1,'HandleVisibility','off','EdgeColor','none','FaceColor',colors{9},'FaceAlpha',0.1);
ylim(yLimits)
yticks(linspace(-12,52,17))
xticks(10*(1:15))

set(gca, 'FontName', 'Abel', 'FontSize', 14)
set(gca,'linewidth',1.5)
legend boxoff
leg.FontSize = 14;
fig.WindowState = 'maximized';

grid off
pbaspect([1.5 1 1])

%saveas(f1,'Mural_WF_HbO_CurveFit.svg');

%% WF HbR

clc
clear all
close all

SF = 100/log(10);

load('F:\ANALYZED_DATA\MAT Files\Curve-fitting\Murals_AverageTraces.mat')
colors = {[197/255 0 48/255],[1 159/255 184/255],...
    [0 137/255 192/255],[183/255 235/255 1],...
    [0 0 0],[85/255 85/255 85/255],...
    [0 165/255 104/255],[147/255 1 215/255],...
    [1 212/255 0],[1 247/255 204/255]}; %HbOx2, HbRx2, HbTx2, GCaMPx2, Stimx2

f2 = figure; f2.WindowState = 'Maximized';
a1 = 0.2152; b1 = 55.64; c1 = -14.37;
a2 = 0.1057; b2 = 36.03; c2 = 6.098;

syms x
y2 = SF.*(eval('a1')*exp(-((x-eval('b1'))/eval('c1'))^2) + eval('a2')*exp(-((x-eval('b2'))/eval('c2'))^2)); y2 = -1*y2;
y2_prime = diff(y2); y2_doubleprime = diff(y2,2);
extrema(1) = vpasolve(y2_prime == 0, x, 35); % specify initial guess close to the solution
extrema(2) = vpasolve(y2_prime == 0, x, 41);
extrema(3) = vpasolve(y2_prime == 0, x, 53);
inflections(1) = vpasolve(y2_doubleprime == 0, x, 35);
inflections(2) = vpasolve(y2_doubleprime == 0, x, 40);
inflections(3) = vpasolve(y2_doubleprime == 0, x, 45);
inflections(4) = vpasolve(y2_doubleprime == 0, x, 60);
s = scatter((1:1500)/10,SF.*WF_HbR,5,'o','MarkerEdgeColor',colors{4});
hold on;
f = fplot(y2, [1 150],'Linewidth', 2, 'Color', colors{3});
for i = 1:size(extrema,2)
    p1 = plot(extrema, subs(y2,extrema), 'k.', 'MarkerSize', 20, 'MarkerEdgeColor',colors{5});
end
for i = 1:size(inflections,2)
    p2 = plot(inflections, subs(y2,inflections), 'k*', 'MarkerSize', 9, 'MarkerEdgeColor',colors{5});
end
hold off

leg = legend([s f p1 p2],'\mu_{HbR}', 'Two-term Gaussian model (R^{2}_{adj}=0.91)', 'Extrema', 'Inflection points','Location', 'Northeast');
set(leg,'Interpreter','tex')
pos = leg.Position; pos(3) = 1.5*pos(3); pos(4) = 1.2*pos(4); leg.Position = pos;

xlabel('Time (s)','FontWeight','bold','FontSize',14);
ylabel('\Deltac[Hb] in \muM','FontWeight','bold','FontSize',14);
x1 = 30*ones(1,1500);
x2 = 60*ones(1,1500);
xP=[x1,fliplr(x2)];
yLimits = ylim;
y = linspace(yLimits(1)-2,yLimits(2)+2,1500);
yP = [y,fliplr(y)];
xP(isnan(yP))=[];
yP(isnan(yP))=[];
patch(xP,yP,1,'HandleVisibility','off','EdgeColor','none','FaceColor',colors{9},'FaceAlpha',0.1);
ylim([-12 4])
yticks(linspace(-12,4,9))
xticks(10*(1:15))

set(gca, 'FontName', 'Abel', 'FontSize', 14)
set(gca,'linewidth',1.5)
legend boxoff
leg.FontSize = 14;
fig.WindowState = 'maximized';
grid off
pbaspect([1.5 1 1])

%saveas(f2,'Mural_WF_HbR_CurveFit.svg');

%% 2P Penetrator Calcium

clc
clear all
close all

load('F:\ANALYZED_DATA\MAT Files\Curve-fitting\Murals_AverageTraces.mat')
colors = {[197/255 0 48/255],[1 159/255 184/255],...
    [0 137/255 192/255],[183/255 235/255 1],...
    [0 0 0],[85/255 85/255 85/255],...
    [0 165/255 104/255],[147/255 1 215/255],...
    [1 212/255 0],[1 247/255 204/255]}; %HbOx2, HbRx2, HbTx2, GCaMPx2, Stimx2

f3 = figure; f3.WindowState = 'Maximized';
a = -1.001; b = 0.0002607;
a1 = 0.1106; b1 = 32.71; c1 = 1.979;
a2 = 0.1461; b2 = 52.48; c2 = 14.48;

syms x
y3 = eval('a')*exp(-1*eval('b')*x) + eval('a1')*exp(-((x-eval('b1'))/eval('c1'))^2) + eval('a2')*exp(-((x-eval('b2'))/eval('c2'))^2); y3 = -1*y3;
y3_prime = diff(y3); y3_doubleprime = diff(y3,2);
extrema(1) = vpasolve(y3_prime == 0, x, 32); % specify initial guess close to the solution
extrema(2) = vpasolve(y3_prime == 0, x, 35);
extrema(3) = vpasolve(y3_prime == 0, x, 50);
extrema(4) = vpasolve(y3_prime == 0, x, 80);
inflections(1) = vpasolve(y3_doubleprime == 0, x, 31);
inflections(2) = vpasolve(y3_doubleprime == 0, x, 35);
inflections(3) = vpasolve(y3_doubleprime == 0, x, 38);
inflections(4) = vpasolve(y3_doubleprime == 0, x, 60);

s = scatter((1:587)/3.91,TwoPhoton_Calcium_Penetrator,5,'o','MarkerEdgeColor',colors{8}); 
hold on;
f = fplot(y3, [1 150], ...
    'Linewidth', 2, 'Color', colors{7});
for i = 1:size(extrema,2)
    p1 = plot(extrema, subs(y3,extrema), 'k.', 'MarkerSize', 20, 'MarkerEdgeColor',colors{5});
end
for i = 1:size(inflections,2)
    p2 = plot(inflections, subs(y3,inflections), 'k*', 'MarkerSize', 9, 'MarkerEdgeColor',colors{5});
end
hold off

leg = legend([s f p1 p2],'\mu_{Ca2+_{Penetrator}}', 'Two-term Gaussian model (R^{2}_{adj}=0.93)', 'Extrema', 'Inflection points','Location', 'Northeast');
set(leg,'Interpreter','tex')
pos = leg.Position; pos(3) = 1.5*pos(3); pos(4) = 1.2*pos(4); leg.Position = pos;

x1 = 30*ones(1,587);
x2 = 60*ones(1,587);
xP=[x1,fliplr(x2)];
yLimits = [0.75 1.1];
xLimits = [0 150];
y = linspace(yLimits(1),yLimits(2),587);
yP = [y,fliplr(y)];
xP(isnan(yP))=[];
yP(isnan(yP))=[];
patch(xP,yP,1,'HandleVisibility','off','EdgeColor','none','FaceColor',colors{9},'FaceAlpha',0.1);
ylim(yLimits)
xlim(xLimits)
xticks(10*(1:15))
xlabel('Time (s)','FontWeight','bold','Interpreter','tex','FontSize',14);
ylabel(' \DeltaF/F','FontWeight','bold','Interpreter','tex','FontSize',14);
set(gca, 'FontName', 'Abel', 'FontSize', 14)
set(gca,'linewidth',1.5)
legend boxoff
leg.FontSize = 14;
pbaspect([1.5 1 1])

%saveas(f3,'Mural_2P_PenetratorCalcium_CurveFit.svg');

%% 2P Penetrator Flow

clc
clear all
close all

load('F:\ANALYZED_DATA\MAT Files\Curve-fitting\Murals_AverageTraces.mat')
colors = {[197/255 0 48/255],[1 159/255 184/255],...
    [0 137/255 192/255],[183/255 235/255 1],...
    [0 0 0],[85/255 85/255 85/255],...
    [0 165/255 104/255],[147/255 1 215/255],...
    [1 212/255 0],[1 247/255 204/255]}; %HbOx2, HbRx2, HbTx2, GCaMPx2, Stimx2

f4 = figure; f4.WindowState = 'Maximized';
a = 0.9984; b = -1.304e-05;
a1 = 0.03999; b1 = 36.04; c1 = 4.334;
a2 = 0.0974; b2 = 56.54; c2 = 18.15;

syms x
y4 = eval('a')*exp(-1*eval('b')*x) + eval('a1')*exp(-((x-eval('b1'))/eval('c1'))^2) + eval('a2')*exp(-((x-eval('b2'))/eval('c2'))^2);
y4_prime = diff(y4); y4_doubleprime = diff(y4,2);
extrema(1) = vpasolve(y4_prime == 0, x, 35.5); % specify initial guess close to the solution
extrema(2) = vpasolve(y4_prime == 0, x, 40);
extrema(3) = vpasolve(y4_prime == 0, x, 54);
inflections(1) = vpasolve(y4_doubleprime == 0, x, 32);
inflections(2) = vpasolve(y4_doubleprime == 0, x, 40);
inflections(3) = vpasolve(y4_doubleprime == 0, x, 48);
inflections(4) = vpasolve(y4_doubleprime == 0, x, 65);

s = scatter((1:587)/3.91,TwoPhoton_Flow_Penetrator,5,'o','MarkerEdgeColor',colors{2}); 
hold on;
f = fplot(y4, [1 150], ...
    'Linewidth', 2, 'Color', colors{1});
for i = 1:size(extrema,2)
    p1 = plot(extrema, subs(y4,extrema), 'k.', 'MarkerSize', 20, 'MarkerEdgeColor',colors{5});
end
for i = 1:size(inflections,2)
    p2 = plot(inflections, subs(y4,inflections), 'k*', 'MarkerSize', 9, 'MarkerEdgeColor',colors{5});
end
hold off

leg = legend([s f p1 p2],'\mu_{Flow_{Penetrator}}', 'Two-term Gaussian model (R^{2}_{adj}=0.97)', 'Extrema', 'Inflection points','Location', 'Northeast');
set(leg,'Interpreter','tex')
pos = leg.Position; pos(3) = 1.5*pos(3); pos(4) = 1.2*pos(4); leg.Position = pos;

x1 = 30*ones(1,587);
x2 = 60*ones(1,587);
xP=[x1,fliplr(x2)];
yLimits = [0.96 1.12];
xLimits = [0 150];
y = linspace(yLimits(1),yLimits(2),587);
yP = [y,fliplr(y)];
xP(isnan(yP))=[];
yP(isnan(yP))=[];
patch(xP,yP,1,'HandleVisibility','off','EdgeColor','none','FaceColor',colors{9},'FaceAlpha',0.1);
ylim(yLimits)
xlim(xLimits)
xticks(10*(1:15))
xlabel('Time (s)','FontWeight','bold','Interpreter','tex','FontSize',14);
ylabel(' \DeltaF/F','FontWeight','bold','Interpreter','tex','FontSize',14);
set(gca, 'FontName', 'Abel', 'FontSize', 14)
set(gca,'linewidth',1.5)
legend boxoff
leg.FontSize = 14;
pbaspect([1.5 1 1])

%saveas(f4,'Mural_2P_PenetratorFlow_CurveFit.svg');

%% 2P First-Order Calcium

clc
clear all
close all

load('F:\ANALYZED_DATA\MAT Files\Curve-fitting\Murals_AverageTraces.mat')
colors = {[197/255 0 48/255],[1 159/255 184/255],...
    [0 137/255 192/255],[183/255 235/255 1],...
    [0 0 0],[85/255 85/255 85/255],...
    [0 165/255 104/255],[147/255 1 215/255],...
    [1 212/255 0],[1 247/255 204/255]}; %HbOx2, HbRx2, HbTx2, GCaMPx2, Stimx2

f5 = figure;  f5.WindowState = 'Maximized';
a = -1.016; b = 0.0009314;
a1 = 0.1246; b1 = 33.17; c1 = 1.86;
a2 = 0.1631; b2 = 55.09; c2 = 20.39;

syms x
y5 = eval('a')*exp(-1*eval('b')*x) + eval('a1')*exp(-((x-eval('b1'))/eval('c1'))^2) + eval('a2')*exp(-((x-eval('b2'))/eval('c2'))^2); y5 = -1*y5;
y5_prime = diff(y5); y5_doubleprime = diff(y5,2);
extrema(1) = vpasolve(y5_prime == 0, x, 32.5); % specify initial guess close to the solution
extrema(2) = vpasolve(y5_prime == 0, x, 35.5);
extrema(3) = vpasolve(y5_prime == 0, x, 50.5);
extrema(4) = vpasolve(y5_prime == 0, x, 80.5);
inflections(1) = vpasolve(y5_doubleprime == 0, x, 32);
inflections(2) = vpasolve(y5_doubleprime == 0, x, 35);
inflections(3) = vpasolve(y5_doubleprime == 0, x, 42);
inflections(4) = vpasolve(y5_doubleprime == 0, x, 70);
s = scatter((1:587)/3.91,TwoPhoton_Calcium_FirstOrder,5,'o','MarkerEdgeColor',colors{8}); 
hold on;
f = fplot(y5, [1 150], ...
    'Linewidth', 2, 'Color', colors{7});
for i = 1:size(extrema,2)
    p1 = plot(extrema, subs(y5,extrema), 'k.', 'MarkerSize', 20, 'MarkerEdgeColor',colors{5});
end
for i = 1:size(inflections,2)
    p2 = plot(inflections, subs(y5,inflections), 'k*', 'MarkerSize', 9, 'MarkerEdgeColor',colors{5});
end
hold off

leg = legend([s f p1 p2],'\mu_{Ca2+_{First-order}}', 'Two-term Gaussian model (R^{2}_{adj}=0.94)', 'Extrema', 'Inflection points','Location', 'Northeast');
set(leg,'Interpreter','tex')
pos = leg.Position; pos(3) = 1.5*pos(3); pos(4) = 1.2*pos(4); leg.Position = pos;

x1 = 30*ones(1,587);
x2 = 60*ones(1,587);
xP=[x1,fliplr(x2)];
yLimits = [0.75 1.1];
xLimits = [0 150];
y = linspace(yLimits(1),yLimits(2),587);
yP = [y,fliplr(y)];
xP(isnan(yP))=[];
yP(isnan(yP))=[];
patch(xP,yP,1,'HandleVisibility','off','EdgeColor','none','FaceColor',colors{9},'FaceAlpha',0.1);
ylim(yLimits)
xlim(xLimits)
xticks(10*(1:15))
xlabel('Time (s)','FontWeight','bold','Interpreter','tex','FontSize',14);
ylabel(' \DeltaF/F','FontWeight','bold','Interpreter','tex','FontSize',14);
set(gca, 'FontName', 'Abel', 'FontSize', 14)
set(gca,'linewidth',1.5)
legend boxoff
leg.FontSize = 14;
pbaspect([1.5 1 1])

%saveas(f5,'Mural_2P_FirstOrderCalcium_CurveFit.svg');

%% 2P First-Order Flow

clc
clear all
close all

load('F:\ANALYZED_DATA\MAT Files\Curve-fitting\Murals_AverageTraces.mat')
colors = {[197/255 0 48/255],[1 159/255 184/255],...
    [0 137/255 192/255],[183/255 235/255 1],...
    [0 0 0],[85/255 85/255 85/255],...
    [0 165/255 104/255],[147/255 1 215/255],...
    [1 212/255 0],[1 247/255 204/255]}; %HbOx2, HbRx2, HbTx2, GCaMPx2, Stimx2

f6 = figure; f6.WindowState = 'Maximized';
a = 1; b = 2.925e-05;
a1 = 0.01628; b1 = 43.59; c1 = 7.142;
a2 = 0.02905; b2 = 68.96; c2 = 18.85;

syms x
y6 = eval('a')*exp(-1*eval('b')*x) + eval('a1')*exp(-((x-eval('b1'))/eval('c1'))^2) + eval('a2')*exp(-((x-eval('b2'))/eval('c2'))^2);
y6_prime = diff(y6); y6_doubleprime = diff(y6,2);
extrema(1) = vpasolve(y6_prime == 0, x, 42.5); % specify initial guess close to the solution
extrema(2) = vpasolve(y6_prime == 0, x, 50);
extrema(3) = vpasolve(y6_prime == 0, x, 65);
inflections(1) = vpasolve(y6_doubleprime == 0, x, 38);
inflections(2) = vpasolve(y6_doubleprime == 0, x, 48);
inflections(3) = vpasolve(y6_doubleprime == 0, x, 57);
inflections(4) = vpasolve(y6_doubleprime == 0, x, 76);

s = scatter((1:587)/3.91,TwoPhoton_Flow_FirstOrder,5,'o','MarkerEdgeColor',colors{2}); 
hold on;
f = fplot(y6, [1 150], ...
    'Linewidth', 2, 'Color', colors{1});
for i = 1:size(extrema,2)
    p1 = plot(extrema, subs(y6,extrema), 'k.', 'MarkerSize', 20, 'MarkerEdgeColor',colors{5});
end
for i = 1:size(inflections,2)
    p2 = plot(inflections, subs(y6,inflections), 'k*', 'MarkerSize', 9, 'MarkerEdgeColor',colors{5});
end
hold off

leg = legend([s f p1 p2],'\mu_{Flow_{First-order}}', 'Two-term Gaussian model (R^{2}_{adj}=0.62)', 'Extrema', 'Inflection points','Location', 'Northeast');
set(leg,'Interpreter','tex')
pos = leg.Position; pos(3) = 1.5*pos(3); pos(4) = 1.2*pos(4); leg.Position = pos;

x1 = 30*ones(1,587);
x2 = 60*ones(1,587);
xP=[x1,fliplr(x2)];
yLimits = [0.96 1.12];
xLimits = [0 150];
y = linspace(yLimits(1),yLimits(2),587);
yP = [y,fliplr(y)];
xP(isnan(yP))=[];
yP(isnan(yP))=[];
patch(xP,yP,1,'HandleVisibility','off','EdgeColor','none','FaceColor',colors{9},'FaceAlpha',0.1);
ylim(yLimits)
xlim(xLimits)
xticks(10*(1:15))
xlabel('Time (s)','FontWeight','bold','Interpreter','tex','FontSize',14);
ylabel(' \DeltaF/F','FontWeight','bold','Interpreter','tex','FontSize',14);
set(gca, 'FontName', 'Abel', 'FontSize', 14)
set(gca,'linewidth',1.5)
legend boxoff
leg.FontSize = 14;
pbaspect([1.5 1 1])

%saveas(f6,'Mural_2P_FirstOrderFlow_CurveFit.svg');

%% TRIAL SHAPING EFFECT

clc
clear all
close all
load('F:\ANALYZED_DATA\MAT Files\Curve-fitting\fits_byTrial.mat')

colors = {[197/255 0 48/255],[1 159/255 184/255],...
    [0 137/255 192/255],[183/255 235/255 1],...
    [0 0 0],[85/255 85/255 85/255],...
    [0 165/255 104/255],[147/255 1 215/255],...
    [1 212/255 0],[1 247/255 204/255]}; %HbOx2, HbRx2, HbTx2, GCaMPx2, Stimx2

for i = 1:size(fits_byTrial_HbO,1)
    
    f1 = figure(1); f1.WindowState = 'Maximized';
    
    y0 = fits_byTrial_HbO(i,1); A1 = fits_byTrial_HbO(i,4);
    A2 = fits_byTrial_HbO(i,8); xc1 = fits_byTrial_HbO(i,2);
    xc2 =  fits_byTrial_HbO(i,6); w1 = fits_byTrial_HbO(i,3);
    w2 =  fits_byTrial_HbO(i,7);
    
    s = scatter((1:1500)/10,HbO(:,i),5,'o','MarkerEdgeColor',colors{2}); hold on;
    fplot(@(x) 2*y0 + A1.*exp(-0.5.*((x-xc1)./w1).^2) + A2.*exp(-0.5.*((x-xc2)./w2).^2),...
        [1 150], 'Linewidth', 2, 'Color', colors{1}); hold off;
    
    leg = legend(['\mu' '_{HbO}'],'Fitted line','Location', 'Northeast','FontSize',14);
    set(leg,'Interpreter','tex')
    
    xlabel('Time (s)','FontWeight','bold','FontSize',14);
    ylabel('\Deltac[Hb] in \muM','FontWeight','bold','FontSize',16);
    
    x1 = 30*ones(1,1500);
    x2 = 60*ones(1,1500);
    xP=[x1,fliplr(x2)];
    yLimits = [-0.4 1.6];
    y = linspace(yLimits(1)-2,yLimits(2)+2,1500);
    yP = [y,fliplr(y)];
    
    xP(isnan(yP))=[];
    yP(isnan(yP))=[];
    patch(xP,yP,1,'HandleVisibility','off','EdgeColor','none','FaceColor',colors{9},'FaceAlpha',0.1);
    ylim(yLimits)
    yticks(linspace(yLimits(1),yLimits(2),11))
    
    set(gca, 'FontName', 'Abel', 'FontSize', 14)
    set(gca,'linewidth',1.5)
    legend boxoff
    leg.FontSize = 14;
    fig.WindowState = 'maximized';
    
    grid off
    pbaspect([1.5 1 1])
    
    input('')
    
    %saveas(f1,['F:\ANALYZED_DATA\FIGURES\FINAL\FIGURE 2\BehaviorDependence_TrialShaping_Trial-' int2str(i) '_HbO_Fit.svg']);
end


for i = 1:size(fits_byTrial_HbR,1)
    
    f2 = figure(2); f2.WindowState = 'Maximized';
    
    y0 = fits_byTrial_HbR(i,1); A1 = fits_byTrial_HbR(i,4);
    A2 = fits_byTrial_HbR(i,8); xc1 = fits_byTrial_HbR(i,2);
    xc2 =  fits_byTrial_HbR(i,6); w1 = fits_byTrial_HbR(i,3);
    w2 =  fits_byTrial_HbR(i,7);
    
    s = scatter((1:1500)/10,HbR(:,i),5,'o','MarkerEdgeColor',colors{4}); hold on;
    fplot(@(x) -1.*(2*y0 + A1.*exp(-0.5.*((x-xc1)./w1).^2) + A2.*exp(-0.5.*((x-xc2)./w2).^2)),...
        [1 150], 'Linewidth', 2, 'Color', colors{3}); hold off;
    
    leg = legend(['\mu' '_{HbR}'],'Fitted line','Location', 'Southeast','FontSize',14);
    set(leg,'Interpreter','tex')
    
    xlabel('Time (s)','FontWeight','bold','FontSize',14);
    ylabel('\Deltac[Hb] in \muM','FontWeight','bold','FontSize',16);
    
    x1 = 30*ones(1,1500);
    x2 = 60*ones(1,1500);
    xP=[x1,fliplr(x2)];
    yLimits = [-0.3 0.1];
    y = linspace(yLimits(1)-2,yLimits(2)+2,1500);
    yP = [y,fliplr(y)];
    
    xP(isnan(yP))=[];
    yP(isnan(yP))=[];
    patch(xP,yP,1,'HandleVisibility','off','EdgeColor','none','FaceColor',colors{9},'FaceAlpha',0.1);
    ylim(yLimits)
    yticks(linspace(yLimits(1),yLimits(2),11))
    
    set(gca, 'FontName', 'Abel', 'FontSize', 14)
    set(gca,'linewidth',1.5)
    legend boxoff
    leg.FontSize = 14;
    fig.WindowState = 'maximized';
    
    grid off
    pbaspect([1.5 1 1])
    
    input('')
    
    %saveas(f2,['F:\ANALYZED_DATA\FIGURES\FINAL\FIGURE 2\BehaviorDependence_TrialShaping_Trial-' int2str(i) '_HbR_Fit.svg']);
end


