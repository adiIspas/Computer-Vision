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
    
    % Punem prima linie in imagine
    for x = 1:nrBlocuriX
        
%         if x == 1
            bloc_stanga = rgb2gray(imgSintetizataMaiMare(1:dimBloc,(x-1)*dimBloc+1:x*dimBloc-pixeli,:));
%         else
%             bloc_stanga = rgb2gray(imgSintetizataMaiMare(1:dimBloc,(x-1)*dimBloc+1-pixeli:x*dimBloc-pixeli,:));
%         end
%             imshow(bloc_stanga)
%             pause(1)
        [indice, bloc, ~] = cautaEroareMinima(bloc_stanga,0,blocuri,pixeli,nrBlocuri,eroareTolerata);
        drum = cautaDrumMinimStanga(bloc);
        
        imshow(imgSintetizataMaiMare(1:dimBloc,(x-1)*dimBloc+1:x*dimBloc-pixeli,:))
        
        img_1 = imgSintetizataMaiMare(1:dimBloc,(x-1)*dimBloc+1:x*dimBloc-pixeli,:);
        img_2 = blocuri(:,:,:,indice);
        for i = 1:size(drum,1)
             coloana = drum(i,2);
            
%              coloana
%              img_1(i,end-pixeli+1+coloana:end,:) = img_2(i,coloana+1:pixeli,:);
                img_1(i,end-pixeli+1+coloana:end,:) = 0;
                img_2(i,1:coloana,:) = 0;
%              
%              coloana
%              size(imgSintetizataMaiMare(i,x*dimBloc+1-jumatate-pixeli+coloana:x*dimBloc-jumatate,:))
%              size(blocuri(i,coloana+1:pixeli,:,indice))
             
          imgSintetizataMaiMare(i,x*dimBloc+1-pixeli+coloana:x*dimBloc,:) = blocuri(i,coloana+1:pixeli,:,indice);
          imgSintetizataMaiMare(i,x*dimBloc+1:(x+1)*dimBloc-pixeli,:) = blocuri(i,pixeli+1:end,:,indice);
          imshow(imgSintetizataMaiMare)
              
             %pause(100);
             %imgSintetizataMaiMare(i,x*dimBloc+1-jumatate:(x+1)*dimBloc-jumatate,:) = blocuri(i,:,:,indice);
        end
%         figure
%         imshow(img_1)
%         figure
%         imshow(img_2)
%         pause(1000);
        imgSintetizataMaiMare(1:dimBloc,(x-1)*dimBloc+1:x*dimBloc-pixeli,:) = img_1;
%         size(imgSintetizataMaiMare(1:dimBloc,x*dimBloc+1-jumatate:(x+1)*dimBloc-jumatate,:))
%         size(img_2(1:dimBloc,pixeli+1:end,:))
%         imgSintetizataMaiMare(1:dimBloc,x*dimBloc+1-pixeli:(x+1)*dimBloc-pixeli-pixeli,:) = img_2(1:dimBloc,pixeli+1:end,:);
        imgSintetizataMaiMare(1:dimBloc,x*dimBloc+1-pixeli:(x+1)*dimBloc-pixeli,:) = img_2;
        
    end
    
    imshow(imgSintetizataMaiMare)
    pause(1000);
    
    
%     clc
%     fprintf('Initializam procesul de sintetizare a imaginii \npe baza frontierei de cost minim ...\n');
%     
%     % Punem prima linie in imagine
%     for x = 1:nrBlocuriX
%         bloc_stanga = rgb2gray(imgSintetizataMaiMare(1:dimBloc,(x-1)*(dimBloc-pixeli)+1:x*(dimBloc-pixeli)+pixeli,:));
% 
%         [indice, bloc, ~] = cautaEroareMinima(bloc_stanga,0,blocuri,pixeli,nrBlocuri,eroareTolerata);
%         drum = cautaDrumMinimStanga(bloc);
% 
%         for i = 1:size(drum,1)
%              coloana = drum(i,2);
%              imgSintetizataMaiMare(i,x*(dimBloc-pixeli)+coloana:(x+1)*(dimBloc-pixeli)+pixeli,:) = blocuri(i,coloana:end,:,indice);
%         end
%     end
    
   
    % Punem prima coloana in imagine
    for y = 1:nrBlocuriY
        bloc_sus = rgb2gray(imgSintetizataMaiMare((y-1)*(dimBloc-pixeli)+1:y*(dimBloc-pixeli)+pixeli,1:dimBloc,:));
        
        [indice, bloc, ~] = cautaEroareMinima(0,bloc_sus,blocuri,pixeli,nrBlocuri,eroareTolerata);
        drum = cautaDrumMinimSus(bloc);
        
        imshow(imgSintetizataMaiMare((y-1)*(dimBloc-pixeli)+1:y*(dimBloc-pixeli)+pixeli,1:dimBloc,:))
     
        for i = 1:size(drum,1)
            linia = drum(i,1);
            imgSintetizataMaiMare(y*(dimBloc-pixeli)+linia:(y+1)*(dimBloc-pixeli)+pixeli,i,:) = blocuri(linia:end,i,:,indice);
        end
    end
    
    % Completam restul imaginii
    total_adaugat = 0;
    total = nrBlocuriX * nrBlocuriY;
    for y=1:nrBlocuriY
        for x=1:nrBlocuriX
             bloc_stanga = rgb2gray(imgSintetizataMaiMare(1:dimBloc,(x-1)*dimBloc+1:x*dimBloc-pixeli,:));
             bloc_sus = rgb2gray(imgSintetizataMaiMare((y-1)*dimBloc+1:y*dimBloc-pixeli,1:dimBloc,:));
             
             indice = cautaEroareMinima(bloc_stanga,bloc_sus,blocuri,pixeli,nrBlocuri, eroareTolerata);
             
             imgSintetizataMaiMare(y*dimBloc+1-pixeli:(y+1)*dimBloc-pixeli,x*dimBloc+1-pixeli:(x+1)*dimBloc-pixeli,:) = blocuri(:,:,:,indice);
             
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