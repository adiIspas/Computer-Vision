% A
image = imresize(rgb2gray(imread('football.jpg')), [100, 100]);
figure('name', 'Imaginea originala')
imshow(image)

sort_intensity = sort(image(:));

figure('name', 'A - Valorile lui X in functie de indecsi')
plot(sort_intensity);

% B
figure('name', 'B - Histrograma intensitatilor din A grupate in 32 de intervale')
hist(double(image(:)),32)

% C
sub_matrix_A = image(1:end/2, 1:end/2);
sub_matrix_B = image(1:end/2, end/2 + 1:end);
sub_matrix_C = image(end/2 + 1:end, 1:end/2);
sub_matrix_D = image(end/2 + 1:end, end/2 + 1:end);


if sum(sum(sub_matrix_A == sub_matrix_D)) == 50 * 50
    sub_matrix_A
end

if sum(sum(sub_matrix_B == sub_matrix_D)) == 50 * 50
    sub_matrix_B
end

if sum(sum(sub_matrix_C == sub_matrix_D)) == 50 * 50
    sub_matrix_C
end

% D
limit_t = median(image(:))

% E
tic
image_B = zeros(size(image));

first_index = find(image < limit_t);
second_index = find(image >= limit_t);

image_B(first_index) = 255;
image_B(second_index) = 0;
toc

figure('name', 'E - Doar intensitati de 0 si 255')
imshow(image_B)

% F
image_C = image(:,:) - mean(image(:));
figure('name', 'F - Pixel - media pixelilor')
imshow(image_C)

% G
y = min(min(image));
positions = find(image == y);

l = mod(positions(:),100);
c = round(positions(:)/100);