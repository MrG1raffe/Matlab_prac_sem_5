function [Q, R] = qr_m(A)
    n = size(A, 1);
    if n ~= size(A, 2)
        error('A must be square.');
    end
    Q = zeros(n);
    R = diag(ones(1, n));
    for i = 1:n
        c = zeros(n, 1);
        for j = 1:(i-1)
            ab = 0;
            bb = 0;
            for k = 1:n
                ab = ab + A(k, i) * Q(k, j);
                bb = bb + Q(k, j) ^ 2;
            end
            d = ab / bb;
            R(j, i) = d;
            for k = 1:n
                c(k) = c(k) + d * Q(k, j);
            end
        end
        for j = 1:n
            Q(j, i) = A(j, i) - c(j);
        end
    end
    for i = 1:n
        c = 0;
        for j = 1:n
            c = c + Q(j, i) ^ 2;
        end
        c = sqrt(c);
        for j = 1:n
            Q(j, i) = Q(j, i) / c;
            R(i, j) = R(i, j) * c;
        end
    end
end