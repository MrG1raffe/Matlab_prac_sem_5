function compareInterp(x, xx, f)
    vq1 = interp1(x, f(x), xx, 'nearest');
    vq2 = interp1(x, f(x), xx, 'linear');
    vq3 = interp1(x, f(x), xx, 'spline');
    vq4 = interp1(x, f(x), xx, 'cubic');
    subplot(2, 4, [1, 2, 5, 6])
    plot(xx, f(xx));
    title('f(x)');
    subplot(2, 4, 3)
    plot(x, f(x), 'o', xx, vq1);
    title('Nearest');
    subplot(2, 4, 4)
    plot(x, f(x), 'o', xx, vq2);
    title('Linear');
    subplot(2, 4, 7)
    plot(x, f(x), 'o', xx, vq3);
    title('Spline');
    subplot(2, 4, 8)
    plot(x, f(x), 'o', xx, vq4);
    title('Cubic');
end