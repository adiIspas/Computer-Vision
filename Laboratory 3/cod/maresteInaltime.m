function img = maresteInaltime(img,numarPixeliInaltime,metodaSelectareDrum,ploteazaDrum,culoareDrum)
    % Mareste imaginea cu un numar de pixeli 'numarPixeliInaltime' pe inaltime (inserand drumuri de stanga la dreapta) 
    %
    % Input: img - imaginea initiala
    %        numarPixeliInaltime - specifica numarul de drumuri de la stanga la dreapta eliminate
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
    % Output: img - imaginea redimensionata obtinuta prin eliminarea drumurilor
    
    % Cautam cele k drumuri minime din imagine
    img_copy = img;
    
    drumuri = zeros(size(img,2),2,numarPixeliInaltime);
    for i = 1:numarPixeliInaltime

        % Calculeaza energia dupa ecuatia (1) din articol
        E = calculeazaEnergie(img_copy,0,0,0);

        % Alege drumul orizontal care conecteaza sus de jos
        drum = selecteazaDrumOrizontal(E,metodaSelectareDrum);
        drumuri(:,:,i) = drum;
        
        % Elimina drumul din imagine
        img_copy = eliminaDrumOrizontal(img_copy,drum);

    end
    
    % Actualizam drumurile in imaginea de referinta
    for i = 1:size(drumuri,3)
        for j = i+1:size(drumuri,3)
            for k = 1:size(drumuri,1)
                if drumuri(k,1,i) < drumuri(k,1,j)
                    drumuri(k,1,j) = drumuri(k,1,j) + 1;
                end
            end
        end
    end
    
     % Sortam drumurile
    drumuri = sortare(drumuri,1);
    
    % Ploteza toate drumurile
    imgDrum = img;
    figure;
    for i = 1:numarPixeliInaltime

        drum = drumuri(:,:,i);
        for j = 1:size(drum,1)
            imgDrum(drum(j,1),drum(j,2),:) = uint8(culoareDrum);
        end
        
        imshow(imgDrum);
    end
    
    for i = 1:numarPixeliInaltime

        clc
        disp(['Insereaza drumul orizontal numarul ' num2str(i) ...
            ' dintr-un total de ' num2str(numarPixeliInaltime)]);
        
        drum = drumuri(:,:,i);

        % Afiseaza drum
        if ploteazaDrum
            ploteazaDrumOrizontal(img,E,drum,culoareDrum);
            pause(1);
            close(gcf);
        end

        % Elimina drumul din imagine
        img = insereazaDrumOrizontal(img,drum,i-1);
    end
end