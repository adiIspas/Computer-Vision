function imgMozaic = adaugaPieseMozaic(params)
%adaugaPieseMozaic
%tratati si cazul in care imaginea de referinta este gri (are numai un canal)

imgMozaic = uint8(zeros(size(params.imgReferintaRedimensionata)));
[H,W,C,N] = size(params.pieseMozaic);
[h,w,c] = size(params.imgReferintaRedimensionata);

figure('name', 'Imagine Originala');
imshow(params.imgReferintaRedimensionata);

switch(params.criteriu)
    case 'aleator'
        %pune o piese aleatoare in mozaic, nu tine cont de nimic
        nrTotalPiese = params.numarPieseMozaicOrizontala * params.numarPieseMozaicVerticala;
        nrPieseAdaugate = 0;
        for i =1:params.numarPieseMozaicVerticala
            for j=1:params.numarPieseMozaicOrizontala
                %alege un indice aleator din cele N
                indice = randi(N);    
                imgMozaic((i-1)*H+1:i*H,(j-1)*W+1:j*W,:) = params.pieseMozaic(:,:,:,indice);
                nrPieseAdaugate = nrPieseAdaugate+1;
                fprintf('Construim mozaic ... %2.2f%% \n',100*nrPieseAdaugate/nrTotalPiese);
            end
        end
        
    case 'distantaCuloareMedie'
        %calculam culoare medie in setul de imagini
        culoare_medie_imagini(:,:) = (sum(sum(params.pieseMozaic)) / (size(params.pieseMozaic,1) * size(params.pieseMozaic,2)));
        
        %pune o piese in mozaic pe baza culoarii medie cea mai apropiatã
        for i=1:size(params.imgReferintaRedimensionata,1)
            for j=1:size(params.imgReferintaRedimensionata,2)
                if i+30 <= size(params.imgReferintaRedimensionata,1) && j+40 <= size(params.imgReferintaRedimensionata,2)
                    temp = (sum(sum(params.imgReferintaRedimensionata(i:i+30,j:j+40,:))) / (30 * 40));
                    
                    culoare_medie_portiune = zeros(3,1);
                    culoare_medie_portiune(1) = temp(:,:,1);
                    culoare_medie_portiune(2) = temp(:,:,2);
                    culoare_medie_portiune(3) = temp(:,:,3);
                    
                    results = zeros(1,N);
                    for k=1:N
                         results(k) = sum((culoare_medie_imagini(:,k) - culoare_medie_portiune).^2);
                    end
                    [value, position] = min(results(:));
                    imgMozaic(i:i+29,j:j+39,:) = params.pieseMozaic(:,:,:,position);
                end
            end
        end
%         nrTotalPiese = params.numarPieseMozaicOrizontala * params.numarPieseMozaicVerticala;
%         nrPieseAdaugate = 0;
%         for i=1:params.numarPieseMozaicVerticala
%             for j=1:params.numarPieseMozaicOrizontala
%                 %alege un indice aleator din cele N
%                 indice = randi(N);    
%                 imgMozaic((i-1)*H+1:i*H,(j-1)*W+1:j*W,:) = params.pieseMozaic(:,:,:,indice);
%                 nrPieseAdaugate = nrPieseAdaugate+1;
%                 %fprintf('Construim mozaic ... %2.2f%% \n',100*nrPieseAdaugate/nrTotalPiese);
%             end
%         end
        
        
    case 'distantaCulori'
        
        %completati codul Matlab
    
    otherwise
        printf('EROARE, optiune necunoscut \n');
end
    
    
    
    
    
