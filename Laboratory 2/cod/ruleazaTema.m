%tema 1: REALIZAREA IMAGINILOR MOZAIC
% ADRIAN ISPAS, Facultatea de Matematica si Informatica - Universitatea din Bucuresti

%%
%seteaza parametri

%citeste imaginea care va fi transformata in mozaic
%puteti inlocui numele imaginii
params.imgReferinta = imread('../data/imaginiTest/dani.jpg');
% verifica daca imaginea este color sau gray
params.type = size(params.imgReferinta,3);

% 1 daca utilizam o baza de date de imagini, 0 altfel.
params.database = 0;
%{0 - 'airplane'; 1 - 'automobile'; 2 - 'bird'; 3 - 'cat'; 4 - 'deer';
% 5 - 'dog'; 6 - 'frog'; 7 - 'horse'; 8 - 'ship'; 9 - 'truck'}
params.category = 5;

%seteaza directorul cu imaginile folosite la realizarea mozaicului
%puteti inlocui numele directorului
params.numeDirector = [pwd '/../data/colectie/'];
params.tipImagine = 'png';

%seteaza numarul de piese ale mozaicului pe orizontala
%puteti inlocui aceasta valoare
params.numarPieseMozaicOrizontala = 200;
%numarul de piese ale mozaciului pe verticala va fi dedus automat

%seteaza optiunea de afisare a pieselor mozaicului dupa citirea lor din
%director
params.afiseazaPieseMozaic = 0;

%seteaza criteriul dupa care realizeze mozaicul
%optiuni: 'aleator','distantaCuloareMedie','distantaCulori'
%params.criteriu = 'aleator';
params.criteriu = 'distantaCuloareMedie';
%params.criteriu = 'distantaCulori';

%%
%apeleaza functia principala
imgMozaic = construiesteMozaic(params);
imwrite(imgMozaic,'mozaic.jpg');
figure('name', 'Imagine Mozaic'), imshow(imgMozaic)
