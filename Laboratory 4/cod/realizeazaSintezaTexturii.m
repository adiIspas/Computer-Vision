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
    %nrBlocuriY = ceil((size(imgSintetizata,1) - overlap) / (dimBloc - overlap));
    nrBlocuriY            = ceil(size(imgSintetizata,1)/dimBloc);
    %nrBlocuriX = ceil((size(imgSintetizata,2) - overlap) / (dimBloc - overlap));
    nrBlocuriX            = ceil(size(imgSintetizata,2)/dimBloc);
        
    size_1 = round((nrBlocuriY - 1) * (dimBloc - overlap) + dimBloc);
    size_2 = round((nrBlocuriX - 1) * (dimBloc - overlap) + dimBloc);
    imgSintetizataMaiMare = uint8(zeros(size_1,size_2,size(parametri.texturaInitiala,3)));
        
    % Setam parametrii de lucru
    params.nrBlocuriY            = nrBlocuriY;
    params.nrBlocuriX            = nrBlocuriX;
    params.nrBlocuri             = nrBlocuri;
    params.blocuri               = blocuri;
    params.dimBloc               = dimBloc;
    params.imgSintetizataMaiMare = imgSintetizataMaiMare;
    params.imgSintetizata        = imgSintetizata;
    params.eroareTolerata        = parametri.eroareTolerata;
    params.pixeli                = pixeli;
    params.progresImagine        = parametri.progresImagine;
    params.iteratii              = 0;
    params.iteratiaCurenta       = 0;
    
    switch parametri.metodaSinteza
        case 'blocuriAleatoare'
            %%
            % Completeaza imaginea de obtinut cu blocuri aleatoare
            imgSintetizata = blocuriAleatoare(params);
            
            close all;
            figure, imshow(parametri.texturaInitiala)
            figure, imshow(imgSintetizata);
            title('Rezultat obtinut pentru blocuri selectatate aleator');
            return
        case 'eroareSuprapunere'
            %%
            % Completeaza imaginea de obtinut cu blocuri ales in functie 
            % de eroare de suprapunere  
            imgSintetizata = eroareSuprapunere(params);
            
            close all;
            figure, imshow(parametri.texturaInitiala)
            figure, imshow(imgSintetizata);
            title('Rezultat obtinut pentru blocuri selectate pe baza erorii de suprapunere');
            return
            
        case 'frontieraCostMinim'
            %%
            % Completeaza imaginea de obtinut cu blocuri ales in functie 
            % de eroare de suprapunere + forntiera de cost minim
            
            imgSintetizata = frontieraCostMinim(params);
            
            close all;
            figure, imshow(parametri.texturaInitiala)
            figure, imshow(imgSintetizata);
            title('Rezultat obtinut pentru blocuri selectate pe baza erorii de suprapunere si a frontierei de cost minim');
            return
        case 'transferTextura'
            %%
            % Transfera textura de pe o imagine de start pe o alta imagine
            
            params.iteratii = parametri.iteratiiTransfer;
            
            imgTransferTextura = frontieraCostMinim(params);
            close all;
            figure, imshow(parametri.texturaInitiala)
            figure, imshow(imgTransferTextura);
            title('Rezultat obtinut pentru transferul texturii');
            return
    end 
end