mnist38 = importdata('mnist_bin38.mat');

train3 = mnist38.train3;
train8 = mnist38.train8;

test3 = mnist38.test3;
test8 = mnist38.test8;

train = [train3; train8];
train = im2double(train);
output = [ones(size(train3,1),1);0*ones(size(train8,1),1)];



m = size(train,1);

f = @(z) 1/(1+exp(-z)) ;

%initializing parameters

W1 = (-1/2+ rand(100,784))/10;
W2 = (-1/2 + rand(1,100))/10;
b1 = (-1/2 + rand(1,100))/10;
b2 = (-1/2 + rand)/10;

dW1 = zeros(100,784);
db1 = zeros(1,100);
dW2 = zeros(1,100);
dW2old = ones(1,100);
db2 = zeros(1,1);
db2old = ones(1,1);

errold = 100;
err = 0

%feed forward pass
num_t = 1;
nita = 1/(num_t)^(0.5);
while(abs(err-errold)>0.0001)%(dW2-dW2old)*(dW2-dW2old)'+(db2-db2old)^2 
p = randperm(size(train,1));
train = train(p,:);
output = output(p,:);


for i = 1:m
   a1 = train(i,:)';% 784*1
   z2 = W1*a1 + b1';%100*1
   %Cz2 = num2cell(z2);
   a2 = fapply(z2);%cellfun(f,Cz2);%100*1    %a2 = f(z2);
   z3 = W2*a2 + b2;%1*1
   disp(z3);
   %Cz3 = num2cell(z3);
   a3 = f(z3);%1*1  %a3 = f(z3);
   disp(a3);
   %calc d
   dout = -(output(i)-a3)*(a3)*(1-a3);%1*1 ; 100*1
   disp(dout);
   disp(i); 
   disp('sdasf');
   
   for j=1:100
      dhid(j) = dout* (W2(1,j))*a2(j,1)*(1-a2(j,1)); 
   end
   %dhid = dout*(W2').*( a2).*(1-a2);%dhid(j) = (W2(1,j)*dout)*( a2(j))*(1-a2(j))
   disp(dhid'*dhid);
   %disp(dout*W2'.*a2.*(1-a2));
   
   dW1 =  (dhid*a1');
   db1 =  (dhid');
   dW2old = dW2;
   dW2 = (dout*a2');%1*100
   db2old = db2;
   db2 = (dout');%1*1
   
   W1 = W1 - nita*((dW1)) ;
   b1 = b1 - nita*((db1)) ;
   W2 = W2 - nita*((dW2)) ;
   b2 = b2 - nita*((db2)) ;
   num_t = num_t +1;

   
end
   errold = err; 
   %err = err + 1/2*((output'-   f
   Cz2 = num2cell((W2*fapply(  (W1*train'+b1'*ones(1,m))')' + b2*ones(1,m) ));%((W2*fapply(  (W1*train'+b1'*ones(1,m))') + b2*ones(1,m) ))    ;
   yy = cellfun(f,Cz2');
   err = err + 1/2*(output - yy)'*((output - yy));
end



% 99.19 test acc. 73208 no. of iterations.