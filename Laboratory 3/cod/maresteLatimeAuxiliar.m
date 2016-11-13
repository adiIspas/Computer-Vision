function img = maresteLatimeAuxiliar(img,numarPixeliLatime,metodaSelectareDrum,ploteazaDrum,culoareDrum)

    % Repetam procesul de marire la fiecare k pixeli adaugati
    latime = size(img,2);
    
    if latime * 0.25 < numarPixeliLatime;
        iteratie_la = round(latime * 0.25 - 10);
    else
        iteratie_la = numarPixeliLatime;
    end 
    
    % Numarul de iteratii principale raportat la numarul de pixeli doriti
    % pentru marire si numarul de pixeli pe set de marire
    iteratii_principale = numarPixeliLatime / iteratie_la;
    
    % Numarul de pixeli ramasi pentru adaugare
    iteratii_secundare = mod(numarPixeliLatime,iteratie_la);
    
    for i = 1:iteratii_principale
        img = maresteLatime(img,iteratie_la,metodaSelectareDrum,ploteazaDrum,culoareDrum);
    end
    
    if iteratii_secundare ~= 0
        img = maresteLatime(img,iteratii_secundare,metodaSelectareDrum,ploteazaDrum,culoareDrum);
    end
end

