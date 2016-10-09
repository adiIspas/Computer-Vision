dirPath = 'E:\Computer-Vision\Laboratory 1';
set = '\set1\';

[ imgColor, imgGray, X ] = colectieImagini(dirPath, set);

figure('name', 'A - Imaginea medie color')
imshow(imgColor)

figure('name', 'B - Imaginea medie de intensitate')
imshow(imgGray)

figure('name', 'C - Imaginea deviatiei standard')
imshow(X)