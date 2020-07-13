clc
clear all
close all

load('F:\ANALYZED_DATA\MAT Files\Behavioral State\2P_Bouts_Processed.mat');

colors = {[197/255 0 48/255],[1 159/255 184/255],...
    [0 137/255 192/255],[183/255 235/255 1],...
    [0 0 0],[190/255 190/255 190/255],...
    [0 165/255 104/255],[147/255 1 215/255],...
    [1 212/255 0],[1 247/255 204/255]}; %HbOx2, HbRx2, HbTx2, GCaMPx2, Stimx2

X1 = linspace(-10,10,78);


% Plot Penetrator Ca2+ (Bouts)
f1 = figure; f1.WindowState = 'Maximized';
temp = basal_penetratorCalcium_Full'; temp = temp(1:78,:);
subplot(2,1,1)
p1 = plot(X1,temp,'Color',colors{6});
hold on; p2 = plot(X1,nanmean(basal_penetratorCalcium_Full(:,1:78)),'Color',colors{7},'LineWidth',3);
title('Ca2+')
xlabel('Time (s)','FontWeight','bold','FontSize',14);
ylabel('\DeltaF/F','FontWeight','bold');
set(gca, 'FontName', 'Abel', 'FontSize', 14)
set(gca,'linewidth',1.5)
leg = legend(p2,'\mu_{Mural Ca2+}','Location', 'Northeast');
set(leg,'Interpreter','tex')
legend boxoff
leg.FontSize = 16;
pbaspect([1.5 1 1])
subplot(2,1,2)
temp = [zeros(1,39) ones(1,39)];
plot(X1,temp,'Color',colors{9},'LineWidth',3)
title('Behavior')
ylim([-1 2])
xlabel('Time (s)','FontWeight','bold','FontSize',14);
yticks([0 1])
yticklabels({'STILL','RUNNING'})
set(gca, 'FontName', 'Abel', 'FontSize', 14)
set(gca,'linewidth',1.5)
leg = legend('Behavior','Location', 'Northeast');
set(leg,'Interpreter','tex')
legend boxoff
leg.FontSize = 16;
pbaspect([1.5 1 1])
sgtitle('Average traces of voluntary locomotion: Penetrator Ca2+')

% Plot First Order Ca2+ (Bouts)
f2 = figure; f2.WindowState = 'Maximized';
temp = basal_firstOrderCalcium_Full'; temp = temp(1:78,:);
subplot(2,1,1)
p1 = plot(X1,temp,'Color',colors{6});
hold on; p2 = plot(X1,nanmean(basal_firstOrderCalcium_Full(:,1:78)),'Color',colors{7},'LineWidth',3);
title('Ca2+')
xlabel('Time (s)','FontWeight','bold','FontSize',14);
ylabel('\DeltaF/F','FontWeight','bold');
set(gca, 'FontName', 'Abel', 'FontSize', 14)
set(gca,'linewidth',1.5)
leg = legend(p2,'\mu_{Mural Ca2+}','Location', 'Northeast');
set(leg,'Interpreter','tex')
legend boxoff
leg.FontSize = 16;
pbaspect([1.5 1 1])
subplot(2,1,2)
temp = [zeros(1,39) ones(1,39)];
plot(X1,temp,'Color',colors{9},'LineWidth',3)
title('Behavior')
ylim([-1 2])
xlabel('Time (s)','FontWeight','bold','FontSize',14);
yticks([0 1])
yticklabels({'STILL','RUNNING'})
set(gca, 'FontName', 'Abel', 'FontSize', 14)
set(gca,'linewidth',1.5)
leg = legend('Behavior','Location', 'Northeast');
set(leg,'Interpreter','tex')
legend boxoff
leg.FontSize = 16;
pbaspect([1.5 1 1])
sgtitle('Average traces of voluntary locomotion: First Order Ca2+')

