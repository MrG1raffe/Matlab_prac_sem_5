function int = simpson(X, Y)
    [m, n] = size(Y);
    if numel(X) ~= m
        error('Vector sizes must be equal');
    end
    if ~mod(numel(X), 2)
        error('Number of intervals must be even');
    end
    h = diff(X);
    if find(diff(h) > 0.001)
        error('X must be uniform');
    end
    h = h(1);
    int = sum(Y) + sum(Y(3 : 2 : m - 2, :)) + 3 * sum(Y(2 : 2 : m - 1, :));
    int = int * h / 3;
end