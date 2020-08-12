% I1 = im2single(imread('../questions/RISHLibrary1.jpg'));
% I2 = im2single(imread('../questions/RISHLibrary2.jpg'));
% I1r = I1(:,:,1);
% I1g = I1(:,:,2);
% I1b = I1(:,:,3);

% I1 = im2single(imread('../questions/Chase1.jpg'));
% I2 = im2single(imread('../questions/Chase2.jpg'));
I1 = im2single(imread('../questions/LaddObservatory1.jpg'));
I2 = im2single(imread('../questions/LaddObservatory2.jpg'));
% 
%imshow(I2);
% I = checkerboard(50,2,2);
f1=figure;
f2=figure;
figure(f1);
l1gray = rgb2gray(I1);
C1 = corner(l1gray);
imshow(l1gray)
hold on
plot(C1(:,1),C1(:,2),'r.');

figure(f2);
l2gray = rgb2gray(I2);
C2 = corner(l2gray);
imshow(l2gray)
hold on
plot(C2(:,1),C2(:,2),'r.');