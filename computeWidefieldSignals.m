function [HbO,HbR,HbT,Fluo] = computeWidefieldSignals(R,G,B)

% The 10*() in lines 8-11 should be 0.1*() That factor is for converting
% extinction coefficients from /cm/M to /mm/M. The divide by 1e6 takes the
% coefficients from /mm/M to /mm/µM
% 
% In the same lines, there should also be a ln(10)=2.303 multiplicative
% factor to account for changing from extinction coefficient to absorption
% coefficient. That term is missing in Hillman's paper Eq. 2.5 but shows
% up if you look at Appendix A in the supplementary data. This could be
% just a notation mistake, or could have carried through into their data.
% 
% Your current code multiplies eps by 10 when it should have multiplied by
% 0.1*2.303. Notice that the concentration equations have an eps term in 
% the numerator and and eps^2 term in the denominator. So to correct the
% values you may have already obtained by running the (incorrect) code,
% you need to multiply by 10 and dive by 0.2303 which is the same as
% divide by 0.02303.
% 
% If you want to discard old results and re-run the code (or write new
% (correct) code for future), then multiply the eps by 0.1*2.303 (still
% keep the divide by 1e6).

eps_hbo_r = 0.1*2.303*319.6/1e6;
eps_hbo_g = 0.1*2.303*35990/1e6;
eps_hb_r = 0.1*2.303*3226.56/1e6;
eps_hb_g = 0.1*2.303*37490/1e6;

d_ua_r = -log(R)/4.535122;
d_ua_g = -log(G)/0.410981;

HbR = (eps_hbo_g*d_ua_r - eps_hbo_r*d_ua_g)/(eps_hbo_g*eps_hb_r - eps_hbo_r*eps_hb_g);
HbO = (eps_hb_g*d_ua_r - eps_hb_r*d_ua_g)/(eps_hb_g*eps_hbo_r - eps_hb_r*eps_hbo_g);
HbT = HbO + HbR;

% eps_ex_hbo = 24174.8/1e6;
% eps_ex_hb = 15898/1e6;
% eps_em_hbo = 39956.8/1e6;
% eps_em_hb = 39036.4/1e6;
% Xest_ex = 0.56;
% Xest_em = 0.57;
% 
% d_ua_ex_em_X = (eps_ex_hbo*HbO + eps_ex_hb*HbR)*Xest_ex + (eps_em_hbo*HbO + eps_em_hb*HbR)*Xest_em;
% B_over_B0 = B ./ nanmean(B(:,:,1:299),3);
% ln_d_GCaMP = log(B_over_B0) - d_ua_ex_em_X;
% Fluo_over_Fluo0 = exp(ln_d_GCaMP);
Fluo = 0;

% HbO(~isfinite(HbO)) = 0;
% HbR(~isfinite(HbR)) = 0;
% HbT(~isfinite(HbT)) = 0;
% Fluo(~isfinite(Fluo)) = 0;

end