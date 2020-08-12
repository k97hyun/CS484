function output = my_imfilter(image, filter)
% This function is intended to behave like the built in function imfilter()
% when operating in convolution mode. See 'help imfilter'. 
% While "correlation" and "convolution" are both called filtering, 
% there is a difference. From 'help filter2':
%    2-D correlation is related to 2-D convolution by a 180 degree rotation
%    of the filter matrix.

% Your function should meet the requirements laid out on the project webpage.

% Boundary handling can be tricky as the filter can't be centered on pixels
% at the image boundary without parts of the filter being out of bounds. If
% we look at 'help imfilter', we see that there are several options to deal 
% with boundaries. 
% Please recreate the default behavior of imfilter:
% to pad the input image with zeros, and return a filtered image which matches 
% the input image resolution. 
% A better approach is to mirror or reflect the image content in the padding.

% Uncomment to call imfilter to see the desired behavior.
% output = imfilter(image, filter, 'conv');

%%%%%%%%%%%%%%%%
% Your code here
% 
% image = imread('RISDance.jpg');
% filter = fspecial('Gaussian', [25 1], 10);
% filter = [1,0,0,0,-1;2,0,0,0,-2;3,0,0,0,-3;2,0,0,0,-2;1,0,0,0,-1];


double_image = im2double(image);

% disp(double_image);

[im,in,ik] = size(double_image);
[fm,fn] = size(filter);
% 
% fprintf("%d, %d, %d\n",im,in,ik);
% fprintf("%d, %d, %d\n",fm,fn);

% error catch.
if rem(fm,2)~=1
    msg = 'filter size error1.';
    error(msg);
elseif rem(fn,2)~=1
    msg = 'fliter size error2.';
    error(msg);
end

%boundaries make zero.
cal_image = double_image;
lrzero = zeros(im,fix(fn/2),3);
cal_image = [lrzero cal_image lrzero];
udzero = zeros(fix(fm/2),in+fn-1,3);
cal_image = [udzero;cal_image;udzero];

% figure(1); imshow(cal_image);
startm = fix(fm/2)+1;
endm = startm+im-1;
startn = fix(fn/2)+1;
endn = startn+in-1;
h = zeros(im,in,ik);
for i = startm:endm
    for j = startn:endn
        sum = zeros(1,ik);
        for a = 1:ik    
            temp = sum(a);
            for k = -fix(fm/2):fix(fm/2)
                for l = -fix(fn/2):fix(fn/2)
                    increase = filter(k+fix(fm/2)+1,l+fix(fn/2)+1).*cal_image(i-k,j-l,a);
                    sum(a) = temp + increase;
%                     fprintf('sum(a) = %d\n',sum(a));
%                     fprintf('filter(%d,%d) = %f\n',k+fix(fm/2)+1,l+fix(fn/2)+1,filter(k+fix(fm/2)+1,l+fix(fn/2)+1));
%                     fprintf('cal_image(%d,%d,%d) = %f\n',i-k,j-l,a,cal_image(i-k,j-l,a));
%                     fprintf('°ö = %f',cal_image(i-k,j-l,a)*filter(k+fix(fm/2)+1,l+fix(fn/2)+1));
                    temp = sum(a);
                end
            end
            h(i-fix(fm/2),j-fix(fn/2),a) = sum(a);
        end
    end
end

output = h;
% 
% figure(2); imshow(h);       
% h2 = imfilter(double_image,filter,'conv');
% figure(3); imshow(h2);
%%%%%%%%%%%%%%%%


