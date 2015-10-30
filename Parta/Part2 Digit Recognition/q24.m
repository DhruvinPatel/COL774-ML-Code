mnist38 = importdata('mnist_bin38.mat');

%train3 = mnist38.train3;
%train8 = mnist38.train8;

%test3 = mnist38.test3;
%test8 = mnist38.test8;

train = [mnist.train0;mnist.train1;mnist.train2;mnist.train3;mnist.train4;mnist.train5;mnist.train6;mnist.train7;mnist.train8;mnist.train9];
train = im2double(train);
o0 =  [ones(size(mnist.train0,1),1) 0*ones(size(mnist.train0,1),1) 0*ones(size(mnist.train0,1),1) 0*ones(size(mnist.train0,1),1) 0*ones(size(mnist.train0,1),1) 0*ones(size(mnist.train0,1),1) 0*ones(size(mnist.train0,1),1) 0*ones(size(mnist.train0,1),1) 0*ones(size(mnist.train0,1),1) 0*ones(size(mnist.train0,1),1)];
o1 =  [0*ones(size(mnist.train1,1),1) ones(size(mnist.train1,1),1) 0*ones(size(mnist.train1,1),1) 0*ones(size(mnist.train1,1),1) 0*ones(size(mnist.train1,1),1) 0*ones(size(mnist.train1,1),1) 0*ones(size(mnist.train1,1),1) 0*ones(size(mnist.train1,1),1) 0*ones(size(mnist.train1,1),1) 0*ones(size(mnist.train1,1),1)];
o2 =  [0*ones(size(mnist.train2,1),1) 0*ones(size(mnist.train2,1),1) ones(size(mnist.train2,1),1) 0*ones(size(mnist.train2,1),1) 0*ones(size(mnist.train2,1),1) 0*ones(size(mnist.train2,1),1) 0*ones(size(mnist.train2,1),1) 0*ones(size(mnist.train2,1),1) 0*ones(size(mnist.train2,1),1) 0*ones(size(mnist.train2,1),1)];
o3 =  [0*ones(size(mnist.train3,1),1) 0*ones(size(mnist.train3,1),1) 0*ones(size(mnist.train3,1),1) ones(size(mnist.train3,1),1) 0*ones(size(mnist.train3,1),1) 0*ones(size(mnist.train3,1),1) 0*ones(size(mnist.train3,1),1) 0*ones(size(mnist.train3,1),1) 0*ones(size(mnist.train3,1),1) 0*ones(size(mnist.train3,1),1)];
o4 =  [0*ones(size(mnist.train4,1),1) 0*ones(size(mnist.train4,1),1) 0*ones(size(mnist.train4,1),1) 0*ones(size(mnist.train4,1),1) ones(size(mnist.train4,1),1) 0*ones(size(mnist.train4,1),1) 0*ones(size(mnist.train4,1),1) 0*ones(size(mnist.train4,1),1) 0*ones(size(mnist.train4,1),1) 0*ones(size(mnist.train4,1),1)];
o5 =  [0*ones(size(mnist.train5,1),1) 0*ones(size(mnist.train5,1),1) 0*ones(size(mnist.train5,1),1) 0*ones(size(mnist.train5,1),1) 0*ones(size(mnist.train5,1),1) ones(size(mnist.train5,1),1) 0*ones(size(mnist.train5,1),1) 0*ones(size(mnist.train5,1),1) 0*ones(size(mnist.train5,1),1) 0*ones(size(mnist.train5,1),1)];
o6 =  [0*ones(size(mnist.train6,1),1) 0*ones(size(mnist.train6,1),1) 0*ones(size(mnist.train6,1),1) 0*ones(size(mnist.train6,1),1) 0*ones(size(mnist.train6,1),1) 0*ones(size(mnist.train6,1),1) ones(size(mnist.train6,1),1) 0*ones(size(mnist.train6,1),1) 0*ones(size(mnist.train6,1),1) 0*ones(size(mnist.train6,1),1)];
o7 =  [0*ones(size(mnist.train7,1),1) 0*ones(size(mnist.train7,1),1) 0*ones(size(mnist.train7,1),1) 0*ones(size(mnist.train7,1),1) 0*ones(size(mnist.train7,1),1) 0*ones(size(mnist.train7,1),1) 0*ones(size(mnist.train7,1),1) ones(size(mnist.train7,1),1) 0*ones(size(mnist.train7,1),1) 0*ones(size(mnist.train7,1),1)];
o8 =  [0*ones(size(mnist.train8,1),1) 0*ones(size(mnist.train8,1),1) 0*ones(size(mnist.train8,1),1) 0*ones(size(mnist.train8,1),1) 0*ones(size(mnist.train8,1),1) 0*ones(size(mnist.train8,1),1) 0*ones(size(mnist.train8,1),1) 0*ones(size(mnist.train8,1),1) ones(size(mnist.train8,1),1) 0*ones(size(mnist.train8,1),1)];
o9 =  [0*ones(size(mnist.train9,1),1) 0*ones(size(mnist.train9,1),1) 0*ones(size(mnist.train9,1),1) 0*ones(size(mnist.train9,1),1) 0*ones(size(mnist.train9,1),1) 0*ones(size(mnist.train9,1),1) 0*ones(size(mnist.train9,1),1) 0*ones(size(mnist.train9,1),1) 0*ones(size(mnist.train9,1),1) ones(size(mnist.train9,1),1)];

