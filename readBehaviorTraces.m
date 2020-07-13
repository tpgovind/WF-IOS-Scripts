%% READ

%clear all
clear all
close all
clc

fileID = fopen('F:\New folder\2PTraces.txt','r');
Block = 1;
NumCols = 2;

while (~feof(fileID))                               % For each block:                         
   
   fprintf('Block: %s\n', num2str(Block))           % Print block number to the screen
   
   InputText = textscan(fileID,'%s',1,'delimiter','\n');  % Read header line
   HeaderLines{Block,1} = InputText{1};
   disp(HeaderLines{Block});                        % Display header lines
   
   FormatString = repmat('%f',1,NumCols);           % Create format string
                                                    % based on the number
                                                    % of columns
   InputText = textscan(fileID,FormatString, ...    % Read data block
      'delimiter',',');
   
   Data{Block,1} = cell2mat(InputText);              
   [NumRows,NumCols] = size(Data{Block});           % Determine size of table
   numRows(Block,1) = NumRows;
   numCols(Block,1) = NumCols;
   disp(cellstr(['Table data size: ' ...
      num2str(NumRows) ' x ' num2str(NumCols)]));
   disp(' ');                                       % New line

   Block = Block+1;                                 % Increment block index
end


% for i = 1:length(Data)
% x = Data{i,1}(:,1); %divide by frame rate for time
% y = Data{i,1}(:,2);
% dydx = abs(gradient(y(:))./gradient(x(:)));
% dydx = (dydx-min(dydx))/(max(dydx)-min(dydx));
% %Data{i,2}(:,1) = x;
% Data{i,2}(:,1) = dydx;
% end

% for i = 1:length(HeaderLines)
% if (i<4)
% temp = HeaderLines{i,1};
% temp = temp{1,1};
% HeaderLines{i,2} = temp(1:2);
% HeaderLines{i,3} = temp(6:8);
% else
% temp = HeaderLines{i,1};
% temp = temp{1,1};
% HeaderLines{i,2} = temp(1:3);
% HeaderLines{i,3} = temp(7:9);
% end
% end
% 
% for i = 1:size(HeaderLines,1)
% TwoPhoton_Behavior_Data{i,1} = HeaderLines{i,2};
% TwoPhoton_Behavior_Data{i,2} = HeaderLines{i,3};
% TwoPhoton_Behavior_Data{i,3} = Data{i,1};
% TwoPhoton_Behavior_Data{i,4} = Data{i,2};
% end

%T = cell2table(Behavior_Data,...
%    'VariableNames',{'Image_ID' 'Image_Mode' 'Trial_Number' 'Manipulation' 'Behavior_Raw' 'Behavior_dydx'});

% for i = 1:length(Data)
%     
% y = Data{i,2}(:,2);
% Data{i,3} = nanmean(y);
% Data{i,4} = nanmedian(y);
% Data{i,5} = nanstd(y);
% Data{i,6} = mad(y);
% 
% end

% for i = 1:length(Data)
%     delta_HbO(:,:,i) = (HbO(:,:,i) - HbO_f0)./abs(HbO_f0).*100;
% end
% 
% clearvars -except HeaderLines Data

% %% PLOT
% 
% f = figure;
% for i = 1:length(Data)
% f.WindowState = 'maximized';
% plot(Data{i,2}(:,1),Data{i,2}(:,2))
% title(int2str(i))
% pause(0.5)
% end
