function [val, point] = oc_rho(l)
%     if 3*l(2) >= (4*sqrt(3) - 3) * abs(l(1))
%         %val = sqrt(3) * abs(l(2));
%         point = [0; sqrt(3)];
%     end
%     if 3*l(2) < (4*sqrt(3) - 3) * abs(l(1)) && l(2) >= -abs(l(1))
%         %val = (3 / 4) * (abs(l(1)) + abs(l(2)));
%         point = 3 / 4 * [sign(l(1)); 1];
%     end    
%     if l(2) < -abs(l(1))
%         %val = 0;
%         point = [0; 0];
%     end
%     val = l' * point;
    if 2 * abs(l(2)) <= sqrt(3) * abs(l(1))
        val = 2 * abs(l(1)) - sqrt(l(1)^2 - l(2)^2);
        point = [sign(l(1))*(2 - abs(l(1)) / sqrt(l(1)^2 - l(2)^2)); (l(2) / sqrt(l(1)^2 - l(2)^2))];
    else
        val = sqrt(3) * abs(l(2));
        point = [0; sqrt(3) * sign(l(2))];
    end
end