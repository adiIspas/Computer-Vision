function [ imagineTexturaTransferata ] = realizeazaTransferTextura( parametri )

    imagineTransfer = parametri.imagineTransfer;
    iteratii = parametri.iteratiiTransfer;
    
    % La fiecare iteratie va scadea la jumatate. Este optimizat pentru 5
    % iteratii.
    dimBloc = 18;
    
    nrBlocuri = parametri.nrBlocuri;
    [inaltimeTexturaInitiala,latimeTexturaInitiala,nrCanale] = size(parametri.texturaInitiala);
   
    H = inaltimeTexturaInitiala;
    W = latimeTexturaInitiala;
    c = nrCanale;
    
    overlap = parametri.portiuneSuprapunere;
    parametri.pixeli  = dimBloc * overlap;
    
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
    
    imagineTransferata = zeros(size(imagineTransfer));
    parametri.dimBloc = dimBloc;
    parametri.blocuri = blocuri;
    parametri.iteratii = iteratii;
    
    for j = 1:iteratii
        [inaltimeTexturaInitiala,latimeTexturaInitiala,nrCanale] = size(parametri.texturaInitiala);

        H = inaltimeTexturaInitiala;
        W = latimeTexturaInitiala;
        c = nrCanale;

        overlap = parametri.portiuneSuprapunere;
        parametri.pixeli  = dimBloc * overlap;
        
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

        imagineTransferata = zeros(size(imagineTransfer));
        parametri.dimBloc = dimBloc;
        parametri.blocuri = blocuri;
        parametri.iteratii = iteratii;
        
        nrBlocuriY = ceil(size(imagineTransferata,1)/dimBloc);
        nrBlocuriX = ceil(size(imagineTransferata,2)/dimBloc);
        size_1 = round((nrBlocuriY - 1) * (dimBloc - overlap) + dimBloc);
        size_2 = round((nrBlocuriX - 1) * (dimBloc - overlap) + dimBloc);
        imagineTransferataMaiMare = uint8(zeros(size_1,size_2,size(parametri.texturaInitiala,3)));
        
        parametri.nrBlocuriX = nrBlocuriX;
        parametri.nrBlocuriY = nrBlocuriY;
        parametri.imgSintetizata = imagineTransferata;
        parametri.imgSintetizataMaiMare = imagineTransferataMaiMare;
        parametri.iteratiaCurenta = i;
        
        imagineTransferata = frontieraCostMinim(parametri);
            
        close all;
        figure, imshow(parametri.texturaInitiala)
        figure, imshow(imagineTransferata);
        title('Rezultat obtinut pentru blocuri selectate pe baza erorii de suprapunere si a frontierei de cost minim');
        
        parametri.dimBloc = round(dimBloc/2);
        parametri.texturaInitiala = imagineTransferata;
    end
    
    imagineTexturaTransferata = imagineTransferata;
end

