%
% Tema 4 - Clasificarea Imaginilor folosind modelul Bag-of-Visual-Words
% 
%
clear 
clc
%%
%ANTRENARE
disp('Etapa de antrenare');
disp('Construim vocabularul de cuvinte vizuale');

k = 5;% k = numarul de cuvinte vizuale ale vocabularului
iterMax = 100;

% cuvintele vizuale sunt centri clusterilor obtinuti prin k-means
% se obtin prin apelarea functiei construiesteVocabular
cuvinteVizuale = construiesteVocabular('../data/masini-exempleAntrenare-pozitive+negative',k,iterMax);
% 
disp('Procesam imaginile de antrenare pozitive (contin masini)');
histogrameBOVW_exemplePozitive = calculeazaHistogrameBOVW_director('../data/masini-exempleAntrenare-pozitive',cuvinteVizuale);
disp('Procesam imaginile de antrenare negative (NU contin masini)');
histogrameBOVW_exempleNegative = calculeazaHistogrameBOVW_director('../data/masini-exempleAntrenare-negative',cuvinteVizuale);

%%
%TESTARE
disp('Etapa de testare');
disp('Procesam imaginile de testare pozitive (contin masini)');
histogrameBOVW_exemplePozitive_test = calculeazaHistogrameBOVW_director('../data/masini-exempleTestare-pozitive',cuvinteVizuale);
disp('Procesam imaginile de testare negative (NU contin masini)');
histogrameBOVW_exempleNegative_test = calculeazaHistogrameBOVW_director('../data/masini-exempleTestare-negative',cuvinteVizuale);

nrExemplePozitive = size(histogrameBOVW_exemplePozitive_test,1);
nrExempleNegative = size(histogrameBOVW_exempleNegative_test,1);

histogrameBOVW_test = [histogrameBOVW_exemplePozitive_test;histogrameBOVW_exempleNegative_test];
etichete_test = [ones(nrExemplePozitive,1);zeros(nrExempleNegative,1)];

disp('______________________________________')
disp('Clasificator Cel Mai Apropiat Vecin')
clasificaBOVW(histogrameBOVW_test, etichete_test, histogrameBOVW_exemplePozitive, histogrameBOVW_exempleNegative, @clasificaBOVWCelMaiApropiatVecin);
disp('______________________________________')
disp('Clasificator SVM linear')
clasificaBOVW(histogrameBOVW_test, etichete_test, histogrameBOVW_exemplePozitive, histogrameBOVW_exempleNegative, @clasificaSVM);
disp('______________________________________')


% Pentru a plota raportul dintre k si performanta modificam functia
% clasificaBOVW astfel incat sa intoarca ca rezultat scorul obtinut si il
% salvam intr-un vector atat el cat si k de forma: 
% scoruri = [scor_1, scor_2, ...] k_uri = [k_1, k_2, ...]
% Apoi salvam aceste fisiere in memorie iar la fiecare rulare le deschidem
% si scriem in continuarea lor, dupa care la final plotam rezultatul plot(scoruri,k_uri).