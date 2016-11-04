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
    
    %calculeaza energia dupa ecuatia (1) din articol
    E = calculeazaEnergie(img);

    % creem matricea costurilor
    m = zeros(size(E));
    m(1,:) = E(1,:);

    for i=2:size(E,1)
        for j=1:size(E,2)
           if j == 1 % se afla pe prima coloana
               m(i,j) = E(i,j) + min(m(i-1,j), m(i-1,j+1));
           elseif j == size(E,2) % se afla pe ultima coloana
               m(i,j) = E(i,j) + min(m(i-1,j-1), m(i-1,j));
           else
               m(i,j) = E(i,j) + min(min(m(i-1,j-1), m(i-1,j)), m(i-1,j+1));
           end
        end
    end

    [~, index] = sort(m(end,:));

%     index(1:50)

%     pause(100);

    for i = 1:numarPixeliLatime

        clc
        disp(['Inseram drumul vertical numarul ' num2str(i) ...
            ' dintr-un total de ' num2str(numarPixeliLatime)]);        

        %alege drumul vertical care conecteaza sus de jos
        drum = selecteazaDrumVerticalInsertie(E,metodaSelectareDrum,index,i,m);

        %afiseaza drum
        if ploteazaDrum
            ploteazaDrumVertical(img,E,drum,culoareDrum);
            pause(1);
            close(gcf);
        end

        %elimina drumul din imagine
        img = insereazaDrumVertical(img,drum);

    end
end

