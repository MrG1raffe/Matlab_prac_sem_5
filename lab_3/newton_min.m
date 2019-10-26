function res = newton_min(~, grad, hess, x0)
    prev_x = x0;
    x = x0 + 1;
    n = 1;
    n_max = 1000;
    res = zeros(2, n_max);
    res(:, 1) = x0;
    while norm(prev_x - x) > 0.01
        n = n + 1;
        prev_x = x;
        x = x - hess(x) \ grad(x);
        res(:, n) = x;
    end
    res(:, n+1:size(res, 2)) = [];
    res = fliplr(res);
    disp(['Number of iterations: ', num2str(n - 1)]);
end