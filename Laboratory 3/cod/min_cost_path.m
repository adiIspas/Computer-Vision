M = [10 3 4 3; 25 8 9 2; 11 7 6 1; 5 6 1 3];
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

d = zeros(size(m,2),2);

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
