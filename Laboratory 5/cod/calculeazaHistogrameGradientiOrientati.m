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
    %descriptoriHOG = zeros(0,nBins*4*4); % fiecare linie reprezinta concatenarea celor 16 histograme corespunzatoare fiecarei celule
    %patchuri = zeros(0,4*dimensiuneCelula*4*dimensiuneCelula); % 

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
    patchuri = [];
    descriptoriHOG = [];
    binranges = linspace(0,180,8);
    for i = 1:size(puncte)
        coordonataX = puncte(i,2);
        coordonataY = puncte(i,1);
        patchCurent = img(1+coordonataY-margine:coordonataY+margine,1+coordonataX-margine:coordonataX+margine);
        orientareCurenta = orientare(1+coordonataY-margine:coordonataY+margine,1+coordonataX-margine:coordonataX+margine);
        
        histogrameCurente = [];
        for idx_y = 1:4
            for idx_x = 1:4
                celula = patchCurent(1 + ((idx_y - 1) * 4):idx_y * 4, 1+((idx_x - 1) * 4):idx_x * 4);
                orientarePixeliCelula = orientareCurenta(1 + ((idx_y - 1) * 4):idx_y * 4, 1+((idx_x - 1) * 4):idx_x * 4);
                %histc(orientarePixeliCelula(:)',binranges)
                histogrameCurente = [histogrameCurente histc(orientarePixeliCelula(:)',binranges)];
            end
        end
        patchuri = [patchuri; patchCurent(:)'];
        descriptoriHOG = [descriptoriHOG; histogrameCurente];
        
        %extragem celule din patchCurent si orientarile din orientare 
        %dupa care
        %aplicam histc(orientare_celula(:),linespace(0,180,9))
        %salvam histogramele pentru cele 16 celule in descriptori si in
        %patch-uri celule cu pixeli din imagine
    end
end
