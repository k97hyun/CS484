I1=im2double(imread('einstein.bmp'));
I2=im2double(imread('marilyn.bmp'));

low_pass = imfilter(I2,fspecial('gaussian',25,6));
high_pass = I1 - imfilter(I1,fspecial('gaussian',25,6));
% high_pass1 = I1 - imfilter(I1,fspecial('gaussian',15,5));
% high_pass2 = I1 - imfilter(I1,fspecial('gaussian',15,15));

mul = imfuse(low_pass,high_pass,'blend','Scaling','joint');

% mul = im2double(imread('myMultipageFile.tif'));
figure(1); imshow(mul);
figure(2); imshow(low_pass);
figure(3); imshow(high_pass);
imwrite(mul, 'einstein&marilyn.jpg', 'quality', 95);
% figure(4); imshow(high_pass1);
% figure(5); imshow(high_pass2);

