function W = tweedle(N)
%Tweedle Generates Tweedle matrix.
%   requires N number of samples

%   these are the powers
%
%    0   0    0    0 
%    
%    0  1*1  2*1  3*1
%     
%    0  1*2  2*2  3*2
%     
%    0  1*3  2*3  3*3
%     

    w = exp( - 1i * 2 * pi / N );
    
    N = abs(N);  % to prevent from negative N values which corresponds to Idft calls.
    W = ones(N);

    for i = 2 : N
        
       %if mod(i,10)==0
        %fprintf('row %d ... \n',i);
       %end
       
       for j = 2 : N
                        W(i,j) = w ^ ( (i-1)*(j-1) ); 
       end
       
    end
    
end

