function [ MedF1 ] = FuncTs( IQ_Ts_Unshifted, Nfft, Index_Pilot, Nc)
    
    for k = 1 : ceil(length(IQ_Ts_Unshifted)/(Nfft + Nfft/8))-1
        MedFst(k, :) = fft(...
                IQ_Ts_Unshifted(...
                    (k - 1)*(Nfft + Nfft/8) + 1:...
                    (k - 1)*(Nfft + Nfft/8) + Nfft));

      NumStart= PilotCorr(MedFst(k,:),Index_Pilot);
      MedF(k, :) = MedFst(k,mod(NumStart+1:NumStart+Nc,1024)+1);

     
       Fi = angle(MedF(k, 1 : Nc ));
       Fi(Index_Pilot(2:2:end)) = Fi(Index_Pilot(2:2:end)) - pi;
        
        for l = 1 : length(Index_Pilot) - 1
            Left = Index_Pilot(l);
            Right = Index_Pilot(l + 1);
            Phase_Left = Fi(Left);
            Phase_Right = Fi(Right);
            while ( Phase_Right > Phase_Left ) 
                Phase_Right = Phase_Right - 2*pi;
            end
            Fi( (Left + 1 ):(Right - 1) ) = ...
                Phase_Left + ((Phase_Right - Phase_Left)/(Right - Left))*(((Left+1) : (Right - 1)) - Left);
        end
        MedF1(k,:) = MedF(k,:);
        MedF1(k,1:Nc ) = MedF(k,1:Nc ) .* exp(-1i*Fi);
    end
end
























