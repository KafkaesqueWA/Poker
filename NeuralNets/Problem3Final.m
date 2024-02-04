clear
load mushrooms.mat;

T = T.+1;

NumFolds = 5;

[Xtrain,Xtest,Ttrain,Ttest] = TrainTestSplit(X,T,0.3);

Data=KfoldCV(Xtrain,Ttrain,NumFolds);
count=1;

for NumN=2:50
    for j=1:NumFolds
       Pred=fitknn(Data.Train{j},Data.TrainTarget{j},Data.Test{j},NumN);
       [C1,err1(j)]=conf_matrix(Data.TestTarget{j},Pred,2);
    end
    Overall(count)=mean(err1);
    count=count+1;
end
plot(Overall)

% Build the full model on the best number of neighbors:

Pred=fitknn(Xtrain,Ttrain,Xtest,9);
[C,err]=conf_matrix(Ttest,Pred,2)