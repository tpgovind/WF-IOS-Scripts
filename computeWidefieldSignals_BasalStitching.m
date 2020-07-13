function [HbO,HbR,HbT,Fluo] = computeWidefieldSignals(R,G,B)

%for some reason, 'correction' was multiplying all four eps values by 10
%(looks similar to others' values)

eps_hbo_r = 10*319.6/1e6;
eps_hbo_g = 10*35990/1e6;
eps_hb_r = 10*3226.56/1e6;
eps_hb_g = 10*37490/1e6;

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
% ln_d_GCaMP = log(B) + d_ua_ex_em_X;
% Fluo = exp(ln_d_GCaMP);
Fluo = 0;

% HbO(~isfinite(HbO)) = 0;
% HbR(~isfinite(HbR)) = 0;
% HbT(~isfinite(HbT)) = 0;
% Fluo(~isfinite(Fluo)) = 0;

end