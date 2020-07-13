function [I,numChannels] = readImagesModified(inputDir,type)

imgFiles = dir([inputDir '*.tiff']);
imgFiles = natsortfiles({imgFiles.name});

if (strcmp(type,'CaHemo\'))
    if ( length(imgFiles) == 3600 )
        numChannels = 2; skip = 2;
    end
    if ( length(imgFiles) > 30000 )
        numChannels = 4; skip = 4;
    end
    
    numImages = length(imgFiles) - skip;
    numFrames = numImages/numChannels; % per channel
    numRows = size(imread([inputDir imgFiles{3}]),1);
    numCols = size(imread([inputDir imgFiles{3}]),2);
    
    disp('Reading: R')
    
    R = zeros(numRows,numCols,numFrames);
    i = 0;
    for n = skip+1:numChannels:numImages+skip
        i = i + 1;
        R(:,:,i) = imread([inputDir imgFiles{n}]);
    end
    
    disp('Reading: G')
    
    G = zeros(numRows,numCols,numFrames);
    j = 0;
    for n = skip+2:numChannels:numImages+skip
        j = j + 1;
        G(:,:,j) = imread([inputDir imgFiles{n}]);
    end
    
    %disp('Reading: B')
    
    B = zeros(numRows,numCols,numFrames);
    
%     if (numChannels == 4)
%         
%         B1 = zeros(numRows,numCols,numFrames);
%         B2 = zeros(numRows,numCols,numFrames);
%         k = 0;
%         for n = skip+3:numChannels:numImages+skip
%             k = k + 1;
%             B1(:,:,k) = imread([inputDir imgFiles{n}]);
%         end
%         k = 0;
%         for n = skip+4:numChannels:numImages+skip
%             k = k + 1;
%             B2(:,:,k) = imread([inputDir imgFiles{n}]);
%         end
%         for n = 1:numFrames
%             B(:,:,n) = B1(:,:,n) + B2(:,:,n);
%         end
%         
%     end
    
    I{1,1} = 'R'; I{1,2} = R;
    I{2,1} = 'G'; I{2,2} = G;
    I{3,1} = 'B'; I{3,2} = B;
    
end

if ( strcmp(type,'OpticalFlow\') )
    
    numChannels = 1;
    numImages = length(imgFiles);
    numFrames = numImages/numChannels; % per channel
    numRows = size(imread([inputDir imgFiles{3}]),1);
    numCols = size(imread([inputDir imgFiles{3}]),2);
    
    if ( numRows == 592 && numCols == 592 )
        topCornerRow = 235; topCornerCol = 345; edge = 149;
        OF = zeros(150,150,numFrames);
        temp = zeros(numRows,numCols,numFrames);
    else
        topCornerRow = 1; topCornerCol = 1; edge = numRows-1;
        OF = zeros(numRows,numCols,numFrames);
        temp = zeros(numRows,numCols,numFrames);
    end
    
    disp('Reading: OF')
    
    for n = 1:numChannels:numImages
        temp(:,:,n) = imread([inputDir imgFiles{n}]);
        OF(:,:,n) = temp(topCornerRow:topCornerRow+edge,...
            topCornerCol:topCornerCol+edge,n);
    end
    
    I{1,1} = 'OF'; I{1,2} = OF;
end

if ( strcmp(type,'CloseUp\') )
    
    numChannels = 1;
    numImages = length(imgFiles);
    numFrames = numImages/numChannels; % per channel
    numRows = size(imread([inputDir imgFiles{3}]),1);
    numCols = size(imread([inputDir imgFiles{3}]),2);
    
    if ( numRows == 592 && numCols == 592 )
        topCornerRow = 1; topCornerCol = 1; w = 591; h = 244;
        CU = zeros(592,245,numFrames);
        temp = zeros(numRows,numCols,numFrames);
        increment = 2;
    else
        topCornerRow = 1; topCornerCol = 1; w = numRows-1; h = numCols-1;
        CU = zeros(numRows,numCols,numFrames);
        temp = zeros(numRows,numCols,numFrames);
        increment = 5;
    end
    
    disp('Reading: CU')
    
    for n = 1:increment:numImages
        temp(:,:,n) = imread([inputDir imgFiles{n}]);
        CU(:,:,n) = temp(topCornerRow:topCornerRow+w,...
            topCornerCol:topCornerCol+h,n);
    end
    
    I{1,1} = 'CU'; I{1,2} = CU;
end

end