function  [num,den]=simplify(b,a);


num=b(find(b):max(size(b)));
den=a(find(a):max(size(a)));

