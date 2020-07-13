clc
clear all
%close all

mode = 'Basal'; variable = 'HbO_vs_HbR'; xLims = [-25 25];
colors = {[197/255 0 48/255],[1 159/255 184/255],...
    [0 137/255 192/255],[183/255 235/255 1],...
    [0 0 0],[85/255 85/255 85/255],...
    [0 165/255 104/255],[147/255 1 215/255],...
    [1 212/255 0],[1 247/255 204/255]}; %Red, Blue, Black, Green, Yellow

if (strcmp(mode,'Trial'))
    load('F:\ANALYZED_DATA\MAT Files\WF\Cross-correlation\WF_Trials.mat')
else
    load('F:\ANALYZED_DATA\MAT Files\WF\Cross-correlation\WF_Basals.mat')
end

if(strcmp(variable,'HbO_vs_Behavior'))
    
    c = zeros(3599,size(HbO,2)); lags = zeros(size(HbO,2),3599);
    for i = 1:size(HbO,2)
        [c(:,i),lags(i,:)] = xcorr(HbO(:,i),Behavior(:,i),'normalized');
    end
    
    X = mean(lags/10,1);
    U = mean(c,2);
    SEM = std(c,0,2)./sqrt(size(c,2));
    H = shadedErrorBar(mean(lags/10,1),U,SEM,'lineprops',{'Color',colors{1},'LineWidth',2,'LineJoin','round'},'transparent',1,'patchSaturation',0.25);
    xlim(xLims)
    title('HbO-Behavior correlation'); xlabel('Lag (s)'); ylabel('Correlation');
    set(gca, 'FontName', 'Abel', 'FontSize', 14)
    set(gca,'linewidth',1.5)
    fig.WindowState = 'maximized';
    grid off
    pbaspect([1.5 1 1])
    
    res = array2table([X' U]); res.Properties.VariableNames = {'Lag_seconds','Correlation_r2'};
	[~,maxidx] = max(abs(res.Correlation_r2));
    disp('Lag with maximum correlation:')
	res(maxidx,:)
    
elseif(strcmp(variable,'HbR_vs_Behavior'))
    
    c = zeros(3599,size(HbO,2)); lags = zeros(size(HbO,2),3599);
    for i = 1:size(HbO,2)
        [c(:,i),lags(i,:)] = xcorr(HbR(:,i),Behavior(:,i),'normalized');
    end
    
    X = mean(lags/10,1);
    U = mean(c,2);
    SEM = std(c,0,2)./sqrt(size(c,2));
    H = shadedErrorBar(mean(lags/10,1),U,SEM,'lineprops',{'Color',colors{3},'LineWidth',2,'LineJoin','round'},'transparent',1,'patchSaturation',0.25);
    xlim(xLims)
    title('HbR-Behavior correlation'); xlabel('Lag (s)'); ylabel('Correlation');
    set(gca, 'FontName', 'Abel', 'FontSize', 14)
    set(gca,'linewidth',1.5)
    fig.WindowState = 'maximized';
    grid off
    pbaspect([1.5 1 1])
    
    res = array2table([X' U]); res.Properties.VariableNames = {'Lag_seconds','Correlation_r2'};
	[~,maxidx] = max(abs(res.Correlation_r2));
    disp('Lag with maximum correlation:')
	res(maxidx,:)
    
elseif(strcmp(variable,'HbO_vs_HbR'))
    
    c = zeros(3599,size(HbO,2)); lags = zeros(size(HbO,2),3599);
    for i = 1:size(HbO,2)
        [c(:,i),lags(i,:)] = xcorr(HbO(:,i),HbR(:,i),'normalized');
    end
    
    X = mean(lags/10,1);
    U = mean(c,2);
    SEM = std(c,0,2)./sqrt(size(c,2));
    H = shadedErrorBar(mean(lags/10,1),U,SEM,'lineprops',{'Color',colors{5},'LineWidth',2,'LineJoin','round'},'transparent',1,'patchSaturation',0.25);
    xlim(xLims)
    title('HbO-HbR correlation'); xlabel('Lag (s)'); ylabel('Correlation');
    set(gca, 'FontName', 'Abel', 'FontSize', 14)
    set(gca,'linewidth',1.5)
    fig.WindowState = 'maximized';
    grid off
    pbaspect([1.5 1 1])
    
    res = array2table([X' U]); res.Properties.VariableNames = {'Lag_seconds','Correlation_r2'};
	[~,maxidx] = max(abs(res.Correlation_r2));
    disp('Lag with maximum correlation:')
	res(maxidx,:)
end
