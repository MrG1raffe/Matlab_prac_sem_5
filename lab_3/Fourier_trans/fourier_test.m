%%
x = -10:0.1:10;
plot(x, func1(x));
f = figure;
ax = [-6 6 -1 1];
SPlotInfo.ax = ax;
SPlotInfo.is_graph = false;
set(f, 'UserData', SPlotInfo);
subplot(1, 2, 1);
axis(ax);
subplot(1, 2, 2);
axis(ax);
step = 0.01;
a = 20;
plotFT(f, @func1, @ftfunc1, step, [-8 15], [-6 6]);

%%
x = -100:0.1:100;
plot(x, func2(x));
f = figure;
ax = [-10 10 -3 3];
SPlotInfo.ax = ax;
SPlotInfo.is_graph = false;
set(f, 'UserData', SPlotInfo);
subplot(1, 2, 1);
axis(ax);
subplot(1, 2, 2);
axis(ax);
step = 0.001;
plotFT(f, @func2, @ftfunc2, step, [-150 150], [-10 10]);

%%
x = -10:0.1:10;
plot(x, func3(x));
f = figure;
ax = [-6 6 -0.3 1];
SPlotInfo.ax = ax;
SPlotInfo.is_graph = false;
set(f, 'UserData', SPlotInfo);
subplot(1, 2, 1);
axis(ax);
subplot(1, 2, 2);
axis(ax);
step = 0.05;
plotFT(f, @func3, [], step, [0 20], [-pi/step pi/step]);

%%
x = -4:0.01:4;
f1 = @(x) sin(x) .* (abs(x) < 1/3);
plot(x, f1(x));
f = figure;
ax = [-2 2 -0.5 2.5];
SPlotInfo.ax = ax;
SPlotInfo.is_graph = false;
set(f, 'UserData', SPlotInfo);
subplot(1, 2, 1);
axis(ax);
subplot(1, 2, 2);
axis(ax);
step = 0.001;
plotFT(f, f1, [], step, [-1 1], [-2 2]);


%% Без наложения
x = -15:0.1:15;
f = @(shift, x) imag(ftfunc1(x - shift));
sum = zeros(size(x));
subplot(1, 2, 2);
plot(x, sum, 'r');
hold on;
T = 14;
for i = -3:3
    subplot(1, 2, 1);
    plot(x, f(i * T, x), 'b');
    hold on;
    subplot(1, 2, 2);
    plot(x, f(i * T, x), 'b');
    hold on;
    sum = sum + f(i * T, x);
end
plot(x, sum, 'r');
legend('Сумма с наложением частот', 'Размноженный со сдвигом образ Фурье');
xlabel('\lambda');
ylabel('F(\lambda)');
axis([-15 15 -1 1]);
subplot(1, 2, 1);
legend('Размноженный со сдвигом образ Фурье');
xlabel('\lambda');
ylabel('F(\lambda)');
axis([-15 15 -1 1]);
%% Наложение спектра
x = -15:0.1:15;
f = @(shift, x) imag(ftfunc1(x - shift));
sum = zeros(size(x));
subplot(1, 2, 2);
plot(x, sum, 'r');
hold on;
T = 8.5;
for i = -3:3
    subplot(1, 2, 1);
    plot(x, f(i * T, x), 'b');
    hold on;
    subplot(1, 2, 2);
    plot(x, f(i * T, x), 'b');
    hold on;
    sum = sum + f(i * T, x);
end
plot(x, sum, 'r');
legend('Сумма с наложением частот', 'Размноженный со сдвигом образ Фурье');
xlabel('\lambda');
ylabel('F(\lambda)');
axis([-15 15 -1 1]);
subplot(1, 2, 1);
legend('Размноженный со сдвигом образ Фурье');
xlabel('\lambda');
ylabel('F(\lambda)');
axis([-15 15 -1 1]);

