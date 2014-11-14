function [P,zerorows,n]=loadlinks(filename)
% j holds row indices for P' (col. indices for P), i holds column indices for 
%      P' (row indices for P).  But, indexing starts at 0
%      rather than 1. So increment each element in both vectors.


fid=fopen(filename);
a = textscan(fid, '%s %s %s');
b = char(a{1,1});
edgInd = find(b=='e');
clear b;
i = a{1,2};
i = str2num(char(i(edgInd)));
j = a{1,3};
j = str2num(char(j(edgInd)));


i=i+1;
j=j+1;
nnzPt=length(j);
n=max(max(i),max(j));
a=ones(nnzPt,1);
Pt=sparse(j,i,a,n,n);
colsumvector=ones(1,n)*Pt;
nonzerocols=find(colsumvector);
zerocols=setdiff(1:n,nonzerocols);
colsumvector(zerocols)=1;

for i=1:n
    Pt(:,i)=Pt(:,i)/colsumvector(i);
end


clear Datamatrix i j a colsumvector nonzerocols;

P=Pt';
zerorows=zerocols;
clear Pt zerocols;