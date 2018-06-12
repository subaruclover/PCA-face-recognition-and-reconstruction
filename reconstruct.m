%reconstruct.m
function []=reconstruct()

load C:\Users\qionghuang\matlab\work\ORL\ORL\test\model.mat;

%read a face eihter in training space or not
img= 'C:\Users\qionghuang\matlab\work\ORL\ORL\s1\1.pgm'
a=imread(img);

b=a(1:112*92);
b=double(b);
b=b-samplemean;

c=b*base;

% reconstruct the face
% the first 15 faces
t = 15;
temp = base(:,1:t) * c(1:t)';
temp = temp + samplemean'; 
imwrite(mat2gray(reshape(temp, 112,92)),'C:\Users\qionghuang\matlab\work\ORL\ORL\test\t1.pgm');
t1=imread('C:\Users\qionghuang\matlab\work\ORL\ORL\test\t1.pgm');

% 50 
t = 50;
temp = base(:,1:t) * c(1:t)';
temp = temp + samplemean'; 
imwrite(mat2gray(reshape(temp, 112,92)),'C:\Users\qionghuang\matlab\work\ORL\ORL\test\t2.pgm');
t2=imread('C:\Users\qionghuang\matlab\work\ORL\ORL\test\t2.pgm');
% 100 
t = 100;
temp = base(:,1:t) * c(1:t)';
temp = temp + samplemean'; 
imwrite(mat2gray(reshape(temp, 112,92)),'C:\Users\qionghuang\matlab\work\ORL\ORL\test\t3.pgm');
t3=imread('C:\Users\qionghuang\matlab\work\ORL\ORL\test\t3.pgm');

% 150 
t = 150;
temp = base(:,1:t) * c(1:t)';
temp = temp + samplemean'; 
imwrite(mat2gray(reshape(temp, 112,92)),'C:\Users\qionghuang\matlab\work\ORL\ORL\test\t4.pgm');
t4=imread('C:\Users\qionghuang\matlab\work\ORL\ORL\test\t4.pgm');

% 199 
t = 199;
temp = base(:,1:t) * c(1:t)';
temp = temp + samplemean'; 
imwrite(mat2gray(reshape(temp, 112,92)),'C:\Users\qionghuang\matlab\work\ORL\ORL\test\t5.pgm');
t5=imread('C:\Users\qionghuang\matlab\work\ORL\ORL\test\t5.pgm');

figure
subplot(1,6,1), subimage(a); axis off;
title('The original image'); hold on;
subplot(1,6,2), subimage(t1); axis off;
title('15');hold on;
subplot(1,6,3), subimage(t2); axis off;
title('50');hold on;
subplot(1,6,4), subimage(t3); axis off;
title('100');hold on;
subplot(1,6,5), subimage(t4); axis off;
title('150');hold on;
subplot(1,6,6), subimage(t5); axis off;
title('199');hold on;

