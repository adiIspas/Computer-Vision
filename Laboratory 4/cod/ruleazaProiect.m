% ADRIAN ISPAS, Facultatea de Matematica si Informatica - Universitatea din Bucuresti

% Curatam spatiul de lucru
clear;
clc;

% Citeste imaginea
name_image   = 'wall';
format_image = '.png';
img          = imread(['../data/' name_image format_image]);

% Seteaza parametri
parametri.texturaInitiala              = img;
marime                                 = 2;
parametri.dimensiuneTexturaSintetizata = [marime * size(img,1) marime * size(img,2)];
parametri.dimensiuneBloc               = 72;

parametri.nrBlocuri           = 2000;
parametri.eroareTolerata      = 0.1;
parametri.portiuneSuprapunere = 1/6;

%parametri.metodaSinteza = 'blocuriAleatoare';
%parametri.metodaSinteza = 'eroareSuprapunere';
parametri.metodaSinteza = 'frontieraCostMinim';

% Afiseaza la fiecare pas imaginea in constructie
parametri.progresImagine = 1;

imgSintetizata = realizeazaSintezaTexturii(parametri);