%% Task 1 +
N = 40;
X = [1, 1:N];
Y = exp(1) - cumsum(1 ./ cumprod([1, 1:N]));
psi = exp(1) - (1 + 1./X).^X;
plot(X, Y, X, psi);

%% Task 2 +
t = -1:0.01:10;
plot(t, sign(t) .* sqrt(abs(t)), t, my_tan(t));
axis([-1 10 -5 5]);
x0 = ginput(1);
x0 = x0(1);
x_min = fzero(@(t) abs(sign(t) .* sqrt(abs(t)) - my_tan(t)) - 0.1, x0);
%plot(t, abs(func_2(t)));
disp(['x = : ', num2str(x_min)]);

%% Task 3 +
subplot(1, 2, 1);
plot(-10:0.01:10, func_3(-10:0.01:10));
axis([-10 10 -10 10]);

x_min = -10:0.01:10;
phi_sz = numel(x_min);
y = zeros(1, phi_sz);
for i = 1:phi_sz
    y(i) = fzero(@func_3, x_min(i));
end
ind1 = find(x_min > 1);
good_sol1 = find(abs(x_min - 1) < 0.01, 1);
y(ind1) = y(good_sol1) * ones(size(y(ind1)));

ind2 = find(x_min < -1);
good_sol2 = find(abs(x_min + 1) < 0.01, 1);
y(ind2) = y(good_sol2) * ones(size(y(ind2)));

subplot(1, 2, 2);
plot(x_min, y, x_min, x_min);
axis([-5 5 -5 5]);

%% Task 4 +
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

%% Task 5 +
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
r_sz = 5;
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
        quiver(y(:, 1), y(:, 2), -5 * y(:, 1), -3 * y(:, 2), 'b');
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
        quiver(y(:, 1), y(:, 2), -2 * y(:, 1), -2 * y(:, 2), 'b');
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
        quiver(y(:, 1), y(:, 2), y(:, 2), y(:, 1), 'b');
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
        quiver(y(:, 1), y(:, 2), y(:, 1) - 2 * y(:, 2), 3 * y(:, 1) + y(:, 2), 'b');
        title('Фокус');
        hold on;
    end
end

% Центр
f = @(t, y) [y(2); -y(1)];
subplot(2, 3, 5);
for i = 1:floor(r_sz)
    for j = 1:phi_sz/4
        [~, y] = ode45(f, [0 2], [r(i) * cos(phi(4*j)); r(i) * sin(phi(4*j))]);
        quiver(y(:, 1), y(:, 2), y(:, 2), -y(:, 1), 'Color', [0 0 1], 'AutoScaleFactor', 0.5);
        title('Центр');
        hold on;
    end
end

f = @(t, y) [-2 * y(1) + y(2); -2 * y(2)];
subplot(2, 3, 6);
for i = 1:r_sz
    for j = 1:phi_sz
        [~, y] = ode45(f, [-3 3], [r(i) * cos(phi(j)); r(i) * sin(phi(j))]);
        quiver(y(:, 1), y(:, 2), -2 * y(:, 1) + y(:, 2), -2 * y(:, 2), 'b');
        title('Вырожденный узел');
        axis([-1 1 -1 1]);
        hold on;
    end
end
%% Task 7
f1 = @(t, y) [2*y(2) - y(1) - y(2)^3; y(1) - 2*y(2)]; % устойчива
f2 = @(t, y) [y(1)*y(2) - y(1)^3 + y(2)^3; y(1).^2 - y(2).^3]; % неустойчива 

v1 = @(y) (y(:, 2).^4 + 2*(y(:, 1) - 2*y(:, 2)).^2);
v2 = @(y) y(:, 1) .* y(:, 2);

lyap = zeros(1, 3);
for i = 1:r_sz
    for j = 1:phi_sz
        [~, y] = ode45(f1, -15:0.01:15, [r(i) * cos(phi(j)); r(i) * sin(phi(j))]);
        to_add = [v1(y), y];
        lyap = [lyap; to_add];
        hold on;
    end
end
lyap = sortrows(lyap);
subplot(1, 2, 1);
sz = find(lyap > 0.3, 1);
quiver(lyap(1:sz, 2), lyap(1:sz, 3), (2*lyap(1:sz, 3) - lyap(1:sz, 2) - lyap(1:sz, 3).^3), (lyap(1:sz, 2) - 2*lyap(1:sz, 3)), 'Color', [0 0 1]);
hold on;
lyap(1:sz, :) = [];
sz = size(lyap, 1);
ind = [1, round(sz * (1:10) / 10)];
for k = 1:10
    quiver(lyap(ind(k):ind(k+1), 2), lyap(ind(k):ind(k+1), 3), (2*lyap(ind(k):ind(k+1), 3) - lyap(ind(k):ind(k+1), 2) - lyap(ind(k):ind(k+1), 3).^3), (lyap(ind(k):ind(k+1), 2) - 2*lyap(ind(k):ind(k+1), 3)), 'Color', [0.1 * k 0 (1 - 0.1 * k)], 'AutoScaleFactor', 0.2);
    hold on;
end

lyap = zeros(1, 3);
for i = 1:r_sz
    for j = 1:phi_sz
        [~, y] = ode45(f2, -10:0.05:10, [r(i) * cos(phi(j)); r(i) * sin(phi(j))]);
        to_add = [v2(y), y];
        lyap = [lyap; to_add];
        hold on;
    end
end
lyap = sortrows(lyap, 'descend');
subplot(1, 2, 2);
sz = find(lyap < 2.72, 1);
quiver(lyap(1:sz, 2), lyap(1:sz, 3), lyap(1:sz, 2).*lyap(1:sz, 3) - lyap(1:sz, 2).^3 + lyap(1:sz, 3).^3, lyap(1:sz, 2).^2 - lyap(1:sz, 3).^3, 'Color', [1 0 0]);
hold on;
lyap(1:sz, :) = [];
sz = size(lyap, 1);
ind = [1, round(sz * (1:10) / 10)];
for k = 1:10
    quiver(lyap(ind(k):ind(k+1), 2), lyap(ind(k):ind(k+1), 3), lyap(ind(k):ind(k+1), 2).*lyap(ind(k):ind(k+1), 3) - lyap(ind(k):ind(k+1), 2).^3 + lyap(ind(k):ind(k+1), 3).^3, lyap(ind(k):ind(k+1), 2).^2 - lyap(ind(k):ind(k+1), 3).^3, 'Color', [1.1 - 0.1 * k 0 (0.1 * k - 0.1)]);
    hold on;
    axis([-1 1 -1 1]);
end

%% Task 8 +
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

%% Task 9; +
%% Test 1
f1 = @(x) (x(1).^2 - x(2)).^2 + (x(1)-1).^2;
grad1 = @(x) [4 * x(1).^3 - 4*x(1).*x(2) + 2*x(1)-2; -2*(x(1).^2 - x(2))];
hess1 = @(x) [(12*x 0; 0 2];
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

%%
t = 0:0.1:1;
plot(t, sin(2*t), 'Color', [1 0 0.8]);
