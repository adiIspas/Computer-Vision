function img1 = insereazaDrumVertical(img,drum,idx)
    % Inseram drumul vertical in imagine
    % input: img - imaginea initiala
    %        drum - drumul vertical
    % output img1 - imaginea initiala in care adaugam drumul vertical
    img1 = zeros(size(img,1),size(img,2)+1,size(img,3),'uint8');

    for i=1:size(img1,1)
        % Coloana determinata in imaginea de referinta
        coloana_img_originala = drum(i,2);
        
        % Coloanele sunt primite in ordine crescatoare, astfel daca am
        % inserat o coloana stim ca urmatoarea coloana este ceea indicata de
        % coloana_img_originala + coloana/coloanele inserata anterior
        coloana_actualizata = coloana_img_originala + idx;
       
        if coloana_actualizata - 1 > 0
            % Copiem partea din stanga
            img1(i,1:coloana_actualizata-1,:) = img(i,1:coloana_actualizata-1,:);
            
            % Eliminam eventualul efect de edge ce poate aparea
            img1(i,coloana_actualizata,:) = mean([img1(i,coloana_actualizata-1,:), img(i,coloana_actualizata,:)]);
            
            if coloana_actualizata + 1 <= size(img,2)
                img1(i,coloana_actualizata + 1,:) = mean([img1(i,coloana_actualizata,:), img(i,coloana_actualizata+1,:)]);
                
                % Copiem partea din dreapta
                if coloana_actualizata + 2 <= size(img,2)
                    img1(i,coloana_actualizata+2:end,:) = img(i,coloana_actualizata+1:end,:);
                else
                    img1(i,coloana_actualizata+2,:) = mean([img1(i,coloana_actualizata+1,:), img(i,coloana_actualizata+1,:)]);
                end
            else
                img1(i,coloana_actualizata+1,:) = mean([img1(i,coloana_actualizata,:), img(i,coloana_actualizata,:)]);
            end
        else
            % Copiem partea din stanga
            img1(i,1:coloana_actualizata,:) = img(i,1:coloana_actualizata,:);
            
            % Eliminam eventualul efect de edge ce poate aparea
            if coloana_actualizata + 1 <= size(img,2)
                img1(i,coloana_actualizata + 1,:) = mean([img1(i,coloana_actualizata,:), img(i,coloana_actualizata+1,:)]);
                
                % Copiem partea de din dreapta
                if coloana_actualizata + 2 <= size(img,2)
                    img1(i,coloana_actualizata+2:end,:) = img(i,coloana_actualizata+1:end,:);
                else
                    img1(i,coloana_actualizata+2,:) = mean([img1(i,coloana_actualizata+1,:), img(i,coloana_actualizata+1,:)]);
                end
            else
                img1(i,coloana_actualizata+1,:) = mean([img1(i,coloana_actualizata,:), img(i,coloana_actualizata,:)]);
            end
        end
    end
end

