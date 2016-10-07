figure;
x = pi*-24:24/24;
plot(x, sin(x));
xlabel('radiani'); 
ylabel('valoare sin'); 
title('incercare');
close all; 
plot(x, sin(x),'or'); 
plot(x, sin(x),'or:'); 


figure;
subplot(1, 2, 1);
plot(x, sin(x));
axis square;
subplot(1, 2, 2);
plot(x, 2*cos(x));
axis square;

figure;
plot(x, sin(x));
hold on;
plot(x, 2*cos(x), '--');
legend('sin', 'cos');
hold off;