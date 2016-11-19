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
    jumatate = round(pixeli/2);
    
    clc
    fprintf('Initializam procesul de sintetizare a imaginii pe baza erorii de suprapunere ...\n');
    
    % Punem prima linie in imagine
    for x = 1:nrBlocuriX
        bloc_stanga = rgb2gray(imgSintetizataMaiMare(1:dimBloc,(x-1)*dimBloc+1:x*dimBloc-jumatate,:));
        %imshow(imgSintetizataMaiMare(1:dimBloc,(x-1)*dimBloc+1:x*dimBloc-jumatate,:))
        
%         erori = zeros(1,nrBlocuri);
%         erori(1,:) = intmax('int64');
%         
%         for i = 1:nrBlocuri
%             bloc_curent =rgb2gray(blocuri(:,:,:,i));
% 
%             stanga = double(bloc_stanga(:,end-pixeli+1:end,:));
%             dreapta = double(bloc_curent(:,1:pixeli,:));
% 
%             eroare_suprapunere = sum(sum(stanga - dreapta).^2);
%             erori(i) = eroare_suprapunere + eroareTolerata * eroare_suprapunere;
%         end
% 
%         [~, indice] = min(erori);
        indice = cautaEroareMinima(bloc_stanga,0,blocuri,pixeli,nrBlocuri, eroareTolerata);
        imgSintetizataMaiMare(1:dimBloc,x*dimBloc+1-jumatate:(x+1)*dimBloc-jumatate,:) = blocuri(:,:,:,indice);
    end
    
    % Punem prima coloana in imagine
    for y = 1:nrBlocuriY
        bloc_sus = rgb2gray(imgSintetizataMaiMare((y-1)*dimBloc+1:y*dimBloc-jumatate,1:dimBloc,:));
        %imshow(imgSintetizataMaiMare((y-1)*dimBloc+1:y*dimBloc-jumatate,1:dimBloc,:))
        
%         erori = zeros(1,nrBlocuri);
%         erori(1,:) = intmax('int64');
%         
%         for i = 1:nrBlocuri
%             bloc_curent =rgb2gray(blocuri(:,:,:,i));
% 
%             sus = double(bloc_sus(end-pixeli+1:end,:,:));
%             jos = double(bloc_curent(1:pixeli,:,:));
% 
%             eroare_suprapunere = sum(sum(sus - jos).^2);
%             erori(i) = eroare_suprapunere + eroareTolerata * eroare_suprapunere;
%         end
% 
%         [~, indice] = min(erori);
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
             
%              erori = zeros(1,nrBlocuri);
%              erori(1,:) = intmax('int64');
%              
%              for i = 1:nrBlocuri
%                 bloc_curent =rgb2gray(blocuri(:,:,:,i));
% 
%                 sus = double(bloc_sus(end-pixeli+1:end,:,:));
%                 jos = double(bloc_curent(1:pixeli,:,:));
%                 
%                 stanga = double(bloc_stanga(:,end-pixeli+1:end,:));
%                 dreapta = double(bloc_curent(:,1:pixeli,:));
% 
%                 eroare_suprapunere = sum(sum(stanga - dreapta).^2) + sum(sum(sus - jos).^2);
%                 erori(i) = eroare_suprapunere + eroareTolerata * eroare_suprapunere;
%              end
% 
%              [~, indice] = min(erori);
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