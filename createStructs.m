clear all
close all
clc

data = struct;

[~,~,raw] = xlsread('BehaviorTraces2.csv');
for i = 1:length(raw)
if(ischar(raw{i,1}))
    date = split
    data.
names{length(names)+1,1} = raw{i,1};
end
end

