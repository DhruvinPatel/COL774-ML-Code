function ans = fapply( z2 )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
f = @(z) 1/(1+exp(-z)) ;
%z2 : m*100
if (size(z2,2)==1)
    
    ans = ones(size(z2,1),1);   
    for i=1:size(z2,1)
        ans(i) = f(z2(i,1));
    end
    
else
    ans = ones(size(z2));
    for i = 1:size(z2,2)% mmmmm
       for j=1:size(z2,1)
        ans(j,i) = f(z2(j,i));
       end 
    
end
end
%100 * m