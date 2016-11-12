function img = maresteInaltime(img,numarPixeliInaltime,metodaSelectareDrum,ploteazaDrum,culoareDrum)
%mareste imaginea cu un numar de pixeli 'numarPixeliInaltime' pe inaltime (inserand drumuri de stanga la dreapta) 
%
%input: img - imaginea initiala
%       numarPixeliInaltime - specifica numarul de drumuri de la stanga la dreapta eliminate
%       metodaSelectareDrum - specifica metoda aleasa pentru selectarea drumului. Valori posibile:
%                           'aleator' - alege un drum aleator
%                           'greedy' - alege un drum utilizand metoda Greedy
%                           'programareDinamica' - alege un drum folosind metoda Programarii Dinamice
%       ploteazaDrum - specifica daca se ploteaza drumul gasit la fiecare pas. Valori posibile:
%                    0 - nu se ploteaza
%                    1 - se ploteaza
%       culoareDrum  - specifica culoarea cu care se vor plota pixelii din drum. Valori posibile:
%                    [r g b]' - triplete RGB (e.g [255 0 0]' - rosu)          
%                           
% output: img - imaginea redimensionata obtinuta prin eliminarea drumurilor

    drumuri = [];
    img_copy = img;
    
    for i = 1:numarPixeliInaltime

        %calculeaza energia dupa ecuatia (1) din articol
        E = calculeazaEnergie(img_copy);

        %alege drumul orizontal care conecteaza sus de jos
        drum = selecteazaDrumOrizontal(E,metodaSelectareDrum);
        drumuri = [drumuri drum];
        
        %elimina drumul din imagine
        img_copy = eliminaDrumOrizontal(img_copy,drum);

    end
    
    % actualizam drumurile in imaginea de referinta
    for i = 1:size(drumuri,1)
        for j = 2:2:size(drumuri,2)-2
            for k = j+2:2:size(drumuri,2)
                if drumuri(i,j) < drumuri(i,k)
                    drumuri(i,k) = drumuri(i,k) + 1;
                end
            end
        end
    end
    
    %ploteza toate drumurile
    imgDrum = img;
    figure;
    last_index = 1;
    for j = 1:numarPixeliInaltime
        drum = drumuri(:,last_index:last_index+1);
        last_index = last_index + 2;
        
        for i = 1:size(drum,1)
            imgDrum(drum(i,1),drum(i,2),:) = uint8(culoareDrum);
        end
        
        imshow(imgDrum);
    end
    
    last_index = 1;
    imgOriginala = img;
    for l = 1:numarPixeliInaltime

        clc
        disp(['Insereaza drumul orizontal numarul ' num2str(l) ...
            ' dintr-un total de ' num2str(numarPixeliInaltime)]);
        
        drum = drumuri(:,last_index:last_index+1);
        last_index = last_index + 2;
        
        %afiseaza drum
        if ploteazaDrum
            ploteazaDrumOrizontal(img,E,drum,culoareDrum);
            pause(1);
            close(gcf);
        end

        %elimina drumul din imagine
        img = insereazaDrumOrizontal(img,imgOriginala,drum,l-1);

    end

end

