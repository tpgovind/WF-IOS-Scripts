%% WF

clc
clear all
close all
load('F:\ANALYZED_DATA\MAT Files\Behavioral State\WF_Murals_ActographData.mat')
lims = [0 3];

% Sort by largest behavioral response during stimulation
Naive_Data = actograph_Naive_Data; sort_Naive_Data = sum(Naive_Data(:,31:59),2); %31:59
PreC21_Data = actograph_PreC21_Data; sort_PreC21_Data = sum(PreC21_Data(:,31:59),2);
PostC21_Data = actograph_PostC21_Data; sort_PostC21_Data = sum(PostC21_Data(:,31:59),2);
Naive_Data = [sort_Naive_Data Naive_Data]; Naive_Data = sortrows(Naive_Data,'descend');
PreC21_Data = [sort_PreC21_Data PreC21_Data]; PreC21_Data = sortrows(PreC21_Data,'descend');
PostC21_Data = [sort_PostC21_Data PostC21_Data]; PostC21_Data = sortrows(PostC21_Data,'descend');
Naive_Data = Naive_Data(:,2:151);
PreC21_Data = PreC21_Data(:,2:151);
PostC21_Data = PostC21_Data(:,2:151);

% GENERATE ACTIVITY HEATMAPS

% Naive: All
f1 = figure(); f1.WindowState = 'Maximized';
imagesc(Naive_Data,lims)
colormap(cividis); cb = colorbar;
set(gca, 'FontName', 'Abel', 'FontSize', 14)
set(gca,'linewidth',1.5)
title('All','FontName', 'Abel', 'FontSize', 16,'FontWeight','bold')
xlabel('Time (s)','FontName', 'Abel', 'FontSize', 14,'FontWeight','bold');
ylabel('Trials (Sorted by Activity Level)','FontName', 'Abel', 'FontSize', 14,'FontWeight','bold');
ylabel(cb,'Activity Level','FontName', 'Abel', 'FontSize', 14,'FontWeight','bold');
pbaspect([1.5 1 1])

% Naive: Runners
f2 = figure();  f2.WindowState = 'Maximized';
imagesc(Naive_Data(1:60,:),lims)
colormap(cividis); cb = colorbar;
set(gca, 'FontName', 'Abel', 'FontSize', 14)
set(gca,'linewidth',1.5)
title('High Activity','FontName', 'Abel', 'FontSize', 16,'FontWeight','bold')
xlabel('Time (s)','FontName', 'Abel', 'FontSize', 14,'FontWeight','bold');
ylabel('Trials (Sorted by Activity Level)','FontName', 'Abel', 'FontSize', 14,'FontWeight','bold');
ylabel(cb,'Activity Level','FontName', 'Abel', 'FontSize', 14,'FontWeight','bold');
pbaspect([1.5 1 1])


% Naive: Middles
f3 = figure();  f3.WindowState = 'Maximized';
imagesc(Naive_Data(77:136,:),lims)
colormap(cividis); cb = colorbar;
set(gca, 'FontName', 'Abel', 'FontSize', 14)
set(gca,'linewidth',1.5)
title('Medium Activity','FontName', 'Abel', 'FontSize', 16,'FontWeight','bold')
xlabel('Time (s)','FontName', 'Abel', 'FontSize', 14,'FontWeight','bold');
ylabel('Trials (Sorted by Activity Level)','FontName', 'Abel', 'FontSize', 14,'FontWeight','bold');
ylabel(cb,'Activity Level','FontName', 'Abel', 'FontSize', 14,'FontWeight','bold');
pbaspect([1.5 1 1])


