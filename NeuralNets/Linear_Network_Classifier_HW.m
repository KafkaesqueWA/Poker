BreastData;

[X,Params] = StandardScaler(X',9);

plot(X);

[Xtrain,Xtest,Ttrain,Ttest] = TrainTestSplit(X,T,0.3);

alpha = 0.03;

NumEpochs = 60;

[W,b,EpochErr]=WidHoff(Xtrain,Ttrain,alpha,NumEpochs);
Z=W*Xtest+b*ones(1,31);
figure(2)
plot(EpochErr);

[val1,idx1]=max(Ttest,[],1);  % Translate vectors into integer classes
[val2,idx2]=max(Z,[],1);  % Same thing

[C,err1]=conf_matrix(idx1,idx2,6)

hatX = [Xtrain;ones(1,75)];
[U,S,V] = svd(hatX,'econ');
P = V*diag(1./diag(S))*U';
hatW = Ttrain*P;

Z=hatW*[Xtest;ones(1,31)];

[val1,idx1]=max(Ttest,[],1);  % Translate vectors into integer classes
[val2,idx2]=max(Z,[],1);  % Same thing

[C,err1]=conf_matrix(idx1,idx2,6)