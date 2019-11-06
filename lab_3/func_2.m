function y = func_2(x, x0)
    y = sign(x) .* sqrt(abs(x)) - tan(x);
    if numel(x) == 1 && (abs(y) > 10)
        y = 10;
    end
    if numel(x) > 1
        ind = find(abs(y) > 10);
        y(ind) = 10;
    end
end