% Naive: Sedentaries
f4 = figure(); f4.WindowState = 'Maximized';
imagesc(Naive_Data(155:214,:),lims)
colormap(cividis); cb = colorbar;
set(gca, 'FontName', 'Abel', 'FontSize', 14)
set(gca,'linewidth',1.5)
title('Low Activity','FontName', 'Abel', 'FontSize', 16,'FontWeight','bold')
xlabel('Time (s)','FontName', 'Abel', 'FontSize', 14,'FontWeight','bold');
ylabel('Trials (Sorted by Activity Level)','FontName', 'Abel', 'FontSize', 14,'FontWeight','bold');
ylabel(cb,'Activity Level','FontName', 'Abel', 'FontSize', 14,'FontWeight','bold');
pbaspect([1.5 1 1])


% ALSO PLOT ACTIVITY COMPARISON TRACES (WF)


highHbO = HbO_ActivitySorted_High2Low(:,1:60); lowHbO = HbO_ActivitySorted_High2Low(:,155:214);
[~,~,~] = graphWFTrialTraces_modified_behComparison(highHbO,lowHbO,1,2,...
'Activity Comparison: HbO','Time(s)','Normalized \Deltac[Hb]');

highHbR = HbR_ActivitySorted_High2Low(:,1:60); lowHbR = HbR_ActivitySorted_High2Low(:,155:214);
[~,~,~] = graphWFTrialTraces_modified_behComparison(highHbR,lowHbR,3,4,...
'Activity Comparison: HbR','Time(s)','Normalized \Deltac[Hb]');

for i = 1:size(highHbO,2)
     highHbO(:,i) = highHbO(:,i) - mean(highHbO(1:300,i));
     highHbR(:,i) = highHbR(:,i) - mean(highHbR(1:300,i));
end

for i = 1:size(lowHbO,2)
     lowHbO(:,i) = lowHbO(:,i) - mean(lowHbO(1:300,i));
     lowHbR(:,i) = lowHbR(:,i) - mean(lowHbR(1:300,i));
end

U_HbO = {mean(highHbO(305:600,:),1)',mean(lowHbO(305:600,:),1)'};
U_HbR = {mean(highHbR(305:600,:),1)',mean(lowHbR(305:600,:),1)'};

% input('')
% saveas(f1,'F:\ANALYZED_DATA\FIGURES\FINAL\FIGURE 2 (Behavioral-state dependence of vascular signals)\Actograms and Activity Level Comparisons\BehavioralDependence_Actograms_WF_All.svg');
% saveas(f2,'F:\ANALYZED_DATA\FIGURES\FINAL\FIGURE 2 (Behavioral-state dependence of vascular signals)\Actograms and Activity Level Comparisons\BehavioralDependence_Actograms_WF_High.svg');
% saveas(f3,'F:\ANALYZED_DATA\FIGURES\FINAL\FIGURE 2 (Behavioral-state dependence of vascular signals)\Actograms and Activity Level Comparisons\BehavioralDependence_Actograms_WF_Medium.svg');
% saveas(f4,'F:\ANALYZED_DATA\FIGURES\FINAL\FIGURE 2 (Behavioral-state dependence of vascular signals)\Actograms and Activity Level Comparisons\BehavioralDependence_Actograms_WF_Low.svg');
% saveas(gcf,'F:\ANALYZED_DATA\FIGURES\FINAL\FIGURE 2 (Behavioral-state dependence of vascular signals)\Actograms and Activity Level Comparisons\BehavioralDependence_Actograms_ActivityComparison_WF_HbO.svg');
% saveas(gcf,'F:\ANALYZED_DATA\FIGURES\FINAL\FIGURE 2 (Behavioral-state dependence of vascular signals)\Actograms and Activity Level Comparisons\BehavioralDependence_Actograms_ActivityComparison_WF_HbR.svg');


%% 2P

clc
clear all
close all
load('F:\ANALYZED_DATA\MAT Files\Behavioral State\TwoPhoton_Murals_ActographData.mat')
lims = [0 4];

% Sort by largest behavioral response during stimulation
Naive_Data = actograph_Naive_Data; sort_Naive_Data = sum(Naive_Data(:,31:59),2);
Naive_Data = [sort_Naive_Data Naive_Data]; Naive_Data = sortrows(Naive_Data,'descend');
Naive_Data = Naive_Data(:,2:151);

