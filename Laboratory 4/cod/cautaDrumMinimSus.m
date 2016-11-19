function [d, cost] = cautaDrumMinimSus(bloc)
   
    d = zeros(size(bloc,2),2);
    
    % Creem matricea costurilor
    m = zeros(size(bloc));
    m(:,1) = bloc(:,1);

    for j=2:size(bloc,2)
        for i=1:size(bloc,1)
           if i == 1 % se afla pe prima linie
               m(i,j) = bloc(i,j) + min(m(i,j-1), m(i+1,j-1));
           elseif i == size(bloc,1) % se afla pe ultima linie
               m(i,j) = bloc(i,j) + min(m(i,j-1), m(i-1,j-1));
           else
               m(i,j) = bloc(i,j) + min(min(m(i-1,j-1), m(i,j-1)), m(i+1,j-1));
           end
        end
    end

    % Reconstruim drumul de dreapta la stanga;
    coloana = size(m,2);

    [~, pozitie] = min(m(:,coloana));
    linia = pozitie;
    % Punem in d linia si coloana coresponzatoare pixelului
    d(coloana,:) = [linia coloana];

    for i = size(d,1)-1:-1:1
        % Alege urmatorul pixel pe baza vecinilor
        % coloana este i
        coloana = i;

        % Linia depinde de linia pixelului anterior
        if d(i+1,1) == 1 % pixelul este localizat la marginea de sus
            % doua optiuni
            [~, pozitie] = min(m(d(i+1,1):d(i+1,1)+1,i));
            optiune = pozitie-1; % genereaza 0 sau 1 cu probabilitati egale 
        elseif d(i+1,1) == size(m,1) % pixelul este la marginea de jos
            % doua optiuni
            [~, pozitie] = min(m(d(i+1,1)-1:d(i+1,1),i));
            optiune = pozitie - 2; % genereaza -1 sau 0
        else
            [~, pozitie] = min(m(d(i+1,1)-1:d(i+1,1)+1,i));
            optiune = pozitie-2; % genereaza -1, 0 sau 1
        end
        linia = d(i+1,1) + optiune; % adun -1 sau 0 sau 1: 
                                    % merg la stanga, dreapta sau stau pe loc
        d(i,:) = [linia coloana];
    end

    % Salvam costul drumului determinat
    cost = min(m(:,end));
end