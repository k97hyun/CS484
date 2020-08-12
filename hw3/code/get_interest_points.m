% Local Feature Stencil Code
% Written by James Hays for CS 143 @ Brown / CS 4476/6476 @ Georgia Tech

% Returns a set of interest points for the input image

% 'image' can be grayscale or color, your choice.
% 'descriptor_window_image_width', in pixels.
%   This is the local feature descriptor width. It might be useful in this function to 
%   (a) suppress boundary interest points (where a feature wouldn't fit entirely in the image, anyway), or
%   (b) scale the image filters being used. 
% Or you can ignore it.

% 'x' and 'y' are nx1 vectors of x and y coordinates of interest points.
% 'confidence' is an nx1 vector indicating the strength of the interest
%   point. You might use this later or not.
% 'scale' and 'orientation' are nx1 vectors indicating the scale and
%   orientation of each interest point. These are OPTIONAL. By default you
%   do not need to make scale and orientation invariant local features.
function [x, y, confidence, scale, orientation] = get_interest_points(image, descriptor_window_image_width)

% Implement the Harris corner detector (See Szeliski 4.1.1) to start with.
% You can create additional interest point detector functions (e.g. MSER)
% for extra credit.

% If you're finding spurious interest point detections near the boundaries,
% it is safe to simply suppress the gradients / corners near the edges of
% the image.

% The lecture slides and textbook are a bit vague on how to do the
% non-maximum suppression once you've thresholded the cornerness score.
% You are free to experiment. Here are some helpful functions:
%  BWLABEL and the newer BWCONNCOMP will find connected components in 
% thresholded binary image. You could, for instance, take the maximum value
% within each component.
%  COLFILT can be used to run a max() operator on each sliding window. You
% could use this to ensure that every interest point is at a local maximum
% of cornerness.

% Placeholder that you can delete -- random points
% x = ceil(rand(500,1) * size(image,2));
% y = ceil(rand(500,1) * size(image,1));
B_gau = fspecial('gaussian',[3,3],1);
image = imfilter(image,B_gau);


dx = [-1 0 1;
    -1 0 1;
    -1 0 1];
dy = dx.';

Ix = imfilter(image,dx,'same','conv');
Iy = imfilter(image,dy,'same','conv');

% gradients near the edges
Ix([(1:descriptor_window_image_width) end-descriptor_window_image_width+(1:descriptor_window_image_width)],:) = 0;
Ix(:, [(1:descriptor_window_image_width) end-descriptor_window_image_width+(1:descriptor_window_image_width)]) = 0;
Iy([(1:descriptor_window_image_width) end-descriptor_window_image_width+(1:descriptor_window_image_width)],:) = 0;
Iy(:, [(1:descriptor_window_image_width) end-descriptor_window_image_width+(1:descriptor_window_image_width)]) = 0;

large_gaussian = fspecial('Gaussian', [25 25], 2);
Ix2 = imfilter(Ix.^2, large_gaussian);
Ixy = imfilter(Ix.*Iy, large_gaussian);
Iy2 = imfilter(Iy.^2, large_gaussian);

alpha = 0.05;
C = Ix2.^2 - Ixy.^2 - alpha.*(Ix2+Iy2).^2;
threshold = C > mean2(C);

comp = bwconncomp(threshold);
x = zeros(comp.NumObjects, 1);
y = zeros(comp.NumObjects, 1);

confidence = zeros(comp.NumObjects, 1);
width = comp.ImageSize(1);
for i=1:(comp.NumObjects)
    pix_i = comp.PixelIdxList{i};
    pix_val = C(pix_i);
    [max_val, max_id] = max(pix_val);
    x(i) = floor(pix_i(max_id)/ width);
    y(i) = mod(pix_i(max_id), width);
    confidence(i) = max_val;
end

% After computing interest points, here's roughly how many we return
% For each of the three image pairs
% - Notre Dame: ~1300 and ~1700
% - Mount Rushmore: ~3500 and ~4500
% - Episcopal Gaudi: ~1000 and ~9000