% GENERATE ACTIVITY HEATMAPS

% Naive: All
f1 = figure(); f1.WindowState = 'Maximized';
imagesc(Naive_Data,lims)
colormap(cividis); cb = colorbar;
set(gca, 'FontName', 'Abel', 'FontSize', 14)
set(gca,'linewidth',1.5)
title('All','FontName', 'Abel', 'FontSize', 16,'FontWeight','bold')
xlabel('Time (s)','FontName', 'Abel', 'FontSize', 14,'FontWeight','bold');
ylabel('Trials (Sorted by Activity Level)','FontName', 'Abel', 'FontSize', 14,'FontWeight','bold');
ylabel(cb,'Activity Level','FontName', 'Abel', 'FontSize', 14,'FontWeight','bold');
pbaspect([1.5 1 1])

% Naive: Runners
f2 = figure(); f2.WindowState = 'Maximized';
imagesc(Naive_Data(1:40,:),lims)
colormap(cividis); cb = colorbar;
set(gca, 'FontName', 'Abel', 'FontSize', 14)
set(gca,'linewidth',1.5)
title('High Activity','FontName', 'Abel', 'FontSize', 16,'FontWeight','bold')
xlabel('Time (s)','FontName', 'Abel', 'FontSize', 14,'FontWeight','bold');
ylabel('Trials (Sorted by Activity Level)','FontName', 'Abel', 'FontSize', 14,'FontWeight','bold');
ylabel(cb,'Activity Level','FontName', 'Abel', 'FontSize', 14,'FontWeight','bold');
pbaspect([1.5 1 1])

% Naive: Middles
f3 = figure(); f3.WindowState = 'Maximized';
imagesc(Naive_Data(47:86,:),lims)
colormap(cividis); cb = colorbar;
set(gca, 'FontName', 'Abel', 'FontSize', 14)
set(gca,'linewidth',1.5)
title('Medium Activity','FontName', 'Abel', 'FontSize', 16,'FontWeight','bold')
xlabel('Time (s)','FontName', 'Abel', 'FontSize', 14,'FontWeight','bold');
ylabel('Trials (Sorted by Activity Level)','FontName', 'Abel', 'FontSize', 14,'FontWeight','bold');
ylabel(cb,'Activity Level','FontName', 'Abel', 'FontSize', 14,'FontWeight','bold');
pbaspect([1.5 1 1])

% Naive: Sedentaries
f4 = figure(); f4.WindowState = 'Maximized';
imagesc(Naive_Data(92:131,:),lims)
colormap(cividis); cb = colorbar;
set(gca, 'FontName', 'Abel', 'FontSize', 14)
set(gca,'linewidth',1.5)
title('Low Activity','FontName', 'Abel', 'FontSize', 16,'FontWeight','bold')
xlabel('Time (s)','FontName', 'Abel', 'FontSize', 14,'FontWeight','bold');
ylabel('Trials (Sorted by Activity Level)','FontName', 'Abel', 'FontSize', 14,'FontWeight','bold');
ylabel(cb,'Activity Level','FontName', 'Abel', 'FontSize', 14,'FontWeight','bold');
pbaspect([1.5 1 1])

PenetratorCalcium_HighActivity = TwoPhoton_Murals_penetrator_Calcium_Sorted(:,1:40);
PenetratorCalcium_LowActivity = TwoPhoton_Murals_penetrator_Calcium_Sorted(:,92:131);
PenetratorFlow_HighActivity = TwoPhoton_Murals_penetrator_Lumen_Sorted(:,1:40);
PenetratorFlow_LowActivity = TwoPhoton_Murals_penetrator_Lumen_Sorted(:,92:131);

