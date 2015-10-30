mnist = importdata('mnist_all.mat');


test = [mnist.test0;mnist.test1;mnist.test2;mnist.test3;mnist.test4;mnist.test5;mnist.test6;mnist.test7;mnist.test8;mnist.test9];
test = im2double(test);
o = [0*ones(length(mnist.test0),1);1*ones(length(mnist.test1),1);2*ones(length(mnist.test2),1);3*ones(length(mnist.test3),1);4*ones(length(mnist.test4),1);5*ones(length(mnist.test5),1);6*ones(length(mnist.test6),1);7*ones(length(mnist.test7),1);8*ones(length(mnist.test8),1);9*ones(length(mnist.test9),1)]; %[ones(size(test3,1),1);0*ones(size(test8,1),1)];
out_test = o;
Z = ones(size(test,1),1);

mnis = importdata('Wandb_p2.mat');

W1 = mnis.W1;
W2 = mnis.W2;
b1 = mnis.b1;
b2 = mnis.b2;

f = @(z) 1/(1+exp(-z)) ;

%p = randperm(size(test,1));
%test = test(p,:);
%out_test = out_test(p,:);

k = size(test,1);
for i= 1:k
   a1 = test(i,:)';% 784*1
   z2 = W1*a1 + b1';%100*1
   %disp(W1*a1);
   %Cz2 = num2cell(z2);
   %a2 = cellfun(f,Cz2);%100*1    %a2 = f(z2);
   a2 = fapply(z2);
   %disp(a2);
   z3 = W2*a2 + b2';%10*1
   Cz3 = num2cell(z3);
   a3 = cellfun(f,Cz3);%10*1  %a3 = f(z3);
   max = a3(1);
   
   for j=1:10
       if(a3(j)>max)
           max = a3(j);
           Z(i) = j-1;
       end
   end
end

acc = 0;

for i = 1:k
   if(out_test(i)==Z(i))
       acc = acc+1;
   end
end

accuracy = acc/k
