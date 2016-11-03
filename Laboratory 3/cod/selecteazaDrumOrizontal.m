function d = selecteazaDrumOrizontal(E,metodaSelectareDrum)

%selecteaza drumul orizontal ce minimizeaza functia cost calculate pe baza lui E
%
%input: E - energia la fiecare pixel calculata pe baza gradientului
%       metodaSelectareDrum - specifica metoda aleasa pentru selectarea drumului. Valori posibile:
%                           'aleator' - alege un drum aleator
%                           'greedy' - alege un drum utilizand metoda Greedy
%                           'programareDinamica' - alege un drum folosind metoda Programarii Dinamice
%
%output: d - drumul orizontal ales

d = zeros(size(E,2),2);

switch metodaSelectareDrum
    case 'aleator'
        %pentru coloana 1 alegem primul pixel in mod aleator
        coloana = 1;
        %linia o alegem intre 1 si size(E,2)
        linia = randi(size(E,1));
        %punem in d linia si coloana coresponzatoare pixelului
        d(1,:) = [linia coloana];
        for i = 2:size(d,1)
            %alege urmatorul pixel pe baza vecinilor
            %coloana este i
            coloana = i;
            %linia depinde de coloana pixelului anterior
            if d(i-1,1) == 1%pixelul este localizat la marginea din stanga
                %doua optiuni
                optiune = randi(2)-1;%genereaza 0 sau 1 cu probabilitati egale 
            elseif d(i-1,1) == size(E,1)%pixelul este la marginea din dreapta
                %doua optiuni
                optiune = randi(2) - 2; %genereaza -1 sau 0
            else
                optiune = randi(3)-2; % genereaza -1, 0 sau 1
            end
            linia = d(i-1,1) + optiune;%adun -1 sau 0 sau 1: 
                                         % merg la stanga, dreapta sau stau pe loc
            d(i,:) = [linia coloana];
        end
        
    case 'greedy'
        %pentru coloana 1 alegem primul pixel ca fiind cel cu valoarea minima;
        coloana = 1;
        [~, pozitie] = min(E(:,1));
        linia = pozitie;
        %punem in d linia si coloana coresponzatoare pixelului
        d(1,:) = [linia coloana];
        for i = 2:size(d,1)
            %alege urmatorul pixel pe baza vecinilor
            %coloana este i
            coloana = i;
            %coloana depinde de coloana pixelului anterior
            if d(i-1,1) == 1 %pixelul este localizat la marginea din stanga
                %doua optiuni
                [~, pozitie] = min(E(d(i-1,1):d(i-1,1)+1,i));
                optiune = pozitie-1; %genereaza 0 sau 1 cu probabilitati egale 
            elseif d(i-1,1) == size(E,1)%pixelul este la marginea din dreapta
                %doua optiuni
                [~, pozitie] = min(E(d(i-1,1)-1:d(i-1,1),i));
                optiune = pozitie - 2; %genereaza -1 sau 0
            else
                [~, pozitie] = min(E(d(i-1,1)-1:d(i-1,1)+1,i));
                optiune = pozitie-2; % genereaza -1, 0 sau 1
            end
            linia = d(i-1,1) + optiune;%adun -1 sau 0 sau 1: 
                                         % merg la stanga, dreapta sau stau pe loc
            d(i,:) = [linia coloana];
        end
    
    case 'programareDinamica'
        % creem matricea costurilor
        m = zeros(size(E));
        m(:,1) = E(:,1);

        for j=2:size(E,2)
            for i=1:size(E,1)
               if i == 1 % se afla pe prima linie
                   m(i,j) = E(i,j) + min(m(i,j-1), m(i+1,j-1));
               elseif i == size(E,1) % se afla pe ultima linie
                   m(i,j) = E(i,j) + min(m(i,j-1), m(i-1,j-1));
               else
                   m(i,j) = E(i,j) + min(min(m(i-1,j-1), m(i,j-1)), m(i+1,j-1));
               end
            end
        end

        
        %reconstruim drumul de dreapta la stanga;
        coloana = size(m,2);
        [~, pozitie] = min(m(:,coloana));
        linia = pozitie;
        %punem in d linia si coloana coresponzatoare pixelului
        d(coloana,:) = [linia coloana];

        for i = size(d,1)-1:-1:1
            %alege urmatorul pixel pe baza vecinilor
            %coloana este i
            coloana = i;
            %linia depinde de linia pixelului anterior
            if d(i+1,1) == 1 %pixelul este localizat la marginea de sus
                %doua optiuni
                [~, pozitie] = min(m(d(i+1,1):d(i+1,1)+1,i));
                optiune = pozitie-1; %genereaza 0 sau 1 cu probabilitati egale 
            elseif d(i+1,1) == size(m,1)%pixelul este la marginea de jos
                %doua optiuni
                [~, pozitie] = min(m(d(i+1,1)-1:d(i+1,1),i));
                optiune = pozitie - 2; %genereaza -1 sau 0
            else
                [~, pozitie] = min(m(d(i+1,1)-1:d(i+1,1)+1,i));
                optiune = pozitie-2; % genereaza -1, 0 sau 1
            end
            linia = d(i+1,1) + optiune;%adun -1 sau 0 sau 1: 
                                 % merg la stanga, dreapta sau stau pe loc
            d(i,:) = [linia coloana];
        end

    otherwise
        error('Optiune pentru metodaSelectareDrum invalida');
end

end

