trainsmall = importdata('train-small.dat');
%trainbig = importdata('train-big.dat');
test = importdata('test.dat');

outputtrainsmall = importdata('train-output.dat');
%outputtrainbig = importdata('train-big-output.dat');
outputtest = importdata('test-output.dat');

X = trainsmall;
Y = outputtrainsmall;

m = size(X,1);
n = size(X,2);

Q = ones(m,m);
for i = 1:m
    for j = 1:m
        Q(i,j) = -1/2*Y(i)*Y(j)*X(i,:)*(X(j,:)');
    end
    end
b = ones(m,1);
c = 0

cvx_begin
variable a(m);
    
maximize ( (a'*Q*a)+(b'*a)+ c);
subject to
0<=a;
a<=1;
a'*Y == 0;
        

cvx_end

%calculating w

w = zeros(n,1);
for i=1:m
    w = w + (a(i)*Y(i)*X(i,:))';
end

%calculating b
min1 = 10000;
max1 = -10000;

for i=1:m
    qwe = X(i,:)*w
    if(Y(i)==1)        
        if(qwe <min1)
            min1 = qwe;
        end
    else
        if(qwe >max1)
            max1 = qwe;
        end

    end
end

b = -1/2*(min1 + max1);

numt = size(test,1);
Zt = zeros (numt,1);
for i = 1:numt
    comp = test(i,:)*w + b;
    if(comp>0)
        Zt(i) = 1;
    else
        Zt(i) = -1
    end
end
accuracy = 0;
for i = 1:numt
   if((Zt(i)==outputtest(i)))
        accuracy = accuracy + 1;
   end       
end

acc = accuracy / numt

