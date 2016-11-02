function imgRedimensionata = redimensioneazaImagine(img,parametri)
%redimensioneaza imaginea
%
%input: img - imaginea initiala
%       parametri - stuctura de defineste modul in care face redimensionarea 
%
% output: imgRedimensionata - imaginea redimensionata obtinuta


optiuneRedimensionare = parametri.optiuneRedimensionare;
metodaSelectareDrum = parametri.metodaSelectareDrum;
ploteazaDrum = parametri.ploteazaDrum;
culoareDrum = parametri.culoareDrum;

switch optiuneRedimensionare
    
    case 'micsoreazaLatime'
        numarPixeliLatime = parametri.numarPixeliLatime;
        imgRedimensionata = micsoreazaLatime(img,numarPixeliLatime,metodaSelectareDrum,...
                            ploteazaDrum,culoareDrum);
        
    case 'miscoreazaInaltime'
        %completati aici codul vostru
        
    case 'maresteLatime'
        %completati aici codul vostru
        
    case 'maresteInaltime'
        %completati aici codul vostru
    
    case 'eliminaObiect'
        %completati aici codul vostru 
    
end