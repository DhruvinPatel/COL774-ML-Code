function ans = calc_wtx( alp, Y,X, x )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
ans = 0;    
m = size(X,1);
gamma = 2.5*10^-4;
for i = 1:m
    ans = ans + alp(i)*Y(i)* (exp (-gamma* (X(i,:)-x)* (X(i,:)-x)' ) );
        
end

end

