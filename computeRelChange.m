function [delta_HbO,delta_HbR,delta_HbT,delta_Fluo] = computeRelChange(HbO,HbR,HbT,Fluo,imageMode)

if(strcmp(imageMode,'Trial'))
    HbO_f0 = mean(HbO(:,:,1:298),3);
    HbR_f0 = mean(HbR(:,:,1:298),3);
    HbT_f0 = mean(HbT(:,:,1:298),3);
    Fluo_f0 = mean(Fluo(:,:,1:298),3);
else
    HbO_f0 = mean(HbO,3);
    HbR_f0 = mean(HbR,3);
    HbT_f0 = mean(HbT,3);
    Fluo_f0 = mean(Fluo,3);
end

delta_HbO = zeros(size(HbO));
delta_HbR = zeros(size(HbR));
delta_HbT = zeros(size(HbT));
delta_Fluo = zeros(size(Fluo));

% Calculate % changes

for i = 1:size(HbO,3)

        delta_HbO(:,:,i) = (HbO(:,:,i) - HbO_f0)./abs(HbO_f0).*100;
        %delta_R(:,:,i) = (temp - min(temp)) ./ (max(temp) - min(temp));
    
        delta_HbR(:,:,i) = (HbR(:,:,i) - HbR_f0)./abs(HbR_f0).*100;
        %delta_G(:,:,i) = (temp - min(temp)) ./ (max(temp) - min(temp));
    
        delta_HbT(:,:,i) = (HbT(:,:,i) - HbT_f0)./abs(HbT_f0).*100;
        %delta_B(:,:,i) = (temp - min(temp)) ./ (max(temp) - min(temp));
        
        delta_Fluo(:,:,i) = (Fluo(:,:,i) - Fluo_f0)./abs(Fluo_f0).*100;
        %delta_Fluo(:,:,i) = (temp - min(temp)) ./ (max(temp) - min(temp));
    
end

delta_HbO(~isfinite(delta_HbO)) = 0;
delta_HbR(~isfinite(delta_HbR)) = 0;
delta_HbT(~isfinite(delta_HbT)) = 0;
delta_Fluo(~isfinite(delta_Fluo)) = 0;

end