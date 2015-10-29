trainsmall = importdata('train-small.dat');
%trainbig = importdata('train-big.dat');
test = importdata('test.dat');

outputtrainsmall = importdata('train-output.dat');
%outputtrainbig = importdata('train-big-output.dat');
outputtest = importdata('test-output.dat');

alp = importdata('adata2.mat');

X = trainsmall;
Y = outputtrainsmall;

m = size(X,1);
n = size(X,2);

count = 0;
disp('Printing support vectors')
for i=1:m
   if(alp(i)>(1e-4))
       if(alp(i)<1)
           disp(i)
           count = count+1;
       end
       end
       
   end

disp('Support vectors printed')

%calculating w

w = zeros(n,1);
for i=1:m
    w = w + (alp(i)*Y(i)*X(i,:))';
end

%calculating b
min1 = 10000;
max1 = -10000;

for i=1:m
    qwe = X(i,:)*w;
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
        Zt(i) = -1;
    end
end
accuracy = 0;
for i = 1:numt
   if((Zt(i)==outputtest(i)))
        accuracy = accuracy + 1;
   end       
end

acc = accuracy / numt

