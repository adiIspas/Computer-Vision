function img1 = eliminaDrumVertical(img,drum)
    % elimina drumul vertical din imagine
    % input: img - imaginea initiala
    %       drum - drumul vertical
    % output img1 - imaginea initiala din care s-a eliminat drumul vertical

    img1 = zeros(size(img,1),size(img,2)-1,size(img,3),'uint8');

    for i=1:size(img1,1)
        coloana = drum(i,2);
        
        if coloana-2 > 0 
            img1(i,1:coloana-2,:) = img(i,1:coloana-2,:);
            
            img1(i,coloana-1,:) = mean([img(i,coloana-2,:), img(i,coloana-1,:)]);
            img1(i,coloana,:) = mean([img(i,coloana-1,:), img(i,coloana+1,:)]);
            
            img1(i,coloana+1:end,:) = img(i,coloana+2:end,:);
        else
            if coloana - 1 > 0
                img1(i,coloana-1,:) = img(i,coloana-1,:);
                img1(i,coloana,:) = mean([img(i,coloana-1,:), img(i,coloana+1,:)]);

                img1(i,coloana+1:end,:) = img(i,coloana+2:end,:);
            else
                img1(i,coloana,:) = img(i,coloana+1,:);
                img1(i,coloana+1:end,:) = img(i,coloana+2:end,:);
            end
        end
        
%         % old version
%         % copiem partea din stanga
%         img1(i,1:coloana-1,:) = img(i,1:coloana-1,:);
% 
%         % eliminam eventualul efect de edge ce poate aparea
%         if coloana-1 > 0 && coloana + 1 < size(img1,1)
%             img1(i,coloana-1,:) = mean([img1(i,coloana-1,:), img(i,coloana+1,:)]);
%         end
%         
%         % copiem partea din dreapta
%         img1(i,coloana:end,:) = img(i,coloana+1:end,:);
    end
end