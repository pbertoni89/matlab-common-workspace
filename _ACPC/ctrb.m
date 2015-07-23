function R = ctrb(A, B)
%CTRLB Summary of this function goes here
%   Detailed explanation goes here

    n = size(A,1); % fix with control
    R = B; 
    for i = 1:n-1
        R = [ R A^(i)*B ];
    end
end

