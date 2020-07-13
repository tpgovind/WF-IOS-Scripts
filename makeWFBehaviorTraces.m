clc
clear all
close all

load('F:\ANALYZED_DATA\MAT Files\Behavioral State\WF_Basal_Bouts.mat')
colors = {[197/255 0 48/255],[1 159/255 184/255],...
    [0 137/255 192/255],[183/255 235/255 1],...
    [0 0 0],[190/255 190/255 190/255],...
    [0 165/255 104/255],[147/255 1 215/255],...
    [1 212/255 0],[1 247/255 204/255]}; %HbOx2, HbRx2, HbTx2, GCaMPx2, Stimx2
fields = fieldnames(bouts_specs);

HbO_Full = zeros(1,774); HbR_Full = zeros(1,774);
for i = 1:size(fields,1)
HbO_Full = padconcat(HbO_Full,(bouts_specs(5).(fields{i}))',1);
HbR_Full = padconcat(HbR_Full,(bouts_specs(6).(fields{i}))',1);
end
HbO_Full(1,:) = []; HbR_Full(1,:) = [];
 
% Plot HbO (Bouts)
f1 = figure; f1.WindowState = 'Maximized';
temp = HbO_Full'; temp = temp(1:300,:);
subplot(2,1,1)
p1 = plot((1:300)/10,temp,'Color',colors{6});
hold on; p2 = plot((1:300)/10,nanmean(HbO_Full(:,1:300)),'Color',colors{1},'LineWidth',3);
title('HbO')
xlabel('Time (s)','FontWeight','bold','FontSize',14);
ylabel('\Deltac[Hb] in \muM','FontWeight','bold');
ylim([-50 150])
set(gca, 'FontName', 'Abel', 'FontSize', 14)
set(gca,'linewidth',1.5)
leg = legend(p2,'\mu_{HbO}','Location', 'Northeast');
set(leg,'Interpreter','tex')
legend boxoff
leg.FontSize = 16;
pbaspect([1.5 1 1])
subplot(2,1,2)
temp = [zeros(1,100) ones(1,200)];
plot((1:300)/10,temp,'Color',colors{9},'LineWidth',3)
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
sgtitle('Average traces of voluntary locomotion: HbO')

% Plot HbR (Bouts)
f2 = figure; f2.WindowState = 'Maximized';
temp = HbR_Full'; temp = temp(1:300,:);
subplot(2,1,1)
p1 = plot((1:300)/10,temp,'Color',colors{6});
hold on; p2 = plot((1:300)/10,nanmean(HbR_Full(:,1:300)),'Color',colors{3},'LineWidth',3);
title('HbR')
xlabel('Time (s)','FontWeight','bold','FontSize',14);
ylabel('\Deltac[Hb] in \muM','FontWeight','bold');
ylim([-40 30])
set(gca, 'FontName', 'Abel', 'FontSize', 14)
set(gca,'linewidth',1.5)
leg = legend(p2, '\mu_{HbR}','Location', 'Northeast');
set(leg,'Interpreter','tex')
legend boxoff
leg.FontSize = 16;
pbaspect([1.5 1 1])
subplot(2,1,2)
temp = [zeros(1,100) ones(1,200)];
plot((1:300)/10,temp,'Color',colors{9},'LineWidth',3)
title('Behavior')
xlabel('Time (s)','FontWeight','bold','FontSize',14);
yticks([0 1])
yticklabels({'STILL','RUNNING'})
set(gca, 'FontName', 'Abel', 'FontSize', 14)
set(gca,'linewidth',1.5)
leg.FontSize = 16;
pbaspect([1.5 1 1])
ylim([-1 2])
leg = legend('Behavior','Location', 'Northeast');
set(leg,'Interpreter','tex')
legend boxoff
sgtitle('Average traces of voluntary locomotion: HbR')

U_Basal_Bouts = {U{1,1},U{1,2},U{1,3}}; U_Basal_Bouts{1,1}(52:57) = [NaN NaN NaN NaN NaN NaN]; 
U_Basal_Bouts{1,2}(52:57) = [NaN NaN NaN NaN NaN NaN]; U_Basal_Bouts{1,3}(52:57) = [NaN NaN NaN NaN NaN NaN];
SEM_Basal_Bouts = SEM; SEM_Basal_Bouts{1,1}(52:57) = [NaN NaN NaN NaN NaN NaN]; 
SEM_Basal_Bouts{1,2}(52:57) = [NaN NaN NaN NaN NaN NaN]; SEM_Basal_Bouts{1,3}(52:57) = [NaN NaN NaN NaN NaN NaN];

clearvars -except timeVector U_Basal_Bouts SEM_Basal_Bouts colors f1 f2 f3 f4 f5 f6 f7 f8 f9


load('F:\ANALYZED_DATA\MAT Files\Behavioral State\WF_Trial_Bouts.mat')
fields = fieldnames(bouts_specs);

HbO_Full = zeros(1,774); HbR_Full = zeros(1,774);
for i = 1:size(fields,1)
HbO_Full = padconcat(HbO_Full,(bouts_specs(5).(fields{i}))',1);
HbR_Full = padconcat(HbR_Full,(bouts_specs(6).(fields{i}))',1);
end
HbO_Full(1,:) = []; HbR_Full(1,:) = [];
HbO_Full = HbO_Full; HbR_Full = HbR_Full;

% Plot HbO (Bouts)
f3 = figure; f3.WindowState = 'Maximized';
temp = HbO_Full'; temp = temp(1:300,:);
subplot(2,1,1)
p1 = plot((1:300)/10,temp,'Color',colors{6});
hold on; p2 = plot((1:300)/10,nanmean(HbO_Full(:,1:300)),'Color',colors{1},'LineWidth',3);
title('HbO')
xlabel('Time (s)','FontWeight','bold','FontSize',14);
ylabel('\Deltac[Hb] in \muM','FontWeight','bold');
ylim([-50 150])
set(gca, 'FontName', 'Abel', 'FontSize', 14)
set(gca,'linewidth',1.5)
leg = legend(p2, '\mu_{HbO}','Location', 'Northeast');
set(leg,'Interpreter','tex')
legend boxoff
leg.FontSize = 16;
pbaspect([1.5 1 1])
subplot(2,1,2)
temp = [zeros(1,100) ones(1,200)];
plot((1:300)/10,temp,'Color',colors{9},'LineWidth',3)
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
sgtitle('Average traces of puff-induced locomotion: HbO')

% Plot HbR (Bouts)
f4 = figure; f4.WindowState = 'Maximized';
temp = HbR_Full'; temp = temp(1:300,:);
subplot(2,1,1)
p1 = plot((1:300)/10,temp,'Color',colors{6});
hold on; p2 = plot((1:300)/10,nanmean(HbR_Full(:,1:300)),'Color',colors{3},'LineWidth',3);
title('HbR')
xlabel('Time (s)','FontWeight','bold','FontSize',14);
ylabel('\Deltac[Hb] in \muM','FontWeight','bold');
ylim([-40 30])
set(gca, 'FontName', 'Abel', 'FontSize', 14)
set(gca,'linewidth',1.5)
leg = legend(p2, '\mu_{HbR}','Location', 'Northeast');
set(leg,'Interpreter','tex')
legend boxoff
leg.FontSize = 16;
pbaspect([1.5 1 1])
subplot(2,1,2)
temp = [zeros(1,100) ones(1,200)];
plot((1:300)/10,temp,'Color',colors{9},'LineWidth',3)
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
sgtitle('Average traces of puff-induced locomotion: HbR')

U_Trial_Bouts = {U{1,1},U{1,2},U{1,3}}; U_Trial_Bouts{1,1}(52:57) = [NaN NaN NaN NaN NaN NaN]; 
U_Trial_Bouts{1,2}(52:57) = [NaN NaN NaN NaN NaN NaN]; U_Trial_Bouts{1,3}(52:57) = [NaN NaN NaN NaN NaN NaN];
SEM_Trial_Bouts = SEM; SEM_Trial_Bouts{1,1}(52:57) = [NaN NaN NaN NaN NaN NaN]; 
SEM_Trial_Bouts{1,2}(52:57) = [NaN NaN NaN NaN NaN NaN]; SEM_Trial_Bouts{1,3}(52:57) = [NaN NaN NaN NaN NaN NaN];

clearvars -except timeVector U_Basal_Bouts SEM_Basal_Bouts U_Trial_Bouts SEM_Trial_Bouts colors f1 f2 f3 f4 f5 f6 f7 f8 f9

f5 = figure;  f5.WindowState = 'Maximized';
hold on;
A(1) = shadedErrorBar(timeVector/10,U_Basal_Bouts{1},SEM_Basal_Bouts{1},'lineprops',{'Color',colors{2},'LineWidth',2,'LineJoin','round'},'transparent',1,'patchSaturation',0.1);
A(2) = shadedErrorBar(timeVector/10,U_Trial_Bouts{1},SEM_Trial_Bouts{1},'lineprops',{'Color',colors{1},'LineWidth',1,'LineJoin','round'},'transparent',1,'patchSaturation',0.1);
line([0 0],[-10 50],'LineWidth',3,'Color',colors{9}); 
hold off;
title('Voluntary vs Puff-induced Locomotion: HbO')
leg = legend([A(1).mainLine, A(1).patch, A(2).mainLine, A(2).patch],...
    ['\mu' '_{HbO_{Voluntary}}'], ['\pmSEM' '_{HbO_{Voluntary}}'], ['\mu' '_{HbO_{Puff-induced}}'], ['\pmSEM' '_{HbO_{Puff-induced}}'],...
    'Location', 'Northeast');
legend boxoff
leg.FontSize = 18;
ylabel('\Deltac[Hb] in \muM','FontWeight','bold');
xlim([-5 5])
ylim([-10 50])
xlabel('Time (s)','FontWeight','bold','FontSize',14);
set(leg,'Interpreter','tex')
set(gca, 'FontName', 'Abel', 'FontSize', 14)
set(gca,'linewidth',1.5)
pbaspect([1.5 1 1])


f6 = figure;  f6.WindowState = 'Maximized';
hold on;
B(1) = shadedErrorBar(timeVector/10,U_Basal_Bouts{2},SEM_Basal_Bouts{2},'lineprops',{'Color',colors{4},'LineWidth',2,'LineJoin','round'},'transparent',1,'patchSaturation',0.1);
B(2) = shadedErrorBar(timeVector/10,U_Trial_Bouts{2},SEM_Trial_Bouts{2},'lineprops',{'Color',colors{3},'LineWidth',1,'LineJoin','round'},'transparent',1,'patchSaturation',0.1);
line([0 0],[-15 5],'LineWidth',3,'Color',colors{9});
hold off;
title('Voluntary vs Puff-induced Locomotion: HbR')
leg = legend([B(1).mainLine, B(1).patch, B(2).mainLine, B(2).patch],...
    ['\mu' '_{HbR_{Voluntary}}'], ['\pmSEM' '_{HbR_{Voluntary}}'], ['\mu' '_{HbR_{Puff-induced}}'], ['\pmSEM' '_{HbR_{Puff-induced}}'],...
    'Location', 'Northeast');
set(leg,'Interpreter','tex')
legend boxoff
leg.FontSize = 18;
ylabel('\Deltac[Hb] in \muM','FontWeight','bold');
xlim([-5 5])
ylim([-15 5])
%yticks(linspace(-43.7,-43.3,5))
xlabel('Time (s)','FontWeight','bold','FontSize',14);
set(leg,'Interpreter','tex')
set(gca, 'FontName', 'Abel', 'FontSize', 14)
set(gca,'linewidth',1.5)
pbaspect([1.5 1 1])

% saveas(f1,'F:\ANALYZED_DATA\FIGURES v2\FIGURE 2 (Behavioral-state dependence of vascular signals)\BehavioralDependence_LocomotionContext_WF_HbO_Voluntary_Traces.svg')
% saveas(f2,'F:\ANALYZED_DATA\FIGURES v2\FIGURE 2 (Behavioral-state dependence of vascular signals)\BehavioralDependence_LocomotionContext_WF_HbR_Voluntary_Traces.svg')
% saveas(f3,'F:\ANALYZED_DATA\FIGURES v2\FIGURE 2 (Behavioral-state dependence of vascular signals)\BehavioralDependence_LocomotionContext_WF_HbO_PuffInduced_Traces.svg')
% saveas(f4,'F:\ANALYZED_DATA\FIGURES v2\FIGURE 2 (Behavioral-state dependence of vascular signals)\BehavioralDependence_LocomotionContext_WF_HbR_PuffInduced_Traces.svg')
% saveas(f5,'F:\ANALYZED_DATA\FIGURES v2\FIGURE 2 (Behavioral-state dependence of vascular signals)\BehavioralDependence_LocomotionContext_WF_HbO.svg')
% saveas(f6,'F:\ANALYZED_DATA\FIGURES v2\FIGURE 2 (Behavioral-state dependence of vascular signals)\BehavioralDependence_LocomotionContext_WF_HbR.svg')



%% CONTROLS

clc
clear all
close all
load('F:\ANALYZED_DATA\MAT Files\Behavioral State\WF_Basal_Bouts.mat')
colors = {[197/255 0 48/255],[1 159/255 184/255],...
    [0 137/255 192/255],[183/255 235/255 1],...
    [0 0 0],[190/255 190/255 190/255],...
    [0 165/255 104/255],[147/255 1 215/255],...
    [1 212/255 0],[1 247/255 204/255]}; %HbOx2, HbRx2, HbTx2, GCaMPx2, Stimx2
fields = fieldnames(bouts_specs);

Beh_Full = zeros(1,774);
for i = 1:size(fields,1)
Beh_Full = padconcat(Beh_Full,(bouts_specs(7).(fields{i}))',1);
end
Beh_Full(1,:) = []; Behavior_Voluntary_Full = Beh_Full;

clearvars -except Behavior_Voluntary_Full colors
load('F:\ANALYZED_DATA\MAT Files\Behavioral State\WF_Trial_Bouts.mat')
fields = fieldnames(bouts_specs);

Beh_Full = zeros(1,774);
for i = 1:size(fields,1)
Beh_Full = padconcat(Beh_Full,(bouts_specs(7).(fields{i}))',1);
end
Beh_Full(1,:) = []; Behavior_PuffInduced_Full = Beh_Full;

clearvars -except Behavior_Voluntary_Full Behavior_PuffInduced_Full


f1 = figure(1);
hold on;
plot((1:300)/10,Behavior_Voluntary_Full(:,1:300),'Color',[155/255 155/255 155/255]);
plot((1:300)/10,nanmean(Behavior_Voluntary_Full(:,1:300)),'Color',[0 0 0],'LineWidth',3);
hold off;
title('Voluntary')
xlabel('Time (s)','FontWeight','bold','FontSize',14);
ylabel('Activity Level','FontWeight','bold');
set(gca, 'FontName', 'Abel', 'FontSize', 14)
pbaspect([1.5 1 1])

f2 = figure(2);
hold on;
plot((1:300)/10,Behavior_PuffInduced_Full(:,1:300),'Color',[155/255 155/255 155/255]);
plot((1:300)/10,nanmean(Behavior_PuffInduced_Full(:,1:300)),'Color',[0 0 0],'LineWidth',3);
hold off;
title('Puff-Induced')
xlabel('Time (s)','FontWeight','bold','FontSize',14);
ylabel('Activity Level','FontWeight','bold');
set(gca, 'FontName', 'Abel', 'FontSize', 14)
pbaspect([1.5 1 1])

f3 = figure(3);
hold on;

B(1) = shadedErrorBar((-50:50)/10,nanmean(Behavior_Voluntary_Full(:,50:150)),...
    nanstd(Behavior_Voluntary_Full(:,50:150))./sqrt(size(Behavior_Voluntary_Full,1)),...
    'lineprops',{'Color',[155/255 155/255 155/255],'LineWidth',2,'LineJoin','round'},'transparent',1,'patchSaturation',0.1);

B(2) = shadedErrorBar((-50:50)/10,nanmean(Behavior_PuffInduced_Full(:,50:150)),...
    nanstd(Behavior_PuffInduced_Full(:,50:150))./sqrt(size(Behavior_Voluntary_Full,1)),...
    'lineprops',{'Color',[0 0 0],'LineWidth',1,'LineJoin','round'},'transparent',1,'patchSaturation',0.1);

hold off;
title('Voluntary and Puff-Induced')
xlabel('Time (s)','FontWeight','bold','FontSize',14);
ylabel('Activity Level','FontWeight','bold');
set(gca, 'FontName', 'Abel', 'FontSize', 14)
set(gca,'linewidth',1.5)
pbaspect([1.5 1 1])


% f1.WindowState = 'maximized'; saveas(f1,'Behavior_Voluntary.svg');
% f2.WindowState = 'maximized'; saveas(f2,'Behavior_Puff-Induced.svg');
% f3.WindowState = 'maximized'; saveas(f3,'Behavior_Puff-Induced_Vs_Voluntary.svg');


% Calculate taus

thresh_voluntary = (1-1/exp(1))*max(Behavior_Voluntary_Full(:,50:150),[],2);
thresh_puffInduced = (1-1/exp(1))*max(Behavior_PuffInduced_Full(:,50:150),[],2);

for i = 1:size(Behavior_Voluntary_Full,1)
%     disp(int2str(i))
%     figure(1); plot((-50:50)/10,Behavior_Voluntary_Full(i,50:150));
    for j = 50:150
        if ((Behavior_Voluntary_Full(i,j) > thresh_voluntary(i)) && (j>99))
            tau_voluntary(i) = j/10 - 10;
            break
        end
    end
%     disp(tau_voluntary(i))
%     input('')
end

for i = 1:size(Behavior_PuffInduced_Full,1)
    for j = 50:150
        if ((Behavior_PuffInduced_Full(i,j) > thresh_puffInduced(i)) && (j>99))
            tau_puffInduced(i) = j/10 - 10;
            break
        end
    end
end

