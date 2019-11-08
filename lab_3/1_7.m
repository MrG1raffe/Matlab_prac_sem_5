n = 15;
x1 = linspace(-1, 1, n);
x2 = x1;
for i = 1:n
    for j = 1:n
        [~, y] = ode45(@(t, x) func1_7(t, x), [-10 10], [x1(i); x2(j)]);
        ind = find(y(:,1).^2 + y(:,2).^2 > 2);
        y(ind, :) = [];
        plot(y(:, 1), y(:, 2), 'b');
        hold on;
    end
end
axis([-1 1 -1 1]);
