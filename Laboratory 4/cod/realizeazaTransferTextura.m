function [ imagineTexturaTransferata ] = realizeazaTransferTextura( parametri )
    nrIteratii = parametri.numarIteratii;
    parametri.dimBloc = parametri.dimensiuneBlocTransfer;
    suprapunere = parametri.portiuneSuprapunere;
    nume = parametri.numeImagine;
    
    tic
    for iteratie = 1:nrIteratii
        dimBloc = parametri.dimBloc;
        overlap = round(dimBloc * suprapunere);
        if overlap == 1
            overlap = 2;
        end
        nrBlocuri = parametri.nrBlocuri;

        [inaltimeTexturaInitiala,latimeTexturaInitiala,nrCanale] = size(parametri.texturaInitiala);
        H = inaltimeTexturaInitiala;
        W = latimeTexturaInitiala;
        c = nrCanale;

        H2 = size(parametri.imagineTransfer,1);
        W2 = size(parametri.imagineTransfer,2);

        dims    = [dimBloc dimBloc c nrBlocuri];
        blocuri = uint8(zeros(dims(1),dims(2),dims(3),dims(4)));

        y = randi(H-dimBloc+1,nrBlocuri,1);
        x = randi(W-dimBloc+1,nrBlocuri,1);

        for i = 1:nrBlocuri
            blocuri(:,:,:,i) = parametri.texturaInitiala(y(i):y(i)+dimBloc-1,x(i):x(i)+dimBloc-1,:);
        end

        imgSintetizata = uint8(zeros(H2,W2,c));
        nrBlocuriY = round((size(imgSintetizata,1) - overlap)/(dimBloc - overlap));
        nrBlocuriX = round((size(imgSintetizata,2) - overlap)/(dimBloc - overlap));

        imgSintetizataMaiMare = uint8(zeros(nrBlocuriY * dimBloc,nrBlocuriX * dimBloc,size(parametri.texturaInitiala,3)));

        params.dimBloc = dimBloc;
        params.imgSintetizataMaiMare = imgSintetizataMaiMare;
        params.imgSintetizata        = imgSintetizata;
        params.blocuri = blocuri;
        params.imagineTransfer = parametri.imagineTransfer;
        params.nrBlocuriY = nrBlocuriY;
        params.nrBlocuriX = nrBlocuriX;
        params.nrBlocuri = nrBlocuri;
        params.eroareTolerata = parametri.eroareTolerata;
        params.pixeli = overlap;
        params.progresImagine        = parametri.progresImagine;
        
        params.iteratieCurenta = iteratie;
        params.totalIteratii = nrIteratii;
        
        imagineTexturaTransferata = frontieraCostMinimTransfer(params);

        parametri.texturaInitiala = imagineTexturaTransferata;
        parametri.dimBloc = round(dimBloc / 2);
        imshow(imagineTexturaTransferata);
        imwrite(imagineTexturaTransferata,[nume '-transfer-textura-iteratie-' num2str(iteratie) '.jpg']);
    end  
    toc
end

