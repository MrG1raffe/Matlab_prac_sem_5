function [val, point] = test_rho1(l)
    val = [2, 2]*l + norm(l);
    point = l/norm(l) + [2;2];
end