A = [1 2; 3 4];

V = [1 2 3];
V_2 = V';
V_3 = pi*-4:4/4;
V_4 = 2*-4:2:4*2;

M_1 = zeros(2,3);
M_2 = ones(1,3);
M_3 = eye(3);
M_4 = rand(3,1);

S = sum(A);
M = mean(A);
Max = max(max(A));

a = rand(3,2);
b = rand(2,4);
c = a * b;

I = inv(A);
E = eig(A);

D = diag([1 2 3]);
R = repmat([1 2; 3 4], 3, 2);

m = 10;
n = 10;
v = 2 * rand(1, n);
A = ones(m, n) + repmat(v, m, 1);

B = zeros(m,n);
ind = find(A > 0);
B(ind) = A(ind);

A = rand(1000,1000);
tic 
suma = 0;
for i = 1:size(A,1)
    for j = 1:size(A,2)
        suma = suma + A(i,j);
    end
end
toc 

tic
suma = sum(sum(A(:)));
toc