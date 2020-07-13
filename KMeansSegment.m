function [I_Labeled,Centroids,Masks] = KMeansSegment(I,k,showOutput)

Width = size(I,1);
Height = size(I,2);
NumFrames = size(I,3);

I_show = mat2gray(I);
I = reshape(single(I),size(I,1)*size(I,2),size(I,3));

[I_Labeled,Centroids] = imsegkmeans(I,k);
%I = reshape(I,Width,Height,NumFrames);
I_Labeled = reshape(I_Labeled,Width,Height,NumFrames);

Masks = zeros(Width,Height,k);
meanProjection = mean(I_Labeled, 3);
for i = 1:k
    Masks(:,:,i) = (meanProjection >= i-0.5) & (meanProjection < i+0.5);
end

if(showOutput)
    figure;
%     for i = 1:5:NumFrames
%         imshow(I_Labeled(:,:,i),[],'InitialMagnification',500,'colormap',jet);
%         text(3,5,int2str(i),'Color','black','FontSize',14);
%         %colorbar
%         pause(0.001)
%     end
    a = ceil(sqrt(k));
    b = ceil(k/a);
    for i = 1:k
        subplot(b,a,i); imshow(Masks(:,:,i),'InitialMagnification',800);
    end
end

end