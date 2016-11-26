function [ imgTexturaTransferata ] = transferaTextura( params )

    iteratii = params.iteratii; 
   
    for i = 1:iteratii
        params.iteratiaCurenta = i;
        
        img = frontieraCostMinim(params);
    end
    
end

