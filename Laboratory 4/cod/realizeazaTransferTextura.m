function [ imagineTexturaTransferata ] = realizeazaTransferTextura( parametri )

    dimBloc   = 7;
    overlap    = 2;
    nrBlocuri = parametri.nrBlocuri;

    [inaltimeTexturaInitiala,latimeTexturaInitiala,nrCanale] = size(parametri.texturaInitiala);
    H = inaltimeTexturaInitiala;
    W = latimeTexturaInitiala;
    c = nrCanale;

    H2 = size(parametri.imagineTransfer,1);
    W2 = size(parametri.imagineTransfer,2);
    
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
    
%     imgSintetizata        = uint8(zeros(H2,W2,c));
%     nrBlocuriY            = ceil(size(imgSintetizata,1)/dimBloc);
%     nrBlocuriX            = ceil(size(imgSintetizata,2)/dimBloc);
%         
%     size_1 = round((nrBlocuriY) * (dimBloc));
%     size_2 = round((nrBlocuriX) * (dimBloc));
%     imgSintetizataMaiMare = uint8(zeros(size_1,size_2,size(parametri.texturaInitiala,3)));

%     aux = dimBloc;
%     dimBloc = dimBloc - overlap;
    imgSintetizata = uint8(zeros(H2,W2,c));
%     nrBlocuriY = ceil(size(imgSintetizata,1)/dimBloc)
%     nrBlocuriX = ceil(size(imgSintetizata,2)/dimBloc)
%     
%     loseY = (nrBlocuriY - 1) * overlap
%     loseX = (nrBlocuriX - 1) * overlap
%     
%     nrBlocuriY = round(nrBlocuriY + (loseY/dimBloc) + 1)
%     nrBlocuriX = round(nrBlocuriX + (loseX/dimBloc) + 1)
    
    nrBlocuriY = round((size(imgSintetizata,1) - overlap)/(dimBloc - overlap))
    nrBlocuriX = round((size(imgSintetizata,2) - overlap)/(dimBloc - overlap))
    
    size(parametri.imagineTransfer)
    
    imgSintetizataMaiMare = uint8(zeros(nrBlocuriY * dimBloc,nrBlocuriX * dimBloc,size(parametri.texturaInitiala,3)));
    
    size(imgSintetizataMaiMare)

   
    
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

    imagineTexturaTransferata = frontieraCostMinimTransfer(params);
    
    imshow(imagineTexturaTransferata);
end

