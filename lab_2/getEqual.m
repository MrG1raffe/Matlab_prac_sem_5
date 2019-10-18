function p = getEqual(f, g, t0, t1, N, test)
    T = linspace(t0, t1, N);
    mid1 = mean(J(T));
    h = (t1 - t0) / (N -1);
    max_iter = 10^6;
    val = norm(abs(diff(J(T))));
    i = 1;
    while val > 0.1 && i < max_iter
        if nargin == 6
            val
        end
        T = T + [0, sign(diff(J(T)))' * h / (4 * i), 0];
        val = norm(abs(diff(J(T))));
        i = i + 1;
    end
    if i == max_iter && val > 0.01
        disp('Algorithm diverged');
    else
        %disp(['Algorithm converged. n = ', num2str(i)]);
    end
    p = T;
    mid2 = mean(J(T));
    disp(['Mean in uniform T: ', num2str(mid1)]);
    disp(['Mean in result: ', num2str(mid2)]);
    function y = J(T)
        A = [f(T)', g(T)'];
        squared_sum = repmat(sum(A .* A, 2), 1, N);
        D = squared_sum + squared_sum' - 2 * (A * A');
        D = sqrt(D);
        D(1, :) = [];
        D(:, N) = [];
        y = diag(D);
    end
end