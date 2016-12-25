function eticheta = clasificaSVM( histograme_test, histogrameBOVW_exemplePozitive, histogrameBOVW_exempleNegative)
% eticheta = eticheta dedusa folosind un SVM liniar: http://www.vlfeat.org/matlab/vl_svmtrain.html
%
% Input: 
%       histogramaBOVW_test - matrice 1 x K, histograma BOVW a unei imagini test
%       histogrameBOVW_exemplePozitive - matrice #ImaginiExemplePozitive x K, fiecare linie reprezinta histograma BOVW a unei imagini pozitive
%       histogrameBOVW_exempleNegative - matrice #ImaginiExempleNegative x K, fiecare linie reprezinta histograma BOVW a unei imagini negative
% Output: 
%     eticheta - eticheta dedusa a imaginii test

    histograme = [histogrameBOVW_exemplePozitive; histogrameBOVW_exempleNegative];
    etichete = double(ones(1,size(histogrameBOVW_exemplePozitive,1) + size(histogrameBOVW_exemplePozitive,1)));
    
    etichete(1,1:size(histogrameBOVW_exemplePozitive,1)) = 1;
    etichete(1,size(histogrameBOVW_exemplePozitive,1)+1:end) = -1;
    
    [w,b] = vl_svmtrain(histograme',etichete,0.01);

    % scores = w'.*histograme_test + b
    [~,~,~, scor] = vl_svmtrain(histograme_test', 1, 0.01, 'model', w, 'bias', b, 'solver', 'none');

    if scor > 0
        eticheta = 1;
    else
        eticheta = 0;
    end
end