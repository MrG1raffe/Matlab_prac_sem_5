function convergenceFunc(fn, f, a, b, n)
    mov(1:n) = struct('cdata', [],'colormap', []);
    x = linspace(a, b, 1000);
    for i = 1:n
    av_metric = sqrt(trapz(x, (fn(i, x)- f(x)) .^ 2));
    unif_metric = max(abs(fn(i, x) - f(x)));
    plot(x, fn(i, x), x, f(x));  
    title({['sup|f(x)-f_n(x)|= ', num2str(unif_metric, '%.4f')]; ['(\int_a^b (f_n(x) - f(x))^2dx)^{1/2}= ', num2str(av_metric, '%.4f')]});
    mov(i) = getframe();
    end
end