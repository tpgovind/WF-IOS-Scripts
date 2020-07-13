clc
clear all
close all

load('F:\ANALYZED_DATA\MAT Files\2P\2PTrial_Indices.mat')
load('F:\ANALYZED_DATA\MAT Files\2P\2P_Data.mat')
split_indices = randperm(135);
Penetrators_Calcium_ADAM = Penetrators_Calcium_ALL(:,split_indices(1:45));
Penetrators_Calcium_GOVIND = Penetrators_Calcium_ALL(:,split_indices(46:135));
[H,U,SEM] = graph2PTrialTraces(Penetrators_Calcium_ADAM,TwoPhoton_All,'First Order Calcium - ADAM','Time(s)','\Delta F/F_0 (%)');
[H,U,SEM] = graph2PTrialTraces(Penetrators_Calcium_GOVIND,TwoPhoton_All,'Penetrators Calcium - GOVIND','Time(s)','\Delta F/F_0 (%)');
[H,U,SEM] = graph2PTrialTraces(Penetrators_Calcium_ALL,TwoPhoton_All,'Penetrators Calcium - ALL','Time(s)','\Delta F/F_0 (%)');