% Plot Penetrator Lumen (Bouts)
f3 = figure; f3.WindowState = 'Maximized';
temp = basal_penetratorLumen_Full'; temp = temp(1:78,:);
subplot(2,1,1)
p1 = plot(X1,temp,'Color',colors{6});
hold on; p2 = plot(X1,nanmean(basal_penetratorLumen_Full(:,1:78)),'Color',colors{1},'LineWidth',3);
title('Flow')
xlabel('Time (s)','FontWeight','bold','FontSize',14);
ylabel('\DeltaF/F','FontWeight','bold');
set(gca, 'FontName', 'Abel', 'FontSize', 14)
set(gca,'linewidth',1.5)
leg = legend(p2,'\mu_{Flow}','Location', 'Northeast');
set(leg,'Interpreter','tex')
legend boxoff
leg.FontSize = 16;
pbaspect([1.5 1 1])
subplot(2,1,2)
temp = [zeros(1,39) ones(1,39)];
plot(X1,temp,'Color',colors{9},'LineWidth',3)
title('Behavior')
ylim([-1 2])
xlabel('Time (s)','FontWeight','bold','FontSize',14);
yticks([0 1])
yticklabels({'STILL','RUNNING'})
set(gca, 'FontName', 'Abel', 'FontSize', 14)
set(gca,'linewidth',1.5)
leg = legend('Behavior','Location', 'Northeast');
set(leg,'Interpreter','tex')
legend boxoff
leg.FontSize = 16;
pbaspect([1.5 1 1])
sgtitle('Average traces of voluntary locomotion: Penetrator Lumen')

% Plot First Order Lumen (Bouts)
f4 = figure; f4.WindowState = 'Maximized';
temp = basal_firstOrderLumen_Full'; temp = temp(1:78,:);
subplot(2,1,1)
p1 = plot(X1,temp,'Color',colors{6});
hold on; p2 = plot(X1,nanmean(basal_firstOrderLumen_Full(:,1:78)),'Color',colors{1},'LineWidth',3);
title('Flow')
xlabel('Time (s)','FontWeight','bold','FontSize',14);
ylabel('\DeltaF/F','FontWeight','bold');
set(gca, 'FontName', 'Abel', 'FontSize', 14)
set(gca,'linewidth',1.5)
leg = legend(p2,'\mu_{Flow}','Location', 'Northeast');
set(leg,'Interpreter','tex')
legend boxoff
leg.FontSize = 16;
pbaspect([1.5 1 1])
subplot(2,1,2)
temp = [zeros(1,39) ones(1,39)];
plot(X1,temp,'Color',colors{9},'LineWidth',3)
title('Behavior')
ylim([-1 2])
xlabel('Time (s)','FontWeight','bold','FontSize',14);
yticks([0 1])
yticklabels({'STILL','RUNNING'})
set(gca, 'FontName', 'Abel', 'FontSize', 14)
set(gca,'linewidth',1.5)
leg = legend('Behavior','Location', 'Northeast');
set(leg,'Interpreter','tex')
legend boxoff
leg.FontSize = 16;
pbaspect([1.5 1 1])
sgtitle('Average traces of voluntary locomotion: First Order Lumen')



% Plot Penetrator Ca2+ (Bouts)
f5 = figure; f5.WindowState = 'Maximized';
temp = stim_penetratorCalcium_Full'; temp = temp(1:78,:);
subplot(2,1,1)
p1 = plot(X1,temp,'Color',colors{6});
hold on; p2 = plot(X1,nanmean(stim_penetratorCalcium_Full(:,1:78)),'Color',colors{7},'LineWidth',3);
title('Ca2+')
xlabel('Time (s)','FontWeight','bold','FontSize',14);
ylabel('\DeltaF/F','FontWeight','bold');
set(gca, 'FontName', 'Abel', 'FontSize', 14)
set(gca,'linewidth',1.5)
leg = legend(p2,'\mu_{Mural Ca2+}','Location', 'Northeast');
set(leg,'Interpreter','tex')
legend boxoff
leg.FontSize = 16;
pbaspect([1.5 1 1])
subplot(2,1,2)
temp = [zeros(1,39) ones(1,39)];
plot(X1,temp,'Color',colors{9},'LineWidth',3)
title('Behavior')
ylim([-1 2])
xlabel('Time (s)','FontWeight','bold','FontSize',14);
yticks([0 1])
yticklabels({'STILL','RUNNING'})
set(gca, 'FontName', 'Abel', 'FontSize', 14)
set(gca,'linewidth',1.5)
leg = legend('Behavior','Location', 'Northeast');
set(leg,'Interpreter','tex')
legend boxoff
leg.FontSize = 16;
pbaspect([1.5 1 1])
sgtitle('Average traces of puff-induced locomotion: Penetrator Ca2+')

