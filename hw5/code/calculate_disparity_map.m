%% HW5-d
function d = calculate_disparity_map(img_left, img_right, window_size, max_disparity)

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Your code here
    img_left = im2double(img_left);
    img_right = im2double(img_right);
    [h w] = size(img_left);
    cost_vol = zeros(h,w,max_disparity);
    
    f = [1,1,1; 1,1,1; 1,1,1];
    meanl = imfilter(img_left,f/9);
    meanr = imfilter(img_right,f/9);
    
    difl = img_left - meanl;
    difr = img_right - meanr;
    
    sql = difl.*difl;
    sqr = difr.*difr;
    
    suml = sqrt(imfilter(sql, f));
    sumr = sqrt(imfilter(sqr, f));
    
    for i = 1:max_disparity
        l = difl(:,1:end-i);
        r = difr(:, i+1:end);
        lr = l.*r;
        sum_lr = imfilter(lr,f);
        
        l2 = suml(:,1:end-i);
        r2 = sumr(:,i+1:end);
        
        cost_vol(:,1:end-i,i) = sum_lr./(l2.*r2);
    end
    
        

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    % winner takes all
    [min_val, index] = min(cost_vol,[],3);

    d = index;
end

