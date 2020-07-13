function corrMat = SeedPixelCorrelation(img,corrLimits,numAttempts,figTitle)
% for i = 1:size(SA_T_averaged,1)
% Img = SA_T_averaged(i).Avg_HbO;
% Img_ID = SA_T_averaged(i).Image_ID;
% corrMat = SeedPixelCorrelation(Img,[0.5 1],10,[Img_ID 'HbO']);
% end

% for i = 1:size(SA_T_averaged,1)
% Img = SA_T_averaged(i).Avg_HbR;
% Img_ID = SA_T_averaged(i).Image_ID;
% corrMat = SeedPixelCorrelation(Img,[0.5 1],10,[Img_ID 'HbR']);
% end

% for i = 1:size(SA_T_averaged,1)
% Img = SA_T_averaged(i).Avg_HbT;
% Img_ID = SA_T_averaged(i).Image_ID;
% corrMat = SeedPixelCorrelation(Img,[0.5 1],10,[Img_ID 'HbT']);
% end

close all

figure; imshow(img(:,:,1),[],'InitialMagnification',300);
title([figTitle ': Structure Map']);

I = reshape(single(img),size(img,1)*size(img,2),size(img,3));
corrMat = zeros(size(img,1),size(img,2),'single');

fig = figure;
%autoArrangeFigures(1,2,2);

for i = 1:numAttempts
    if(i==1)
        set(0, 'CurrentFigure', fig)
        imshow(img(:,:,1),[],'InitialMagnification',600); title([figTitle ': Correlation Map']);
    else
        set(0, 'CurrentFigure', fig)
        imshow(corrMat,corrLimits,'InitialMagnification',600); title([figTitle ': Correlation Map']);
        colormap cividis
        colorbar
        text(0.9*size(img,1),0.9*size(img,2),int2str(i),'Color','w','FontWeight','bold','FontSize',16);
    end
    try
        hold on
        plot(x,y,'wo');
        hold off
    end
    [x,y]=ginput(1);
    x = round(x);
    y = round(y);
    %disp(strcat("[",int2str(x),",",int2str(y),"]"))
    corrMat = corr(squeeze(I((x-1)*size(img,1)+y,:))',I'); %pixelwise correlation
    corrMat = reshape(corrMat,size(img,1),size(img,2));
    %normCM = corrMat - min(corrMat(:));
    %normCM = normCM ./ max(normCM(:));
end

end