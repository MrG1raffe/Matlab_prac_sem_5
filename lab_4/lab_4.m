%% Task 1
clc;
mex -R2018a biquadsolve.c;

A = rand(2, 3)
B = rand(2, 3)
C = rand(2, 3)

[x1, x2, x3, x4] = biquadsolve(complex(A), complex(B), complex(C))

check1 = A .* (x1 .^ 4) + B .* (x1 .^ 2) + C
check2 = A .* (x2 .^ 4) + B .* (x2 .^ 2) + C 
check3 = A .* (x3 .^ 4) + B .* (x3 .^ 2) + C 
check4 = A .* (x4 .^ 4) + B .* (x4 .^ 2) + C

%% Task 2
mex qr_c.c
A = rand(5);
disp(A);
[Q1, R1] = qr_c(A);
check1 = Q1 * R1 - A
check2 = Q1 * Q1'

[Q2, R2] = qr_c(A);
check1 = Q2 * R2 - A
check2 = Q2 * Q2'

%% Task 3
sz = 10;
n = linspace(100, 1000, sz);
err_c = zeros(1, sz);
err_m = zeros(1, sz);
for i = 1:sz
    A = rand(n(i));
    [Q, R] = qr(A);
    [Qc, Rc] = qr_c(A);
    [Qm, Rm] = qr_m(A);
    err_c(i) = max(max(abs(Q - Qc), [], 'all'), max(abs(R - Rc), [], 'all'));
    err_m(i) = max(max(abs(Q - Qm), [], 'all'), max(abs(R - Rm), [], 'all'));
end
plot(n, err_c, n, err_m);
legend('Максимальное отклонение qr\_c', 'Максимальное отклонение qr\_m');

%% Task 4
sz = 10;
n = linspace(100, 1000, sz);
tm = zeros(sz);
tm_c = tm;
tm_m = tm;
for i = 1:sz
    for j = 1:sz
        A = rand(n(i));
        tic();
        [~, ~] = qr(A);
        tm(j, i) = toc();
        
        tic();
        [~, ~] = qr_c(A);
        tm_c(j, i) = toc();
        tic();
        [Q, R] = qr_m(A);
        tm_m(j, i) = toc();
    end
end

plot(n, median(tm ,1), n, median(tm_c, 1), n, median(tm_m, 1));
legend('Время работы qr', 'Время работы qr\_c', 'Время работы qr\_m');

%% Task 5
sz = 10;
n = linspace(100, 1000, sz);
Tval = zeros(1, sz);
for i = 1:sz
    Tval(i) = T(2, n(i));
end
f = regr(n, Tval, 2);
x = linspace(100, 1000, 100);
plot(n, Tval, x, f(x));