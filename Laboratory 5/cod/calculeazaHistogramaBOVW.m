function histogramaBOVW = calculeazaHistogramaBOVW(descriptoriHOG, cuvinteVizuale)
  % calculeaza histograma BOVW pe baza descriptorilor si a cuvintelor
  % vizuale, gasind pentru fiecare descriptor cuvantul vizual cel mai
  % apropiat (in sensul distantei Euclidiene)
  %
  % Input:
  %   descriptori: matrice MxD, contine M descriptori de dimensiune D
  %   cuvinteVizuale: matrice NxD, contine N centri de dimensiune D 
  % Output:
  %   histogramaBOVW: vector linie 1xN 
  
 % completati codul
 %...
  % trebuie sa calculez pentru fiecare descriptor cel mai apropiat cuvant
  % vizual si dupa numaram cati descriptori are fiecare cuvant vizual.
  % astfel intoarcem in variabial histogramaBOVW un vector linie de lungime
  % N (in cazul nostru k, deoarece avem k cuvinte vizuale) in care
  % fiecare componenta spune cati descriptori are acel cuvant vizual
  
  histogramaBOVW = zeros(1,size(cuvinteVizuale,1));
  
  for i = 1:size(descriptoriHOG,1)
    valoareMinima = intmax('int32');
    for j = 1:size(cuvinteVizuale,1)
        valoareCurenta = sqrt(sum((descriptoriHOG(i,:) - cuvinteVizuale(j,:)).^2));
        if valoareCurenta < valoareMinima
            valoareMinima = valoareCurenta;
            cuvantVizual = j;
        end
    end
    histogramaBOVW(1,cuvantVizual) = histogramaBOVW(1,cuvantVizual) + 1;
  end
  
end