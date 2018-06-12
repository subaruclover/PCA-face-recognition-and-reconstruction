clc
clear all
close all

%Recognition.m
allsamples=[];            % the array allsamples is used to restore all pictures
for i=1:40
    for j=1:7           %choose 7 faces for training
        a=imread(strcat('C:\Users\qionghuang\matlab\work\ORL\ORL\s',num2str(i),'\',num2str(j),'.pgm')); 
        b=a(1:112*92);                        
        b=double(b);
        allsamples=[allsamples;b];
    end
end
samplemean=mean(allsamples); %average the pictures
for i=1:280
    xmean(i,:)=allsamples(i,:)-samplemean;
end
sigma=xmean*xmean'; %obtain the M*M array
[v d]=eig(sigma);%vproduces a diagonal matrix D of eigenvalues and a
                 % full matrix V whose columns are the corresponding eigenvectors so
                 %that X*V = V*D.
d1=diag(d);         %obtain the diagonal of the sigma
dsort=flipud(d1);
vsort=fliplr(v);

dsum=sum(dsort);
dsum_extract=0;
p=0;
while(dsum_extract/dsum<0.90) 
    p=p+1;
    dsum_extract=sum(dsort(1:p));
end

%normalize
base = xmean' * vsort(:,1:p) * diag(dsort(1:p).^(-1/2));
allcoor=allsamples*base;
accu = 0;  

for i=1:40
     for j=8:10                            
     a=imread(strcat('C:\Users\qionghuang\matlab\work\ORL\ORL\s',num2str(i),'\',num2str(j),'.pgm'));
     b=a(1:10304);
     b=double(b);
     tcoor=b*base;                  

     for k=1:280
      mdist(k)=norm(tcoor-allcoor(k,:));
     end;
     % 3 calsses
 [dist,index2]=sort(mdist);
        class1=floor((index2(1)-1)/7)+1;
        class2=floor((index2(2)-1)/7)+1;
        class3=floor((index2(3)-1)/7)+1;
        if class1~=class2 && class2~=class3
            class=class1;
        elseif class1==class2
            class=class1;
        elseif class2==class3
            class=class2;
        end;
        if class==i
            accu=accu+1;
        end;
    end;
end;

accuracy=accu/120    %accuracy of the recognition


       




