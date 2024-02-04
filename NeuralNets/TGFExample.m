%% Script file:  Online Training (Hebbian Learning)
% Example 1:  T, G and F.

%% Load the Data and Graph the Results.
T1=[1 1 1 -1;-1 1 -1 -1;-1 1 -1 -1;-1 1 -1 -1];
T2=[-1 1 1 1;-1 -1 1 -1;-1 -1 1 -1;-1 -1 1 -1];
G1=[1 1 1 -1;1 -1 -1 -1; 1 1 1 -1 ; 1 1 1 -1];
G2=[-1 1 1 1;-1 1 -1 -1; -1 1 1 1; -1 1 1 1];
F1=[1 1 1 -1;1 1 -1 -1;1 -1 -1 -1;1 -1 -1 -1];
F2=[-1 1 1 1;-1 1 1 -1;-1 1 -1 -1;-1 1 -1 -1];

gg=colormap(gray); gg=gg(end:-1:1,:);  %I'm reversing the usual grayscale values

X=[T1(:) T2(:) G1(:) G2(:) F1(:) F2(:)]; %X is 16 x 6
T=[1 1 0 0 0 0;0 0 1 1 0 0;0 0 0 0 1 1];

figure(1)
for j=1:6
    subplot(2,3,j);
    imagesc(reshape(X(:,j),4,4));
    colormap(gg);
end


% Now that the data is ready, set things up and train:
%% Main code start
alpha=0.03;

NumPoints=6;
NumEpochs=60;

[W,b,EpochErr]=WidHoff(X,T,alpha,NumEpochs);

%% Output results
Z=W*X+b*ones(1,NumPoints);
figure(2)
plot(EpochErr);

[val1,idx1]=max(T,[],1);  % Translate vectors into integer classes
[val2,idx2]=max(Z,[],1);  % Same thing

[C,err1]=conf_matrix(idx1,idx2,3)


