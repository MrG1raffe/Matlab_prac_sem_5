function f = func_5(~, y, m1, m2)
    f = zeros(12, 1);
    G = 6.67430 * 10^(-2);
    f(1:3) = y(4:6);
    delt = y(7:9) - y(1:3);
    f(4:6) = G * m2 * (delt) / ((norm(delt))^3);
    f(7:9) = y(10:12);
    f(10:12) = G * m1 * (-delt) / ((norm(delt))^3);
end