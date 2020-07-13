function I_Reg = registerImages(I)

I_Reg = zeros(size(I));
fixed = I(:,:,10);
Rout = imref2d(size(fixed));

numImages = size(I,3);

for i = 1:numImages
    moving = I(:,:,i);
    points1 = detectHarrisFeatures(fixed);
    points2 = detectHarrisFeatures(moving);
    %points1 = detectMinEigenFeatures(I1);
    %points2 = detectMinEigenFeatures(I2);
    
    [features1,valid_points1] = extractFeatures(fixed,points1);
    [features2,valid_points2] = extractFeatures(moving,points2);
    indexPairs = matchFeatures(features1,features2);
    matchedPoints1 = valid_points1(indexPairs(:,1),:);
    matchedPoints2 = valid_points2(indexPairs(:,2),:);
    %showMatchedFeatures(fixed,moving,matchedPoints1,matchedPoints2);
    
    tform = estimateGeometricTransform(matchedPoints1,matchedPoints2,'similarity');
    I_Reg(:,:,i) = imwarp(moving,tform,'nearest','outputView',Rout);
    
    disp("Processing frame: " + int2str(i) + " of " + int2str(numImages))
end

end
