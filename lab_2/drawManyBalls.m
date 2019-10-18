function drawManyBalls(alphas, colors, edges)
    n = numel(alphas);
    for i = 1:n
        subplot(1, n, i);
        if (edges(i) == 'N')
            drawBall(1, alphas(i), 100, colors(i), edges(i,:));
        else
            drawBall(1, alphas(i), 100, colors(i), edges(i));            
        end
    end
end