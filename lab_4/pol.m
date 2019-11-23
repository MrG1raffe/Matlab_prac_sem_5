function y = pol(a, x)
    n = numel(a);
    y = [1, cumprod(repmat(x, 1, n - 1))] .* a;
end