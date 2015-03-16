function [id] = who_am_i ( model, test_im , avg , eigenfaces )
%converting the unknown image to column vector
[row,col]=size(test_im);
total_size=row*col;
temp=reshape(test_im,total_size,1);%unknown image to column vector.
temp=double(temp)-avg;%extracting individual characteristiics by subtracting mean value.

model_test=eigenfaces'*temp;%same method followed in the model is used.
%model_test

%Important step: to find distance from unknown image to each eigenfaces. This is called euclidian distance.%
euclide_test=[];
for i=1:size(eigenfaces,2)
    model_test1=model_test-model(:,i);
    model_test2=norm(model_test1);%calculating the normal.
    model_test3=model_test2^2;
    euclide_test=[euclide_test model_test3];%maintain it in the array
end

[~, id]=min(euclide_test);%The lowest distance is selected. 
id=ceil(id/6);%since there are 6 images each. the id is plotted in the corresponding sample.


