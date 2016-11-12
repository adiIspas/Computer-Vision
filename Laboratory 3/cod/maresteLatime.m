function img = maresteLatime(img,numarPixeliLatime,metodaSelectareDrum,ploteazaDrum,culoareDrum)
    %mareste imaginea cu un numar de pixeli 'numarPixeliLatime' pe latime (adauga drumuri de sus in jos) 
    %
    %input: img - imaginea initiala
    %       numarPixeliLatime - specifica numarul de drumuri de sus in jos
    %       adaugate
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
    % output: img - imaginea redimensionata obtinuta prin adaugarea drumurilor
    
    % cautam cele k drumuri minime din imagine
    drumuri = [];
    img_copy = img;
    for i = 1:numarPixeliLatime
        
        %calculeaza energia dupa ecuatia (1) din articol
        E = calculeazaEnergie(img_copy);

        %alege drumul vertical care conecteaza de sus in jos
        drum = selecteazaDrumVertical(E,metodaSelectareDrum);
        drumuri = [drumuri drum];

        %elimina drumul din imagine
        img_copy = eliminaDrumVertical(img_copy,drum);

    end
    
%     actualizam drumurile in imaginea de referinta
    for i = 1:size(drumuri,1)
        for j = 2:2:size(drumuri,2)-2
            for k = j+2:2:size(drumuri,2)
                if drumuri(i,j) < drumuri(i,k)
                    drumuri(i,k) = drumuri(i,k) + 1;
                end
            end
        end
    end
       
%     ploteza toate drumurile
    imgDrum = img;
    figure;
    last_index = 1;
    for j = 1:numarPixeliLatime
        drum = drumuri(:,last_index:last_index+1);
        last_index = last_index + 2;
        
        for i = 1:size(drum,1)
            imgDrum(drum(i,1),drum(i,2),:) = uint8(culoareDrum);
        end
        
        imshow(imgDrum);
    end
    %pause(10);
    
    last_index = 1;
    imgOriginala = img;
    for l = 1:numarPixeliLatime  
        %clc
        disp(['Insereaza drumul vertical numarul ' num2str(l) ...
            ' dintr-un total de ' num2str(numarPixeliLatime)]);
        
         drum = drumuri(:,last_index:last_index+1);
         last_index = last_index + 2;
        
       
%         drum = sortrows(drum,2);
 
        %afiseaza drum
        if ploteazaDrum
            ploteazaDrumVertical(img,E,drum,culoareDrum);
            pause(1);
            close(gcf);
        end
        
        %insereaza drumul in imagine
        img = insereazaDrumVertical(img,imgOriginala,drum,l-1);
    end
end

