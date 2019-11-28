%%

clc;
sz = 500;
mu = 2;
z1 = 2;
z2 = -1;
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
sz = 200;
x = linspace(0, 1, sz);
y = x;
[X, Y] = meshgrid(x, y);
ch = @(x) cosh(x - 0.5) + cosh(0.5);
sol = solveDirichlet(@(x, y) zeros(size(x)), @(x) ones(size(x)),@(x) zeros(size(x)) , 1, sz, sz);
my_sol = @(x, y) cosh(x - 0.5) + cosh(y - 0.5);
figure;
surf(X, Y, sol, 'Edgecolor', 'None');
title('Численное решение');
figure;
surf(X, Y, my_sol(X, Y), 'Edgecolor', 'None');
title('Аналитическое решение');
figure;
d = real(sol) - my_sol(X, Y);
max(abs(d), [], 'all')
surf(X, Y, d, 'Edgecolor', 'None');
title('Невязка');