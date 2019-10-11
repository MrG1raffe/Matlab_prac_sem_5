function fourierApprox(f, a, b, n, meth)
    % meth = 1 - тригонометрическая система
    % meth = 2 - система функций Уолша
    % meth = 3 - система многочленов Лагерра
    mov(1:n) = struct('cdata', [],'colormap', []);
    sz = 10000;
    lin = linspace(0, 2 * pi, sz);
    sum = zeros(size(lin));
    for i = 0:n-1
        bas_f = getFunc(i, meth, n);
        if meth ~= 3
            sum = sum + trapz(lin, f(a + lin * (b - a) / (2 * pi)) .* bas_f(lin)) * bas_f(lin);
        end
        if meth == 3
            sum = sum + trapz(lin, f(a + lin * (b - a) / (2 * pi)) .* bas_f(lin) .* exp(-lin)) * bas_f(lin);
        end
        plot(a + (b - a) / (2 * pi) * lin, f(a + (b - a) / (2 * pi) * lin), a + (b - a) / (2 * pi) * lin, sum);
        mov(i + 1) = getframe();
    end
end