function E = calculeazaEnergie(img)
%calculeaza energia la fiecare pixel pe baza gradientului
%input: img - imaginea initiala
%output: E - energia

%urmati urmatorii pasi:
%transformati imaginea in grayscale
%folositi un filtru sobel pentru a calcula gradientul in directia x si y
%calculati magnitudiena gradientului
%E - energia = gradientul imaginii

%completati aici codul vostru

img_gray = rgb2gray(img);

sobel_x = [-1 0 1; -2 0 2; -1 0 1];
sobel_y = [1 2 1; 0 0 0; -1 -2 -1];

%sobel_y = fspecial('sobel');
%sobel_x = sobel_y';

gradient_x = imfilter(double(img_gray), sobel_x);
gradient_y = imfilter(double(img_gray), sobel_y);

magnitudine_gradient = abs(gradient_x) + abs(gradient_y);
%imshow(magnitudine_gradient);

E = magnitudine_gradient;
