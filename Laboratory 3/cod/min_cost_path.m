M = [1 3 0; 2 8 9; 5 2 6];
m = zeros(size(M));
m(:,1) = M(:,1);

for j=2:size(M,2)
    for i=1:size(M,1)
       if i == 1 % se afla pe prima linie
           m(i,j) = M(i,j) + min(m(i,j-1), m(i+1,j-1));
       elseif i == size(M,1) % se afla pe ultima linie
           m(i,j) = M(i,j) + min(m(i,j-1), m(i-1,j-1));
       else
           m(i,j) = M(i,j) + min(min(m(i-1,j-1), m(i,j-1)), m(i+1,j-1));
       end
    end
end

d = zeros(size(m,1),2);

%reconstruim drumul de jos in sus;
linia = size(m,1);
[~, pozitie] = min(m(linia,:));
coloana = pozitie;
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
