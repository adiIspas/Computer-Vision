function drumuri_sortate = sortare(drumuri_initiale, metoda)
    % Functia sorteaza o matrice de drumuri primite in functie de coloana
    % de start a fiecarui drum.
    drumuri_sortate = zeros(size(drumuri_initiale));
    
    [~, index] = sort(drumuri_initiale(1,metoda,:));
    
    index = index(:)';
    for i = 1:size(index,2)
        drumuri_sortate(:,:,i) = drumuri_initiale(:,:,index(i));    
    end    
end

