Attenuation = [0 10 20 30 40 50];
AmpmV = [0.66 ];
dBm = 10*log10(((AmpmV.*10^-3).^2)/2/50/10^(-3));
