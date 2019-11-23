function res = solveDirichlet(fHandle, xiHandle, etaHandle, mu, N, M)
    phi = zeros(N, M);
    x = linspace(0, 1, N + 1);
    y = linspace(0, 1, M + 1);
    [X, Y] = meshgrid(x, y);
    phi(2:N, 2:M) = fHandle(X(2:N, 2:M), Y(2:N, 2:M));
    B_tmp = ifft2(phi);
    X = X(1:N, 1:M);
    Y = Y(1:N, 1:M);
    C = -N^2 * 4 * (sin(pi * X)) .^ 2 - M ^ 2 * 4 * (sin(pi * Y)) .^ 2 - mu;
    xi = xiHandle(x(1:N));
    eta = etaHandle(y(1:M));
    C = ones(size(C)) ./ C;
        
    A = zeros(M + N - 1);
    right = zeros(M + N - 1, 1);
    for m = 1:M
        D = ifft(C');
        D = D' / N;
        D = sum(D, 1);
        A(m, 1:M) = [D((mod(-(m - 1), M) + 1):M), D(1:(mod(-(m - 1), M)))];
    end
            
    D = fft(C');
    D = D';
    D = ifft(D) / M;
    D = D';
    A(1:M, M+1:M+N-1) = D(:, 2:N);
    A(1:M, 1) = A(1:M, 1) + D(:, 1);
    
    D = fft(C');
    D = sum(D, 2) / (M * N);
    A(1:M, 1) = A(1:M, 1) - D;
    
    D = B_tmp .* C;
    D = fft(D');
    D = sum(D, 2) / (M * N);
    right(1:M) = eta' - D;
    
    
    D = fft(C);
    D = ifft(D') / N;
    A(M+1:M+N, 1:M) = D';
    
    for k = M+1:N+M
        D = ifft(C);
        D = D / M;
        D = sum(D, 2);
        D = [D((mod(-(k - 1), N) + 1):N); D(1:(mod(-(k - 1), N)))];
        A(k, M+1:M+N-1) = D(2:N);
        A(k, 1) = A(k, 1) + D(1);
    end
    
    D = fft(C);
    D = sum(D, 2) / (M * N);
    A(M+1:M+N, 1) = A(M+1:M+N, 1) - D;
    
    D = B_tmp .* C;
    D = fft(D);
    D = sum(D, 2) / (M * N);
    right(M+1:M+N) = xi' - D;
    
    sys_sol = A \ right;
    phi(1, 1:M) = sys_sol(1:M);
    phi(2:N, 1) = sys_sol(M+1:M+N-1);
    
    B = ifft2(phi);
    A = B .* C;
    res = fft2(A);
end