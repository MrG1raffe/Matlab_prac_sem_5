function p = getEqual_st(f, g, t0, t1, N)
    T = linspace(t0, t1, N);
    h = (t1 - t0) / (N -1);
    n_mut_c = 50;
    n_mut_i = 50;
    max_iter = 10^6;
    val = J(T);
    i = 1;
    while val > 0.1 && i < max_iter
        val
        mut_c = [zeros(n_mut_c, 1), randn(n_mut_c, N - 2) * h / 24, zeros(n_mut_c, 1)];
        mut_c = repmat(T, n_mut_c, 1) + mut_c;
        mut_c = sortrows(mut_c')';
        mut_i = [zeros(n_mut_i, 1), randn(n_mut_i, N - 2) * h / (24 * i), zeros(n_mut_i, 1)];
        mut_i = repmat(T, n_mut_i, 1) + mut_i;
        mut_i = sortrows(mut_i')';
        mut = [mut_c; mut_i];
        for j=1:size(mut, 1)
            if mut(j, 1) >= t0 && mut(j, N) <= t1
                tmp = J(mut(j, :));
                if tmp < val 
                    T = mut(j, :);
                    val = tmp;
                end
            end
        end
        i = i + 1;
    end
    if i == max_iter && val > 0.1
        disp('Algorithm diverges');
    else
        disp(['Algorithm converged. n = ', num2str(i)]);
    end
    p = T
    val
    
    function y = J(T)
        A = [f(T)', g(T)'];
        squared_sum = repmat(sum(A .* A, 2), 1, N);
        D = squared_sum + squared_sum' - 2 * (A * A');
        D = sqrt(D);
        D(1, :) = [];
        D(:, N) = [];
        D = diag(D);
        D = abs(diff(D));
        y = max(D);
    end
end