% ADRIAN ISPAS, Facultatea de Matematica si Informatica - Universitatea din Bucuresti

% Curatam spatiul de lucru
clear;
clc;

% Citeste imaginea de textura
name_image   = 'texture_5';
format_image = '.jpg';
img          = imread(['../data/' name_image format_image]);

% Citeste imaginea pe care vom aplica textura
name_image_transfer   = 'abraham_lincoln';
format_image_transfer = '.jpg';
img_transfer           = imread(['../data/' name_image_transfer format_image_transfer]);

% Seteaza parametri
parametri.texturaInitiala              = img;
parametri.imagineTransfer              = img_transfer;
marime                                 = 3;
parametri.dimensiuneTexturaSintetizata = [marime * size(img,1) marime * size(img,2)];
parametri.dimensiuneBloc               = 144;

% Parametrii transfer textura
parametri.dimensiuneBlocTransfer = 80;
parametri.numarIteratii          = 5;

parametri.nrBlocuri           = 2000;
parametri.eroareTolerata      = 0.1;
parametri.portiuneSuprapunere = 1/6;

%parametri.metodaSinteza = 'blocuriAleatoare';
%parametri.metodaSinteza = 'eroareSuprapunere';
parametri.metodaSinteza = 'frontieraCostMinim';

% Transfera textura de pe o imagine pe cealalta
transferTextura = 1;

% Afiseaza la fiecare pas imaginea in constructie
parametri.progresImagine = 1;

if transferTextura == 0
    imgSintetizata = realizeazaSintezaTexturii(parametri);
else
    imgSintetizata = realizeazaTransferTextura(parametri);
end