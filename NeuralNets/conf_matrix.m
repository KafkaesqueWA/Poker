function [C,err]=conf_matrix(actual_vals,predicted_vals,N)
% function [C,err]=conf_matrix(actual_vals,predicted_vals,N)
% Input:  Vector of actual classes and predicted classes (in that order).
%         Also: number of classes, N.  
%  ** It is assumed that the classes are 1, 2, 3, ..., N.
% Output:  Confusion matrix C and overall error rate in err.

p=length(actual_vals);  % This should be the total number of data.
C=zeros(N,N);

    for j=1:p
        C(predicted_vals(j), actual_vals(j) )=C(predicted_vals(j),actual_vals(j))+1;
    end

err=1 - sum(diag(C)/p);

