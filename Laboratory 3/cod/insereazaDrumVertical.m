function img1 = insereazaDrumVertical(img,imgOriginala,drum,idx)
    % inseram drumul vertical in imagine
    % input: img - imaginea initiala
    %        drum - drumul vertical
    % output img1 - imaginea initiala in care adaugam drumul vertical
    img1 = zeros(size(img,1),size(img,2)+1,size(img,3),'uint8');

    for i=1:size(img1,1)
        %idx = 0;
        
        coloana_img_originala = drum(i,2);
        coloana_actualizata = coloana_img_originala + idx;

        %copiem partea de sus
        img1(i,1:coloana_actualizata - 1,:) = img(i,1:coloana_actualizata - 1,:);

        %duplicam linia
        img1(i,coloana_actualizata,:) = mean([img(i,coloana_actualizata-1,:), img(i,coloana_actualizata,:)]);

        img1(i,coloana_actualizata+1,:) = mean([img(i,coloana_actualizata,:), img(i,coloana_actualizata+1,:)]);
        %copiem partea de jos
        img1(i,coloana_actualizata+2:end,:) = img(i,coloana_actualizata+1:end,:);
    end
end

