function imgSintetizata = realizeazaSintezaTexturii(parametri)
    dimBloc = parametri.dimensiuneBloc;
    nrBlocuri = parametri.nrBlocuri;

    [inaltimeTexturaInitiala,latimeTexturaInitiala,nrCanale] = size(parametri.texturaInitiala);
    H = inaltimeTexturaInitiala;
    W = latimeTexturaInitiala;
    c = nrCanale;

    H2 = parametri.dimensiuneTexturaSintetizata(1);
    W2 = parametri.dimensiuneTexturaSintetizata(2);
    overlap = parametri.portiuneSuprapunere;
    pixeli = dimBloc * overlap;
    
    % O imagine este o matrice cu 3 dimensiuni: inaltime x latime x nrCanale
    % Variabila blocuri - matrice cu 4 dimensiuni: punem fiecare bloc (portiune din textura initiala) 
    % unul peste altul 
    dims = [dimBloc dimBloc c nrBlocuri];
    blocuri = uint8(zeros(dims(1), dims(2),dims(3),dims(4)));

    % Selecteaza blocuri aleatoare din textura initiala
    % genereaza (in maniera vectoriala) punctul din stanga sus al blocurilor
    y = randi(H-dimBloc+1,nrBlocuri,1);
    x = randi(W-dimBloc+1,nrBlocuri,1);
    
    % Extrage portiunea din textura initiala continand blocul
    for i =1:nrBlocuri
        blocuri(:,:,:,i) = parametri.texturaInitiala(y(i):y(i)+dimBloc-1,x(i):x(i)+dimBloc-1,:);
    end

    imgSintetizata = uint8(zeros(H2,W2,c));
    nrBlocuriY = ceil(size(imgSintetizata,1)/dimBloc);
    nrBlocuriX = ceil(size(imgSintetizata,2)/dimBloc);
    imgSintetizataMaiMare = uint8(zeros(nrBlocuriY * dimBloc,nrBlocuriX * dimBloc,size(parametri.texturaInitiala,3)));

    switch parametri.metodaSinteza

        case 'blocuriAleatoare'
            %%
            % Completeaza imaginea de obtinut cu blocuri aleatoare
            for y=1:nrBlocuriY
                for x=1:nrBlocuriX
                    indice = randi(nrBlocuri);
                    imgSintetizataMaiMare((y-1)*dimBloc+1:y*dimBloc,(x-1)*dimBloc+1:x*dimBloc,:)=blocuri(:,:,:,indice);
                end
            end

            imgSintetizata = imgSintetizataMaiMare(1:size(imgSintetizata,1),1:size(imgSintetizata,2),:);

            figure, imshow(parametri.texturaInitiala)
            figure, imshow(imgSintetizata);
            title('Rezultat obtinut pentru blocuri selectatate aleator');
            return


        case 'eroareSuprapunere'
            %%
            % Completeaza imaginea de obtinut cu blocuri ales in functie de eroare de suprapunere  
            erori = zeros(1,nrBlocuri);
            for y=1:nrBlocuriY
                for x=1:nrBlocuriX
                    
                    % Verificam doar la stanga
                    if x == 1
                    
                        bloc_stanga = imgSintetizataMaiMare((y-1)*dimBloc+1:y*dimBloc,(x-1)*dimBloc+1:x*dimBloc,:);
                        
                        for i = 1:nrBlocuri
                            bloc_curent = blocuri(:,:,:,i);
                            
                            stanga = double(bloc_stanga(:,end-pixeli+1:end,:));
                            dreapta = double(bloc_curent(:,1:pixeli,:));
                            
                            value = sum(sum(sum(stanga - dreapta).^2));
            
                            erori(i) = value;
                        end
                        
                        [~, position] = min(erori);
                        
                    % Verificam doar sus
                    elseif y == 1
                    
                        bloc_sus = imgSintetizataMaiMare((y-1)*dimBloc+1:y*dimBloc,(x-1)*dimBloc+1:x*dimBloc,:);
                        
                        for i = 1:nrBlocuri
                            bloc_curent = blocuri(:,:,:,i);
                            
                            stanga = double(bloc_sus(end-pixeli+1:end,:,:));
                            dreapta = double(bloc_curent(1:pixeli,:,:));
                            
                            value = sum(sum(sum(stanga - dreapta).^2));
            
                            erori(i) = value;
                        end
                        
                        [~, position] = min(erori);
                        
                    % Verificam si la stanga si sus
                    else
                        
                    end
                    
                    
                    indice = position;
                    imgSintetizataMaiMare((y-1)*dimBloc+1:y*dimBloc,(x-1)*dimBloc+1:x*dimBloc,:)=blocuri(:,:,:,indice);
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