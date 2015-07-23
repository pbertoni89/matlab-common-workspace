function [O] = obsv(A, C)
%CTRLB Summary of this function goes here
%   Detailed explanation goes here

    n = size(A,1); % fix with control
    At = A';
    Ct = C';
    O = Ct; 
    for i = 1:n-1
        O = [ O At^(i)*Ct ];
    end
end

