function f = regr(x, y, n)
    A = [ones(size(x)); cumprod(repmat(x, n, 1), 1)];
    b = A * y';
    A = A * A';
    a = A\b;
    f = @(x) sum([ones(1, numel(x)); cumprod(repmat(x, n, 1), 1)] .* repmat(a, 1, numel(x)));
end