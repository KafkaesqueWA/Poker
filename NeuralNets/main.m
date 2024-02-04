function net=main()
%  Putting this in terms of a function so we can have the subroutines under
%  the function.  This is an attempt at an neural net in a single file.
%  The net is defined by the following, which are indexed 1,2:
%   P, S, dS, Delta, W, b

%% Data:
load diabetes1.mat
[Xs,Params]=StandardScaler(P,8);
[Xtrain,Xtest,Ttrain,Ttest]=TrainTestSplit(Xs',T',0.3);


%% Define parameters:

alpha=0.001;   %Learning parameter for Stochastic Gradient Descent
NumEpochs=1000;  %Number of Epochs
[xdim,Numpts]=size(Xtrain);
[tdim,~]=size(Ttrain);

NetNodes=[xdim, 15, tdim];

%% Define/Initialize Structures of the network
P1=zeros(NetNodes(2),1);  S1=zeros(NetNodes(2),1);  dS1=zeros(NetNodes(2),1); Delta1=zeros(NetNodes(2),1);
P2=zeros(NetNodes(2),1);  S2=zeros(NetNodes(2),1);  dS2=zeros(NetNodes(2),1); Delta2=zeros(NetNodes(2),1);
P3=zeros(NetNodes(3),1);  S3=zeros(NetNodes(3),1);  dS3=zeros(NetNodes(3),1); Delta3=zeros(NetNodes(3),1);
W1=randn(NetNodes(2),NetNodes(1)); b1=randn(NetNodes(2),1);
W2=randn(NetNodes(2),NetNodes(2)); b2=randn(NetNodes(2),1);
W3=randn(NetNodes(3),NetNodes(2)); b3=randn(NetNodes(3),1);

err=zeros(1,NumEpochs);

% Main Training Loop - 
for j=1:NumEpochs
    err(j)=0;
    for k=1:Numpts
        % Forward Pass:
        P1=W1*Xtrain(:,k)+b1;  S1=activate(P1); dS1=dactivate(P1);
        P2=W2*S1+b2;    S2=activate(P2); dS2=dactivate(P2);
        P3=W3*S2+b3;    S3=P3;   dS3=ones(size(P3));
        
        % Backwards Pass:
        Delta3=Ttrain(:,k)-S3;  Delta2=(W3)'*Delta3.*dS2; Delta1=(W2)'*Delta2.*dS1;
        
        % Update Weights and Biases
        dW1=Delta1*Xtrain(:,k)'; db1=Delta1;
        dW2=Delta2*(S1)';  db2=Delta2;
        dW3=Delta3*(S2)';  db3=Delta3;
        
        W1=W1+alpha*dW1; b1=b1+alpha*db1;
        W2=W2+alpha*dW2; b2=b2+alpha*db2;
        W3=W3+alpha*dW3; b3=b3+alpha*db3;
        
        err(j)=err(j)+norm(Ttrain(:,k)-S3);
    end
end

% Although we shouldn't really do this, sometimes its good to know that you
% have a small error on your training set to be sure your algorithm is
% correct.

Ztrain=W3*activate(W2*(activate(W1*Xtrain + b1))+b2)+b3;
[~,t1]=max(Ztrain,[],1);
[~,t2]=max(Ttrain,[],1);
[Ct,et]=conf_matrix(t1,t2,2)



% Now compute our "real" estimate of the error:

Zout=W3*activate(W2*(activate(W1*Xtest + b1))+b2)+b3;
[~,t1]=max(Zout,[],1);
[~,t2]=max(Ttest,[],1);
[C,ee]=conf_matrix(t1,t2,2)



% This section is here if you want to save or look at the data:
net.W1=W1; net.W2=W2; net.b1=b1; net.b2=b2;
net.Xtrain=Xtrain; net.Xtest=Xtest; net.Ttrain=Ttrain; net.Ttest=Ttest;
net.err=err;
net.ScalingParams=Params;

end

function g = relu(z)

g = max(0,z);

end

function g = relugradient(z)

g= (z>=0);

end

function y=activate(x)
% Default for now is sigmoidal (Matlab's logsig, but we'll compute it)
    %y=1./(1+exp(-x));
    y = relu(x);
end

function dy=dactivate(x)
    %y=activate(x);
    %dy=y.*(1-y);
    dy = relugradient(x);
end

function [C,err]=conf_matrix(actual_vals,predicted_vals,N)
% function [C,err]=conf_matrix(actual_vals,predicted_vals,N)
% Input:  Vector of actual classes and predicted classes (in that order).
%         Also: number of classes, N.  
%  ** It is assumed that the classes are 1, 2, 3, ..., N.
% Output:  Confusion matrix C and overall error rate in err.

p=length(actual_vals);  % This should be the total number of data.
C=zeros(N,N);

    for j=1:p
        C( predicted_vals(j), actual_vals(j) )=C(predicted_vals(j),actual_vals(j))+1;
    end

err=1 - sum(diag(C)/p);

end

function [X,Params]=StandardScaler(X,n)
% Function params=StandardScaler(X,n)
%  Input:  Data matrix X with dimension n (can be n x p or p x n).
%  Output:  Scaled matrix X
%           Params.m = mean used for scaling (n-dim vector)
%           Params.s = std used for scalaing (n-dim vector)

[mm,nn]=size(X);
if mm==n
    % Matrix is n x p
    m=mean(X,2); s=std(X,0,2);
    X=(X-m)./s;
elseif nn==n
    % Matrix is p x n 
    m=mean(X,1); s=std(X,0,1);
    X=(X-m)./s;
else
    error('Dimension mismatch in StandardScaler\n');
end
Params.m=m;
Params.s=s;

end


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


