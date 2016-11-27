function [ imgTexturaTransferata ] = transferaTextura( params )

    iteratii = params.iteratii;
        
    params.dimBloc = 128;
    for i = 1:iteratii
        params.iteratiaCurenta = i;
        img_curenta = frontieraCostMinim(params);
        
        params.imagineTransfer = img_curenta;
        params.dimBloc = round(params.dimBloc/2);
    end
    
    imgTexturaTransferata = img_curenta;
end

