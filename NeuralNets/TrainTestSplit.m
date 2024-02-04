function [Xtrain,Xtest,Ttrain,Ttest]=TrainTestSplit(X,T,p)
% input: Data in X, T, and percentage of test, like 0.3
%        We assume that the data is arranged as dim x numpts
[~,c1]=size(X);
[~,c2]=size(T);
if c1~=c2
    error('Dimension mismatch in TrainTest\n');
end

NumTest=floor(p*c1);
NumTrain=c1-NumTest;

idx=randperm(c1);
tridx=idx(1:NumTrain);
teidx=idx(NumTrain+1:end);

Xtrain=X(:,tridx);
Xtest=X(:,teidx);
Ttrain=T(:,tridx);
Ttest=T(:,teidx);

end

