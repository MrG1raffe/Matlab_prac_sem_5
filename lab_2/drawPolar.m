function drawPolar(rho, N)
    i = 1 : N;
    L = [cos(2 * pi * i / N); sin(2 * pi * i / N)];
    vals = zeros(N, 1);
    points = zeros(2, N);
    for i = 1 : N
        [vals(i), points(:, i)] = rho(L(:, i));
    end
    connect(points, 'b'); % рисуем множество
    hold on;
    
    if min(vals) >= 0
        A = zeros(2 * N);
        b = ones(2 * N, 1);
        for i = 1:N-1
            A(2*i-1:2*i, 2*i-1:2*i) = points(:, i:i+1)';
        end
        A(2*N-1:2*N, 2*N-1:2*N) = [points(:, N)'; points(:, 1)'];
        P = A\b;
        P = reshape(P, 2, N);
        connect(P);
    else
        if vals(1) > 0 && vals(N) > 0
            neg = find(vals < 0);
            x_right = neg(1) - 1;
            x_left = neg(numel(neg)) + 1;
            ind = [x_left:N, 1:x_right];
        else
            ind = find(vals > 0);
        end
        %vals = vals(pos_ind);
        points = points(:, ind);
        N = numel(ind);
        A = zeros(2 * N);
        b = ones(2 * N, 1);
        for i = 1:N-1
            A(2*i-1:2*i, 2*i-1:2*i) = points(:, i:i+1)';
        end
        A(2*N-1:2*N, 2*N-1:2*N) = [points(:, N)'; points(:, 1)'];
        P = A\b;
        P = reshape(P, 2, N);
        P = P(:,1:N-1);
        x1 = min([min(points(1,:)), min(P(1, :))]);
        x2 = max([max(points(1,:)), max(P(1, :))]);
        y1 = min([min(points(2,:)), min(P(2, :))]);
        y2 = max([max(points(2,:)), max(P(2, :))]);
        if abs(x1 - min(P(1, :))) < 0.01 && abs(y1 - min(P(2, :))) < 0.01
            P = [P, [x1; y1]];
        end
        if abs(x1 - min(P(1, :))) < 0.01 && abs(y2 - max(P(2, :))) < 0.01
            P = [P, [x1; y2]];
        end
        if abs(x2 - max(P(1, :))) < 0.01 && abs(y1 - min(P(2, :))) < 0.01
            P = [P, [x2; y1]];
                end
        if abs(x2 - max(P(1, :))) < 0.01 && abs(y2 - max(P(2, :))) < 0.01
            P = [P, [x2; y2]];
        end
        connect(P, 'y');
        axis([x1 x2 y1 y2]);
    end
end