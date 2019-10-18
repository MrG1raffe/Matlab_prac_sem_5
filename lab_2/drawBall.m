function drawBall(val, alpha, N, col, edg)
    if isnan(alpha)
        f = @(x, y, z) max(max(abs(x), abs(y)), abs(z));
    else
        f = @(x, y, z) abs(x).^alpha + abs(y).^alpha + abs(z).^alpha;        
    end
    x = linspace(-val - 1, val + 1, N);
    [X, Y, Z] = meshgrid(x);
    [fc, v] = isosurface(X, Y, Z, f(X,Y,Z), val);
    if isempty(v)
        error('Isosurface is empty');
    else
        p = patch(isosurface(X, Y, Z, f(X,Y,Z), val));
        isonormals(X,Y,Z,f(X,Y,Z),p);
        p.FaceColor = col;
        p.EdgeColor = edg;
        daspect([1 1 1])
        view(3); 
        axis tight
        camlight 
        lighting gouraud
    end
end