% Curatam spatiul de lucru
clear
clc

% Citeste imaginea
img = imread('../data/radishes.jpg');

% Seteaza parametri
parametri.texturaInitiala = img;
marime = 3;
parametri.dimensiuneTexturaSintetizata = [marime * size(img,1) marime * size(img,2)];
parametri.dimensiuneBloc = 36;

parametri.nrBlocuri = 2000;
parametri.eroareTolerata = 0.1;
parametri.portiuneSuprapunere = 1/6;
%parametri.metodaSinteza = 'blocuriAleatoare';
parametri.metodaSinteza = 'eroareSuprapunere';
%parametri.metodaSinteza = 'frontieraMinima';

imgSintetizata = realizeazaSintezaTexturii(parametri);