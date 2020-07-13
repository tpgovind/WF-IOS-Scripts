clc
clear all
close all

source = ["D:","G:"];
sink = "F:\WF-guided-2P Masks\";

% WF-guided 2P
folder = ["M9" "1";"M10" "1";"M17" "4";"M18" "2";"M19" "3";"M20" "3";"M21" "4";"M22" "4";...
    "M23" "1";"M25" "4";"M26" "1";"M28" "3";"M31" "4";"M33" "3";"M35" "4";"M48" "6";"M49" "4"];

disp("STARTING...\n");

counter = 0;

for h = 1:length(source)
    
    for i = 1:length(folder)
        disp(folder(i,1));
        
        path = strcat(source(h),"\",folder(i,1),"\Trial 1\CaHemo\");
        
        if (exist(path,"dir")>0)
            counter = counter + 1;
            HeaderLines{counter} = folder(i,1);
            inputDir = path;
            
            imgFiles = dir(strcat(inputDir,"CaHemo*"));
            %imgFiles = dir(strcat(inputDir,"Basler*"));
            imgFiles = natsortfiles({imgFiles.name});
            numImages = length(imgFiles);
            numFrames = numImages/4;
            %numFrames = numImages/2;
            numRows = size(imread(strcat(inputDir,imgFiles{3})),1);
            numCols = size(imread(strcat(inputDir,imgFiles{3})),2);
            
            Img = zeros(numRows,numCols,numFrames);
            m = 0;
            for n = 2:4:numImages
                m = m + 1;
                Img(:,:,m) = imread(strcat(inputDir,imgFiles{n}));
            end
            
            for g = 1:str2double(folder(i,2))
                fig = imshow(Img(:,:,500),[],"InitialMagnification",500);
                movegui(fig,"northwest");
                title(strcat(folder(i,1),{' '},"Loc",int2str(g)));
                %mask = roipoly;
                mask = createMask(drawrectangle());
                Data{counter,g} = mask;
                close all
            end
            
        end
        
    end
    
end

clearvars -except HeaderLines Data