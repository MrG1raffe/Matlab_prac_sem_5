%% Task 1
N = 40;
X = [1, 1:N];
Y = exp(1) - cumsum(1 ./ cumprod([1, 1:N]));
psi = exp(1) - (1 + 1./X).^X;
plot(X, Y, X, psi);

%% Task 2
t = -1:0.01:10;
plot(t, sign(t) .* sqrt(abs(t)), t, tan(t));
axis([-1 10 -5 5]);
x0 = ginput(1);
x0 = x0(1);
x_min = fzero(@(x) sign(x) .* sqrt(abs(x)) - tan(x), x0);
disp(['x = : ', num2str(x_min)]);

%% Task 3
subplot(1, 2, 1);
plot(-1:0.001:1, func_3(-1:0.001:1));

x_min = -1:0.001:1;
phi_sz = numel(x_min);
y = zeros(1, phi_sz);
for i = 1:phi_sz
    y(i) = fzero(@func_3, x_min(i));
end
subplot(1, 2, 2);
plot(x_min, y, x_min, x_min);
axis([-1 1 -1 1]);

%% Task 4
a = 0.3;
y0 = [pi/2; -1];
options = odeset('RelTol',1e-5);
[t, y] = ode45(@(t, x) func_4(t, x, a), [0 10*pi], y0, options);
y = abs(y(:,1)) .* sign(y0(1));
subplot(1, 2, 1);
plot(t, y);
N = 100;
y = reshape(repmat(y', N, 1), N * numel(y), 1);
subplot(1, 2, 2);
comet(sin(y), 1 - cos(y));
axis equal;

%% Task 5
y0 = [5 5 10 0.5 0 0 5 5 0 -.5 -0.5 0]';
m1 = 1500;
m2 = 500;
[~, y] = ode45(@(t, x) func_5(t, x, m1, m2), [0 15], y0);
nFrames = 500;
mov(1:nFrames) = struct('cdata', [],'colormap', []);
for i = 1:nFrames
    t_max = ceil(i/nFrames * size(y,1));
    plot3(y(1:t_max, 1), y(1:t_max, 2), y(1:t_max, 3), 'o', y(1:t_max, 7), y(1:t_max, 8), y(1:t_max, 9), 'o');
    mov(i) = getframe();
end
hold on;
A = y(:, 1:3);
normal = pinv(A' * A) * A' * ones(size(A,1), 1);  
base1 = [0; -normal(3); normal(2)];
base1 = base1 / norm(base1);
base2 = [normal(2); -normal(1); 0];
base2 = base2 / norm(base2);
point = ones(3,1) / sum(normal);
par = -5:0.1:5;
plot3(point(1) + base1(1) * par, point(2) + base1(2) * par, point(3) + base1(3) * par, 'g', point(1) + base2(1) * par, point(2) + base2(2) * par, point(3) + base2(3) * par, 'g');

%% Для фазового портрета
phi_sz = 16;
r_sz = 8;
min_r = 0.1;
max_r = 1;
phi = (1:phi_sz) * 2*pi / phi_sz;
r = linspace(min_r, max_r, r_sz);
%% Task 6
% Устойчивый узел
f = @(t, y) [-5*y(1); -3*y(2)];
subplot(2, 3, 1);
for i = 1:r_sz
    for j = 1:phi_sz
        [~, y] = ode45(f, [-5 5], [r(i) * cos(phi(j)); r(i) * sin(phi(j))]);
        plot(y(:, 1), y(:, 2), 'b');
        title('Узел');
        hold on;
    end
end

% Дикритический узел
f = @(t, y) [-2*y(1); -2*y(2)];
subplot(2, 3, 2);
for i = 1:r_sz
    for j = 1:phi_sz
        [~, y] = ode45(f, [-5 5], [r(i) * cos(phi(j)); r(i) * sin(phi(j))]);
        plot(y(:, 1), y(:, 2), 'b');
        title('Дикритический узел');
        hold on;
    end
end

% Седло
f = @(t, y) [y(2); y(1)];
subplot(2, 3, 3);
for i = 1:r_sz
    for j = 1:phi_sz
        [~, y] = ode45(f, [-10 10], [r(i) * cos(phi(j)); r(i) * sin(phi(j))]);
        plot(y(:, 1), y(:, 2), 'b');
        title('Седло');
        axis([-1 1 -1 1]);
        hold on;
    end
end

% Фокус
f = @(t, y) [y(1) - 2*y(2); y(2) + 3*y(1)];
subplot(2, 3, 4);
for i = 1:r_sz
    for j = 1:phi_sz
        [~, y] = ode45(f, [-0.1 1], [r(i) * cos(phi(j)); r(i) * sin(phi(j))]);
        plot(y(:, 1), y(:, 2), 'b');
        title('Фокус');
        hold on;
    end
end

% Центр
f = @(t, y) [y(2); -2*y(1)];
subplot(2, 3, 5);
for i = 1:r_sz
    for j = 1:phi_sz
        [~, y] = ode45(f, [-2 2], [r(i) * cos(phi(j)); r(i) * sin(phi(j))]);
        plot(y(:, 1), y(:, 2), 'b');
        title('Центр');
        hold on;
    end
end

f = @(t, y) [2*y(1) + y(2); 2 * y(2)];
subplot(2, 3, 6);
for i = 1:r_sz
    for j = 1:phi_sz
        [~, y] = ode45(f, [-3 3], [r(i) * cos(phi(j)); r(i) * sin(phi(j))]);
        plot(y(:, 1), y(:, 2), 'b');
        title('Вырожденный узел');
        axis(3 * [-1 1 -1 1]);
        hold on;
    end
end
%% Task 7
f1 = @(t, y) [2*y(2) - y(1) - y(2)^3; y(1) - 2*y(2)]; % устойчива
f2 = @(t, y) [y(1)*y(2) - y(1)^3 + y(2)^3; y(1).^2 - y(2).^3]; % неустойчива 

v1 = @(x, y) y.^4 + 2*(x - 2*y).^2;
v2 = @(x, y) x .* y;

for i = 1:r_sz
    for j = 1:phi_sz
        [~, y] = ode45(f1, [-10 10], [r(i) * cos(phi(j)); r(i) * sin(phi(j))]);
        subplot(2, 2, 1)
        plot(y(:, 1), y(:, 2), 'b');
        hold on;
        
        [~, y] = ode45(f2, [-15 15], [r(i) * cos(phi(j)); r(i) * sin(phi(j))]);
        subplot(2, 2, 2)
        plot(y(:, 1), y(:, 2), 'b');
        axis([-1 1 -1 1]);
        hold on;
    end
end

x_min = -1:0.01:1;
[X, Y] = meshgrid(x_min);
number_of_lines = 20;
subplot(2, 2, 3);
contour(X, Y, v1(X, Y), number_of_lines);
subplot(2, 2, 4);
contour(X, Y, v2(X, Y), number_of_lines);

%% Task 8
acc_sol = @(t) exp(t) - 2;
odefun = @(t, y) [y(2); y(2)];
bcfun = @(y0, y1) [y0(1) + 1; y1(2) - y1(1) - 2];
sz = 20;
solinit = bvpinit(linspace(0, 1, sz), [1 0]);
num_sol = bvp4c(odefun, bcfun, solinit);
t = linspace(0, 1, sz);
y = deval(num_sol, t);
subplot(1, 2, 1);
plot(t, y(1, :));
title('Численное решение');
subplot(1, 2, 2);
plot(t, acc_sol(t));
title('Аналитическое решение');

norm_l2 = sqrt(trapz(t, (y(1, :) - acc_sol(t)) .^ 2));
norm_c = max(abs(y(1, :) - acc_sol(t)));
disp(['L2-norm = ', num2str(norm_l2)]);
disp(['C-norm = ', num2str(norm_c)]);

%% Task 9;
%% Test 1
f1 = @(x) x(1).^2 + x(2).^2;
grad1 = @(x) [2 * x(1); 2 * x(2)];
hess1 = @(x) [2 0; 0 2];
x0 = [4; 4];
x_min = newton_min(f1, grad1, hess1, x0);
sz = 30;
other_f1 = @(x, y) x.^2 + y.^2;
[X, Y] = meshgrid(linspace(-6, 6, sz));
contour(X, Y, other_f1(X, Y), other_f1(x_min(1,:), x_min(2, :)), '--');
hold on;
plot(x_min(1, :), x_min(2, :), 'o-r');
axis([-4 4 -6 6]);
axis equal;
disp(x_min);
disp(x_min);

%% Test 2
f2 = @(x) (x.^4) / 4 + 2 * x.^2 - 3 * x;
grad2 = @(x) x.^3 + 4 * x - 3;
hess2 = @(x) 3 * x.^2 + 4;
x0 = 1;
x_min = newton_min(f2, grad2, hess2, x0);
x_min = x_min(1);
disp('Newtons solution:');
disp(x_min); 
x_minbnd = fminbnd(f2, 0, 1);
disp('fminbnd solution:');
disp(x_minbnd);
t = linspace(0, 1, 30);
plot(t, f2(t), x_min, f2(x_min), 'o');

%% Test 3
f3 = @(x) (x(1).^4) / 4 - (x(1).^2) / 2 + x(2).^2;
grad3 = @(x) [x(1).^3 - x(1); 2 * x(2)];
hess3 = @(x) [3 * x(1).^2 - 1, 0; 0, 2];
x0 = [3; 4];
x_min = newton_min(f3, grad3, hess3, x0);
sz = 30;
other_f3 = @(x, y) x.^4 / 4 - x.^2 / 2 + y .^ 2;
[X, Y] = meshgrid(linspace(-6, 6, sz));
plot(x_min(1, :), x_min(2, :), 'o-r');
hold on;
contour(X, Y, other_f3(X, Y), other_f3(x_min(1,:), x_min(2, :)), '--');
hold on;
axis([-4 4 -6 6]);
axis equal;
disp(x_min);
