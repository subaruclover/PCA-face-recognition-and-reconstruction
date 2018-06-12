% A sample script, which shows the usage of functions, included in
% PCA-based face recognition system (Eigenface method)
%
% using functions CREATEDATABASE, EIGENFACECORE, RECOGNITION

clear all
clc
close all

% the initial directory paths
% Standard open directory dialog box - uigetdir
TrainDatabasePath = uigetdir('C:\Users\qionghuang\matlab\work', 'Select training database path' );
TestDatabasePath = uigetdir('C:\Users\qionghuang\matlab\work', 'Select test database path');

prompt = {'Enter test image name (a number between 1 to 10):'};
dlg_title = 'Input of PCA-Based Face Recognition System';
num_lines= 1;
def = {'1'};

TestImage  = inputdlg(prompt,dlg_title,num_lines,def);
TestImage = strcat(TestDatabasePath,'\',char(TestImage),'.jpg');
im = imread(TestImage);

T = CreateDatabase(TrainDatabasePath);
[m, A, Eigenfaces] = EigenfaceCore(T);
OutputName = Recognition(TestImage, m, A, Eigenfaces);

SelectedImage = strcat(TrainDatabasePath,'\',OutputName);
SelectedImage = imread(SelectedImage);

%for the text in the report, plot the 2 images together
figure;
subplot(1,2,1), subimage(im); axis off;
title('The test image'); hold on;
subplot(1,2,2), subimage(SelectedImage); axis off;
title('The equivalent image');

str = strcat('The matched image is :  ',OutputName)