output = [o0;o1;o2;o3;o4;o5;o6;o7;o8;o9];


m = size(train,1);

f = @(z) 1/(1+exp(-z)) ;

%initializing parameters

W1 = (-1/2+ rand(100,784))/10;
W2 = (-1/2 + rand(10,100))/10;
b1 = (-1/2 + rand(1,100))/10;
b2 = (-1/2 + rand(1,10))/10;

dW1 = zeros(100,784);
db1 = zeros(1,100);
dW2 = zeros(10,100);
dW2old = ones(10,100);
db2 = zeros(1,10);
db2old = ones(1,10);

errold = 100;
err = 0

%feed forward pass
num_t = 1;
nita = 1/(num_t)^(0.5);
while(num_t<7)%(dW2-dW2old)*(dW2-dW2old)'+(db2-db2old)^2 
p = randperm(size(train,1));
train = train(p,:);
output = output(p,:);


for i = 1:m
   a1 = train(i,:)';% 784*1
   z2 = W1*a1 + b1';%100*1
   %Cz2 = num2cell(z2);
   a2 = fapply(z2);%cellfun(f,Cz2);%100*1    %a2 = f(z2);
   
   z3 = W2*a2 + b2';%10*1
   a3 = fapply(z3);%10*1 ---> 10*1
   disp(a3);
   %Cz3 = num2cell(z3);
   %calc d
   dout = -(output(i,:)'-a3).*(a3).*(1-a3);%1*1 ; 100*1
   %disp(dout);
   disp(i); 
   disp('sdasf');
   
   %for j=1:100
    %  dhid(j) = dout* (W2(1,j))*a2(j,1)*(1-a2(j,1)); 
   %end
   dhid = (W2'*dout).*( a2).*(1-a2);%dhid(j) = (W2(1,j)*dout)*( a2(j))*(1-a2(j))
   %dhid ---- 100*1
   disp(dhid'*dhid);
   %disp(dout*W2'.*a2.*(1-a2));
   
   dW1 =  (dhid*a1');
   db1 =  (dhid');
   dW2old = dW2;
   dW2 = (dout*a2');%10*100
   db2old = db2;
   db2 = (dout');%1*10
   
   W1 = W1 - nita*((dW1)) ;
   b1 = b1 - nita*((db1)) ;
   W2 = W2 - nita*((dW2)) ;
   b2 = b2 - nita*((db2)) ;
   

   
end
   errold = err; 
   %err = err + 1/2*((output'-   f
   Cz2 = num2cell((W2*fapply(  (W1*train'+b1'*ones(1,m))')' + b2'*ones(1,m) ));%((W2*fapply(  (W1*train'+b1'*ones(1,m))') + b2*ones(1,m) ))    ;
   yy = cellfun(f,Cz2');
   err = err + 1/2*det((output - yy)'*((output - yy)));
   num_t = num_t +1;
end



% 99.19 test acc. 73208 no. of iterations.
% partd--- 0.9919  9702 correct/10000