%%
% ADRIAN ISPAS, Facultatea de Matematica si Informatica - Universitatea din Bucuresti
% Implementarea a proiectului Redimensionare imagini dupa articolul 
% "Seam Carving for Content-Aware Image Resizing", autori S. Avidan si A. Shamir 

%%
% Aceasta functie ruleaza intregul proiect 
% Setati parametri si imaginile de redimensionat aici

% Curatam spatiul de lucru
clear;
clc

% Citeste o imagine
img = imread('../data/castel.jpg');

parametri.optiuneRedimensionare = 'maresteLatime';
parametri.ploteazaDrum = 0;
parametri.culoareDrum = [255 0 0]'; %culoarea rosie
parametri.metodaSelectareDrum = 'programareDinamica'; %optiuni posibile: 'aleator','greedy','programareDinamica'

% Reducem imaginea in latime
% Seteaza parametri
parametri.numarPixeliLatime = 50;

% Reducem imaginea in inaltime
% Seteaza parametri
parametri.numarPixeliInaltime = 100;

if strcmp(parametri.optiuneRedimensionare,'eliminaObiect')
    imshow(img)
    parametri.rect = getrect;
end

imgRedimensionata_proiect = redimensioneazaImagine(img,parametri); 

% Foloseste functia imresize pentru redimensionare traditionala
imgRedimensionata_traditional = imresize(img,[size(imgRedimensionata_proiect,1) ...
                                size(imgRedimensionata_proiect,2)]);

% Ploteaza imaginile obtinute
figure, hold on;

% 1. imaginea initiala
h1 = subplot(1,3,1);imshow(img);
xsize = get(h1,'XLim');ysize = get(h1,'YLim');
xlabel('imaginea initiala');

% 2. imaginea redimensionata cu pastrarea continutului
h2 = subplot(1,3,2);imshow(imgRedimensionata_proiect);
set(h2, 'XLim', xsize, 'YLim', ysize);
xlabel('rezultatul nostru');

% 3. imaginea obtinuta prin redimensionare traditionala
h3 = subplot(1,3,3);imshow(imgRedimensionata_traditional);
set(h3, 'XLim', xsize, 'YLim', ysize);
xlabel('rezultatul imresize');

imwrite(imgRedimensionata_proiect,['rezultat-' parametri.metodaSelectareDrum '.jpg']);
imwrite(imgRedimensionata_traditional,'rezultat-imresize.jpg');