FirstOrderCalcium_HighActivity = TwoPhoton_Murals_firstOrder_Calcium_Sorted(:,1:33);
FirstOrderCalcium_LowActivity = TwoPhoton_Murals_firstOrder_Calcium_Sorted(:,78:110);
FirstOrderFlow_HighActivity = TwoPhoton_Murals_firstOrder_Lumen_Sorted(:,1:33);
FirstOrderFlow_LowActivity = TwoPhoton_Murals_firstOrder_Lumen_Sorted(:,78:110);

[~,~,~] = graph2PTrialTraces_modified_behComparison(PenetratorCalcium_HighActivity,...
    PenetratorCalcium_LowActivity,7,8,...
    'Activity Comparison: Penetrator Calcium','Time(s)','\Delta F/F');

[~,~,~] = graph2PTrialTraces_modified_behComparison(PenetratorFlow_HighActivity,...
    PenetratorFlow_LowActivity,1,2,...
    'Activity Comparison: Penetrator Flow','Time(s)','\Delta F/F');

[~,~,~] = graph2PTrialTraces_modified_behComparison(FirstOrderCalcium_HighActivity,...
    FirstOrderCalcium_LowActivity,7,8,...
    'Activity Comparison: First Order Calcium','Time(s)','\Delta F/F');

[~,~,~] = graph2PTrialTraces_modified_behComparison(FirstOrderFlow_HighActivity,...
    FirstOrderFlow_LowActivity,1,2,...
    'Activity Comparison: First Order Flow','Time(s)','\Delta F/F');


for i = 1:size(PenetratorCalcium_HighActivity,2)
     PenetratorCalcium_HighActivity(:,i) = PenetratorCalcium_HighActivity(:,i) ./ abs(mean(PenetratorCalcium_HighActivity(1:116,i)));
     PenetratorFlow_HighActivity(:,i) = PenetratorFlow_HighActivity(:,i) ./ abs(mean(PenetratorFlow_HighActivity(1:116,i)));
end

for i = 1:size(PenetratorCalcium_LowActivity,2)
     PenetratorCalcium_LowActivity(:,i) = PenetratorCalcium_LowActivity(:,i) ./ abs(mean(PenetratorCalcium_LowActivity(1:116,i)));
     PenetratorFlow_LowActivity(:,i) = PenetratorFlow_LowActivity(:,i) ./ abs(mean(PenetratorFlow_LowActivity(1:116,i)));
end

for i = 1:size(FirstOrderCalcium_HighActivity,2)
     FirstOrderCalcium_HighActivity(:,i) = FirstOrderCalcium_HighActivity(:,i) ./ abs(mean(FirstOrderCalcium_HighActivity(1:116,i)));
     FirstOrderFlow_HighActivity(:,i) = FirstOrderFlow_HighActivity(:,i) ./ abs(mean(FirstOrderFlow_HighActivity(1:116,i)));
end

for i = 1:size(FirstOrderCalcium_LowActivity,2)
     FirstOrderCalcium_LowActivity(:,i) = FirstOrderCalcium_LowActivity(:,i) ./ abs(mean(FirstOrderCalcium_LowActivity(1:116,i)));
     FirstOrderFlow_LowActivity(:,i) = FirstOrderFlow_LowActivity(:,i) ./ abs(mean(FirstOrderFlow_LowActivity(1:116,i)));
end

U_PenetratorCalcium = {mean(PenetratorCalcium_HighActivity(120:234,:),1)',mean(PenetratorCalcium_LowActivity(120:234,:),1)'};
U_PenetratorFlow = {mean(PenetratorFlow_HighActivity(120:234,:),1)',mean(PenetratorFlow_LowActivity(120:234,:),1)'};

U_FirstOrderCalcium = {mean(FirstOrderCalcium_HighActivity(120:234,:),1)',mean(FirstOrderCalcium_LowActivity(120:234,:),1)'};
U_FirstOrderFlow = {mean(FirstOrderFlow_HighActivity(120:234,:),1)',mean(FirstOrderFlow_LowActivity(120:234,:),1)'};


