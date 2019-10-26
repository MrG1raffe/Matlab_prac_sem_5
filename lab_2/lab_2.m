%% Task 1 +
a = 0;
b = 3;
h_x = 0.5;
h_xx = 0.001;
x = a:h_x:b;
xx = a:h_xx:b;
f = @(x) exp(x);
compareInterp(x, xx, f);

%% Task 2 + 
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

%% Task 3 +
a = 0;
b = 1;
h_x = 0.1;
h_xx = 0.001;
x = a:h_x:b;
xx = a:h_xx:b;
f = @(x) exp(-x .^ 2);
M = max(abs(gradient(f(xx), h_xx))); % error <= M*h_x/2
max_err = M * h_x / 2;
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
max_err = M * h_x / 2;
vq = interp1(x, f(x), xx, 'nearest');
subplot(1, 2, 2);
plot(xx, f(xx) - vq, xx, -max_err * ones(size(xx)), 'r', xx, max_err * ones(size(xx)), 'r');
title('Error of sin(x^{10}) interpolation');

%% Task 4 +
fn = @(n, x) x .^ n;
f = @(x) 0 * x;
convergenceFunc(fn, f, 0, 1, 500, 1);
%%
fn = @(n, x) sqrt(n) * (1/n - x > 0);
f = @(x) 0 * x;
convergenceFunc(fn, f, 0, 1, 100, 2);
%%
fn = @(n, x) (n - 2 .^ (floor(log(n)/log(2))) < x .* 2 .^ (floor(log(n)/log(2)))) & (x .* 2 .^ (floor(log(n)/log(2))) < n + 1 - 2 .^ (floor(log(n)/log(2))));
f = @(x) 0 * x;
convergenceFunc(fn, f, 0, 1, 512, 2);

%% Task 5 +
fourierApprox(@(x) sign(x), -1, 2, 100, 1);

%%
fourierApprox(@(x) x .^ 3, -1, 1, 100, 2);

%%
fourierApprox(@(x) sin(x), 0, 2*pi, 100, 3);

%% Task 6 +
f = @(x) -x .* x .* cos(x .* x);
x = linspace(0, 2 * pi, 10000);

%%
global_max = max(f(x));
ind_max = find(global_max - f(x) < 0.001, 1);
h = (x(size(x, 2)) - x(1)) / size(x, 2);
ind_min = find(f(x) < f(x + h) & f(x) < f(x - h));
min_dif = min(abs(ind_min - ind_max));
closest_min = find((abs(ind_min - ind_max) - min_dif) == 0, 1);
plot(x, f(x), x(ind_max), f(x(ind_max)), 'o', x(ind_min), f(x(ind_min)), 'rx', x(ind_min(closest_min)), f(x(ind_min(closest_min))), 'o');
hold on;
h = h * sign(x(ind_min(closest_min)) - x(ind_max));
y = x(ind_max):h:x(ind_min(closest_min));
comet(y, f(y));

%% Task 7 
f = @(x) sin(2*x + 1);
g = @(x) 2*sin(x);
t0 = 0;
t1 = 2*pi;
N = 10;
T = getEqual(f, g, t0, t1, N);
t = linspace(t0, t1, 10000);
plot(f(t), g(t));
hold on;
connect([f(T); g(T)], 'r', 1);

%%
f = @(x) sin(3 * x + 2);
g = @(x) 0.5 * sin(2 * x);
t0 = 0;
t1 = pi * 2;
N = 100;
T = getEqual(f, g, t0, t1, N);
t = linspace(t0, t1, 10000);
plot(f(t), g(t));
hold on;
connect([f(T); g(T)], 'r', 1);

%%
f = @(x) 2 * sin(3 * x);
g = @(x) 4 * sin(2 * x);
t0 = 0;
t1 = pi;
N = 14;
T = getEqual(f, g, t0, t1, N);
t = linspace(t0, t1, 10000);
plot(f(t), g(t));
hold on;
connect([f(T); g(T)], 'r', 1);

%% Task 8
subplot(1, 2, 2);
drawSet(@(x) test_rho1(x), 30);
subplot(1, 2, 1);
drawSet(@(x) test_rho1(x), 12);

%%
subplot(1, 2, 2);
drawSet(@(x) test_rho2(x), 100);
subplot(1, 2, 1);
drawSet(@(x) test_rho2(x), 38);

%% Task 9
rho = supportLebesgue(@(x) x(1)^2 + x(2)^2 - 10^(-7), optimoptions('fmincon', 'Display', 'none', 'Algorithm', 'sqp'));
drawSet(@(x) rho(x), 30);

%%
f = @(x) max([abs(x(1)), abs(x(2))]) - 1;
rho = supportLebesgue(f, optimoptions('fmincon', 'Display', 'none', 'Algorithm', 'sqp'));
drawSet(@(x) rho(x), 47);

%%
f = @(x) exp(abs(x(1))+abs(x(2))) - 10;
rho = supportLebesgue(f, optimoptions('fmincon', 'Display', 'none', 'Algorithm', 'sqp'));
drawSet(@(x) rho(x), 100);

%% Task 10                                                                                                                    
drawPolar(supportLebesgue(@(x) x(1).^2 + (2*x(2)).^2 - 1, optimoptions('fmincon', 'Display', 'none', 'Algorithm', 'sqp')), 100);

%%
drawPolar(@test_rho1, 40);
%% Трехмерная графика
f = @(x, y, p) sin(p*x) + cos(p*y);
h_x = 0.1;
h_y = 0.1;
x = -pi:h_x:pi;
y = -pi:h_y:pi;
[X, Y] = meshgrid(x, y);
p_min = 1;
p_max = 3;

%% Task 11
nFrames = 200;
C = ones(size(X));
mov(1:nFrames) = struct('cdata', [],'colormap', []);
for i = 1:nFrames
    p = p_min + i * (p_max - p_min) / nFrames;

    ind_max = find(f(X, Y, p) >= f(X + h_x, Y, p) & f(X, Y, p) >= f(X - h_x, Y, p) & f(X, Y, p) >= f(X, Y + h_y, p) & f(X, Y, p) >= f(X, Y - h_y, p));
    ind_min = find(f(X, Y, p) <= f(X + h_x, Y, p) & f(X, Y, p) <= f(X - h_x, Y, p) & f(X, Y, p) <= f(X, Y + h_y, p) & f(X, Y, p) <= f(X, Y - h_y, p));    
    C = ones(size(X));
    C(ind_min) = 10;
    C(ind_max) = 15;
    surf(X, Y, f(X, Y, p), C);
    mov(i) = getframe();
end
%%
level = 0;
contour(f(X, Y, 10), [level level]);
%%
movie(mov);

%% Task 12
v = VideoWriter('task12.avi');
open(v);
writeVideo(v, mov);
close(v);

%%
save mov;

%% Task 13
points = [0 0; 0 4; -1 3; 2 5];
L = 10;
p = 1;
viewEaten(points, L, p);

%% Task 14
drawBall(0.1, 2, 100, 'green', 'none');

%%
drawBall(1, 0.5, 100, 'red', 'none');

%%
drawBall(1, nan, 100, 'y', 'none');

%%
drawBall(-1, nan, 100, 'y', 'none');

%% Task 15
colors = repmat('r', 10, 1);
edges = repmat('None', 10, 1);
% edges(1,:) = 'None';
% edges(2,:) = 'y';
% edges(3,:) = 'g';
% edges(4,:) = 'b';
drawManyBalls(ones(1, 10), colors, edges);
