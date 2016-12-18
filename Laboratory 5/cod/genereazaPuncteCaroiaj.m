function puncteCaroiaj = genereazaPuncteCaroiaj(img,nrPuncteX,nrPuncteY,margine)
    % genereaza puncte pe baza unui caroiaj
    % un caroiaj este o retea de drepte orizontale si verticale de forma urmatoare:
    %
    %        |   |   |   |
    %      --+---+---+---+--
    %        |   |   |   |
    %      --+---+---+---+--
    %        |   |   |   |
    %      --+---+---+---+--
    %        |   |   |   |
    %      --+---+---+---+--
    %        |   |   |   |
    %
    % Input:
    %       img - imaginea input
    %       nrPuncteX - numarul de drepte verticale folosit la constructia caroiajului
    %                 - in desenul de mai sus aceste drepte sunt identificate cu simbolul |
    %       nrPuncteY - numarul de drepte orizontale folosit la constructia caroiajului
    %                 - in desenul de mai sus aceste drepte sunt identificate cu simbolul --
    %         margine - numarul de pixeli de la marginea imaginii (sus, jos, stanga, dreapta) pentru care nu se considera puncte
    % Output:
    %       puncteCaroiaj - matrice (nrPuncteX * nrPuncteY) X 2
    %                     - fiecare linie reprezinta un punct (y,x) de pe caroiaj aflat la intersectia dreptelor orizontale si verticale
    %                     - in desenul de mai sus aceste puncte sunt idenficate cu semnul +

    puncteCaroiaj = zeros(nrPuncteX*nrPuncteY,2);

    % Determinam numarul de pixel dintre punctele de caroiaj
    pasVertical = ceil((size(img,1) - 2 * margine) / (nrPuncteY-1));
    pasOrizontal = ceil((size(img,2) - 2 * margine) / (nrPuncteX-1));
    % Indexul curent al punctului determinat
    
    idx = 1;
    indiceVertical = margine;
    for i = 1:nrPuncteY
        indiceOrizontal = margine;
        for j = 1:nrPuncteX 
            puncteCaroiaj(idx,1) = indiceVertical;
            puncteCaroiaj(idx,2) = indiceOrizontal;
            idx = idx + 1;
            
            indiceOrizontal = indiceOrizontal + pasOrizontal;
            if indiceOrizontal > size(img,2) - margine
                indiceOrizontal = size(img,2) - margine;
            end
        end
        indiceVertical = indiceVertical + pasVertical;
        if indiceVertical > size(img,1) - margine
            indiceVertical = size(img,1) - margine;
        end
    end
    
    % Pentru validarea datelor
    idx = 1;
    img = uint8(img);
    for i = 1:nrPuncteX
        for j = 1:nrPuncteY
            if puncteCaroiaj(idx,1)
                img(puncteCaroiaj(idx,1),puncteCaroiaj(idx,2)) = 255;
                idx = idx + 1;
            end
        end
    end
    
    imshow(img)
end