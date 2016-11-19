function [ imgSintetizata ] = frontieraCostMinim( params )
    % Imaginea texturii se completeaza cu blocuri bazare pe eroare de suprapunere
    % si a frontiere de cost minim.

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
    jumatate = round(pixeli/2);
    
    clc
    fprintf('Initializam procesul de sintetizare a imaginii pe baza frontierei de cost minim ...\n');
    
    % Punem prima linie in imagine
    for x = 1:nrBlocuriX
        bloc_stanga = rgb2gray(imgSintetizataMaiMare(1:dimBloc,(x-1)*dimBloc+1:x*dimBloc-jumatate,:));
        
        [indice, bloc, ~] = cautaEroareMinima(bloc_stanga,0,blocuri,pixeli,nrBlocuri, eroareTolerata);
        
        drum = cautaDrumMinimStanga(bloc);
        x = imgSintetizataMaiMare(1:dimBloc,(x-1)*dimBloc+1:x*dimBloc-jumatate,:);
        y = blocuri(:,:,:,indice);
        z = zeros(36,72,3);
        for i = 1:size(drum,1)
            coloana = drum(i,2)
            %coloana = 0;
%               size(imgSintetizataMaiMare(i,x*dimBloc+1+coloana-pixeli:(x+1)*dimBloc-pixeli,:))
%               size(blocuri(i,coloana+1:end,:,indice))
              
              
              y(i,1:coloana,:) = 0;
              x(i,end+coloana+1-pixeli:end,:) = 0;
%               e = 36;
%               
%               %z = x;
%                size(z(i,e+coloana+1-pixeli:72,:))
%                size(y(i,coloana+1:36,:))
%                z(i,e+coloana+1-pixeli:72,:) = y(i,coloana+1:36,:);
              
%             size(imgSintetizataMaiMare(i,x*dimBloc+1-coloana:(x+1)*dimBloc-coloana,:))
%             size(blocuri(i,coloana+1:end,:,indice))
%             
%             imgSintetizataMaiMare(i,x*dimBloc+1-coloana:(x+1)*dimBloc-coloana,:) = ...
%                 blocuri(i,coloana+1:end,:,indice);
%             
%             close all;
%             figure, imshow(imgSintetizataMaiMare);
%             pause(0.1);
            %imgSintetizataMaiMare(i,x*dimBloc+1+coloana-pixeli:(x+1)*dimBloc-pixeli,:) = blocuri(i,coloana+1:end,:,indice);
            %imgSintetizataMaiMare(1:dimBloc,x*dimBloc+1-jumatate:(x+1)*dimBloc-jumatate,:) = blocuri(:,:,:,indice);
        end
        
        figure
        imshow(x);
        figure
        imshow(y);
        pause(10);
    end
    
    % Punem prima coloana in imagine
    for y = 1:nrBlocuriY
        bloc_sus = rgb2gray(imgSintetizataMaiMare((y-1)*dimBloc+1:y*dimBloc-jumatate,1:dimBloc,:));

        indice = cautaEroareMinima(0,bloc_sus,blocuri,pixeli,nrBlocuri, eroareTolerata);
        
        imgSintetizataMaiMare(y*dimBloc+1-jumatate:(y+1)*dimBloc-jumatate,1:dimBloc,:) = blocuri(:,:,:,indice);
    end
    
    % Completam restul imaginii
    total_adaugat = 0;
    total = nrBlocuriX * nrBlocuriY;
    for y=1:nrBlocuriY
        for x=1:nrBlocuriX
             bloc_stanga = rgb2gray(imgSintetizataMaiMare(1:dimBloc,(x-1)*dimBloc+1:x*dimBloc-jumatate,:));
             bloc_sus = rgb2gray(imgSintetizataMaiMare((y-1)*dimBloc+1:y*dimBloc-jumatate,1:dimBloc,:));
             
             indice = cautaEroareMinima(bloc_stanga,bloc_sus,blocuri,pixeli,nrBlocuri, eroareTolerata);
             
             imgSintetizataMaiMare(y*dimBloc+1-jumatate:(y+1)*dimBloc-jumatate,x*dimBloc+1-jumatate:(x+1)*dimBloc-jumatate,:) = blocuri(:,:,:,indice);
             
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