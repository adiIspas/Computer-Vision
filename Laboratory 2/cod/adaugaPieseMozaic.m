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
        culoare_medie_imagini(:,:) = mean(mean(params.pieseMozaic));
        
        if params.type == 1
            culoare_medie_imagini = culoare_medie_imagini';
        end
        
        %pune o piese in mozaic pe baza culoarii medie cea mai apropiatã
        nrTotalPiese = params.numarPieseMozaicOrizontala * params.numarPieseMozaicVerticala;
        nrPieseAdaugate = 0;
        for i=1:params.numarPieseMozaicVerticala
            for j=1:params.numarPieseMozaicOrizontala
                % calcualm culoarea medie pe un bloc
                culoare_medie_portiune = mean(mean(params.imgReferintaRedimensionata((i-1)*H+1:i*H,(j-1)*W+1:j*W,:)));
                
                % calculam distanta euclidiana
                results = zeros(1,N);
                for k=1:N
                     results(k) = sum((culoare_medie_imagini(:,k) - culoare_medie_portiune(:)).^2);
                     %results(k) = sum((culoare_medie_imagini - culoare_medie_portiune(:)).^2);
                end
                [~, position] = min(results(:));
                imgMozaic((i-1)*H+1:i*H,(j-1)*W+1:j*W,:) = params.pieseMozaic(:,:,:,position);
                nrPieseAdaugate = nrPieseAdaugate+1;
                fprintf('Construim mozaic ... %2.2f%% \n',100*nrPieseAdaugate/nrTotalPiese);
            end
        end
        
    case 'distantaCulori'
        %pune o piese in mozaic pe baza culoarii medie cea mai apropiatã
        nrTotalPiese = params.numarPieseMozaicOrizontala * params.numarPieseMozaicVerticala;
        nrPieseAdaugate = 0;
        for i=1:params.numarPieseMozaicVerticala
            for j=1:params.numarPieseMozaicOrizontala
                % calculam distanta euclidiana
                results = zeros(1,N);
                for k=1:N
                     results(k) = sum(sum(sqrt(sum(int32(params.imgReferintaRedimensionata((i-1)*H+1:i*H,(j-1)*W+1:j*W,:)) - int32(params.pieseMozaic(:,:,:,k))).^2)));
                end
                [~, position] = min(results(:));
                imgMozaic((i-1)*H+1:i*H,(j-1)*W+1:j*W,:) = params.pieseMozaic(:,:,:,position);
                nrPieseAdaugate = nrPieseAdaugate+1;
                fprintf('Construim mozaic ... %2.2f%% \n',100*nrPieseAdaugate/nrTotalPiese);
            end
        end
    
    otherwise
        printf('EROARE, optiune necunoscut \n');
end
    
    
    
    
    
