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
plotFT(f, @func1, @ftfunc1, step, [-5 8], [-6 6]);

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
step = 0.01;
plotFT(f, @func2, @ftfunc2, step, [-100 120], [-pi/step pi/step]);

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
plotFT(f, @func3, [], step, [-6 6], [-pi/step pi/step]);

%%
x = -10:0.1:10;
plot(x, func4(x));
f = figure;
ax = [-10 10 -0.5 2];
SPlotInfo.ax = ax;
SPlotInfo.is_graph = false;
%set(f, 'UserData', SPlotInfo);
subplot(1, 2, 1);
axis(ax);
subplot(1, 2, 2);
axis(ax);
step = 0.05;
plotFT(f, @func4, [], step, [-10 10], [-10 10]);
