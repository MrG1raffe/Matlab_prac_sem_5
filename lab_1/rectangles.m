function int = rectangles(X, Y)
    [m, n] = size(Y);
    if numel(X) ~= m
        error('Point spacing must be a scalar specifying uniform spacing or a vector of x-coordinates for each data point.');
    end
    int = diff(X) * Y(1 : m - 1, :);
end