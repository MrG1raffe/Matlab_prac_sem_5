function [val, point] = test_rho2(x)
    % опорная функция для единичного квадрата с цетром в M
    M = [3; 0];
    val = sum(abs(x)) + M' * x;
    if abs(x(2)) < abs(x(1))
        point = sign(x(1)) * [1; x(2) / x(1)];
    else
        point = sign(x(2)) * [x(1) / x(2); 1];
    end
    point = point + M;
end