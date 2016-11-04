function d = selecteazaDrumVerticalInsertie(E,metodaSelectareDrum,index,i,m)
%selecteaza drumul vertical ce minimizeaza functia cost calculate pe baza lui E
%
%input: E - energia la fiecare pixel calculata pe baza gradientului
%       metodaSelectareDrum - specifica metoda aleasa pentru selectarea drumului. Valori posibile:
%                           'aleator' - alege un drum aleator
%                           'greedy' - alege un drum utilizand metoda Greedy
%                           'programareDinamica' - alege un drum folosind metoda Programarii Dinamice
%
%output: d - drumul vertical ales

d = zeros(size(E,1),2);

switch metodaSelectareDrum
    case 'aleator'
        %pentru linia 1 alegem primul pixel in mod aleator
        linia = 1;
        %coloana o alegem intre 1 si size(E,2)
        coloana = randi(size(E,2));
        %punem in d linia si coloana coresponzatoare pixelului
        d(1,:) = [linia coloana];
        for i = 2:size(d,1)
            %alege urmatorul pixel pe baza vecinilor
            %linia este i
            linia = i;
            %coloana depinde de coloana pixelului anterior
            if d(i-1,2) == 1%pixelul este localizat la marginea din stanga
                %doua optiuni
                optiune = randi(2)-1;%genereaza 0 sau 1 cu probabilitati egale 
            elseif d(i-1,2) == size(E,2)%pixelul este la marginea din dreapta
                %doua optiuni
                optiune = randi(2) - 2; %genereaza -1 sau 0
            else
                optiune = randi(3)-2; % genereaza -1, 0 sau 1
            end
            coloana = d(i-1,2) + optiune;%adun -1 sau 0 sau 1: 
                                         % merg la stanga, dreapta sau stau pe loc
            d(i,:) = [linia coloana];
        end
        
    case 'greedy'
        %pentru linia 1 alegem primul pixel ca fiind cel cu valoarea minima;
        linia = 1;
        [~, pozitie] = min(E(1,:));
        coloana = pozitie;
        %punem in d linia si coloana coresponzatoare pixelului
        d(1,:) = [linia coloana];
        for i = 2:size(d,1)
            %alege urmatorul pixel pe baza vecinilor
            %linia este i
            linia = i;
            %coloana depinde de coloana pixelului anterior
            if d(i-1,2) == 1 %pixelul este localizat la marginea din stanga
                %doua optiuni
                [~, pozitie] = min(E(i,d(i-1,2):d(i-1,2)+1));
                optiune = pozitie-1; %genereaza 0 sau 1 cu probabilitati egale 
            elseif d(i-1,2) == size(E,2)%pixelul este la marginea din dreapta
                %doua optiuni
                [~, pozitie] = min(E(i,d(i-1,2)-1:d(i-1,2)));
                optiune = pozitie - 2; %genereaza -1 sau 0
            else
                [~, pozitie] = min(E(i,d(i-1,2)-1:d(i-1,2)+1));
                optiune = pozitie-2; % genereaza -1, 0 sau 1
            end
            coloana = d(i-1,2) + optiune;%adun -1 sau 0 sau 1: 
                                         % merg la stanga, dreapta sau stau pe loc
            d(i,:) = [linia coloana];
        end
    
    case 'programareDinamica'
        
        %reconstruim drumul de jos in sus;
        linia = size(m,1);
        
        coloana = index(i);
        %punem in d linia si coloana coresponzatoare pixelului
        d(linia,:) = [linia coloana];
        
        for i = size(d,1)-1:-1:1
            %alege urmatorul pixel pe baza vecinilor
            %linia este i
            linia = i;
            %coloana depinde de coloana pixelului anterior
            if d(i+1,2) == 1 %pixelul este localizat la marginea din stanga
                %doua optiuni
                [~, pozitie] = min(m(i,d(i+1,2):d(i+1,2)+1));
                optiune = pozitie-1; %genereaza 0 sau 1 cu probabilitati egale 
            elseif d(i+1,2) == size(m,2)%pixelul este la marginea din dreapta
                %doua optiuni
                [~, pozitie] = min(m(i,d(i+1,2)-1:d(i+1,2)));
                optiune = pozitie - 2; %genereaza -1 sau 0
            else
                [~, pozitie] = min(m(i,d(i+1,2)-1:d(i+1,2)+1));
                optiune = pozitie-2; % genereaza -1, 0 sau 1
            end
            coloana = d(i+1,2) + optiune;%adun -1 sau 0 sau 1: 
                                         % merg la stanga, dreapta sau stau pe loc
            d(i,:) = [linia coloana];
        end

    otherwise
        error('Optiune pentru metodaSelectareDrum invalida');
end

end

