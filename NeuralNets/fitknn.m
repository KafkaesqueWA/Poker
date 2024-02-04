function PredictedClasses=fitknn(X,t,hatX,N)
% Use the data in X and t to perform k-NN classifier for data in hatX.
%  where N is the number of neighbors to use.
%
%  The data should be entered as dim x numpts
%  The classes are assumed to be 1: max(t)
%

[n,p]=size(X);
[n1,k]=size(hatX);
if n~=n1
    error('Dimension mismatch in fitknn.m');
end

PredictedClasses=zeros(1,k);
temp=max(t);
NumClasses=temp(1);

% We'll do the slow version with a loop through the new data:

for j=1:k
    
    hat_x=hatX(:,j);

    temp=X-hat_x;                  % Subtract hat_x from each column of X. 

    distances=sum( temp.*temp );   % Sum (down) the square of temp to get a row 
                                   %   of squared distances
    [vals,idx]=sort(distances);    % Sort the distances in ascending order

    
    classval=zeros(1,NumClasses);
    
% Find which class wins:
    
    for w=1:NumClasses
        classval(w)=length(find(t(idx(1:N))==w));  % Number of times each class appears
    end
    
    [win,winidx]=max(classval);
    PredictedClasses(j)=winidx;

end  % end of loop through data
        
end % end of function       