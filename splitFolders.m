function splitFolders(inputDir,outputDir,framesPerRepeat)

imgFiles = dir([inputDir 'Basler*']);
imgFiles = natsortfiles({imgFiles.name});
imgFiles = imgFiles';
numFiles = size(imgFiles,1);
numRepeats = numFiles/framesPerRepeat;

imgFiles = reshape(imgFiles,framesPerRepeat,numRepeats);

for i = 1:numRepeats
    subfolder = strcat(outputDir,"Trial ",int2str(i),"\CaHemo\");
    mkdir(subfolder);
    for j = 1:framesPerRepeat
        movefile(strcat(inputDir,imgFiles{j,i}),subfolder);
    end
end

end