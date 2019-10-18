function f = getFunc(k, meth, N)
    if meth == 1
       if k == 0
           f = @(x) 1/sqrt(2 * pi) * ones(size(x));
       end
       if mod(k, 2) == 0 && k ~= 0
           f = @(x) cos((x - pi) * k / 2) / sqrt(pi);
       end
       if mod(k, 2) == 1
           f = @(x) sin((x - pi) * (k + 1) / 2) / sqrt(pi);
       end
    end
    
    if meth == 2
        r = @(n, x) sign(sin(2 ^ (n) * pi * x));
        N = 2 ^ (ceil(log(N) / log(2)));
        n = log(N) / log(2);
        f = @(x) ones(size(x));
        for i = 1:n
            w1 = mod(floor(k / (2^(i-1))), 2);
            w2 = mod(floor(k / (2^i)), 2);
            if (xor(w1, w2))
                f = @(x) f(x) .* r(i, x);
            end
        end
        f = @(x) f(x /(2 * pi)) / sqrt(2 * pi);
    end
    
    if meth == 3
       f = @(x) ones(size(x));
       for i = 1:k
           c = ((-1) ^ i) * prod(1:k) / ((prod(1:i))^2 * prod(1:k-i));
           f = @(x) f(x) + c * x .^ i;
       end
       x = linspace(0, 100, 100000);
       norm = sqrt(trapz(x, f(x) .^ 2 .* exp(-x)));
       f = @(x) f(x) / norm;
    end
end