%This file is a simple example which used some made-up data set. 
%It's only 2 dimensions, and the reason why I have choosen this is so that
%I can provide plots of the data to show what the PCA analysis is doing at
%each step
%written by: Qiong^.^ 
%date: 2012-12-13

%data_x=[2.5,0.5,2.2,1.9,3.1,2.3,2,1,1.5,1.1];
%data_y=[2.4,0.7,2.9,2.2,3.0,2.7,1.6,1.1,1.6,0.9];see them in myfile

clc;clear;
%Step 1: get my data
load ('myfile.txt') %myfile
XMean=mean(myfile); %the mean
XStd=std(myfile);% the standard deviation

%X='myfile.txt';
%fidin=fopen(x);
%data=fscanf(fidin,'%f');
X = dlmread('myfile.txt');
[n m]=size(X); 
plot(X(:,1),X(:,2),'b+');%a plot of PCA example data
xlim([-1 4]);
ylim([-1 4]);
title('Original PCA data');

%Step 2: subtract the mean
DataAdjust=X-repmat(XMean,[n,1]);
X_adjust=(X-repmat(XMean,[n,1]))./repmat(XStd,[n,1]);
%or X_adjust=zscore(X);

%Step 3: calculate the covariance--cov(X)
%Step 4: calculate the eigenvectors and eigenvalues of the covariance
%matrix
[V D]=eig(cov(X));%V contains the coefficients for the principal components
%diag(D) is the variance of the respective principal components
eigenvalues=diag(D);
%The coefficients and respective variances of the principal components 
%could also be found using the princomp function from the Statistics Toolbox:
%[A B C]=princomp(X_adjust);

figure; % a plot fo the normalised data with the eigenvectors
x=-2:0.1:2;
plot(X_adjust(:,1),X_adjust(:,2),'b+');hold on;
plot(x,V(1,1)/V(2,1)*x,'k--');hold on;
plot(x,V(1,2)/V(2,2)*x,'k--');
xlim([-2 2]);
ylim([-2 2]);
title('Mean adjust data with eigenvectors overlayed');
text(0.45,1.75,'eigenvectors*x ----','FontSize',14);

%Step 5: Deriving the new data set---
%FinalData=RowFeatureVector*RowDataAdjust

FinalData=V(:,2)'*X_adjust';
FinalData1=V(:,1)'*X_adjust';

TransformData=V(:,2)'*DataAdjust';
TransformData1=V(:,1)'*DataAdjust';
figure;
x=-2:0.1:2;
plot(TransformData,TransformData1,'b+');hold on;
plot(x,0,'k--');
xlim([-2 2]);
ylim([-2 2]);

cumsum(flipud(diag(D)))/sum(diag(D));
PC=X_adjust*V;%princcipal component
VReduced=V(:,2);%dropping the columns that representing the unwanted principal componets
PVReduced=X_adjust*VReduced;

%getting the old data back--decompression
x_DataAdjust=PVReduced*VReduced';%we can have the "un-standard"adjust matrix
OldData=((PVReduced*VReduced').*repmat(XStd,[n 1]))+repmat(XMean,[n 1]);

figure;
x=-4:0.1:4;
plot(OldData(:,1),OldData(:,2),'b+');hold on;
xlim([-1 4]);
ylim([-1 4]);