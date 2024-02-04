load diabetes;

NumFolds = 5;

[Xtrain,Xtest,Ttrain,Ttest] = TrainTestSplit(X',T',0.3);

Data=KfoldCV(Xtrain,Ttrain,NumFolds);
count=1;

for NumN=2:30
    for j=1:NumFolds
       Pred=fitknn(Data.Train{j},Data.TrainTarget{j},Data.Test{j},NumN);
       [C1,err1(j)]=conf_matrix(Data.TestTarget{j},Pred,2);
    end
    Overall(count)=mean(err1);
    count=count+1;
    hold on
    plot(Overall)
end

% Build the full model on the best number of neighbors (5):
Pred=fitknn(Xtrain,Ttrain,Xtest,10);
[C,err]=conf_matrix(Ttest,Pred,2)