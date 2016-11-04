function img1 = insereazaDrumOrizontal(img,drum)
    %elimina drumul orizontal din imagine
    %input: img - imaginea initiala
    %       drum - drumul orizontal
    %output img1 - imaginea initiala din care s-a eliminat drumul vertical
    img1 = zeros(size(img,1)+1,size(img,2),size(img,3),'uint8');

    for i=1:size(img1,2)
            linia = drum(i,1);

            %copiem partea de sus
            img1(1:linia,i,:) = img(1:linia,i,:);
            
            %duplicam linia
            img1(linia+1,i,:) = img(linia,i,:);

            %copiem partea de jos
            img1(linia+2:end,i,:) = img(linia+1:end,i,:);
    end
end

