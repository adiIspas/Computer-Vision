image = imread('girl.jpg'); 
imshow(image);

culoarea_medie = uint8(sum(sum(image)) / (size(image,1) * size(image,2)))

culoarea_medie_portiune = uint8(sum(sum(image(1:30,1:40,:))) / (30 * 40))