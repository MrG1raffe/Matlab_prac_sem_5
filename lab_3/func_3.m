function y = func_3(x)
    if x == 0
        y = 0;
    else
        y = sqrt(abs(x)) .* sin(1 ./ (x.^2));
    end
end