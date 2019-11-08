function y = func3(t)
    y = exp(-2*abs(t)) ./ (1 + cos(t).^2);
end