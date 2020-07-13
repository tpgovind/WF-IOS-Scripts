function pixSum = computeLocomotionTraces(I)

numFrames = size(I{1,2},3);
pixSum = zeros(numFrames-1,2);
diffImg = single(zeros(size(I{1,2},1),size(I{1,2},2),numFrames-1));

for i = 1:numFrames-1
    im1 = single(I{1,2}(:,:,i));
    im2 = single(I{1,2}(:,:,i+1));
    diffImg = imabsdiff(im2,im1);
    pixSum(i,1) = i*(180/numFrames); % Time (s)
    pixSum(i,2) = sum(diffImg,'all'); % Total frame intensity
end

temp = pixSum(:,2);
temp = (temp - min(temp)) / (max(temp) - min(temp));
pixSum(:,2) = temp;

end