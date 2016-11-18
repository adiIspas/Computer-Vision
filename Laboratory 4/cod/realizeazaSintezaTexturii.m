function imgSintetizata = realizeazaSintezaTexturii(parametri)
    dimBloc   = parametri.dimensiuneBloc;
    nrBlocuri = parametri.nrBlocuri;

    [inaltimeTexturaInitiala,latimeTexturaInitiala,nrCanale] = size(parametri.texturaInitiala);
    H = inaltimeTexturaInitiala;
    W = latimeTexturaInitiala;
    c = nrCanale;

    H2 = parametri.dimensiuneTexturaSintetizata(1);
    W2 = parametri.dimensiuneTexturaSintetizata(2);
    
    overlap = parametri.portiuneSuprapunere;
    pixeli  = dimBloc * overlap;
    
    % O imagine este o matrice cu 3 dimensiuni: inaltime x latime x nrCanale
    % Variabila blocuri - matrice cu 4 dimensiuni: punem fiecare bloc (portiune din textura initiala) 
    % unul peste altul 
    dims    = [dimBloc dimBloc c nrBlocuri];
    blocuri = uint8(zeros(dims(1),dims(2),dims(3),dims(4)));

    % Selecteaza blocuri aleatoare din textura initiala
    % genereaza (in maniera vectoriala) punctul din stanga sus al blocurilor
    y = randi(H-dimBloc+1,nrBlocuri,1);
    x = randi(W-dimBloc+1,nrBlocuri,1);
    
    % Extrage portiunea din textura initiala continand blocul
    for i = 1:nrBlocuri
        blocuri(:,:,:,i) = parametri.texturaInitiala(y(i):y(i)+dimBloc-1,x(i):x(i)+dimBloc-1,:);
    end

    imgSintetizata        = uint8(zeros(H2,W2,c));
    nrBlocuriY            = ceil(size(imgSintetizata,1)/dimBloc);
    nrBlocuriX            = ceil(size(imgSintetizata,2)/dimBloc);
    imgSintetizataMaiMare = uint8(zeros(nrBlocuriY * dimBloc,nrBlocuriX * dimBloc,size(parametri.texturaInitiala,3)));

    switch parametri.metodaSinteza

        case 'blocuriAleatoare'
            %%
            % Setam parametrii de lucru
            params.nrBlocuriY            = nrBlocuriY;
            params.nrBlocuriX            = nrBlocuriX;
            params.nrBlocuri             = nrBlocuri;
            params.blocuri               = blocuri;
            params.dimBloc               = dimBloc;
            params.imgSintetizataMaiMare = imgSintetizataMaiMare;
            params.imgSintetizata        = imgSintetizata;
            
            % Completeaza imaginea de obtinut cu blocuri aleatoare
            imgSintetizata = blocuriAleatoare(params);

            figure, imshow(parametri.texturaInitiala)
            figure, imshow(imgSintetizata);
            title('Rezultat obtinut pentru blocuri selectatate aleator');
            return
        case 'eroareSuprapunere'
            %%
            % Completeaza imaginea de obtinut cu blocuri ales in functie de eroare de suprapunere  
            erori = zeros(1,nrBlocuri);
            
            % Punem primul bloc in imagine
            imgSintetizataMaiMare(1:dimBloc,1:dimBloc,:) = blocuri(:,:,:,1);
            
            % Punem prima linie in imagine
            for x = 1:nrBlocuriX-1
                bloc_stanga = imgSintetizataMaiMare(1:dimBloc,(x-1)*dimBloc+1:x*dimBloc,:);
                
                for i = 1:nrBlocuri
                    bloc_curent = blocuri(:,:,:,i);

                    stanga = double(bloc_stanga(:,end-pixeli+1:end,:));
                    dreapta = double(bloc_curent(:,1:pixeli,:));

                    value = sum(sum(sum(stanga - dreapta).^2));

                    erori(i) = value;
                end
                
                [~, indice] = min(erori);
                imgSintetizataMaiMare(1:dimBloc,x*dimBloc+1:(x+1)*dimBloc,:)=blocuri(:,:,:,indice);
            end
            
            % Punem prima coloana in imagine
            for y = 1:nrBlocuriY-1
                bloc_sus = imgSintetizataMaiMare((y-1)*dimBloc+1:y*dimBloc,1:dimBloc,:);
                
                for i = 1:nrBlocuri
                    bloc_curent = blocuri(:,:,:,i);

                    stanga = double(bloc_sus(end-pixeli+1:end,:,:));
                    dreapta = double(bloc_curent(1:pixeli,:,:));

                    value = sum(sum(sum(stanga - dreapta).^2));

                    erori(i) = value;
                end
                
                [~, indice] = min(erori);
                imgSintetizataMaiMare(y*dimBloc+1:(y+1)*dimBloc,1:dimBloc,:)=blocuri(:,:,:,indice);
            end
            
            % Completam restul imaginii
            for y=2:nrBlocuriY
                for x=2:nrBlocuriX
                    
                    bloc_stanga = imgSintetizataMaiMare((y-1)*dimBloc+1:y*dimBloc,(x-2)*dimBloc+1:(x-1)*dimBloc,:);
                    bloc_sus = imgSintetizataMaiMare((y-2)*dimBloc+1:(y-1)*dimBloc,(x-1)*dimBloc+1:x*dimBloc,:);
                    
                    value = zeros(1,2);
                    for i = 1:nrBlocuri
                        bloc_curent = blocuri(:,:,:,i);
                        
                        stanga = double(bloc_stanga(:,end-pixeli+1:end,:));
                        dreapta = double(bloc_curent(:,1:pixeli,:));

                        value(1) = sum(sum(sum(stanga - dreapta).^2));
                        
                        stanga = double(bloc_sus(end-pixeli+1:end,:,:));
                        dreapta = double(bloc_curent(1:pixeli,:,:));

                        value(2) = sum(sum(sum(stanga - dreapta).^2));
                        
                        
                        erori(i) = (value(1)+value(2))/2;
                    end
                    
                    [~, indice] = min(erori);
                    imgSintetizataMaiMare((y-1)*dimBloc+1:y*dimBloc,(x-1)*dimBloc+1:x*dimBloc,:)=blocuri(:,:,:,indice);
%                     close all;
%                     figure, imshow(imgSintetizataMaiMare);
%                     pause(0.3);
                end
            end

            imgSintetizata = imgSintetizataMaiMare(1:size(imgSintetizata,1),1:size(imgSintetizata,2),:);

            figure, imshow(parametri.texturaInitiala)
            figure, imshow(imgSintetizata);
            title('Rezultat obtinut pentru blocuri selectate pe baza erorii de suprapunere');
            return
            
        case 'frontieraCostMinim'
            %%
            % Completeaza imaginea de obtinut cu blocuri ales in functie de eroare de suprapunere + forntiera de cost minim


    end 
end