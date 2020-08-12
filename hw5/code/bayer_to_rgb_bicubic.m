%% HW5-a
% generate rgb image from bayer pattern image using bicubic interpolation
function rgb_img = bayer_to_rgb_bicubic(bayer_img)

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Your code here
    %1. bilinear
    [M,N,L] = size(bayer_img);
    img = uint8(zeros(M,N,3));
    for i = 2:M-1
        for j = 2:N-1
            if mod(i,2) == 0 && mod(j,2) == 1 %G
                img(i,j,1)=round((bayer_img(i-1,j)+bayer_img(i+1,j))/2);
                img(i,j,2)=round(bayer_img(i,j));
                img(i,j,3)=round((bayer_img(i,j-1)+bayer_img(i,j+1))/2);
            elseif mod(i,2) == 1 && mod(j,2) == 0
                img(i,j,1)=round((bayer_img(i,j-1)+bayer_img(i,j+1))/2);
                img(i,j,2)=round(bayer_img(i,j));
                img(i,j,3)=round((bayer_img(i-1,j)+bayer_img(i+1,j))/2);
            elseif mod(i,2) == 1 %R
                img(i,j,1)=round(bayer_img(i,j));
                img(i,j,2)=round((bayer_img(i-1,j)+bayer_img(i+1,j)+bayer_img(i,j-1)+bayer_img(i,j+1))/4);
                img(i,j,3)=round((bayer_img(i-1,j-1)+bayer_img(i+1,j-1)+bayer_img(i+1,j-1)+bayer_img(i-1,j+1))/4);
            else %B
                img(i,j,1)=round((bayer_img(i-1,j-1)+bayer_img(i+1,j-1)+bayer_img(i+1,j-1)+bayer_img(i-1,j+1))/4);
                img(i,j,2)=round((bayer_img(i-1,j)+bayer_img(i+1,j)+bayer_img(i,j-1)+bayer_img(i,j+1))/4);
                img(i,j,3)=round(bayer_img(i,j));
            end
        end
    end
    bayer_img = img;
    % imshow(bayer_img);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    rgb_img = bayer_img;
end