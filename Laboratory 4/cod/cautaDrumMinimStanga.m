function [d, cost] = cautaDrumMinimStanga(bloc)

    d = zeros(size(bloc,1),2);
  
    % Creem matricea costurilor
    m = zeros(size(bloc));
    m(1,:) = bloc(1,:);

    for i=2:size(bloc,1)
        for j=1:size(bloc,2)
           if j == 1 % se afla pe prima coloana
               m(i,j) = bloc(i,j) + min(m(i-1,j), m(i-1,j+1));
           elseif j == size(bloc,2) % se afla pe ultima coloana
               m(i,j) = bloc(i,j) + min(m(i-1,j-1), m(i-1,j));
           else
               m(i,j) = bloc(i,j) + min(min(m(i-1,j-1), m(i-1,j)), m(i-1,j+1));
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
end