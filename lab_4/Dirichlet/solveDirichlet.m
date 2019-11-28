function res = solveDirichlet(fHandle, xiHandle, etaHandle, mu, N, M)
    x = linspace(0, 1, N + 1);
    y = linspace(0, 1, M + 1);
    [X, Y] = meshgrid(x, y);
    phi = zeros(M, N);
    phi(2:M, 2:N) = fHandle(X(2:M, 2:N), Y(2:M, 2:N));
    phi = phi';
    B_tmp = ifft2(phi);
    %B_tmp
    X = X(1:M, 1:N);
    Y = Y(1:M, 1:N);
    C = -N^2 * 4 * (sin(pi * X)) .^ 2 - M ^ 2 * 4 * (sin(pi * Y)) .^ 2 - mu;
    C = C';
    xi = xiHandle(x(1:N));
    eta = etaHandle(y(1:M));
    C = ones(size(C)) ./ C;
            
    A = zeros(M + N, M + N - 1);
    %right = zeros(M + N, 1);
    
    %phi
    
    for m = 1:M
        D = sum(C', 2);
        D = ifft(D);
        D = D' / N;
        A(m, 1:M) = [D((mod(-(m - 1), M) + 1):M), D(1:(mod(-(m - 1), M)))];
    end

    D = fft(C');
    D = D';
    D = ifft(D) / M;
    D = D';
    A(1:M, M+1:M+N-1) = D(:, 2:N);

    
    D = B_tmp.*C;
    D = sum(D);
    right = eta' - fft(D)';
%     for m=0:M-1
%         right(m+1) = eta(m+1);
%         for s=0:N-1
%             for p=0:M-1
%                 %right(m+1) = right(m+1) - B_tmp(s+1,p+1)*C(s+1, p+1)*exp(-2*pi*1i*m*p/M);
%                 right(m+1) = right(m+1) - B_tmp(s+1,p+1)*C(s+1, p+1)*exp(-2*pi*1i*m*p/M);
%             end
%         end
%     end
    
    
    D = fft(C);
    D = ifft(D') / N;
    D = D';
    A(M+1:M+N, 1:M) = D;
    
    for k = M+1:N+M
        D = sum(C, 2);
        D = ifft(D);
        D = [D((mod(-(k - 1), N) + 1):N); D(1:(mod(-(k - 1), N)))];
        D = D / M;
        A(k, M+1:M+N-1) = D(2:N);
    end
    
%     D = B_tmp .* C;
%     D = fft(D);
%     D = sum(D, 2);
%     right(M+1:M+N) = xi' - D;
    
    D = B_tmp .* C;
    D = fft(sum(D, 2));
    size(D)
    size(xi)
    right(M+1:M+N) = xi' - D;

% %     for k=0:N-1
% %         right(M+k+1) = xi(k+1);
% %         for s=0:N-1
% %             for p=0:M-1
% %                 right(M+k+1) = right(M+k+1) - B_tmp(s+1,p+1)*C(s+1, p+1)*exp(-2*pi*1i*k*s/N);
% %             end
% %         end
% %     end    
    
    A(M + 1,:) = [];
    right(M + 1) = [];
    
    sys_sol = A \ right;

    phi(1, 1:M) = sys_sol(1:M);
    phi(2:N, 1) = sys_sol(M+1:M+N-1);
    
    B = ifft2(phi);
    A = B .* C;
   
    res = fft2(A);
    res = real(res');
end