% Plot First Order Ca2+ (Bouts)
f6 = figure; f6.WindowState = 'Maximized';
temp = stim_firstOrderCalcium_Full'; temp = temp(1:78,:);
subplot(2,1,1)
p1 = plot(X1,temp,'Color',colors{6});
hold on; p2 = plot(X1,nanmean(stim_firstOrderCalcium_Full(:,1:78)),'Color',colors{7},'LineWidth',3);
title('Ca2+')
xlabel('Time (s)','FontWeight','bold','FontSize',14);
ylabel('\DeltaF/F','FontWeight','bold');
set(gca, 'FontName', 'Abel', 'FontSize', 14)
set(gca,'linewidth',1.5)
leg = legend(p2,'\mu_{Mural Ca2+}','Location', 'Northeast');
set(leg,'Interpreter','tex')
legend boxoff
leg.FontSize = 16;
pbaspect([1.5 1 1])
subplot(2,1,2)
temp = [zeros(1,39) ones(1,39)];
plot(X1,temp,'Color',colors{9},'LineWidth',3)
title('Behavior')
ylim([-1 2])
xlabel('Time (s)','FontWeight','bold','FontSize',14);
yticks([0 1])
yticklabels({'STILL','RUNNING'})
set(gca, 'FontName', 'Abel', 'FontSize', 14)
set(gca,'linewidth',1.5)
leg = legend('Behavior','Location', 'Northeast');
set(leg,'Interpreter','tex')
legend boxoff
leg.FontSize = 16;
pbaspect([1.5 1 1])
sgtitle('Average traces of puff-induced locomotion: First Order Ca2+')

% Plot Penetrator Lumen (Bouts)
f7 = figure; f7.WindowState = 'Maximized';
temp = stim_penetratorLumen_Full'; temp = temp(1:78,:);
subplot(2,1,1)
p1 = plot(X1,temp,'Color',colors{6});
hold on; p2 = plot(X1,nanmean(stim_penetratorLumen_Full(:,1:78)),'Color',colors{1},'LineWidth',3);
title('Flow')
xlabel('Time (s)','FontWeight','bold','FontSize',14);
ylabel('\DeltaF/F','FontWeight','bold');
set(gca, 'FontName', 'Abel', 'FontSize', 14)
set(gca,'linewidth',1.5)
leg = legend(p2,'\mu_{Flow}','Location', 'Northeast');
set(leg,'Interpreter','tex')
legend boxoff
leg.FontSize = 16;
pbaspect([1.5 1 1])
subplot(2,1,2)
temp = [zeros(1,39) ones(1,39)];
plot(X1,temp,'Color',colors{9},'LineWidth',3)
title('Behavior')
ylim([-1 2])
xlabel('Time (s)','FontWeight','bold','FontSize',14);
yticks([0 1])
yticklabels({'STILL','RUNNING'})
set(gca, 'FontName', 'Abel', 'FontSize', 14)
set(gca,'linewidth',1.5)
leg = legend('Behavior','Location', 'Northeast');
set(leg,'Interpreter','tex')
legend boxoff
leg.FontSize = 16;
pbaspect([1.5 1 1])
sgtitle('Average traces of puff-induced locomotion: Penetrator Lumen')

% Plot First Order Lumen (Bouts)
f8 = figure; f8.WindowState = 'Maximized';
temp = stim_firstOrderLumen_Full'; temp = temp(1:78,:);
subplot(2,1,1)
p1 = plot(X1,temp,'Color',colors{6});
hold on; p2 = plot(X1,nanmean(stim_firstOrderLumen_Full(:,1:78)),'Color',colors{1},'LineWidth',3);
title('Flow')
xlabel('Time (s)','FontWeight','bold','FontSize',14);
ylabel('\DeltaF/F','FontWeight','bold');
set(gca, 'FontName', 'Abel', 'FontSize', 14)
set(gca,'linewidth',1.5)
leg = legend(p2,'\mu_{Flow}','Location', 'Northeast');
set(leg,'Interpreter','tex')
legend boxoff
leg.FontSize = 16;
pbaspect([1.5 1 1])
subplot(2,1,2)
temp = [zeros(1,39) ones(1,39)];
plot(X1,temp,'Color',colors{9},'LineWidth',3)
title('Behavior')
ylim([-1 2])
xlabel('Time (s)','FontWeight','bold','FontSize',14);
yticks([0 1])
yticklabels({'STILL','RUNNING'})
set(gca, 'FontName', 'Abel', 'FontSize', 14)
set(gca,'linewidth',1.5)
leg = legend('Behavior','Location', 'Northeast');
set(leg,'Interpreter','tex')
legend boxoff
leg.FontSize = 16;
pbaspect([1.5 1 1])
sgtitle('Average traces of puff-induced locomotion: First Order Lumen')




