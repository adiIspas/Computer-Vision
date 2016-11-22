function [ imgSintetizata ] = frontieraCostMinim( params )
    % Imaginea texturii se completeaza cu blocuri bazare pe eroare de suprapunere
    % si a frontiere de cost minim.

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
    
    %jumatate = round(pixeli/2);
    %jumatate = pixeli; % alternativa de suprapunere, in cazul acesta intru-totul
    %jumatate = 0;
    clc
    fprintf('Initializam procesul de sintetizare a imaginii \npe baza erorii de suprapunere ...\n');
    
    for x = 1:nrBlocuriX
        if x == 1
            bloc_stanga = rgb2gray(imgSintetizataMaiMare(1:dimBloc,(x-1)*(dimBloc-pixeli)+1:x*(dimBloc-pixeli)+pixeli,:));
        else
            bloc_stanga = rgb2gray(imgSintetizataMaiMare(1:dimBloc,(x-1)*(dimBloc-pixeli)+1-pixeli:x*(dimBloc-pixeli),:));    
        end
        
        [indice, bloc, ~] = cautaEroareMinima(bloc_stanga,0,blocuri,pixeli,nrBlocuri,eroareTolerata);
        drum = cautaDrumMinimStanga(bloc);

        for i = 1:size(drum,1)
            coloana = drum(i,2); 
            imgSintetizataMaiMare(i,x*(dimBloc-pixeli)+1-pixeli+coloana:(x+1)*(dimBloc-pixeli),:) = blocuri(i,coloana+1:end,:,indice);
        end
    end

    % Punem prima coloana in imagine
    for y = 1:nrBlocuriX
        if y == 1
            bloc_sus = rgb2gray(imgSintetizataMaiMare((y-1)*(dimBloc-pixeli)+1:y*(dimBloc-pixeli)+pixeli,1:dimBloc,:));
        else
            bloc_sus = rgb2gray(imgSintetizataMaiMare((y-1)*(dimBloc-pixeli)+1-pixeli:y*(dimBloc-pixeli),1:dimBloc,:)); 
        end
        
        [indice, ~, bloc] = cautaEroareMinima(0,bloc_sus,blocuri,pixeli,nrBlocuri,eroareTolerata);
        drum = cautaDrumMinimSus(bloc);
        for i = 1:size(drum,1)
            linia = drum(i,1); 
            imgSintetizataMaiMare(y*(dimBloc-pixeli)+1-pixeli+linia:(y+1)*(dimBloc-pixeli),i,:) = blocuri(linia+1:end,i,:,indice);
        end
    end
    
    imshow(imgSintetizataMaiMare)
    
    % Completam restul imaginii
    total_adaugat = 0;
    total = nrBlocuriX * nrBlocuriY;
    for y=2:nrBlocuriY
        for x=2:nrBlocuriX

            bloc_stanga = rgb2gray(imgSintetizataMaiMare((y-1)*(dimBloc)+1:(y)*(dimBloc),(x-2)*(dimBloc-pixeli)+1:(x-1)*(dimBloc-pixeli),:));    
            bloc_sus = rgb2gray(imgSintetizataMaiMare((y-2)*(dimBloc-pixeli)+1:(y-1)*(dimBloc-pixeli),(x-1)*(dimBloc)+1:(x)*(dimBloc),:));
            
%             size(bloc_stanga)
%             size(bloc_sus)
            
            [indice, bloc_st, bloc_su] = cautaEroareMinima(bloc_stanga,bloc_sus,blocuri,pixeli,nrBlocuri,eroareTolerata);
            drum_stanga = cautaDrumMinimStanga(bloc_st); 
            drum_sus = cautaDrumMinimSus(bloc_su); 
            
            for i = 1:size(drum_stanga,1)
                coloana = drum_stanga(i,2); 
                imgSintetizataMaiMare(i,x*(dimBloc-pixeli)+1-pixeli+coloana:(x+1)*(dimBloc-pixeli),:) = blocuri(i,coloana+1:end,:,indice);
            end
            
            for i = 1:size(drum_sus,1)
                linia = drum_sus(i,1); 
                imgSintetizataMaiMare(y*(dimBloc-pixeli)+1-pixeli+linia:(y+1)*(dimBloc-pixeli),i,:) = blocuri(linia+1:end,i,:,indice);
            end
             
             %imgSintetizataMaiMare(y*dimBloc+1-pixeli:(y+1)*dimBloc-pixeli,x*dimBloc+1-pixeli:(x+1)*dimBloc-pixeli,:) = blocuri(:,:,:,indice);
             
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
    
    imgSintetizata = imgSintetizataMaiMare(1:size(imgSintetizata,1),1:size(imgSintetizata,2),:);
end