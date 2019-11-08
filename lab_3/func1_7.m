function y = func1_7(~, x)
    y = [0; 0];
    y(1) = x(1).^2 + 2 * x(2).^3;
    y(2) = x(1) .* x(2).^2;
end