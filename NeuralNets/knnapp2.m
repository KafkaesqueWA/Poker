% Same as knnapp1, except 5-fold CV for num neighbors.

NumFolds=5;

load irisdata;   %Loads data in matrix X, targets

[Xtrain,Xtest,Ttrain,Ttest]=TrainTestSplit(X,targets,0.3);

Data=KfoldCV(Xtrain,Ttrain,NumFolds);
count=1

for NumN=2:30
    for j=1:NumFolds
       Pred=fitknn(Data.Train{j},Data.TrainTarget{j},Data.Test{j},NumN);
       [C1,err1(j)]=conf_matrix(Data.TestTarget{j},Pred,3);
    end
    Overall(count)=mean(err1);
    count=count+1;
end

% Build the full model on the best number of neighbors (5):
Pred=fitknn(Xtrain,Ttrain,Xtest,5);
[C,err]=conf_matrix(Ttest,Pred,3)
