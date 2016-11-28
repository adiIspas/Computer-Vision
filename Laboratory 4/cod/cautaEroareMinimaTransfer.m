function [indice, bloc_stanga, bloc_sus] = cautaEroareMinimaTransfer(bloc_stanga, bloc_sus, blocuri, pixeli, nrBlocuri, eroareTolerata, bloc_imagine_transfer)
    % Functia ne returneaza indicele blocului a carui eroare este minima la
    % suprapunere si blocul pe baza caruia sa determinat eroarea, ulterior
    % blocul acesta va fi folosit pentru calcularea frontierei minime
    
    imagine_transfer = bloc_imagine_transfer;
    
    stanga = sum(sum(bloc_stanga ~= 0));
    sus = sum(sum(bloc_sus ~= 0));    
    threshold = 1 + eroareTolerata;
    
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
            
           erori(i) = sum(sqrt(sum((stanga - dreapta).^2)))^2 + sum(sqrt(sum((sus - jos).^2)))^2 ...
               + sum(sum(imagine_transfer - bloc_curent)).^2;
        end
        
        eroare_minima = min(erori);
        blocuri_selectate = zeros(size(blocuri));
        blocuri_adaugate = 1;
        indexi_originali = zeros(1,nrBlocuri);
        for i = 1:nrBlocuri
            if erori(i) <= eroare_minima * threshold
                blocuri_selectate(:,:,:,blocuri_adaugate) = blocuri(:,:,:,i);
                indexi_originali(1,blocuri_adaugate) = i;
                blocuri_adaugate = blocuri_adaugate + 1;
            end
        end
        
        index_generat = randi(blocuri_adaugate-1);
        indice = indexi_originali(1,index_generat);

        bloc_stanga = stanga - dreapta;
        bloc_sus = sus - jos;
    % Doar blocul din stanga are imagine
    elseif stanga ~= 0

        erori = zeros(1,nrBlocuri);
        erori(1,:) = intmax('int64');

        for i = 1:nrBlocuri
            bloc_curent = rgb2gray(blocuri(:,:,:,i));

            stanga = double(bloc_stanga(:,end-pixeli+1:end,:));
            dreapta = double(bloc_curent(:,1:pixeli,:));
            
            erori(i) = sum(sqrt(sum((stanga - dreapta).^2))) + sum(sum(imagine_transfer - bloc_curent)).^2;
        end
        
        eroare_minima = min(erori);
        blocuri_selectate = zeros(size(blocuri));
        blocuri_adaugate = 1;
        indexi_originali = zeros(1,nrBlocuri);
        
        for i = 1:nrBlocuri
            if erori(i) <= eroare_minima * threshold
                blocuri_selectate(:,:,:,blocuri_adaugate) = blocuri(:,:,:,i);
                indexi_originali(1,blocuri_adaugate) = i;
                blocuri_adaugate = blocuri_adaugate + 1;
            end
        end

        index_generat = randi(blocuri_adaugate-1);
        indice = indexi_originali(1,index_generat);

        bloc_stanga = stanga - dreapta;
        bloc_sus = 0;
    % Doar blocul de sus are imagine
    elseif sus ~= 0
        erori = zeros(1,nrBlocuri);
        erori(1,:) = intmax('int64');
        
        for i = 1:nrBlocuri
            bloc_curent =rgb2gray(blocuri(:,:,:,i));

            sus = double(bloc_sus(end-pixeli+1:end,:,:));
            jos = double(bloc_curent(1:pixeli,:,:));

            erori(i) = sum(sqrt(sum((sus - jos).^2))) + sum(sum(imagine_transfer - bloc_curent)).^2; 
        end
        
        eroare_minima = min(erori);
        blocuri_selectate = zeros(size(blocuri));
        blocuri_adaugate = 1;
        indexi_originali = zeros(1,nrBlocuri);
        for i = 1:nrBlocuri
            if erori(i) <= eroare_minima * threshold
                blocuri_selectate(:,:,:,blocuri_adaugate) = blocuri(:,:,:,i);
                indexi_originali(1,blocuri_adaugate) = i;
                blocuri_adaugate = blocuri_adaugate + 1;
            end
        end

        index_generat = randi(blocuri_adaugate-1);
        indice = indexi_originali(1,index_generat);

        bloc_stanga = 0;
        bloc_sus = sus - jos;
    end
end