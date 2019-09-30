function int = rectangles(X, Y, dim)
    if nargin == 3 && (~isscalar(dim) || ~isnumeric(dim) || (dim ~= floor(dim)))
        error(message('MATLAB:getdimarg:dimensionMustBePositiveInteger'));
    end
    if nargin == 1
        Y = X;
        int = sum(Y);
    else
        if nargin == 2 && isscalar(Y) % rectangles(y,dim)
            dim = Y;
            Y = X;
            if ~isscalar(dim) || ~isnumeric(dim) || (dim ~= floor(dim))
                error(message('MATLAB:getdimarg:dimensionMustBePositiveInteger'));
            end
            int = sum(Y, dim);
        else
            if ~isvector(X)
                error(message('MATLAB:trapz:xNotVector'));
            end
            X = X(:);
            if (nargin == 2 && size(Y, 1) ~= 1) || (nargin == 3 && dim == 1) 
                m  = size(Y, 1);
                if ~isscalar(X) && length(X) ~= m
                    error(message('MATLAB:trapz:LengthXmismatchY'));
                end    
                int = diff(X)' * Y(1 : m - 1, :);
            else
                m  = size(Y, 2);
                if ~isscalar(X) && length(X) ~= m
                    error(message('MATLAB:trapz:LengthXmismatchY'));
                end 
                int = Y(:, 1 : m - 1) * diff(X);
            end 
        end
    end
end