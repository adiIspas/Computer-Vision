function [imgSintetizata] = blocuriAleatoare(params)
    % Imaginea texturii se completeaza cu blocuri aleatoare.

    % Setam parametrii de intrare
    nrBlocuriY            = params.nrBlocuriY;
    nrBlocuriX            = params.nrBlocuriX;
    nrBlocuri             = params.nrBlocuri;
    dimBloc               = params.dimBloc;
    imgSintetizataMaiMare = params.imgSintetizataMaiMare;
    imgSintetizata        = params.imgSintetizata;
    blocuri               = params.blocuri;
    
    % Adaugam aleator blocuri in imagine
    for y = 1:nrBlocuriY
        for x = 1:nrBlocuriX
            indice = randi(nrBlocuri);
            imgSintetizataMaiMare((y - 1) * dimBloc + 1:y * dimBloc,(x - 1) * dimBloc + 1:x * dimBloc,:) = ...
                blocuri(:,:,:,indice);
        end
    end
    
    % Extragem din imaginea rezultata doar portiune de interes raportata la
    % marimea dorita de sintetizare
    imgSintetizata = imgSintetizataMaiMare(1:size(imgSintetizata,1),1:size(imgSintetizata,2),:);
end

