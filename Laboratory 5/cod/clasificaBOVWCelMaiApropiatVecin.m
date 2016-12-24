function eticheta = clasificaBOVWCelMaiApropiatVecin(histogramaBOVW_test,histogrameBOVW_exemplePozitive,histogrameBOVW_exempleNegative)
% eticheta = eticheta celui mai apropiat vecin (in sensul distantei Euclidiene)
% eticheta = 1, daca cel mai apropiat vecin este un exemplu pozitiv,
% eticheta = 0, daca cel mai apropiat vecin este un exemplu negativ. 
% Input: 
%       histogramaBOVW_test - matrice 1 x K, histograma BOVW a unei imagini test
%       histogrameBOVW_exemplePozitive - matrice #ImaginiExemplePozitive x K, fiecare linie reprezinta histograma BOVW a unei imagini pozitive
%       histogrameBOVW_exempleNegative - matrice #ImaginiExempleNegative x K, fiecare linie reprezinta histograma BOVW a unei imagini negative
% Output: 
%     eticheta - eticheta dedusa a imaginii test

  
% completati codul
%...
  
  valoareMinimaPozitive = intmax('int32');
  for i = 1:size(histogrameBOVW_exemplePozitive,1)
    valoareCurenta = sqrt(sum((histogramaBOVW_test(1,:) - histogrameBOVW_exemplePozitive(i,:)).^2));
    if valoareCurenta < valoareMinimaPozitive
        valoareMinimaPozitive = valoareCurenta;
    end
  end
  
  valoareMinimaNegative = intmax('int32');
  for i = 1:size(histogrameBOVW_exempleNegative,1)
    valoareCurenta = sqrt(sum((histogramaBOVW_test(1,:) - histogrameBOVW_exemplePozitive(i,:)).^2)); 
    if valoareCurenta < valoareMinimaNegative
        valoareMinimaNegative = valoareCurenta;
    end
  end
  
  if valoareMinimaPozitive < valoareMinimaNegative
      eticheta = 1;
  else
      eticheta = 0;
  end
end
