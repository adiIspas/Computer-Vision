function img1 = insereazaDrumVertical(img,imgOriginala,drum,idx)
    % inseram drumul vertical in imagine
    % input: img - imaginea initiala
    %        drum - drumul vertical
    % output img1 - imaginea initiala in care adaugam drumul vertical
    img1 = zeros(size(img,1),size(img,2)+1,size(img,3),'uint8');

    for i=1:size(img1,1)
            coloana_img_originala = drum(i,2);
            coloana_actualizata = coloana_img_originala + idx;

%             % copiem partea din stanga
%             %img1(i,1:coloana,:) = img(i,1:coloana,:);
%             img1(i,1:coloana-1,:) = img(i,1:coloana-1,:);
%             
% %             % inseram media vecinilor 
% %             %img1(i,coloana+1,:) = img(i,coloana,:);
% %             if coloana - 1 > 0 && coloana + 1 < size(img,2)
% %                 img1(i,coloana,:) = mean([img(i,coloana-1,:),img(i,coloana,:)]);
% %                 img1(i,coloana+1,:) = mean([img(i,coloana,:),img(i,coloana+1,:)]);
% %             end
%             
%             % copiem partea din dreapta
%             img1(i,coloana+2:end,:) = img(i,coloana+1:end,:);

             %copiem partea din stanga
%              coloana-1
%              size(img)
%              size(img1)
            img1(i,1:coloana_actualizata,:) = img(i,1:coloana_actualizata,:);
            
            %duplicam coloana
            %img1(i,coloana_actualizata,:) = mean([img(i,coloana_actualizata,:), imgOriginala(i,coloana_img_originala-1,:)]);
            %img1(i,coloana_actualizata+1,:) = mean([imgOriginala(i,coloana_img_originala,:), img(i,coloana_actualizata,:)]);
            img1(i,coloana_actualizata+1,:) = img(i,coloana_actualizata,:);

%             img1(i,coloana_actualizata,:) = imgOriginala(i,coloana_img_originala,:);
%             img1(i,coloana_actualizata+1,:) = imgOriginala(i,coloana_img_originala,:);

            %copiem partea din dreapta
            img1(i,coloana_actualizata+2:end,:) = img(i,coloana_actualizata+1:end,:);
    end
end

