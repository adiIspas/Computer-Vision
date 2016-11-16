function [d, cost] = selecteazaDrumVertical(E,metodaSelectareDrum)
    % Selecteaza drumul vertical ce minimizeaza functia cost calculate pe baza lui E
    %
    % input: E - energia la fiecare pixel calculata pe baza gradientului
    %        metodaSelectareDrum - specifica metoda aleasa pentru selectarea drumului. Valori posibile:
    %                            'aleator' - alege un drum aleator
    %                            'greedy' - alege un drum utilizand metoda Greedy
    %                            'programareDinamica' - alege un drum folosind metoda Programarii Dinamice
    %
    % output: d - drumul vertical ales

    d = zeros(size(E,1),2);
    switch metodaSelectareDrum
        case 'aleator'
            % Pentru linia 1 alegem primul pixel in mod aleator
            linia = 1;
            
            % Coloana o alegem intre 1 si size(E,2)
            coloana = randi(size(E,2));
            % Punem in d linia si coloana coresponzatoare pixelului
            d(1,:) = [linia coloana];
            for i = 2:size(d,1)
                % Alege urmatorul pixel pe baza vecinilor
                % linia este i
                linia = i;
                
                % Coloana depinde de coloana pixelului anterior
                if d(i-1,2) == 1 % pixelul este localizat la marginea din stanga
                    % doua optiuni
                    optiune = randi(2)-1; % genereaza 0 sau 1 cu probabilitati egale 
                elseif d(i-1,2) == size(E,2) % pixelul este la marginea din dreapta
                    % doua optiuni
                    optiune = randi(2) - 2; % genereaza -1 sau 0
                else
                    optiune = randi(3)-2; % genereaza -1, 0 sau 1
                end
                coloana = d(i-1,2) + optiune; % adun -1 sau 0 sau 1: 
                                              % merg la stanga, dreapta sau stau pe loc
                d(i,:) = [linia coloana];
            end
            
            % Salvam costul drumului determinat
            cost = min(E(end,:));
        
        case 'greedy'
            % Pentru linia 1 alegem primul pixel ca fiind cel cu valoarea minima;
            linia = 1;
            
            [~, pozitie] = min(E(1,:));
            coloana = pozitie;
            % Punem in d linia si coloana coresponzatoare pixelului
            d(1,:) = [linia coloana];
            for i = 2:size(d,1)
                % Alege urmatorul pixel pe baza vecinilor
                % linia este i
                linia = i;
                
                % Coloana depinde de coloana pixelului anterior
                if d(i-1,2) == 1 % pixelul este localizat la marginea din stanga
                    % doua optiuni
                    [~, pozitie] = min(E(i,d(i-1,2):d(i-1,2)+1));
                    optiune = pozitie-1; % genereaza 0 sau 1 cu probabilitati egale 
                elseif d(i-1,2) == size(E,2) % pixelul este la marginea din dreapta
                    % doua optiuni
                    [~, pozitie] = min(E(i,d(i-1,2)-1:d(i-1,2)));
                    optiune = pozitie - 2; % genereaza -1 sau 0
                else
                    [~, pozitie] = min(E(i,d(i-1,2)-1:d(i-1,2)+1));
                    optiune = pozitie-2; % genereaza -1, 0 sau 1
                end
                coloana = d(i-1,2) + optiune; % adun -1 sau 0 sau 1: 
                                              % merg la stanga, dreapta sau stau pe loc
                d(i,:) = [linia coloana];
            end
            
            % Salvam costul drumului determinat
            cost = min(E(end,:));
        
        case 'programareDinamica'
            % Creem matricea costurilor
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

            % Reconstruim drumul de jos in sus;
            linia = size(m,1);
            
            [~, pozitie] = min(m(linia,:));
            coloana = pozitie;
            % Punem in d linia si coloana coresponzatoare pixelului
            d(linia,:) = [linia coloana];

            for i = size(d,1)-1:-1:1
                % Alege urmatorul pixel pe baza vecinilor
                % linia este i
                linia = i;
                
                % Coloana depinde de coloana pixelului anterior
                if d(i+1,2) == 1 % pixelul este localizat la marginea din stanga
                    % doua optiuni
                    [~, pozitie] = min(m(i,d(i+1,2):d(i+1,2)+1));
                    optiune = pozitie-1; % genereaza 0 sau 1 cu probabilitati egale 
                elseif d(i+1,2) == size(m,2)% pixelul este la marginea din dreapta
                    % doua optiuni
                    [~, pozitie] = min(m(i,d(i+1,2)-1:d(i+1,2)));
                    optiune = pozitie - 2; % genereaza -1 sau 0
                else
                    [~, pozitie] = min(m(i,d(i+1,2)-1:d(i+1,2)+1));
                    optiune = pozitie-2; % genereaza -1, 0 sau 1
                end
                coloana = d(i+1,2) + optiune; % adun -1 sau 0 sau 1: 
                                              % merg la stanga, dreapta sau stau pe loc
                d(i,:) = [linia coloana];
            end
            
            % Salvam costul drumului determinat
            cost = min(m(end,:));
    
        otherwise
            error('Optiune pentru metodaSelectareDrum invalida');
    end
end