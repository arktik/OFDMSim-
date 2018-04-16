function NumStart=PilotCorr(MedF,Index_Pilot)

for k = 1:1024
    
    CoefCorr(k) = prod(abs(MedF(mod(Index_Pilot+k,1024)+1)));
end

NumStart = find(CoefCorr == max(CoefCorr));
end