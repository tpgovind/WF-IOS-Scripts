clc
clear all
close all
load('F:\ANALYZED_DATA\BACKUP\dataStructs2.mat')

%%

rows = 1799; cols = size(filenames,1);
%rows = 7199; cols = size(filenames,1);

[varTypes{1:cols}] = deal('double');

R = table('Size',[rows cols],'VariableTypes',varTypes);
G = table('Size',[rows cols],'VariableTypes',varTypes);
%B = table('Size',[rows cols],'VariableTypes',varTypes);

HbO = table('Size',[rows cols],'VariableTypes',varTypes);
HbR = table('Size',[rows cols],'VariableTypes',varTypes);
HbT = table('Size',[rows cols],'VariableTypes',varTypes);
%Fluo = table('Size',[rows cols],'VariableTypes',varTypes);

% deltaHbO = table('Size',[rows cols],'VariableTypes',varTypes);
% deltaHbR = table('Size',[rows cols],'VariableTypes',varTypes);
% deltaHbT = table('Size',[rows cols],'VariableTypes',varTypes);
% deltaFluo = table('Size',[rows cols],'VariableTypes',varTypes);

Behavior = table('Size',[rows cols],'VariableTypes',varTypes);

% temp1 = zeros(1799,1);
% temp2 = zeros(1799,1);
% temp3 = zeros(1799,1);
% temp4 = zeros(1799,1);

%%

for i = 17:cols
    disp(filenames{i,1})
    load(['F:\ANALYZED_DATA\DATA STRUCTS\' filenames{i,1}]);
    
    colName = split(filenames{i,1},'.');
    colName = colName{1,1};
    colName = convertStringsToChars(strrep(colName,"-","_"));
    
    S.WFSignals.Raw.R(S.WFSignals.Raw.R == 0) = NaN;
    S.WFSignals.Raw.G(S.WFSignals.Raw.G == 0) = NaN;
    %S.WFSignals.Processed.B(S.WFSignals.Processed.B == 0) = NaN;
    
    for j = 1:rows
        temp1(j,1) = nanmean2(S.WFSignals.Raw.R(:,:,j));
        temp2(j,1) = nanmean2(S.WFSignals.Raw.G(:,:,j));
        %temp3(j,1) = nanmean2(S.WFSignals.Processed.B(:,:,j));
    end
    
    R.Properties.VariableNames{i} = colName;
    R(:,i) = array2table(temp1);
    
    G.Properties.VariableNames{i} = colName;
    G(:,i) = array2table(temp2);
    
%     B.Properties.VariableNames{i} = colName;
%     B(:,i) = array2table(temp3);
    
    S.WFSignals.Processed.HbO(S.WFSignals.Processed.HbO==0) = NaN;
    S.WFSignals.Processed.HbR(S.WFSignals.Processed.HbR==0) = NaN;
    S.WFSignals.Processed.HbT(S.WFSignals.Processed.HbT==0) = NaN;
    %S.WFSignals.Processed.Fluo(S.WFSignals.Processed.Fluo==0) = NaN;
    
    for j = 1:rows
        temp1(j,1) = nanmean2(S.WFSignals.Processed.HbO(:,:,j));
        temp2(j,1) = nanmean2(S.WFSignals.Processed.HbR(:,:,j));
        temp3(j,1) = nanmean2(S.WFSignals.Processed.HbT(:,:,j));
        %temp4(j,1) = nanmean2(S.WFSignals.Processed.Fluo(:,:,j));
    end
    
    HbO.Properties.VariableNames{i} = colName;
    HbO(:,i) = array2table(temp1);
    
    HbR.Properties.VariableNames{i} = colName;
    HbR(:,i) = array2table(temp2);
    
    HbT.Properties.VariableNames{i} = colName;
    HbT(:,i) = array2table(temp3); 
    
    %{
    Fluo.Properties.VariableNames{i} = colName;
    Fluo(:,i) = array2table(temp4);

    S.WFSignals.Delta.HbO(S.WFSignals.Delta.HbO==0) = NaN;
    S.WFSignals.Delta.HbR(S.WFSignals.Delta.HbR==0) = NaN;
    S.WFSignals.Delta.HbT(S.WFSignals.Delta.HbT==0) = NaN;
    S.WFSignals.Delta.Fluo(S.WFSignals.Delta.Fluo==0) = NaN;
    
    for j = 1:rows
        temp1(j,1) = nanmean2(S.WFSignals.Delta.HbO(:,:,j));
        temp2(j,1) = nanmean2(S.WFSignals.Delta.HbR(:,:,j));
        temp3(j,1) = nanmean2(S.WFSignals.Delta.HbT(:,:,j));
        temp4(j,1) = nanmean2(S.WFSignals.Delta.Fluo(:,:,j));
    end
    
    deltaHbO.Properties.VariableNames{i} = colName;
    deltaHbO(:,i) = array2table(temp1);
    
    deltaHbR.Properties.VariableNames{i} = colName;
    deltaHbR(:,i) = array2table(temp2);
    
    deltaHbT.Properties.VariableNames{i} = colName;
    deltaHbT(:,i) = array2table(temp3);
    
    deltaFluo.Properties.VariableNames{i} = colName;
    deltaFluo(:,i) = array2table(temp4);
    %}
    
    Behavior.Properties.VariableNames{i} = colName;
%     if (size(S.WFBehavior.LocomotionTrace,1) == 3599)
%         A = S.WFBehavior.LocomotionTrace(:,2);
%         B = padarray(A,3600,'post');
%         Behavior(:,i) = array2table(B);
%     else
%         Behavior(:,i) = array2table(S.WFBehavior.LocomotionTrace(:,2));
%     end
    
    temp = S.WFBehavior.LocomotionTrace(:,2);
    temp(7200,1) = temp(7199,1); temp = resample(temp,10,40);
    Behavior(:,i) = array2table(temp(1:1799,1));
    clear S A B
end

clearvars -except R G B HbO HbR HbT Fluo deltaHbO deltaHbR deltaHbT deltaFluo Behavior