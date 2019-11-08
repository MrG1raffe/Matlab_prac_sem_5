function y = ftfunc2(t)
    if isscalar(t)     
        if (t ~= 0)
            y = pi/2 * (sign(t-1) + sign(t + 1)) - 2*(pi/2 * sign(t) - atan(1./t));
        else
            y = 0;
        end
    else
        ind = find(t);
        y = zeros(size(t));
        tmp = pi/2 * (sign(t-1) + sign(t + 1)) - 2*(pi/2 * sign(t) - atan(1./t));
        y(ind) = tmp(ind);
    end
    y = -1i * y;
end