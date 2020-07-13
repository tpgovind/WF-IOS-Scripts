function [HbO, HbR, Behavior, f1] = graphWFBasalTraces(indices,fullHbO,fullHbR,fullBehavior)

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
    'M58','M59'}';

colors = {[197/255 0 48/255],[1 159/25 184/255],...
    [0 137/255 192/255],[183/255 235/25 1],...
    [0 0 0],[85/255 85/255 85/255],...
    [0 165/255 104/255],[147/255 1 215/255],...
    [1 212/255 0],[1 247/255 204/255]}; %HbOx2, HbRx2, HbTx2, GCaMPx2, Stimx2

for i = indices
    low = 20*(i-1)+1; high = 20*i;
    partialHbO = fullHbO(:,low:high);
    partialHbR = fullHbR(:,low:high);
    partialBehavior = fullBehavior(:,low:high); 
    HbO = [HbO partialHbO];
    HbR = [HbR partialHbR];
    Behavior = [Behavior partialBehavior];
end

HbO(:,all(ismissing(HbO)))=[]; HbR(:,all(ismissing(HbR)))=[]; Behavior(:,all(ismissing(Behavior)))=[];
exclude = [11 21 22 23 24 25 27 28 33 36 38 40];
for i = exclude
    HbO(:,i) = table(NaN(size(HbO,1),1));
    HbR(:,i) = table(NaN(size(HbR,1),1));
    Behavior(:,i) = table(NaN(size(HbR,1),1));
end
HbO(:,all(ismissing(HbO)))=[]; HbR(:,all(ismissing(HbR)))=[]; Behavior(:,all(ismissing(Behavior)))=[];
names = HbO.Properties.VariableNames;
HbO = table2array(HbO); HbR = table2array(HbR); Behavior = table2array(Behavior);
HbO = HbO(1:1500,:); HbR = HbR(1:1500,:); Behavior = Behavior(1:1500,:);
SF = 100/log(10); % Widefield correction scale factor (due to erroneous coeffs)!
HbO = SF.*HbO; HbR = SF.*HbR;

for i = 1:size(HbO,2)
     
     HbO(:,i) = HbO(:,i) - mean(HbO(:,i));
     HbR(:,i) = HbR(:,i) - mean(HbR(:,i));
     Behavior(:,i) = rescale(Behavior(:,i),0,1.5);
    
end

f1 = figure(1);
Behavior = Behavior';
% sort = randperm(size(Behavior,1))';
% Behavior = [sort Behavior]; Behavior = sortrows(Behavior,'descend');
% Behavior = Behavior(:,2:size(Behavior,2));
imagesc(Behavior, [0 1])
colormap(cividis); cb = colorbar;
set(gca, 'FontName', 'Abel', 'FontSize', 14)
set(gca,'linewidth',1.5)
title('Basal (Behavior)','FontName', 'Abel', 'FontSize', 16,'FontWeight','bold')
xlabel('Time (s)','FontName', 'Abel', 'FontSize', 14,'FontWeight','bold');
ylabel('Trials','FontName', 'Abel', 'FontSize', 14,'FontWeight','bold');
ylabel(cb,'Activity Level','FontName', 'Abel', 'FontSize', 14,'FontWeight','bold');
pbaspect([1.5 1 1])

f2 = figure(2);
HbO = HbO';
% HbO = [sort HbO];
% HbO = sortrows(HbO,'descend');
% HbO = HbO(:,2:size(HbO,2));
imagesc(HbO, [0 50])
colormap(cividis); cb = colorbar;
set(gca, 'FontName', 'Abel', 'FontSize', 14)
set(gca,'linewidth',1.5)
title('Basal (HbO)','FontName', 'Abel', 'FontSize', 16,'FontWeight','bold')
xlabel('Time (s)','FontName', 'Abel', 'FontSize', 14,'FontWeight','bold');
ylabel('Trials','FontName', 'Abel', 'FontSize', 14,'FontWeight','bold');
ylabel(cb,'HbO','FontName', 'Abel', 'FontSize', 14,'FontWeight','bold');
pbaspect([1.5 1 1])

f3 = figure(3);
HbR = HbR';
% HbR = [sort HbR];
% HbR = sortrows(HbR,'descend');
% HbR = HbR(:,2:size(HbR,2));
imagesc(HbR, [-10 30])
colormap(cividis); cb = colorbar;
set(gca, 'FontName', 'Abel', 'FontSize', 14)
set(gca,'linewidth',1.5)
title('Basal (HbR)','FontName', 'Abel', 'FontSize', 16,'FontWeight','bold')
xlabel('Time (s)','FontName', 'Abel', 'FontSize', 14,'FontWeight','bold');
ylabel('Trials','FontName', 'Abel', 'FontSize', 14,'FontWeight','bold');
ylabel(cb,'HbR','FontName', 'Abel', 'FontSize', 14,'FontWeight','bold');
pbaspect([1.5 1 1])

% for i = [12 15 17 18 20 21 22 23 24 26 30 32 39 45 54 55 56]
%     
%     f4 = figure(4);
%     p = plot((1:1500)/10,HbO(i,:)); ylim([-50 50]);
%     p.Color = colors{1}; grid off;
%     saveas(gcf,['F:\ANALYZED_DATA\FIGURES v2\FIGURE 1 (Characterizing the stimulus-evoked response)\Basal_Behavior_ExampleTraces\' 'Number ' int2str(i) '_HbO.svg']);
%     figure(5);
%     q = plot((1:1500)/10,HbR(i,:)); ylim([-50 50]);
%     q.Color = colors{3}; grid off;
%     %saveas(gcf,['F:\ANALYZED_DATA\FIGURES v2\FIGURE 1 (Characterizing the stimulus-evoked response)\Basal_Behavior_ExampleTraces\' 'Number ' int2str(i) '_HbR.svg']);
%     
% end

% COMPUTE POWER SPECTRA

Fs = 10;
T = 1/Fs;
L = 1500;
t = (0:L-1)*T;
f = Fs*(0:(L/2))/L;

for i = 1:size(HbO,1)
    
    X = HbO(:,i);
    Y = fft(X);
    P2 = abs(Y/L);
    P1 = P2(1:L/2+1);
    P1(2:end-1) = 2*P1(2:end-1);
    P1_calciums(:,i) = P1;
    
end

for i = 1:size(HbO,2)
    
    currentTrace = ['Single-sided amplitude spectrum of Calcium: Trace ' int2str(i)];
    figure('NumberTitle', 'off', 'Name', currentTrace);
    plot(f,P1_calciums(:,i))
    xlabel('f (Hz)', 'FontName', 'Calibri'); xlim([0 1]);
    ylabel('|P|', 'FontName', 'Calibri')
    title(currentTrace, 'FontName', 'Calibri');  
    
end

for i = 1:size(diameter,2)
    
    X = diameter(:,i);
    Y = fft(X);
    P2 = abs(Y/L);
    P1 = P2(1:L/2+1);
    P1(2:end-1) = 2*P1(2:end-1);
    P1_diameters(:,i) = P1;
    
end

for i = 1:size(diameter,2)
    
    currentTrace = ['Single-sided amplitude spectrum of Diameter: Trace ' int2str(i)];
    figure('NumberTitle', 'off', 'Name', currentTrace);
    plot(f,P1_diameters(:,i))
    xlabel('f (Hz)', 'FontName', 'Calibri'); xlim([0 1]);
    ylabel('|P|', 'FontName', 'Calibri')
    title(currentTrace, 'FontName', 'Calibri');
    
end

end
