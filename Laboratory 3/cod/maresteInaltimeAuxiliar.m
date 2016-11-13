function img = maresteInaltimeAuxiliar(img,numarPixeliInaltime,metodaSelectareDrum,ploteazaDrum,culoareDrum)

    % Repetam procesul de marire la fiecare k pixeli adaugati
    inaltime = size(img,1);
    
    if inaltime * 0.25 < numarPixeliInaltime;
        iteratie_la = round(inaltime * 0.25 - 10);
    else
        iteratie_la = numarPixeliInaltime;
    end
    
    % Numarul de iteratii principale raportat la numarul de pixeli doriti
    % pentru marire si numarul de pixeli pe set de marire
    iteratii_principale = numarPixeliInaltime / iteratie_la;
    
    % Numarul de pixeli ramasi pentru adaugare
    iteratii_secundare = mod(numarPixeliInaltime,iteratie_la);
    
    for i = 1:iteratii_principale
        img = maresteInaltime(img,iteratie_la,metodaSelectareDrum,ploteazaDrum,culoareDrum);
    end
    
    if iteratii_secundare ~= 0
        img = maresteInaltime(img,iteratii_secundare,metodaSelectareDrum,ploteazaDrum,culoareDrum);
    end
end

