% eigface.m
function [] = eigface()
% calc xmean,sigma and its eigen decomposition 
allsamples=[];
for i=1:40
   for j=1:5
       a=imread(strcat('C:\Users\qionghuang\matlab\work\ORL\ORL\s',num2str(i),'\',num2str(j),'.pgm'));
       b=a(1:112*92); 
       b=double(b);
       allsamples=[allsamples; b]; 
   end
end
samplemean=mean(allsamples); % average figure,1 × N
for i=1:200 
    xmean(i,:)=allsamples(i,:)-samplemean;
end;

% eigenvalue and eigenvector
sigma=xmean*xmean'; % M * M 
[v d]=eig(sigma);
d1=diag(d);

% eigenvalue from max to min
dsort = flipud(d1); 
vsort = fliplr(v);

% select the first 90%
dsum = sum(dsort);
dsum_extract = 0;
p = 0;
while( dsum_extract/dsum < 0.9)
   p = p + 1;
   dsum_extract = sum(dsort(1:p)); 
end
p = 199;

%normalize
base = xmean' * vsort(:,1:p) * diag(dsort(1:p).^(-1/2));

% eigenface 
for (k=1:p),
     temp = reshape(base(:,k), 112,92); 
     newpath = ['C:\Users\qionghuang\matlab\work\ORL\ORL\test\' int2str(k) '.pgm']; 
     imwrite(mat2gray(temp), newpath);
end

avg = reshape(samplemean, 112,92); 
imwrite(mat2gray(avg), 'C:\Users\qionghuang\matlab\work\ORL\ORL\test\average.pgm');

% save
save('C:\Users\qionghuang\matlab\work\ORL\ORL\test\model.mat', 'base', 'samplemean');

cd C:\Users\qionghuang\matlab\work\ORL\ORL\test

I1=imread('1.pgm');
I2=imread('2.pgm');
I3=imread('10.pgm');
I4=imread('50.pgm');
I5=imread('100.pgm');
I6=imread('average.pgm');

figure;
subplot(1,6,1), subimage(I1); axis off;
title('1'); hold on;
subplot(1,6,2), subimage(I2); axis off;
title('2');hold on;
subplot(1,6,3), subimage(I3); axis off;
title('10');hold on;
subplot(1,6,4), subimage(I4); axis off;
title('50');hold on;
subplot(1,6,5), subimage(I5); axis off;
title('100');hold on;
subplot(1,6,6), subimage(I6); axis off;
title('average');hold on;
