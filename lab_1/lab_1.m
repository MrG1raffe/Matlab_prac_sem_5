%% task 1 +
a = input('Enter a: ');
b = input('Enter b: ');
n = input('Enter n: ');
x = linspace(a, b, n);
y1 = cos(2 * (x .^ 3) + 5);
x_max = find(max(y1) - y1 < 0.01);
x_min = find(y1 - min(y1) < 0.01);
plot(x,y1,'blue', x(x_max), y1(x_max), 'xgreen', x(x_min), y1(x_min), 'xred');
xlabel('x');
ylabel('f(x) = cos(x^3 + 5)');

%% task 2 +
n = input('Enter n: ');
if ~isprime(n)
    error('n is not prime');
end
% 1
res1 = 7:14:n;
disp(res1);
% 2
res2 = repmat(2:n + 1, n, 1)';
disp(res2);
% 3
B = reshape(1:(n + 1) * (n + 1), n + 1, n + 1);
B = B';
disp(B);
c = reshape(B, 1, (n + 1) * (n + 1));
disp(c);
D = [B(:, n), B(:, n + 1)];
disp(D);

%% task 3 +
A = ceil(100 * rand(4, 9));
disp(A);
max_diag = max(diag(A));
disp(max_diag);
quot = prod(A, 2) ./ sum(A, 2);
max_quot = max(quot);
disp(max_quot);
min_quot = min(quot);
disp(min_quot);
A = sortrows(A, 'descend');
disp(A);
clear quot;


%% task 4 +
A = input('Enter matrix: ');
disp(A);
[m, n] = size(A);
if (mod(n, 2) > 0.01)
    error('wrong n');
end
R = A(1:2:m, 2:2:n);
B = A(2:2:m, 1:2:n);
G(1:2:m, :) = A(1:2:m, 1:2:n);
G(2:2:m, :) = A(2:2:m, 2:2:n);
disp(R);
disp(G);
disp(B);
clear m;
clear n;

%% task 5 +
x = input('Enter x: ');
y1 = input('Enter y: ');
x_col = reshape(repmat(x, numel(y1), 1), numel(x) * numel(y1), 1);
y_col = repmat(y1', numel(x), 1);
A = [x_col, y_col];
disp(A);
clear x_col;
clear y_col;

%% task 6 +
X = input('Enter X: ');
[m, n] = size(X);
C = X' * X; % matrix of scalar products
C = C .* C;
norms_sq = sum(X .* X, 1); % squares of norms
B = repmat(norms_sq', 1, n) .* repmat(norms_sq, n, 1);
A = sqrt(B - C);
disp(A);
clear n;
clear norms_sq;
clear B;
clear C;

%% task 7
a = input('Enter a: ');
b = input('Enter b: ');
res = max(max(a) - min(b), max(b) - min(a));
disp(res);

%% task 8
A = input('Enter matrix: ');
[n, k] = size(A);
squared_sum = repmat(sum(A .* A, 2), 1, n);
D = squared_sum + squared_sum' - 2 * (A * A');
D = sqrt(D);
disp(D);
clear squared_sum;

%% task 9 
min_dim = input('Enter min dimension: ');
max_dim = input('Enter max dimension: ');
step = input('Enter step: ');
sizes = min_dim : step : max_dim;
rep = 100;
time1 = zeros(numel(sizes), rep);
time2 = time1;
for i = 1 : numel(sizes)
    B = rand(sizes(i));
    C = rand(sizes(i));
    for j = 1:rep
        tic();
        my_add(B, C);
        time1(i, j) = toc();
        tic()
        B + C;
        time2(i, j) = toc();
    end
end

time1 = median(time1, 2);
time2 = median(time2, 2);
plot(sizes, time1, sizes, time2);
xlabel('size')
ylabel('time');
legend('my\_add', 'MATLAB add');
clear A;
clear B;
clear C;
clear i;

%% task 10
A = input('Enter vector A: ');
A = reshape(A, 1, numel(A));
diff = A - fliplr(A);
if isempty(find(diff > 0.0001, 1))
    disp('A is symmetric');
else
    disp('A is not symmetric');
end
clear diff;
 
%% task 11
n = input('Enter n: ');
a = input('Enter a: ');
b = input('Enter b: ');
sample = a * rand(1, n);
delt = numel(find(sample > b)) / n;
disp(['number of elements > b = ', num2str(delt)]);
disp(['a/2b = ', num2str(a / (2 * b))]);
if delt < a / (2 * b)
    disp('Markovs inequality is correct');
else
    disp('Markovs inequality is not correct');
end
clear sample;

%% task 12
a = -20;
b = 20;
x = a:0.4:b;
f = exp(-x .^ 2);
Y = tril(repmat(f, numel(f), 1));
y1 = trapz(x, Y');
y2 = rectangles(x, Y');
y3 = simpson(x, Y');
subplot(3, 1, 1);
plot(x, y1, x, y2, x, y3);
legend('trapz', 'rectangles', 'simpson');
title('\int_{-\infty}^x e^{-x^2}dx');

h = 1;
n = 15;
rep = 100;
err = zeros(3, n);
time = zeros(3, n, rep);
t = zeros(1, n);
for i = 1:n
        x = a:h:b;
        f = sin(x .* x) + x .^ 3;
        for j = 1:rep
        tic(); 
        err(1, i) = trapz(x, f');
        time(1, i, j) = toc();
        tic();
        err(2, i) = rectangles(x, f');
        time(2, i, j) = toc();
        tic();
        err(3, i) = simpson(x, f');
        time(3, i, j) = toc();
        end
    t(i) = h;
    h = h / 2;
end
time = median(time, 3);
err = abs(diff(err, 1, 2));
subplot(3, 1, 2);
loglog(t(1 : n - 1), err(1, :), t(1 : n - 1), err(2, :), t(1 : n - 1), err(3, :));
legend('trapz', 'rectangles', 'simpson');
title('Внутренняя скорость сходимости');
subplot(3, 1, 3);
loglog(t, time(1, :), t, time(2, :), t, time(3, :));
legend('trapz', 'rectangles', 'simpson');
title('Время выполнения функции');

%% task 13
x0 = 0;
h = logspace(0, -5, 100000);
der_r = (f(x0 + h) - f(x0)) ./ h;
der_c = (f(x0 + h) - f(x0 - h)) ./ (2 * h);
dif_r = abs(der_r - f_der(x0));
dif_c = abs(der_c - f_der(x0));
loglog(h, dif_r, h, dif_c);
legend('правая р.п.', 'центральная р.п.');
title('Отклонение разностной производной от точного значения');
