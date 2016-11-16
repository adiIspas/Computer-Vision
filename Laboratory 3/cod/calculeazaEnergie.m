function E = calculeazaEnergie(img,rect,idx,ultimul_drum)
    % Calculeaza energia la fiecare pixel pe baza gradientului
    % input: img - imaginea initiala
    % output: E - energia

    % Urmati urmatorii pasi:
    % - transformati imaginea in grayscale
    % - folositi un filtru sobel pentru a calcula gradientul in directia x si y
    % - calculati magnitudiena gradientului
    % E - energia = gradientul imaginii

    % Completati aici codul vostru

    img_gray = rgb2gray(img);

    % Putem utiliza definitia noastra
    % sobel_x = [-1 0 1; -2 0 2; -1 0 1];
    % sobel_y = [1 2 1; 0 0 0; -1 -2 -1];

    sobel_y = fspecial('sobel');
    sobel_x = sobel_y';

    gradient_x = imfilter(double(img_gray), sobel_x);
    gradient_y = imfilter(double(img_gray), sobel_y);

    magnitudine_gradient = abs(gradient_x) + abs(gradient_y);

    % Verificam limitele portiunii selectate, purtiune in care punem
    % valoarea minima pentru a ne asigura ca toate drumurile minime trec
    % prin aceasta portiune selectata de catre utilizator.
    
    if rect ~= 0
        
        if isequal(ultimul_drum,1) || isequal(ultimul_drum,0)
            % Daca dimensiunile selectiei se incadreaza in imagine, selectam
            % portiunea din care scadem de cate ori am eliminat un rand.
            if rect(2) + rect(4) <= size(img,1) && rect(1) + rect(3) <= size(img,2)
                magnitudine_gradient(rect(2):rect(2)+rect(4),rect(1):rect(1)+rect(3)-idx,:) = intmin('int64');

            % Daca dimensiunile selectiei ies din imagine prin partea de stanga insa
            % se incadreaza in partea din drepta, alegem partea din drepta din care
            % scadeam de cate ori am eliminat un rand, iar partea de jos este
            % limita imaginii.
            elseif rect(2) + rect(4) > size(img,1) && rect(1) + rect(3) <= size(img,2)
                magnitudine_gradient(rect(2):size(img,1),rect(1):rect(1)+rect(3)-idx,:) = intmin('int64');

            % Daca dimensiunile selectiei ies din imagine in partea din dreapta
            % insa se incadreaza in partea de jos, atunci pastram partea de jos,
            % iar din partea alegem marginea imaginii din care scadeam de cate ori
            % am eliminat un rand
            elseif rect(2) + rect(4) <= size(img,1) && rect(1) + rect(3) > size(img,2)
                magnitudine_gradient(rect(2):rect(2)+rect(4),rect(1):size(img,2)-idx,:) = intmin('int64');
            else

            % Similar ca in celelalte cazuri, numai ca in aceasta situatie alegem
            % atat marginea de jos cat si marginea din dreapta ca limita a
            % selectiei
                magnitudine_gradient(rect(2):size(img,1),rect(1):size(img,2)-idx,:) = intmin('int64');
            end
        else
            % Analog, doar ca de data aceasta lucram pe linii cu valoarea
            % parametrului idx.
            if rect(2) + rect(4) <= size(img,1) && rect(1) + rect(3) <= size(img,2)
                
                magnitudine_gradient(rect(2):rect(2)+rect(4)-idx,rect(1):rect(1)+rect(3),:) = intmin('int16');
            elseif rect(2) + rect(4) > size(img,1) && rect(1) + rect(3) <= size(img,2)
                
                magnitudine_gradient(rect(2):size(img,1)-idx,rect(1):rect(1)+rect(3),:) = intmin('int16');
            elseif rect(2) + rect(4) <= size(img,1) && rect(1) + rect(3) > size(img,2)
                
                magnitudine_gradient(rect(2):rect(2)+rect(4)-idx,rect(1):size(img,2),:) = intmin('int16');
            else
                
                magnitudine_gradient(rect(2):size(img,1)-idx,rect(1):size(img,2),:) = intmin('int16');
            end
        end
    end

    E = magnitudine_gradient;
end