% input('')
% saveas(f1,'F:\ANALYZED_DATA\FIGURES\FINAL\FIGURE 2 (Behavioral-state dependence of vascular signals)\Actograms and Activity Level Comparisons\BehavioralDependence_Actograms_2P_All.svg');
% saveas(f2,'F:\ANALYZED_DATA\FIGURES\FINAL\FIGURE 2 (Behavioral-state dependence of vascular signals)\Actograms and Activity Level Comparisons\BehavioralDependence_Actograms_2P_High.svg');
% saveas(f3,'F:\ANALYZED_DATA\FIGURES\FINAL\FIGURE 2 (Behavioral-state dependence of vascular signals)\Actograms and Activity Level Comparisons\BehavioralDependence_Actograms_2P_Medium.svg');
% saveas(f4,'F:\ANALYZED_DATA\FIGURES\FINAL\FIGURE 2 (Behavioral-state dependence of vascular signals)\Actograms and Activity Level Comparisons\BehavioralDependence_Actograms_2P_Low.svg');
% saveas(gcf,'F:\ANALYZED_DATA\FIGURES\FINAL\FIGURE 2 (Behavioral-state dependence of vascular signals)\Actograms and Activity Level Comparisons\BehavioralDependence_Actograms_ActivityComparison_2P_PenetratorCalcium.svg');
% saveas(gcf,'F:\ANALYZED_DATA\FIGURES\FINAL\FIGURE 2 (Behavioral-state dependence of vascular signals)\Actograms and Activity Level Comparisons\BehavioralDependence_Actograms_ActivityComparison_2P_PenetratorFlow.svg');
% saveas(gcf,'F:\ANALYZED_DATA\FIGURES\FINAL\FIGURE 2 (Behavioral-state dependence of vascular signals)\Actograms and Activity Level Comparisons\BehavioralDependence_Actograms_ActivityComparison_2P_FirstOrderCalcium.svg');
% saveas(gcf,'F:\ANALYZED_DATA\FIGURES\FINAL\FIGURE 2 (Behavioral-state dependence of vascular signals)\Actograms and Activity Level Comparisons\BehavioralDependence_Actograms_ActivityComparison_2P_FirstOrderFlow.svg');


%% C21

%PreC21_Data = orderedArray(randperm(size(PreC21_Data,1)),:);
% C21: Pre
figure();
imagesc(PreC21_Data,lims)
colormap(cividis); cb = colorbar;
set(gca, 'FontName', 'Abel', 'FontSize', 14)
set(gca,'linewidth',1.5)
title('PRE-C21','FontName', 'Abel', 'FontSize', 16,'FontWeight','bold')
xlabel('Time (s)','FontName', 'Abel', 'FontSize', 14,'FontWeight','bold');
ylabel('Trials (Sorted by Activity Level)','FontName', 'Abel', 'FontSize', 14,'FontWeight','bold');
ylabel(cb,'Activity Level','FontName', 'Abel', 'FontSize', 14,'FontWeight','bold');
pbaspect([1.5 1 1])

%PostC21_Data = orderedArray(randperm(size(PostC21_Data,1)),:);
% C21: Post
figure();
imagesc(PostC21_Data,lims)
colormap(cividis); cb = colorbar;
set(gca, 'FontName', 'Abel', 'FontSize', 14)
set(gca,'linewidth',1.5)
title('POST-C21','FontName', 'Abel', 'FontSize', 16,'FontWeight','bold')
xlabel('Time (s)','FontName', 'Abel', 'FontSize', 14,'FontWeight','bold');
ylabel('Trials (Sorted by Activity Level)','FontName', 'Abel', 'FontSize', 14,'FontWeight','bold');
ylabel(cb,'Activity Level','FontName', 'Abel', 'FontSize', 14,'FontWeight','bold');
pbaspect([1.5 1 1])
