function [X,Params]=StandardScaler(X,n)
% Function params=StandardScaler(X,n)
%  Input:  Data matrix X with dimension n (can be n x p or p x n).
%  Output:  Scaled matrix X
%           Params.m = mean used for scaling (n-dim vector)
%           Params.s = std used for scalaing (n-dim vector)

[mm,nn]=size(X);
if mm==n
    % Matrix is n x p
    m=mean(X,2);
    s=std(X,0,2);
    if sum(s==0)>0
        error('Standard deviation has at least one zero')
    end
    X=(X-m)./s;
elseif nn==n
    % Matrix is p x n 
    m=mean(X,1); 
    s=std(X,0,1);
    if sum(s==0)>0
        error('Standard deviation has at least one zero')
    end
    X=(X-m)./s;
else
    error('Dimension mismatch in StandardScaler');
end
Params.m=m;
Params.s=s;
