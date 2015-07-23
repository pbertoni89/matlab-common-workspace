function yk = mycircshift(y,k)

k = floor(k);
yk = zeros(size(y));

% check for 1D, convert to row
if size(y,1)>1
    y = y';
end
if size(y,1)>1
    return;
end

if k>=0
    yk = [ y(end-k+1:end) y(1:end-k)];
else
    yk = [y(-k+1:end) y(1:-k)];


end