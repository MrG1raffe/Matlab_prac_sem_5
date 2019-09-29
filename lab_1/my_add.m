function A = my_add(B, C)
    if(size(B, 1) ~= size(C, 1) | size(B, 2) ~= size(C, 2))
        error('Wrong matrices sizes');
    end 
    A = zeros(size(B));
    for i = 1 : numel(B)
        A(i) = B(i) + C(i);
    end
end