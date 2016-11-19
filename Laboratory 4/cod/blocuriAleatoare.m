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
    progres               = params.progresImagine;
    
    % Adaugam aleator blocuri in imagine
    total_adaugat = 0;
    total = nrBlocuriX * nrBlocuriY;
    for y = 1:nrBlocuriY
        for x = 1:nrBlocuriX
            indice = randi(nrBlocuri);
            imgSintetizataMaiMare((y - 1) * dimBloc + 1:y * dimBloc,(x - 1) * dimBloc + 1:x * dimBloc,:) = ...
                blocuri(:,:,:,indice);
            
            % Afisam progresul procentual
             total_adaugat = total_adaugat + 1;
             clc
             fprintf('Sintetizam imaginea ... %2.2f%% \n',100*total_adaugat/total);
            
            % Afisam progresul imaginii
             if progres == 1
                 close all;
                 figure, imshow(imgSintetizataMaiMare);
                 pause(0.1);
             end
        end
    end
    
    % Extragem din imaginea rezultata doar portiune de interes raportata la
    % marimea dorita de sintetizare
    imgSintetizata = imgSintetizataMaiMare(1:size(imgSintetizata,1),1:size(imgSintetizata,2),:);
end

