function res = supportLebesgue(f, opts)
    res = @rho;
    function [val, point] = rho(y)
        nonlcon = @(x) const(f(x));
        maxim = fmincon(@(x) -(y' * x), [0; 0], [], [], [], [], [], [], nonlcon, opts);
        val = y' * maxim;
        point = maxim;
    end
end