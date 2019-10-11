function syst = fun(f, g, t0, t1, N, t)
    syst(1) = (f(t(1)) - f(t0))^2 + (g(t(1)) - g(t0))^2 - t(N);
    syst(N) = (f(t1) - f(t(N-1)))^2 + (g(t1) - g(t(N-1)))^2 - t(N);
    for i=2:N-1
       syst(i) = (f(t(i)) - f(t(i-1)))^2 + (g(t(i)) - g(t(i-1)))^2 - t(N);
    end
end