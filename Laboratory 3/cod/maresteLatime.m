function img = maresteLatime(img,numarPixeliLatime,metodaSelectareDrum,ploteazaDrum,culoareDrum)
    % Mareste imaginea cu un numar de pixeli 'numarPixeliLatime' pe latime (adauga drumuri de sus in jos) 
    %
    % Input: img - imaginea initiala
    %        numarPixeliLatime - specifica numarul de drumuri de sus in jos
    %        adaugate
    %        metodaSelectareDrum - specifica metoda aleasa pentru selectarea drumului. Valori posibile:
    %                            'aleator' - alege un drum aleator
    %                            'greedy' - alege un drum utilizand metoda Greedy
    %                            'programareDinamica' - alege un drum folosind metoda Programarii Dinamice
    %        ploteazaDrum - specifica daca se ploteaza drumul gasit la fiecare pas. Valori posibile:
    %                     0 - nu se ploteaza
    %                     1 - se ploteaza
    %        culoareDrum  - specifica culoarea cu care se vor plota pixelii din drum. Valori posibile:
    %                     [r g b]' - triplete RGB (e.g [255 0 0]' - rosu)          
    %                           
    % Output: img - imaginea redimensionata obtinuta prin adaugarea drumurilor
    
    % Cautam cele k drumuri minime din imagine
    img_copy = img;
    
    drumuri = zeros(size(img,1),2,numarPixeliLatime);
    for i = 1:numarPixeliLatime
        
        % Calculeaza energia dupa ecuatia (1) din articol
        E = calculeazaEnergie(img_copy,0,0,0);

        % Alege drumul vertical care conecteaza de sus in jos
        drum = selecteazaDrumVertical(E,metodaSelectareDrum);
        drumuri(:,:,i) = drum;

        % Elimina drumul din imagine
        img_copy = eliminaDrumVertical(img_copy,drum);

    end
    
    % Actualizam drumurile in imaginea de referinta
    for i = 1:size(drumuri,3)
        for j = i+1:size(drumuri,3)
            for k = 1:size(drumuri,1)
                if drumuri(k,2,i) < drumuri(k,2,j)
                    drumuri(k,2,j) = drumuri(k,2,j) + 1;
                end
            end
        end
    end
    
    % Sortam drumurile
    drumuri = sortare(drumuri,2);
    
    % Ploteza toate drumurile
    imgDrum = img;
    figure;
    for i = 1:numarPixeliLatime
        drum = drumuri(:,:,i);
        for j = 1:size(drum,1)
            imgDrum(drum(j,1),drum(j,2),:) = uint8(culoareDrum);
        end
        
        imshow(imgDrum);
    end

    for i = 1:numarPixeliLatime  
        clc
        disp(['Insereaza drumul vertical numarul ' num2str(i) ...
            ' dintr-un total de ' num2str(numarPixeliLatime)]);
        
        drum = drumuri(:,:,i);
       
        % Afiseaza drum
        if ploteazaDrum
            ploteazaDrumVertical(img,E,drum,culoareDrum);
            pause(1);
            close(gcf);
        end
        
        % Insereaza drumul in imagine
        img = insereazaDrumVertical(img,drum,i-1);
    end
end