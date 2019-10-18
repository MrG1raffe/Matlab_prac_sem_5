function connect(X, col, p)
    % X is matrix 2xN
    sz = 1000;
    t = linspace(0, 1, sz);
    N = size(X, 2);
    D1 = [diff(X(1,:)), X(1,1) - X(1,N)];
    D1 = repmat(D1, sz, 1);
    D2 = [diff(X(2,:)), X(2,1) - X(2,N)];
    D2 = repmat(D2, sz, 1);
    D1 = D1(:)';
    D2 = D2(:)';
    D = [D1; D2];
    X1 = repmat(X(1,:), sz, 1);
    X1 = X1(:)';
    X2 = repmat(X(2,:), sz, 1);
    X2 = X2(:)';
    X = [X1; X2];
    X = X + repmat(t, 2, N) .* D;
    if nargin == 1
        plot(X(1,:), X(2, :));        
    end
    if nargin == 2
        fill(X(1,:), X(2, :), col);
    end
    if nargin == 3
         plot(X(1,1:(N-1)*sz), X(2, 1:(N-1)*sz));        
    end
end