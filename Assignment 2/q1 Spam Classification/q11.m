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

gamma = 2.5*10^-4;
Q = -1*ones(m,m);
for i = 1:m
    for j = 1:m
        Q(i,j) = -1/2*Y(i)*Y(j)* (exp (-gamma* (X(i,:)-(X(j,:)))* (X(i,:)-(X(j,:)))' ) )     ;
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

%save 'a_data_guassian' a