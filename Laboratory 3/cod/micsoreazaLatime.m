function img = micsoreazaLatime(img,numarPixeliLatime,metodaSelectareDrum,ploteazaDrum,culoareDrum,rect,eliminare)
    % Micsoreaza imaginea cu un numar de pixeli 'numarPixeliLatime' pe latime (elimina drumuri de sus in jos)
    %
    % input: img - imaginea initiala
    %        numarPixeliLatime - specifica numarul de drumuri de sus in jos eliminate
    %        metodaSelectareDrum - specifica metoda aleasa pentru selectarea drumului. Valori posibile:
    %                            'aleator' - alege un drum aleator
    %                            'greedy' - alege un drum utilizand metoda Greedy
    %                            'programareDinamica' - alege un drum folosind metoda Programarii Dinamice
    %        ploteazaDrum - specifica daca se ploteaza drumul gasit la fiecare pas. Valori posibile:
    %                     0 - nu se ploteaza
    %                     1 - se ploteaza
    %        culoareDrum  - specifica culoarea cu care se vor plota pixelii din drum. Valori posibile:
    %                     [r g b]' - triplete RGB (e.g [255 0 0]' - rosu)
    %
    % output: img - imaginea redimensionata obtinuta prin eliminarea drumurilor

    % Se foloseste in cazul eliminarii obiectului si spune daca ultimul
    % drum eliminat a fost pe orizontal sau pe vertical
    ultimul_drum = 0;
    drumuri_verticale_eliminate = eliminare.latime;
    drumuri_orizontale_eliminate = eliminare.inaltime;
    elimina_obiect = eliminare.elimina_obiect;

    for i = 1:numarPixeliLatime
        clc

        % Calculeaza energia dupa ecuatia (1) din articol
        E = calculeazaEnergie(img,rect,i-1,ultimul_drum);

        % In cazul eliminarii de obiect verificam care este drumul cel mai
        % mic, orizontal sau vertical
        if strcmp(elimina_obiect,'da')
            % Cazul in care dorim sa eliminam un obiect

            if drumuri_orizontale_eliminate > 0 && drumuri_verticale_eliminate > 0
                [drum_vertical, cost_drum_vertical] = selecteazaDrumVertical(E,metodaSelectareDrum);
                [drum_orizontal, cost_drum_orizontal] = selecteazaDrumOrizontal(E,metodaSelectareDrum);

                % Pentru a calcula in functie de cel mai mic drum, oriziontal
                % sau vertical, trebuie comentata linia de mai jos.
                %cost_drum_vertical = intmin('int16');

                if cost_drum_vertical < cost_drum_orizontal
                    disp(['Eliminam drumul vertical numarul ' num2str(i) ...
                            ' dintr-un posibil total de ' num2str(numarPixeliLatime)]);

                    drumuri_verticale_eliminate = drumuri_verticale_eliminate - 1;
                    img = eliminaDrumVertical(img,drum_vertical);
                    ultimul_drum = 1;
                    
                    % Afiseaza drum
                    if ploteazaDrum
                        ploteazaDrumVertical(img,E,cost_drum_vertical,culoareDrum);
                        pause(0.3);
                        close(gcf);
                    end
                else                 
                    disp(['Eliminam drumul orizontal numarul ' num2str(i) ...
                            ' dintr-un posibil total de ' num2str(numarPixeliLatime)]);

                    drumuri_orizontale_eliminate = drumuri_orizontale_eliminate - 1;
                    img = eliminaDrumOrizontal(img,drum_orizontal);

                    ultimul_drum = 2;
                    % Afiseaza drum
                    if ploteazaDrum
                        ploteazaDrumOrizontal(img,E,cost_drum_orizontal,culoareDrum);
                        pause(0.3);
                        close(gcf);
                    end
                end
            else
                break;
            end
        else
            % Cazul standard de eliminare drum
            disp(['Eliminam drumul vertical numarul ' num2str(i) ...
                    ' dintr-un total de ' num2str(numarPixeliLatime)]);

            % Alege drumul vertical care conecteaza sus de jos
            drum = selecteazaDrumVertical(E,metodaSelectareDrum);

            % Afiseaza drum
            if ploteazaDrum
                ploteazaDrumVertical(img,E,drum,culoareDrum);
                pause(1);
                close(gcf);
            end
            
            % Elimina drumul din imagine
            img = eliminaDrumVertical(img,drum);
        end
    end
end
