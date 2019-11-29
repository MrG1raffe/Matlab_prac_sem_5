%%

clc;
sz = 300;
mu = 2;
z1 = 2;
z2 = 3;
x = linspace(0, 1, sz);
y = x;
[X, Y] = meshgrid(x, y);
xiHandle = @(x) uAnalytical(x, zeros(size(x)), z1, z2, mu);
etaHandle = @(y) uAnalytical(zeros(size(y)), y, z1, z2, mu);

sol = solveDirichlet(@(x, y) fGiven(x, y), xiHandle, etaHandle, mu, sz, sz);
figure;
surf(X, Y, sol, 'Edgecolor', 'None');
title('Численное решение');
figure;
surf(X, Y, uAnalytical(X, Y, z1, z2, mu), 'Edgecolor', 'None');
title('Аналитическое решение');
figure;
d = real(sol) - uAnalytical(X, Y, z1, z2, mu);
max(abs(d), [], 'all')
surf(X, Y, d, 'Edgecolor', 'None');
title('Невязка');

%%
clc;
sz = 1000;
x = linspace(0, 1, sz);
y = x;
[X, Y] = meshgrid(x, y);
ch = @(x) cosh(x - 0.5) + cosh(0.5);
sol = solveDirichlet(@(x, y) cos(x.*y.^2).*exp(x-y), @(x) zeros(size(x)), @(y) zeros(size(y)), 10, sz, sz);
figure;
surf(X, Y, sol, 'Edgecolor', 'None')
title('Численное решение');