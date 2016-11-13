function img1 = insereazaDrumOrizontal(img,imgOriginala,drum,idx)
    %elimina drumul orizontal din imagine
    %input: img - imaginea initiala
    %       drum - drumul orizontal
    %output img1 - imaginea initiala din care s-a eliminat drumul vertical
    img1 = zeros(size(img,1)+1,size(img,2),size(img,3),'uint8');

    for i=1:size(img1,2)
        %linia = drum(i,1);
        %idx = 0;
        
        linia_img_originala = drum(i,1);
        linia_actualizata = linia_img_originala + idx;

        %copiem partea de sus
        img1(1:linia_actualizata - 1,i,:) = img(1:linia_actualizata - 1,i,:);

        %duplicam linia
        img1(linia_actualizata,i,:) = mean([img(linia_actualizata-1,i,:), img(linia_actualizata,i,:)]);

        img1(linia_actualizata+1,i,:) = mean([img(linia_actualizata,i,:), img(linia_actualizata+1,i,:)]);
        %copiem partea de jos
        img1(linia_actualizata+2:end,i,:) = img(linia_actualizata+1:end,i,:);
    end
end

