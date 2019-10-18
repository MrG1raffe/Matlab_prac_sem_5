function viewEaten(points, L, p)
    m = 1000;
    x = linspace(min(points(1, :)) - L, max(points(1, :)) + L, m);
    y = linspace(min(points(2, :)) - L, max(points(2, :)) + L, m);  
    [X, Y] = meshgrid(x, y);
    n = size(points, 2);
    
    big_X = repmat(X, 1, 1, n);
    big_Px = reshape(points(1, :), 1, 1, n);
    big_Px = repmat(big_Px, m, m, 1);

    big_Y = repmat(Y, 1, 1, n);
    big_Py = reshape(points(2, :), 1, 1, n);
    big_Py = repmat(big_Py, m, m, 1);
    
    big_norm = ((abs(big_X - big_Px)).^p + (abs(big_Y - big_Py)).^p).^(1/p);
    Z = L - sum(big_norm, 3);
    Z = 1 * (Z >= 0);
    c = contour(X, Y, Z, [1 1]);
    c(:, 1) = [];
    norm(c(:,100))
    fill(c(1, :), c(2, :), 'y');
end