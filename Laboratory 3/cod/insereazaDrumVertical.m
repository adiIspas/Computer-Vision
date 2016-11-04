function img1 = insereazaDrumVertical(img,drum)
    %inseram drumul vertical in imagine
    %input: img - imaginea initiala
    %       drum - drumul vertical
    %output img1 - imaginea initiala in care adaugam drumul vertical
    img1 = zeros(size(img,1),size(img,2)+1,size(img,3),'uint8');

    for i=1:size(img1,1)
            coloana = drum(i,2);

            %copiem partea din stanga
            img1(i,1:coloana,:) = img(i,1:coloana,:);
            
            %duplicam coloana
            img1(i,coloana+1,:) = img(i,coloana,:);

            %copiem partea din dreapta
            img1(i,coloana+2:end,:) = img(i,coloana+1:end,:);
    end
end

