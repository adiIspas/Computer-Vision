function [descriptoriHOG, patchuri] = calculeazaHistogrameGradientiOrientati(img,puncte,dimensiuneCelula)
    % Calculeaza pentru fiecare punct de pe caroiaj, histograma de gradienti orientati
    % corespunzatoare dupa cum urmeaza:
    %  - considera cele 16 celule inconjuratoare si calculeaza pentru fiecare
    %  celula histograma de gradienti orientati de dimensiune 8;
    %  - concateneaza cele 16 histograme de dimeniune 8 intr-un descriptor de
    %  lungime 128 = 16*8;
    %  - fiecare celula are dimensiunea dimensiuneCelula x dimensiuneCelula (4x4 pixeli)
    %
    % Input:
    %     img - imaginea input
    %     puncte - puncte de pe caroiaj pentru care calculam histograma de
    %             gradienti orientati
    %     dimensiuneCelula - defineste cat de mare este celula
    %                    - fiecare celula este un patrat continand
    %                      dimensiuneCelula x dimensiuneCelula pixeli
    % Output:
    %        descriptoriHOG - matrice #Puncte X 128
    %                       - fiecare linie contine histograme de gradienti
    %                        orientati calculata pentru fiecare punct de pe
    %                        caroiaj
    %               patchuri - matrice #Puncte X (16 * dimensiuneCelula^2)
    %                       - fiecare linie contine pixelii din cele 16 celule
    %                         considerati pe coloana

    nBins = 8; %dimensiunea histogramelor fiecarei celule
    margine = 8;
    descriptoriHOG = zeros(0,nBins*4*4); % fiecare linie reprezinta concatenarea celor 16 histograme corespunzatoare fiecarei celule
    patchuri = zeros(0,4*dimensiuneCelula*4*dimensiuneCelula); % 

    if size(img,3)==3
        img = rgb2gray(img);
    end
    img = double(img);

    f = [-1 0 1];
    Ix = imfilter(img,f,'replicate');
    Iy = imfilter(img,f','replicate');

    orientare = atand(Ix./(Iy+eps)); %unghiuri intre -90 si 90 grade
    orientare = orientare + 90; %unghiuri intre 0 si 180 grade
    %completati codul
    %...
    
    for i = 1:size(puncte)
        patch = img(1+puncte(i,1)-margine:puncte(i,1)+margine,1+puncte(i,2)-margine:puncte(i,2)+margine);

    end
    
end
