function res = uAnalytical(xMat, yMat, u1Zero, u2Zero, mu)
    c1 = @(x) (3*sin(3*x)+(2-sqrt(mu)).*cos(3*x)).*exp(x*(2-sqrt(mu)))/((mu-4*sqrt(mu)+13)*2*sqrt(mu));
    c2 = @(x) -(3*sin(3*x)+(2+sqrt(mu)).*cos(3*x)).*exp(x*(2+sqrt(mu)))/((mu+4*sqrt(mu)+13)*2*sqrt(mu));
    A = [1 1; exp(sqrt(mu)) exp(-sqrt(mu))];
    b = [(u1Zero - c1(0) - c2(0)); (u1Zero - exp(sqrt(mu))*c1(1) - exp(-sqrt(mu))*c2(1))];
    const = A\b;
    res = exp(sqrt(mu)*xMat) .* (c1(xMat) + const(1)) + exp(-sqrt(mu)*xMat) .* (c2(xMat) + const(2));
    
    if (abs(mu) ~= 1)
        c1 = @(y) (-1/((2*sqrt(mu))*(1-sqrt(mu))))*y.^2.*exp(y*(1-sqrt(mu))) + (1/(sqrt(mu)*(1-sqrt(mu))^2))*y.*exp(y*(1-sqrt(mu))) - (1/(sqrt(mu)*(1-sqrt(mu))^3))*exp(y*(1-sqrt(mu)));
        c2 = @(y) (1/((2*sqrt(mu))*(1+sqrt(mu))))*y.^2.*exp(y*(1+sqrt(mu))) - (1/(sqrt(mu)*(1+sqrt(mu))^2))*y.*exp(y*(1+sqrt(mu))) + (1/(sqrt(mu)*(1+sqrt(mu))^3))*exp(y*(1+sqrt(mu)));
    end
    if mu == 1
        c1 = @(y) -y.^3 / 6;
        c2 = @(y) (2*y.^2-2*y+1).*exp(2*y)/8;
    end
        
        
    A = [1 1; exp(sqrt(mu)) exp(-sqrt(mu))];
    b = [(u2Zero - c1(0) - c2(0)); (u2Zero - exp(sqrt(mu))*c1(1) - exp(-sqrt(mu))*c2(1))];
    const = A\b;
    res = res + exp(sqrt(mu)*yMat) .* (c1(yMat) + const(1)) + exp(-sqrt(mu)*yMat) .* (c2(yMat) + const(2));   
end