X2 = linspace(-5,5,41);
basal_penetratorCalcium = basal_penetratorCalcium_Full(:,19:59)';
basal_firstOrderCalcium = basal_firstOrderCalcium_Full(:,19:59)';
basal_penetratorLumen = basal_penetratorLumen_Full(:,19:59)';
basal_firstOrderLumen = basal_firstOrderLumen_Full(:,19:59)';
stim_penetratorCalcium = stim_penetratorCalcium_Full(:,19:59)';
stim_firstOrderCalcium = stim_firstOrderCalcium_Full(:,19:59)';
stim_penetratorLumen = stim_penetratorLumen_Full(:,19:59)';
stim_firstOrderLumen = stim_firstOrderLumen_Full(:,19:59)';

U_basal = {mean(basal_penetratorCalcium,2),mean(basal_firstOrderCalcium,2),...
    mean(basal_penetratorLumen,2),mean(basal_firstOrderLumen,2)};
SEM_basal = {std(basal_penetratorCalcium,0,2)./sqrt(size(basal_penetratorCalcium,2)),...
    std(basal_firstOrderCalcium,0,2)./sqrt(size(basal_firstOrderCalcium,2)),...
    std(basal_penetratorLumen,0,2)./sqrt(size(basal_penetratorLumen,2)),...
    std(basal_firstOrderLumen,0,2)./sqrt(size(basal_firstOrderLumen,2))};
 
U_stim = {mean(stim_penetratorCalcium,2),mean(stim_firstOrderCalcium,2),...
    mean(stim_penetratorLumen,2),mean(stim_firstOrderLumen,2)};
SEM_stim = {std(stim_penetratorCalcium,0,2)./sqrt(size(stim_penetratorCalcium,2)),...
    std(stim_firstOrderCalcium,0,2)./sqrt(size(stim_firstOrderCalcium,2)),...
    std(stim_penetratorLumen,0,2)./sqrt(size(stim_penetratorLumen,2)),...
    std(stim_firstOrderLumen,0,2)./sqrt(size(stim_firstOrderLumen,2))};

U_basal{1,1}(21:23) = [NaN NaN NaN]; U_basal{1,2}(21:23) = [NaN NaN NaN]; U_basal{1,3}(21:23) = [NaN NaN NaN]; U_basal{1,4}(21:23) = [NaN NaN NaN];
U_stim{1,1}(21:23) = [NaN NaN NaN]; U_stim{1,2}(21:23) = [NaN NaN NaN]; U_stim{1,3}(21:23) = [NaN NaN NaN]; U_stim{1,4}(21:23) = [NaN NaN NaN];

f9 = figure;
line([0 0],[0.75 1.05],'LineWidth',3,'Color',colors{9}); hold on;
A(1) = shadedErrorBar(X2,U_basal{1},SEM_basal{1},'lineprops',{'Color',colors{8},'LineWidth',2,'LineJoin','round'},'transparent',1,'patchSaturation',0.1);
A(2) = shadedErrorBar(X2,U_stim{1},SEM_stim{1},'lineprops',{'Color',colors{7},'LineWidth',1,'LineJoin','round'},'transparent',1,'patchSaturation',0.1);
hold off;
title('Voluntary vs Puff-induced Locomotion: Penetrator Ca2+')
leg = legend([A(1).mainLine, A(2).mainLine],...
    ['\mu' '_{Penetrator Ca2+_{Voluntary}}'], ['\mu' '_{Penetrator Ca2+_{Puff-induced}}'],...
    'Location', 'Southeast');
