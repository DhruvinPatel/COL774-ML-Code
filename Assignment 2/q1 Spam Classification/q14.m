X = importdata('train-small.dat');
Y = importdata('train-output.dat');
X_test = importdata('test.dat');
Y_test = importdata('test-output.dat');

model1 = svmtrain(Y,X,'-t 0 -c 1');
[predicted_label1,accuracy1,prob_estimates1] = svmpredict(Y_test,X_test,model1);

model2 = svmtrain(Y,X,'-t 2 -g 0.00025 -c 1');
[predicted_label2,accuracy2,prob_estimates2] = svmpredict(Y_test,X_test,model2);