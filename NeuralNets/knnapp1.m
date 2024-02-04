
load irisdata;   %Loads data in matrix X, targets

[Xtrain,Xtest,Ttrain,Ttest]=TrainTestSplit(X,targets,0.3);

for NumN=2:30

Pred1=fitknn(Xtrain,Ttrain,Xtest,NumN);
[C1,err1(NumN)]=conf_matrix(Ttest,Pred1,3);

end