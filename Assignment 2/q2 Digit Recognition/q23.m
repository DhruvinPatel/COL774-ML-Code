mnist38 = importdata('mnist_bin38.mat');

train3 = mnist38.train3;
train8 = mnist38.train8;

test3 = mnist38.test3;
test8 = mnist38.test8;

train = [train3; train8];
train = im2double(train);
output = [ones(size(train3,1),1);0*ones(size(train8,1),1)];

test = [test3;test8];
test = im2double(test);
out_test = [ones(size(test3,1),1);0*ones(size(test8,1),1)];
Z = ones(size(test,1),1);

mnis = importdata('Wandb3.mat');

W1 = mnis.W1;
W2 = mnis.W2;
b1 = mnis.b1;
b2 = mnis.b2;

f = @(z) 1/(1+exp(-z)) ;

k = size(test,1);
for i= 1:k
   a1 = test(i,:)';% 784*1
   z2 = W1*a1 + b1';%100*1
   %disp(W1*a1);
   %Cz2 = num2cell(z2);
   %a2 = cellfun(f,Cz2);%100*1    %a2 = f(z2);
   a2 = fapply(z2);
   %disp(a2);
   z3 = W2*a2 + b2;%1*1
   Cz3 = num2cell(z3);
   a3 = cellfun(f,Cz3);%1*1  %a3 = f(z3);
    if(a3>0.5)
        Z(i) = 1;
    else
        Z(i) = 0;
    end
end

acc = 0;

for i = 1:k
   if(out_test(i)==Z(i))
       acc = acc+1;
   end
end

accuracy = acc/k
