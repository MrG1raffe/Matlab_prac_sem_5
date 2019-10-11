function p = getEqual(f, g, t0, t1, N)
    p = zeros(2, N);
    syst = @(t) fun(f, g, t0, t1, N, t);
    h = (t1 - t0) / (N - 1);
    t = linspace(t0 + h, t1 - h, N - 1);
    t = [t, 1];
    x = fsolve(syst, t);
    x
end