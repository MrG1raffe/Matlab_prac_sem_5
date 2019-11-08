function y = func1(t)
   y = t .* exp(-t.^2);
 %   y = 10^(-5) * ones(size(t));
 %     ind = find(t < -5);
%     y(ind) = 0;
end