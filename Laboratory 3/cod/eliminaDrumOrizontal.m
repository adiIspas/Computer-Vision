function img1 = eliminaDrumOrizontal(img,drum)
%elimina drumul orizontal din imagine
%input: img - imaginea initiala
%       drum - drumul orizontal
%output img1 - imaginea initiala din care s-a eliminat drumul vertical
img1 = zeros(size(img,1)-1,size(img,2),size(img,3),'uint8');

for i=1:size(img1,2)
        linia = drum(i,1);
        
        %copiem partea din stanga
        img1(1:linia-1,i,:) = img(1:linia-1,i,:);
        
        %copiem partea din dreapta
        img1(linia:end,i,:) = img(linia+1:end,i,:);
end
end

