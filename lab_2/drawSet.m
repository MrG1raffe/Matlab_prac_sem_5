function drawSet(rho, N)
    i = 1 : N;
    L = [cos(2 * pi * i / N); sin(2 * pi * i / N)];
    vals = zeros(N, 1);
    points = zeros(2, N);
    for i = 1 : N
        [vals(i), points(:, i)] = rho(L(:, i));
    end
    connect(points);
    hold on;
    A = zeros(2 * N);
    b = zeros(2 * N, 1);
    for i = 1:N-1
        A(2*i-1:2*i, 2*i-1:2*i) = L(:, i:i+1)';
        b(2*i-1:2*i) = vals(i:i+1);
    end
    A(2*N-1:2*N, 2*N-1:2*N) = [L(:, N)'; L(:, 1)'];
    b(2*N-1:2*N) = [vals(N); vals(1)];
    P = A\b;
    P = reshape(P, 2, N);
    connect(P);
end