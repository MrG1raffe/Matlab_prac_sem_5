function int = simpson(X, Y, dim)
    if nargin == 3 && (~isscalar(dim) || ~isnumeric(dim) || (dim ~= floor(dim)))
        error(message('MATLAB:getdimarg:dimensionMustBePositiveInteger'));
    end
    if nargin == 1
        Y = X;
        if (size(Y, 1) > 1)
            m = size(Y, 1);
            int = (sum(Y) + sum(Y(3 : 2 : m - 2, :)) + 3 * sum(Y(2 : 2 : m - 1, :))) / 3;
        else 
            m = size(Y, 2);
            int = (sum(Y) + sum(Y(3 : 2 : m - 2)) + 3 * sum(Y(2 : 2 : m - 1))) / 3;
        end
    else
        if nargin == 2 && isscalar(Y) % simpson(y,dim)
            dim = Y;
            Y = X;
            if ~isscalar(dim) || ~isnumeric(dim) || (dim ~= floor(dim))
                error(message('MATLAB:getdimarg:dimensionMustBePositiveInteger'));
            end
            if (dim == 1)
                m = size(Y, 1);
                int = (sum(Y) + sum(Y(3 : 2 : m - 2, :)) + 3 * sum(Y(2 : 2 : m - 1, :))) / 3;
            else 
                m = size(Y, 2);
                int = (sum(Y, 2) + sum(Y(:, 3 : 2 : m - 2), 2) + 3 * sum(Y(:, 2 : 2 : m - 1), 2)) / 3;
            end
        else
            if ~isvector(X)
                error(message('MATLAB:trapz:xNotVector'));
            end
            X = X(:);
            h = diff(X);
            if find(diff(h) > 0.001)
                error('X must be uniform');
            end
            h = h(1);
            if (nargin == 2 && size(Y, 1) ~= 1) || (nargin == 3 && dim == 1) 
                m  = size(Y, 1);
                if ~isscalar(X) && length(X) ~= m
                    error(message('MATLAB:trapz:LengthXmismatchY'));
                end    
                int = h / 3 * (sum(Y) + sum(Y(3 : 2 : m - 2, :)) + 3 * sum(Y(2 : 2 : m - 1, :)));
            else
                m  = size(Y, 2);
                if ~isscalar(X) && length(X) ~= m
                    error(message('MATLAB:trapz:LengthXmismatchY'));
                end 
                int = h / 3 * (sum(Y, 2) + sum(Y(:, 3 : 2 : m - 2), 2) + 3 * sum(Y(:, 2 : 2 : m - 1), 2));
            end 
        end
    end
end