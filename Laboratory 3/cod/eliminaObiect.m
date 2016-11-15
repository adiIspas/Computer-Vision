function imgRedimensionata = eliminaObiect(img, parametri)
    % Vom elimina din imagine obiectul delimitat de utilizator

    rect = parametri.rect;
    eliminare.elimina_obiect = 'da';
    metodaSelectareDrum = parametri.metodaSelectareDrum;
    ploteazaDrum = parametri.ploteazaDrum;
    culoareDrum = parametri.culoareDrum;

    % Extragem dimensiunile dreptunghiului

    height = size(img(rect(2):rect(2)+rect(4),rect(1):rect(1)+rect(3),:),1);
    width = size(img(rect(2):rect(2)+rect(4),rect(1):rect(1)+rect(3),:),2);
    eliminare.latime = width;
    eliminare.inaltime = height;

    numarPixeli = height + width;

    imgRedimensionata = micsoreazaLatime(img,numarPixeli,metodaSelectareDrum,...
                            ploteazaDrum,culoareDrum,rect,eliminare);
end
