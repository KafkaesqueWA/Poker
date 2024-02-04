%% Script file:  All-at-once training using the pseudoinverse

%% Load the Data and Graph the Results.
T1=[1 1 1 -1;-1 1 -1 -1;-1 1 -1 -1;-1 1 -1 -1];
T2=[-1 1 1 1;-1 -1 1 -1;-1 -1 1 -1;-1 -1 1 -1];
G1=[1 1 1 -1;1 -1 -1 -1; 1 1 1 -1 ; 1 1 1 -1];
G2=[-1 1 1 1;-1 1 -1 -1; -1 1 1 1; -1 1 1 1];
F1=[1 1 1 -1;1 1 -1 -1;1 -1 -1 -1;1 -1 -1 -1];
F2=[-1 1 1 1;-1 1 1 -1;-1 1 -1 -1;-1 1 -1 -1];

X=[T1(:) T2(:) G1(:) G2(:) F1(:) F2(:)]; %X is 16 x 6
T=[1 1 0 0 0 0;0 0 1 1 0 0;0 0 0 0 1 1];
T
size(X)
size(T)
hatX=[X;ones(1,6)];
size(hatX)
[U,S,V]=svd(hatX,'econ');  % Looks like its 6 dimensions.
P=V*diag(1./diag(S))*U';
size(P)
hatW=T*P;
size(hatW)

%% Output results
Z=hatW*hatX;

[val1,idx1]=max(T,[],1);  % Translate vectors into integer classes
[val2,idx2]=max(Z,[],1);  % Same thing

[C,err1]=conf_matrix(idx1,idx2,3)


