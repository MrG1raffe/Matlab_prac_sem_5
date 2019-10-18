function [val, point] = test_rho1(x)
    % опорная функция для круга радиуса r с цетром в М
    r = 1;
    M = [3; -4];
    val = r * norm(x) + M'* x;
    point = M + r * x ./ norm(x);
end