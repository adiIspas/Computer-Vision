img = imread('delfin.jpeg');
imshow(img)

 rect = getrect;
% 
% line([rect(1) rect(1)+rect(3)], [rect(2) rect(2)])
% line([rect(1) rect(1)],[rect(2) rect(2)+rect(4)]);
% 
% %line([rect(1) rect(1)],[0 size(img,1)]);
% 
% line([rect(1) rect(1)+rect(3)],[rect(2)+rect(4) rect(2)+rect(4)]);
% line([rect(1)+rect(3) rect(1)+rect(3)],[rect(2) rect(2)+rect(4)]);
% 
% %line([rect(1)+rect(3) rect(1)+rect(3)],[0 size(img,2)]);
% 
% % Am luat portiunea de matrice
 img_copy = double(img);
 img_copy(rect(2):rect(2)+rect(4),rect(1):rect(1)+rect(3),:) = mean(mean(mean(img(rect(2):rect(2)+rect(4),rect(1):rect(1)+rect(3),:))));
% 
 %img_copy(rect(2)-2:rect(2)+rect(4)+2,rect(1)-2:rect(1)+rect(3)+2,:) = imgaussfilt(img_copy(rect(2)-2:rect(2)+rect(4)+2,rect(1)-2:rect(1)+rect(3)+2,:), 2);
% 
% width = size(img(rect(2):rect(2)+rect(4),rect(1):rect(1)+rect(3),:),1);
% height = size(img(rect(2):rect(2)+rect(4),rect(1):rect(1)+rect(3),:),2);
 img = uint8(img_copy);
 imshow(img);
 pause(2)
% 
% 
% % Facem portiunea din dreptunghi -inf si astfel obligam toata drumurile sa
% % treaca pe acolo, iar dupa aplicam o reducere cu minim(latime, inaltime)
% % de drumuri. Iar dupa toate astea inseram minim(latime, inaltime) drumuri
% % pentru a o readuce la dimensiunea initiala.


img_gray = rgb2gray(img);

%sobel_x = [-1 0 1; -2 0 2; -1 0 1];
%sobel_y = [1 2 1; 0 0 0; -1 -2 -1];

sobel_y = fspecial('sobel');
sobel_x = sobel_y';

gradient_x = imfilter(double(img_gray), sobel_x);
gradient_y = imfilter(double(img_gray), sobel_y);

magnitudine_gradient = abs(gradient_x) + abs(gradient_y);
%imshow(magnitudine_gradient);

E = magnitudine_gradient;

imshow(E,[]);
