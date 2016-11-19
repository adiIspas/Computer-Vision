function [indice, bloc] = cautaEroareMinima(bloc_stanga, bloc_sus, blocuri, pixeli, nrBlocuri, eroareTolerata)
    % Functia ne returneaza indicele blocului a carui eroare este minima la
    % suprapunere si blocul pe baza caruia sa determinat eroarea, ulterior
    % blocul acesta va fi folosit pentru calcularea frontierei minime
    
    stanga = sum(sum(bloc_stanga ~= 0));
    sus = sum(sum(bloc_sus ~= 0));
    
    % Cazul in care ambele blocuri au imagini
    if  stanga ~= 0 &&  sus ~= 0
        erori = zeros(1,nrBlocuri);
        erori(1,:) = intmax('int64');

        for i = 1:nrBlocuri
           bloc_curent = rgb2gray(blocuri(:,:,:,i));
           
           sus = double(bloc_sus(end-pixeli+1:end,:,:));
           jos = double(bloc_curent(1:pixeli,:,:));

           stanga = double(bloc_stanga(:,end-pixeli+1:end,:));
           dreapta = double(bloc_curent(:,1:pixeli,:));

           eroare_suprapunere = sum(sum(stanga - dreapta).^2) + sum(sum(sus - jos).^2);
           erori(i) = eroare_suprapunere + eroareTolerata * eroare_suprapunere;
        end

        [~, indice] = min(erori);
        bloc = eroare_suprapunere;
    
    % Doar blocul din stanga are imagine
    elseif stanga ~= 0
        erori = zeros(1,nrBlocuri);
        erori(1,:) = intmax('int64');

        for i = 1:nrBlocuri
            bloc_curent =rgb2gray(blocuri(:,:,:,i));

            stanga = double(bloc_stanga(:,end-pixeli+1:end,:));
            dreapta = double(bloc_curent(:,1:pixeli,:));

            eroare_suprapunere = sum(sum(stanga - dreapta).^2);
            erori(i) = eroare_suprapunere + eroareTolerata * eroare_suprapunere;
        end
        
        [~, indice] = min(erori);
        bloc = eroare_suprapunere;
        
    % Doar blocul de sus are imagine
    elseif sus ~= 0
        erori = zeros(1,nrBlocuri);
        erori(1,:) = intmax('int64');
        
        for i = 1:nrBlocuri
            bloc_curent =rgb2gray(blocuri(:,:,:,i));

            sus = double(bloc_sus(end-pixeli+1:end,:,:));
            jos = double(bloc_curent(1:pixeli,:,:));

            eroare_suprapunere = sum(sum(sus - jos).^2);
            erori(i) = eroare_suprapunere + eroareTolerata * eroare_suprapunere;
        end

        [~, indice] = min(erori);
        bloc = eroare_suprapunere;
    end
end

