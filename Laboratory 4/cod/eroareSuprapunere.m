function [ imgSintetizata ] = eroareSuprapunere( params )
    % Imaginea texturii se completeaza cu blocuri bazare pe eroare de suprapunere.

    % Setam parametrii de intrare
    nrBlocuriY            = params.nrBlocuriY;
    nrBlocuriX            = params.nrBlocuriX;
    nrBlocuri             = params.nrBlocuri;
    dimBloc               = params.dimBloc;
    imgSintetizataMaiMare = params.imgSintetizataMaiMare;
    imgSintetizata        = params.imgSintetizata;
    blocuri               = params.blocuri;
    eroareTolerata        = params.eroareTolerata;
    pixeli                = params.pixeli;
    progres               = params.progresImagine;
    
    % Punem primul bloc in imagine
    indice = randi(nrBlocuri);
    imgSintetizataMaiMare(1:dimBloc,1:dimBloc,:) = blocuri(:,:,:,indice);
    suprapunere = pixeli; 
    
    clc
    fprintf('Initializam procesul de sintetizare a imaginii \npe baza erorii de suprapunere ...\n');
    
    % Punem prima linie in imagine
    for x = 1:nrBlocuriX
        if x == 1
            bloc_stanga = rgb2gray(imgSintetizataMaiMare(1:dimBloc,(x-1)*dimBloc+1:x*dimBloc,:));
        else
            bloc_stanga = rgb2gray(imgSintetizataMaiMare(1:dimBloc,(x-1)*dimBloc+1-suprapunere:x*dimBloc-suprapunere,:));
        end
        
        indice = cautaEroareMinima(bloc_stanga,0,blocuri,pixeli,nrBlocuri,eroareTolerata);
        imgSintetizataMaiMare(1:dimBloc,x*dimBloc+1-suprapunere:(x+1)*dimBloc-suprapunere,:) = blocuri(:,:,:,indice);
        % Afisam progresul imaginii
         if progres == 1
             imshow(imgSintetizataMaiMare);
         end
    end
    
    % Punem prima coloana in imagine
    for y = 1:nrBlocuriY 
        if y == 1
            bloc_sus = rgb2gray(imgSintetizataMaiMare((y-1)*dimBloc+1:y*dimBloc,1:dimBloc,:));
        else
            bloc_sus = rgb2gray(imgSintetizataMaiMare((y-1)*dimBloc+1-suprapunere:y*dimBloc-suprapunere,1:dimBloc,:));
        end
        
        indice = cautaEroareMinima(0,bloc_sus,blocuri,pixeli,nrBlocuri, eroareTolerata);
        imgSintetizataMaiMare(y*dimBloc+1-suprapunere:(y+1)*dimBloc-suprapunere,1:dimBloc,:) = blocuri(:,:,:,indice);
        
        % Afisam progresul imaginii
         if progres == 1
             imshow(imgSintetizataMaiMare);
         end
    end
    
    % Completam restul imaginii
    total_adaugat = 0;
    total = nrBlocuriX * nrBlocuriY;
    for y=1:nrBlocuriY
        for x=1:nrBlocuriX
             if x == 1 && y == 1
                bloc_stanga = rgb2gray(imgSintetizataMaiMare((y-1)*dimBloc+1:y*dimBloc,(x-1)*dimBloc+1:x*dimBloc,:));
                bloc_sus = rgb2gray(imgSintetizataMaiMare((y-1)*dimBloc+1:y*dimBloc,(x-1)*dimBloc+1:x*dimBloc,:));
             elseif x == 1 && y ~= 1
                bloc_stanga = rgb2gray(imgSintetizataMaiMare((y-1)*dimBloc+1-suprapunere:y*dimBloc-suprapunere,(x-1)*dimBloc+1:x*dimBloc,:));
                bloc_sus = rgb2gray(imgSintetizataMaiMare((y-1)*dimBloc+1-suprapunere:y*dimBloc-suprapunere,(x-1)*dimBloc+1:x*dimBloc,:));
             elseif x ~= 1 && y == 1
                bloc_stanga = rgb2gray(imgSintetizataMaiMare((y-1)*dimBloc+1:y*dimBloc,(x-1)*dimBloc+1-suprapunere:x*dimBloc-suprapunere,:));
                bloc_sus = rgb2gray(imgSintetizataMaiMare((y-1)*dimBloc+1:y*dimBloc,(x-1)*dimBloc+1-suprapunere:x*dimBloc-suprapunere,:));
             else
                bloc_stanga = rgb2gray(imgSintetizataMaiMare((y-1)*dimBloc+1-suprapunere:y*dimBloc-suprapunere,(x-1)*dimBloc+1-suprapunere:x*dimBloc-suprapunere,:)); 
                bloc_sus = rgb2gray(imgSintetizataMaiMare((y-1)*dimBloc+1-suprapunere:y*dimBloc-suprapunere,(x-1)*dimBloc+1-suprapunere:x*dimBloc-suprapunere,:));
             end
        
             indice = cautaEroareMinima(bloc_stanga,bloc_sus,blocuri,pixeli,nrBlocuri, eroareTolerata);
             imgSintetizataMaiMare(y*dimBloc+1-suprapunere:(y+1)*dimBloc-suprapunere,x*dimBloc+1-suprapunere:(x+1)*dimBloc-suprapunere,:) = blocuri(:,:,:,indice);
             
             % Afisam progresul procentual
             total_adaugat = total_adaugat + 1;
             clc
             fprintf('Sintetizam imaginea ... %2.2f%% \n',100*total_adaugat/total);
             
             % Afisam progresul imaginii
             if progres == 1
                 imshow(imgSintetizataMaiMare);
             end
        end
    end
    
    imgSintetizata = imgSintetizataMaiMare(1:size(imgSintetizata,1),1:size(imgSintetizata,2),:);
end