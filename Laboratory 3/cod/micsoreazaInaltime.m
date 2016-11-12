function img = micsoreazaInaltime(img,numarPixeliInaltime,metodaSelectareDrum,ploteazaDrum,culoareDrum,rect)
%micsoreaza imaginea cu un numar de pixeli 'numarPixeliInaltime' pe inaltime (elimina drumuri de sus in jos) 
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

for i = 1:numarPixeliInaltime
    
    clc
    disp(['Eliminam drumul orizontal numarul ' num2str(i) ...
        ' dintr-un total de ' num2str(numarPixeliInaltime)]);
    
    %calculeaza energia dupa ecuatia (1) din articol
    E = calculeazaEnergie(img,rect,i-1);
    
    %alege drumul orizontal care conecteaza sus de jos
    drum = selecteazaDrumOrizontal(E,metodaSelectareDrum);
    
    %afiseaza drum
    if ploteazaDrum
        ploteazaDrumOrizontal(img,E,drum,culoareDrum);
        pause(1);
        close(gcf);
    end
    
    %elimina drumul din imagine
    img = eliminaDrumOrizontal(img,drum);

end

end

