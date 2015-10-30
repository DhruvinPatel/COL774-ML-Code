mnist = importdata('mnist_all.mat');
train3 = mnist.train3;
train8 = mnist.train8;

test3 = mnist.test3;
test8 = mnist.test8;

save 'mnist_bin38' train3 train8 test3 test8;

Aim = vec2mat(test3(3,:),28);
image(Aim);
axis off;
colormap gray;
%trainbig = importdata('train-big.dat');

