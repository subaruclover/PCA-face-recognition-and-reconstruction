function T = CreateDatabase(TrainDatabasePath)
% Align a set of face images (the training set T1, T2, ... , TM )
%
% Description: This function reshapes all 2D images of the training database
% into 1D column vectors. Then, it puts these 1D column vectors in a row to 
% construct 2D matrix 'T'.
%  
% Argument:     TrainDatabasePath      - Path of the training database
%
% Returns:      T                      - A 2D matrix, containing all 1D image vectors.
%                                        Suppose all P images in the training database 
%                                        have the same size of MxN. So the length of 1D 
%                                        column vectors is MN and 'T' will be a MNxP 2D matrix.
%
% See also: STRCMP, STRCAT, RESHAPE                  

% File management
TrainFiles = dir(TrainDatabasePath);
Train_Number = 0;

for i = 1:size(TrainFiles,1)
    if not(strcmp(TrainFiles(i).name,'.')|strcmp(TrainFiles(i).name,'..')|strcmp(TrainFiles(i).name,'Thumbs.db'))%compare trainfiles name
        Train_Number = Train_Number + 1; % Number of all images in the training database
    end
end
% Construction of 2D matrix from 1D image vectors
T = [];
for i = 1 : Train_Number
    str = int2str(i);   % Convert integer to string
    str = strcat('\',str,'.jpg');    % concatenate strings, link them together
    str = strcat(TrainDatabasePath,str);
    
    img = imread(str);
    img = rgb2gray(img); %Convert RGB image or colormap to grayscale.
    
    [irow icolumn] = size(img);
   
    temp = reshape(img',irow*icolumn,1);   % Reshaping 2D images into 1D image vectors
    T = [T temp]; % 'T' grows after each turn                    
end