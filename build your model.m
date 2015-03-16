%In this program PCA algorithm is used in order to perform face recognition. %
%Steps used will be clearly explained in as the program proceeds.%
%This particular matlab file is used to create a model from the dataset.%
%It will return the model, eigenfaces and mean.%

function [model,avg,eigenfaces] = build_model ()

% STEP1: for each image, load the images and convert the image into a column
% vector using a function called reshape. Each image will then be stacked
% beside each other such that if there are 42 images in total then there
% will be 42 column vectors placed next to each other to form a matrix
% face_vec

face_vec=[];
for s = 1:7 %for every training folder
    for i = 1:6 %for every image in the training folder
        fn = sprintf ( 'train/subject%d/%d.gif', s, i );%fetching image path
        f = imread ( fn );  %reading image      
        [row, col]= size(f);%to check thhe size of each image
        face_size=row*col;%the face_vec matrix will be face_size*42 in dimension
                          %using reshape function to convert image matrix to column vector
        face_vec_temp = reshape(f, face_size, 1);
       %face_vec_temp=face_size(:);
       vector_number=(s-1)*6+i;
        face_vec(:, vector_number)=[face_vec_temp];%concatenate the column vector to the matrix
     
    end
     
end

%size(face_vec)

%STEP 2: calculating average face vector i.e. mean of face_vec. This process is
%done to normalize the face vector
avg= mean(face_vec,2);

%Calculate total number of column vectors formed
total_img= size(face_vec,2);

%STEP: 3, The above formed vector basically has all the characteristics in each vector.
%we shall extract the characteristic of individual vector by subtracting
%the common features from all. 
individual_char=[];
for i=1:total_img
    avg_face_vec=face_vec(:,i);%calculate total sum of pixels in each column.
    avg_face=double(avg_face_vec);%converting it to type scalar.
    temp= avg_face-avg;%subtracting it from mean. This helps to recognize the particular 
                     %feature of an image that is not common to other
                     %images.helps to extract individual characteristics of
                     %an image.
    individual_char(:,i)=[temp];
end

%STEP 4: Once the indvidual features are prominent on each vector, next
%step is to calculate the eigen vaues. function eig() is used.

[V,D]= eig(individual_char'*individual_char);
v_length=size(V,2);

%Step 5: Extracting PCA characteristics. 
eig_vector=[];
for i=1:v_length
    if(D(i,i)>1)%only those which have their distance more than one are selected.
                %others are discarded.Since their existence might not give us clear characteristics
        eig_vector=[eig_vector V(:,i)];
    end
end

%STEP 6: size of eig_vector is always less than or equal to total face_vec formed.

eigenfaces= individual_char*eig_vector;
eigenfaces_len=size(eigenfaces,2);

%STEP 7: Create the final model that can be used while recognising unknown
%images.

model=[];
for i=1:eigenfaces_len
    transpose_eig=eigenfaces';%To align the matrix dimensions.
    temp= transpose_eig * individual_char(:,i);%This gives a linear combination of individual vectors.
    model(:,i)=[temp];
end
            
        
