function img1 = insereazaDrumOrizontal(img,drum,idx)
    % Insereaza drum orizontal in imagine
    % input: img - imaginea initiala
    %        drum - drumul orizontal
    % output img1 - imaginea initiala in care s-a inserat drumul orizontal
    img1 = zeros(size(img,1)+1,size(img,2),size(img,3),'uint8');

    for i=1:size(img1,2)
        
        % Linia determinata in imaginea de referinta
        linia_img_originala = drum(i,1);
        
        % Liniile sunt primite in ordine crescatoare, astfel daca am
        % inserat o linie stim ca urmatoarea linie este ceea indicata de
        % linia_img_originala + linia/liniile inserata anterior
        linia_actualizata = linia_img_originala + idx;

        % Copiem partea de sus
        if linia_actualizata - 1 > 0
            img1(1:linia_actualizata-1,i,:) = img(1:linia_actualizata-1,i,:);
            
            % Eliminam eventualul efect de edge ce poate aparea
            img1(linia_actualizata,i,:) = mean([img1(linia_actualizata-1,i,:), img(linia_actualizata,i,:)]);
            
            if linia_actualizata + 1 <= size(img,1)
                img1(linia_actualizata + 1,i,:) = mean([img1(linia_actualizata,i,:), img(linia_actualizata+1,i,:)]);
                
                % Copiem partea de jos
                if linia_actualizata + 2 <= size(img,1)
                    img1(linia_actualizata+2:end,i,:) = img(linia_actualizata+1:end,i,:);
                else
                    img1(linia_actualizata+2,i,:) = mean([img1(linia_actualizata+1,i,:), img(linia_actualizata+1,i,:)]);
                end
            else
                img1(linia_actualizata+1,i,:) = mean([img1(linia_actualizata,i,:), img(linia_actualizata,i,:)]);
            end
        else
            img1(1:linia_actualizata,i,:) = img(1:linia_actualizata,i,:);
            
            % Eliminam eventualul efect de edge ce poate aparea
            if linia_actualizata + 1 <= size(img,1)
                img1(linia_actualizata + 1,i,:) = mean([img1(linia_actualizata,i,:), img(linia_actualizata+1,i,:)]);
                
                % Copiem partea de jos
                if linia_actualizata + 2 <= size(img,1)
                    img1(linia_actualizata+2:end,i,:) = img(linia_actualizata+1:end,i,:);
                else
                    img1(linia_actualizata+2,i,:) = mean([img1(linia_actualizata+1,i,:), img(linia_actualizata+1,i,:)]);
                end
            else
                img1(linia_actualizata+1,i,:) = mean([img1(linia_actualizata,i,:), img(linia_actualizata,i,:)]);
            end
        end
    end
end

