function img1 = eliminaDrumOrizontal(img,drum)
    % Elimina drumul orizontal din imagine
    % input: img - imaginea initiala
    %        drum - drumul orizontal
    % output img1 - imaginea initiala din care s-a eliminat drumul vertical
    
    img1 = zeros(size(img,1)-1,size(img,2),size(img,3),'uint8');

    for i=1:size(img1,2)
        linia = drum(i,1);
        
        if linia - 1 > 0
            img1(1:linia-1,i,:) = img(1:linia-1,i,:);
            
            % Eliminam eventualul efect de edge ce poate aparea
            if linia + 1 < size(img,1)
                img1(linia-1,i,:) = mean([img1(linia-1,i,:), img(linia+1,i,:)]);
            else
                img1(linia-1,i,:) = mean([img1(linia-1,i,:), img(linia,i,:)]);
            end
            
        else
            img1(1:linia,i,:) = img(1:linia,i,:);
        end
        
        img1(linia:end,i,:) = img(linia+1:end,i,:);
    end
end

