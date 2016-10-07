I = imread('girl.jpg');
figure
imshow(I)

I_red = I;
I_red(:,:,2) = 0;
I_red(:,:,3) = 0;
figure
imshow(I_red)

I_green = I;
I_green(:,:,1) = 0;
I_green(:,:,3) = 0;
figure
imshow(I_green)

I_blue = I;
I_blue(:,:,1) = 0;
I_blue(:,:,2) = 0;
figure
imshow(I_blue)

rgbI = I_red + I_green + I_blue;
isequal(rgbI,I)