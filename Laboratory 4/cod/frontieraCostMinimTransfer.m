function [ imgSintetizata ] = frontieraCostMinimTransfer( params )
    % Imaginea texturii se completeaza cu blocuri bazare pe eroare de suprapunere
    % si a frontiere de cost minim.

    % Imaginea texturii se completeaza cu blocuri bazare pe eroare de suprapunere.

    % Setam parametrii de intrare
    nrBlocuriY            = params.nrBlocuriY;
    nrBlocuriX            = params.nrBlocuriX;
    nrBlocuri             = params.nrBlocuri;
    dimBloc               = params.dimBloc;
    imgSintetizataMaiMare = params.imgSintetizataMaiMare;
    blocuri               = params.blocuri;
    eroareTolerata        = params.eroareTolerata;
    suprapunere           = params.pixeli;
    imagineTransfer       = params.imagineTransfer;
    progres               = params.progresImagine;
    
    transfer.iteratieCurenta = params.iteratieCurenta;
    transfer.totalIteratii = params.totalIteratii;
    
    if size(imagineTransfer,3) ~= 1
        imagineTransfer = rgb2gray(imagineTransfer);
    end
    
    % Punem primul bloc in imagine
    bloc_imagine = imagineTransfer(1:dimBloc, 1:dimBloc,:);
    erori = zeros(1,nrBlocuri);
    for i = 1:nrBlocuri
        bloc_curent = rgb2gray(blocuri(:,:,:,i));
        erori(i) = (sum(sum(bloc_imagine - bloc_curent)).^2);
    end
    
    threshold = 1 + eroareTolerata;
    eroare_minima = min(erori);
    blocuri_selectate = zeros(size(blocuri));
    blocuri_adaugate = 1;
    indexi_originali = zeros(1,nrBlocuri);
    for i = 1:nrBlocuri
        if erori(i) <= eroare_minima * threshold
            blocuri_selectate(:,:,:,blocuri_adaugate) = blocuri(:,:,:,i);
            indexi_originali(1,blocuri_adaugate) = i;
            blocuri_adaugate = blocuri_adaugate + 1;
        end
    end
    index_generat = randi(blocuri_adaugate-1);
    indice = indexi_originali(1,index_generat);
    imgSintetizataMaiMare(1:dimBloc,1:dimBloc,:) = blocuri(:,:,:,indice);
    
    clc
    fprintf('Initializam procesul de transfer a texturii \npe baza erorii de suprapunere si a frontierei \nde cost minim ...\n');
    
    pixeli_adaugati = dimBloc;
    for x = 1:nrBlocuriX + 1
        if pixeli_adaugati + dimBloc <= size(imagineTransfer,2)
            bloc_stanga = rgb2gray(imgSintetizataMaiMare(1:dimBloc,pixeli_adaugati - dimBloc + 1:pixeli_adaugati,:));

            transfer.bloc_imagine_transfer = imagineTransfer(1:dimBloc, pixeli_adaugati+1:pixeli_adaugati + dimBloc,:);

            [indice, bloc, ~] = cautaEroareMinimaTransfer(bloc_stanga,0,blocuri,suprapunere,nrBlocuri,eroareTolerata,transfer);
            drum = cautaDrumMinimStanga(bloc);

            bloc_stanga_imagine = imgSintetizataMaiMare(1:dimBloc,pixeli_adaugati - dimBloc + 1:pixeli_adaugati,:);
            bloc_dreapta_imagine = blocuri(:,:,:,indice);

            overlap_stanga = bloc_stanga_imagine(:,end-suprapunere+1:end,:);
            overlap_dreapta = bloc_dreapta_imagine(:,1:suprapunere,:);

            for i = 1:size(drum,1)
                coloana = drum(i,2); 
                overlap_stanga(i,coloana+1:end,:) = overlap_dreapta(i,coloana+1:end,:);
            end

            imgSintetizataMaiMare(1:dimBloc,pixeli_adaugati + 1 - suprapunere:pixeli_adaugati,:) = overlap_stanga(:,:,:);
            imgSintetizataMaiMare(1:dimBloc,pixeli_adaugati + 1:pixeli_adaugati + dimBloc - suprapunere,:) = blocuri(:,suprapunere+1:end,:,indice);

            % Afisam progresul imaginii
             if progres == 1
                 imshow(imgSintetizataMaiMare);
             end

            pixeli_adaugati = pixeli_adaugati + (dimBloc - suprapunere);        
        end
    end
   
    pixeli_adaugati = dimBloc;
    for y = 1:nrBlocuriY
        if pixeli_adaugati + dimBloc <= size(imagineTransfer,1)
            bloc_sus = rgb2gray(imgSintetizataMaiMare(pixeli_adaugati - dimBloc + 1:pixeli_adaugati,1:dimBloc,:));  
            
            transfer.bloc_imagine_transfer = imagineTransfer(pixeli_adaugati+1:pixeli_adaugati + dimBloc, 1:dimBloc,:);

            [indice, ~, bloc] = cautaEroareMinimaTransfer(0,bloc_sus,blocuri,suprapunere,nrBlocuri,eroareTolerata,transfer);
            drum = cautaDrumMinimSus(bloc);

            bloc_sus_imagine = imgSintetizataMaiMare(pixeli_adaugati - dimBloc + 1:pixeli_adaugati,1:dimBloc,:);
            bloc_jos_imagine = blocuri(:,:,:,indice);

            overlap_sus = bloc_sus_imagine(end-suprapunere+1:end,:,:);
            overlap_jos = bloc_jos_imagine(1:suprapunere,:,:);

            for i = 1:size(drum,1)
                linia = drum(i,1); 
                overlap_sus(linia+1:end,i,:) = overlap_jos(linia+1:end,i,:);
            end

            imgSintetizataMaiMare(pixeli_adaugati + 1 - suprapunere:pixeli_adaugati,1:dimBloc,:) = overlap_sus(:,:,:);
            imgSintetizataMaiMare(pixeli_adaugati + 1:pixeli_adaugati + dimBloc - suprapunere,1:dimBloc,:) = blocuri(suprapunere+1:end,:,:,indice);

            % Afisam progresul imaginii
             if progres == 1
                 imshow(imgSintetizataMaiMare);
             end

            pixeli_adaugati = pixeli_adaugati + (dimBloc - suprapunere);
        end 
    end
    
    % Completam restul imaginii
    total_adaugat = nrBlocuriX + nrBlocuriY - 1;
    total = nrBlocuriX * nrBlocuriY;
    
    pixeli_adaugati_orizontal = dimBloc;
    for y=2:nrBlocuriY
        if pixeli_adaugati_orizontal + dimBloc <= size(imagineTransfer,1)
            pixeli_adaugati_vertical = dimBloc;
            for x=2:nrBlocuriX
                if pixeli_adaugati_vertical + dimBloc < size(imagineTransfer,2)
                    bloc_stanga = rgb2gray(imgSintetizataMaiMare(pixeli_adaugati_orizontal + 1:pixeli_adaugati_orizontal + dimBloc,pixeli_adaugati_vertical - dimBloc + 1:pixeli_adaugati_vertical,:));    
                    bloc_sus = rgb2gray(imgSintetizataMaiMare(pixeli_adaugati_orizontal - dimBloc + 1:pixeli_adaugati_orizontal,pixeli_adaugati_vertical + 1:pixeli_adaugati_vertical + dimBloc,:));

                    transfer.bloc_imagine_transfer = imagineTransfer(pixeli_adaugati_orizontal+1:pixeli_adaugati_orizontal + dimBloc, pixeli_adaugati_vertical+1:pixeli_adaugati_vertical+dimBloc,:);

                    [indice, bloc_st, bloc_su] = cautaEroareMinimaTransfer(bloc_stanga,bloc_sus,blocuri,suprapunere,nrBlocuri,eroareTolerata,transfer);
                    drum_stanga = cautaDrumMinimStanga(bloc_st); 
                    drum_sus = cautaDrumMinimSus(bloc_su); 

                    bloc_stanga_imagine = imgSintetizataMaiMare(pixeli_adaugati_orizontal + 1 - suprapunere:pixeli_adaugati_orizontal + dimBloc - suprapunere,pixeli_adaugati_vertical - dimBloc + 1:pixeli_adaugati_vertical,:);
                    bloc_dreapta_imagine = blocuri(:,:,:,indice);

                    overlap_stanga = bloc_stanga_imagine(:,end-suprapunere+1:end,:);
                    overlap_dreapta = bloc_dreapta_imagine(:,1:suprapunere,:);

                    for i = 1:size(drum_stanga,1)
                        coloana = drum_stanga(i,2); 
                        overlap_stanga(i,coloana+1:end,:) = overlap_dreapta(i,coloana+1:end,:);
                    end

                    % suprapunem overlap stanga
                    imgSintetizataMaiMare(pixeli_adaugati_orizontal + 1 - suprapunere:pixeli_adaugati_orizontal + dimBloc - suprapunere,pixeli_adaugati_vertical + 1 - suprapunere:pixeli_adaugati_vertical,:) = overlap_stanga(:,:,:);

                    bloc_sus_imagine = imgSintetizataMaiMare(pixeli_adaugati_orizontal - dimBloc + 1:pixeli_adaugati_orizontal,pixeli_adaugati_vertical + 1 - suprapunere:pixeli_adaugati_vertical + dimBloc - suprapunere,:);
                    bloc_jos_imagine = blocuri(:,:,:,indice);

                    overlap_sus = bloc_sus_imagine(end-suprapunere+1:end,:,:);
                    overlap_jos = bloc_jos_imagine(1:suprapunere,:,:);

                    for i = 1:size(drum_sus,1)
                        linia = drum_sus(i,1); 
                        overlap_sus(linia+1:end,i,:) = overlap_jos(linia+1:end,i,:);
                    end

                    % suprapunem overlap sus
                    imgSintetizataMaiMare(pixeli_adaugati_orizontal + 1 - suprapunere:pixeli_adaugati_orizontal,pixeli_adaugati_vertical + 1 - suprapunere:pixeli_adaugati_vertical + dimBloc - suprapunere,:) = overlap_sus(:,:,:);

                    % adaugam restul imaginii
                    imgSintetizataMaiMare(pixeli_adaugati_orizontal + 1:pixeli_adaugati_orizontal + dimBloc - suprapunere,pixeli_adaugati_vertical+ 1:pixeli_adaugati_vertical + dimBloc - suprapunere,:) = blocuri(suprapunere+1:end,suprapunere+1:end,:,indice);         

                    % crestem numarul de pixeli adaugati pe vertical
                    pixeli_adaugati_vertical = pixeli_adaugati_vertical + (dimBloc - suprapunere);

                     % Afisam progresul procentual
                     total_adaugat = total_adaugat + 1;
                     clc
                     fprintf('Transferam textura pe imagine ... %2.2f%% \n',100*total_adaugat/total);

                     % Afisam progresul imaginii
                     if progres == 1
                         imshow(imgSintetizataMaiMare);
                     end

                end
            end
            pixeli_adaugati_orizontal = pixeli_adaugati_orizontal + (dimBloc - suprapunere);
        end
    end
    
    clc
    fprintf('Transferam textura pe imagine ... %2.2f%% \n',100);
    
    % Determinam portiunile pana la care s-au scris pixeli
    for i = 1:size(imgSintetizataMaiMare,1)
        if imgSintetizataMaiMare(i,1,:) == 0
            y_min = i;
            break;
        end
    end
    y_min = y_min - 1;
    
    for i = 1:size(imgSintetizataMaiMare,2)
        if imgSintetizataMaiMare(1,i,:) == 0
            x_min = i;
            break;
        end
    end
    x_min = x_min - 1;
    
    imgSintetizata = imgSintetizataMaiMare(1:y_min,1:x_min,:);
end