ylabel('\DeltaF/F','FontWeight','bold');
xlim([-5 5])
ylim([0.75 1.05])
xlabel('Time (s)','FontWeight','bold','FontSize',14);
set(leg,'Interpreter','tex')
set(gca, 'FontName', 'Abel', 'FontSize', 14)
set(gca,'linewidth',1.5)
legend boxoff
leg.FontSize = 18;
pbaspect([1.5 1 1])


f10 = figure;
line([0 0],[0.75 1.05],'LineWidth',3,'Color',colors{9}); hold on;
B(1) = shadedErrorBar(X2,U_basal{2},SEM_basal{2},'lineprops',{'Color',colors{8},'LineWidth',2,'LineJoin','round'},'transparent',1,'patchSaturation',0.1);
B(2) = shadedErrorBar(X2,U_stim{2},SEM_stim{2},'lineprops',{'Color',colors{7},'LineWidth',1,'LineJoin','round'},'transparent',1,'patchSaturation',0.1);
hold off;
title('Voluntary vs Puff-induced Locomotion: First-Order Ca2+')
leg = legend([B(1).mainLine, B(2).mainLine],...
    ['\mu' '_{First-Order Ca2+_{Voluntary}}'], ['\mu' '_{First-Order Ca2+_{Puff-induced}}'],...
    'Location', 'Southeast');
ylabel('\DeltaF/F','FontWeight','bold');
xlim([-5 5])
ylim([0.75 1.05])
xlabel('Time (s)','FontWeight','bold','FontSize',14);
set(leg,'Interpreter','tex')
set(gca, 'FontName', 'Abel', 'FontSize', 14)
set(gca,'linewidth',1.5)
legend boxoff
leg.FontSize = 18;
pbaspect([1.5 1 1])

f11 = figure;
line([0 0],[0.94 1.12],'LineWidth',3,'Color',colors{9}); hold on;
C(1) = shadedErrorBar(X2,U_basal{3},SEM_basal{3},'lineprops',{'Color',colors{2},'LineWidth',2,'LineJoin','round'},'transparent',1,'patchSaturation',0.1);
C(2) = shadedErrorBar(X2,U_stim{3},SEM_stim{3},'lineprops',{'Color',colors{1},'LineWidth',1,'LineJoin','round'},'transparent',1,'patchSaturation',0.1);
hold off;
title('Voluntary vs Puff-induced Locomotion: Penetrator Lumen')
leg = legend([C(1).mainLine, C(2).mainLine],...
    ['\mu' '_{Penetrator Lumen_{Voluntary}}'], ['\mu' '_{Penetrator Lumen_{Puff-induced}}'],...
    'Location', 'Southeast');
ylabel('\DeltaF/F','FontWeight','bold');
xlim([-5 5])
ylim([0.94 1.12])
xlabel('Time (s)','FontWeight','bold','FontSize',14);
set(leg,'Interpreter','tex')
set(gca, 'FontName', 'Abel', 'FontSize', 14)
set(gca,'linewidth',1.5)
legend boxoff
leg.FontSize = 18;
pbaspect([1.5 1 1])


f12 = figure;
line([0 0],[0.94 1.12],'LineWidth',3,'Color',colors{9}); hold on;
D(1) = shadedErrorBar(X2,U_basal{4},SEM_basal{4},'lineprops',{'Color',colors{2},'LineWidth',2,'LineJoin','round'},'transparent',1,'patchSaturation',0.1);
D(2) = shadedErrorBar(X2,U_stim{4},SEM_stim{4},'lineprops',{'Color',colors{1},'LineWidth',1,'LineJoin','round'},'transparent',1,'patchSaturation',0.1);
hold off;
title('Voluntary vs Puff-induced Locomotion: First-Order Lumen')
leg = legend([D(1).mainLine, D(2).mainLine],...
    ['\mu' '_{First-Order Lumen_{Voluntary}}'], ['\mu' '_{First-Order Lumen_{Puff-induced}}'],...
    'Location', 'Southeast');
ylabel('\DeltaF/F','FontWeight','bold');
xlim([-5 5])
ylim([0.94 1.12])
xlabel('Time (s)','FontWeight','bold','FontSize',14);
set(leg,'Interpreter','tex')
set(gca, 'FontName', 'Abel', 'FontSize', 14)
set(gca,'linewidth',1.5)
legend boxoff
leg.FontSize = 18;
pbaspect([1.5 1 1])

