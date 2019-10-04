%% Task 1
a = 0;
b = 3;
h_x = 0.5;
h_xx = 0.001;
x = a:h_x:b;
xx = a:h_xx:b;
f = @(x) exp(x);
compareInterp(x, xx, f);

%% Task 2
%% +nearest -linear -cubic -spline
a = 0.5;
b = 5.5;
h_x = 1;
h_xx = 0.001;
x = a:h_x:b;
xx = a:h_xx:b;
f = @(x) ceil(x);
figure('Name','+nearest -linear -cubic -spline');
compareInterp(x, xx, f);

%% +spline +-cubic -linear -nearest
a = 0;
b = 4 * pi;
h_x = 1;
h_xx = 0.001;
x = a:h_x:b;
xx = a:h_xx:b;
f = @(x) cos(x - 1);
figure('Name','+spline +-cubic -nearest - linear');
compareInterp(x, xx, f);

%% +linear +-cubic -spline -nearest
a = 0;
b = 5;
h_x = 0.5;
h_xx = 0.001;
x = a:h_x:b;
xx = a:h_xx:b;
f = @(x) abs(x) - 3 * abs(x - 4) + 5 * abs(x - 1);
figure('Name','+linear +cubic -spline -nearest');
compareInterp(x, xx, f);

%% +cubic +-spline -nearest -linear
a = -5;
b = 5;
h_x = 1;
h_xx = 0.001;
x = a:h_x:b;
xx = a:h_xx:b;
f = @(x) exp(-x .^ 2);
figure('Name','+cubic +-spline -nearest -linear');
compareInterp(x, xx, f);

%% Task 3
a = 0;
b = 1;
h_x = 0.1;
h_xx = 0.001;
x = a:h_x:b;
xx = a:h_xx:b;
f = @(x) exp(-x .^ 2);
M = max(abs(gradient(f(xx), h_xx))); % error <= M*h_x/2
max_err = M * h_x / 2
vq = interp1(x, f(x), xx, 'nearest');
subplot(1, 2, 1);
plot(xx, f(xx) - vq, xx, -max_err * ones(size(xx)), 'r', xx, max_err * ones(size(xx)), 'r');
title('Error of e^{-x^2} interpolation');

a = 1;
b = 2;
h_x = 0.1;
h_xx = 0.001;
x = a:h_x:b;
xx = a:h_xx:b;
f = @(x) cos(x .^ 10);
M = max(abs(gradient(f(xx), h_xx))); % error <= M*h_x/2
max_err = M * h_x / 2
vq = interp1(x, f(x), xx, 'nearest');
subplot(1, 2, 2);
plot(xx, f(xx) - vq, xx, -max_err * ones(size(xx)), 'r', xx, max_err * ones(size(xx)), 'r');
title('Error of sin(x^{10}) interpolation');

%% Task 4
fn = @(n, x) x .^ n;
f = @(x) 0 * x;
convergenceFunc(fn, f, 0, 1, 500);
%%
fn = @(n, x) n * (1/n - x > 0) ;
f = @(x) 0 * x;
convergenceFunc(fn, f, 0, 1, 100);
%%



