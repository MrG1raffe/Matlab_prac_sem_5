function DFT = plotFT(hFigure, fHandle, fFTHandle, step, inpLimVec, outLimVec)
    SPlotInfo = get(hFigure, 'UserData');
    flag = false;
    if isempty(SPlotInfo)
        flag = true;
    else
        is_graph = SPlotInfo.is_graph;
        ax = SPlotInfo.ax;
        if is_graph
            clf;
            subplot(1, 2, 1);
            axis(ax);
            subplot(1, 2, 2);
            axis(ax);
        end
    end
    a = inpLimVec(1);
    b = inpLimVec(2);
    DFT.nPoints = round((b - a) / step) + 1;
    DFT.step = step;
    DFT.inpLimVec = [a, b];
    
    f = fHandle;
    fHandle = @(x) f(mod(x - a, b - a) + a);
    
    T = b - a;
    N = round(T / step);
    step = T / N;
    if nargin == 5
        c = 0;
        d = 2 * pi / step;
    else
        c = outLimVec(1);
        d = outLimVec(2);
    end
    N = N + 1;
    x = linspace(-step/2, T - step/2, N);
    y = fHandle(x);
    four_im = step * fft(y);
    four_step = 2 * pi / T;
    ind_left = ceil(c / four_step);
    ind_right = floor(d / four_step);
    four_x = ind_left:ind_right;
    inds = mod(four_x, N);
    four_x = four_x * four_step;
    four_res = zeros(1, numel(four_x));
    for j = 1:numel(four_x)
        four_res(j) = four_im(inds(j) + 1);
    end
    re_res = real(four_res);
    im_res = imag(four_res);
    
    m = min(min(re_res), min(im_res));
    M = max(max(re_res), max(im_res));
    
    figure(hFigure.Number);
    subplot(1, 2, 1);
    hold on;
    axis manual;
    plot(four_x, re_res);
    legend('Численная аппроксимация F(\lambda)');
    hold on;
    if (~isempty(fFTHandle))
        plot(four_x, real(fFTHandle(four_x)), 'r');
        legend('Численная аппроксимация F(\lambda)', 'Аналитическое решение');
    end
    xlabel('\lambda');
    ylabel('Re F(\lambda)');
    if flag
        axis([c d m M]);
    end
    
    subplot(1, 2, 2);
    hold on;
    axis manual;
    plot(four_x, im_res);

    legend('Численная аппроксимация F(\lambda)');
    hold on;
    if (~isempty(fFTHandle))
        plot(four_x, imag(fFTHandle(four_x)), 'r');
        legend('Численная аппроксимация F(\lambda)' ,'Аналитическое решение');
    end
    xlabel('\lambda');
    ylabel('Im F(\lambda)');
    if flag
        axis([c d m M]);
        ax = [c d m M];
    end
    DFT.outLimVec = [c, d];
    SPlotInfo.ax = ax;
    SPlotInfo.is_graph = true;
    set(hFigure, 'UserData', SPlotInfo);
end