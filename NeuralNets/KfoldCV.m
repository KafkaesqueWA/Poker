function Data=KfoldCV(X,t,N)
% Split the data into N folds for cross validation.
%  INPUT:  X: Data to separate (dim x numpts)
%          t: Targets to separate (dim x numpts)
%          N:  How many folds
%  OUTPUT:  A data structure containing the training and test sets that are
%         indexed from 1 to N:
%
%  Data.NumTestSets=N
%  for j=1:N
%     Data.Train{j}   % Is the j^th training set (dim x numpts)
%     Data.TrainTarget{j}  %Targets for these data points
%
%     Data.Test{j}    % is the j^th test set
%     Data.TestTarget{j} % Targets for the test set.
%
%   end


% Dimension check:
[~,p1]=size(X); [~,p2]=size(t);
if p1~=p2
    error('Dimension mismatch in KfoldCV.  Input is dim x numpts');
end

p=p1; clear p1 p2
idx=randperm(p);  % idx has integers from 1 to p in random order.

% Number of points per group:
g=floor(p/N);
R=mod(p,N);
Numpts=g*ones(N,1);
for j=1:R
    Numpts(j)=Numpts(j)+1;
end

%Now split the data into N groups.
PointIdx=[0 cumsum(Numpts)']; %length is N+1
for j=1:N
    Group{j}=X(:,idx(PointIdx(j)+1:PointIdx(j+1)));
    Target{j}=t(idx(PointIdx(j)+1:PointIdx(j+1)));
end

Data.NumTestSets=N;

for j=1:N
    Data.Train{j}=[];
    Data.TrainTarget{j}=[];
    for k=1:N
        if j==k
            Data.Test{j}=Group{k};
            Data.TestTarget{j}=Target{k};
        else
            Data.Train{j}=[Data.Train{j}, Group{k}];
            Data.TrainTarget{j}=[Data.TrainTarget{j}, Target{k}];
        end
    end
end

end %End of function


  
  
  
  
  
  
  
  
  
