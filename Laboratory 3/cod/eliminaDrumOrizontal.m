function img1 = eliminaDrumOrizontal(img,drum)
    % elimina drumul orizontal din imagine
    % input: img - imaginea initiala
    %       drum - drumul orizontal
    % output img1 - imaginea initiala din care s-a eliminat drumul vertical
    
    img1 = zeros(size(img,1)-1,size(img,2),size(img,3),'uint8');

    for i=1:size(img1,2)
        linia = drum(i,1);
        
        if linia-2 > 0 
            img1(1:linia-2,i,:) = img(1:linia-2,i,:);
            
            img1(linia-1,i,:) = mean([img(linia-2,i,:), img(linia-1,i,:)]);
            img1(linia,i,:) = mean([img(linia-1,i,:), img(linia+1,i,:)]);
            
            img1(linia+1:end,i,:) = img(linia+2:end,i,:);
        else
            if linia - 1 > 0
                img1(linia-1,i,:) = img(linia-1,i,:);
                img1(linia,i,:) = mean([img(linia-1,i,:), img(linia+1,i,:)]);

                img1(linia+1:end,i,:) = img(linia+2:end,i,:);
            else
                img1(linia,i,:) = img(linia+1,i,:);

                img1(linia+1:end,i,:) = img(linia+2:end,i,:);
            end
        end
        
%         % old version
%         % copiem partea din stanga
%         img1(1:linia-1,i,:) = img(1:linia-1,i,:);
%         
%         % eliminam eventualul efect de edge ce poate aparea
%         if linia-1 > 0 && linia + 1 < size(img1,2)
%             img1(linia-1,i,:) = mean([img1(linia-1,i,:), img(linia+1,i,:)]);
%         end
%         
%         % copiem partea din dreapta
%         img1(linia:end,i,:) = img(linia+1:end,i,:);

    end
end

