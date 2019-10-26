function y = func_4(t, x, a)
    y = zeros(2, 1);
    y(1) = x(2);
    y(2) = -sin(x(1)) - a * x(2);
end