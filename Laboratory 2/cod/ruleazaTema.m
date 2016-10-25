%tema 1: REALIZAREA IMAGINILOR MOZAIC
%

%%
%seteaza parametri

%citeste imaginea care va fi transformata in mozaic
%puteti inlocui numele imaginii
params.imgReferinta = imread('../data/imaginiTest/ferrari.jpeg');

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
params.afiseazaPieseMozaic = 1;

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