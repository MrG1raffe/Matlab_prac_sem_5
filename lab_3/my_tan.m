function y = my_tan(x)
    y =tan(x);
    ind = find(y > 30);
    y(ind) = 30;
end