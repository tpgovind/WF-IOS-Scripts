function [R_masked,G_masked,B_masked] = applyMasks(R,G,B,mask)

for i = 1:size(R,3)
    currentImage = R(:,:,i).*mask;
    [nonZeroRows,nonZeroColumns] = find(currentImage);
    topRow = min(nonZeroRows(:)); bottomRow = max(nonZeroRows(:));
    leftColumn = min(nonZeroColumns(:)); rightColumn = max(nonZeroColumns(:));
    length = max(abs(topRow-bottomRow),abs(leftColumn-rightColumn));
    
    try
        croppedImage = currentImage(topRow:topRow+length, leftColumn:leftColumn+length);
    catch
        err = lasterror;
        switch err.identifier
            case 'MATLAB:badsubscript'
                length = length - 1;
                croppedImage = currentImage(topRow:topRow+length, leftColumn:leftColumn+length);
        end
    end
    
    R_masked(:,:,i) = croppedImage;
end

for i = 1:size(G,3)
    currentImage = G(:,:,i).*mask;
    [nonZeroRows,nonZeroColumns] = find(currentImage);
    topRow = min(nonZeroRows(:)); bottomRow = max(nonZeroRows(:));
    leftColumn = min(nonZeroColumns(:)); rightColumn = max(nonZeroColumns(:));
    length = max(abs(topRow-bottomRow),abs(leftColumn-rightColumn));
    
    try
        croppedImage = currentImage(topRow:topRow+length, leftColumn:leftColumn+length);
    catch
        err = lasterror;
        switch err.identifier
            case 'MATLAB:badsubscript'
                length = length - 1;
                croppedImage = currentImage(topRow:topRow+length, leftColumn:leftColumn+length);
        end
    end
    
    G_masked(:,:,i) = croppedImage;
end

for i = 1:size(B,3)
    currentImage = B(:,:,i).*mask;
    [nonZeroRows,nonZeroColumns] = find(currentImage);
    topRow = min(nonZeroRows(:)); bottomRow = max(nonZeroRows(:));
    leftColumn = min(nonZeroColumns(:)); rightColumn = max(nonZeroColumns(:));
    length = max(abs(topRow-bottomRow),abs(leftColumn-rightColumn));
    
    try
        croppedImage = currentImage(topRow:topRow+length, leftColumn:leftColumn+length);
    catch
        err = lasterror;
        switch err.identifier
            case 'MATLAB:badsubscript'
                length = length - 1;
                croppedImage = currentImage(topRow:topRow+length, leftColumn:leftColumn+length);
        end
    end
    
    B_masked(:,:,i) = croppedImage;
end

% if (isempty(R_masked) && isempty(G_masked))
%     R_masked = zeros(size(B_masked));
%     G_masked = zeros(size(B_masked));
% end