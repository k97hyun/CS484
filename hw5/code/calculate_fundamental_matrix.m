%% HW5-b
% Use Normalized Eight-Point algorithm
function f = calculate_fundamental_matrix(pts1, pts2)

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Your code here
    [m,~] = size(pts1);

    X1 = pts1(:, 1);
    Y1 = pts1(:, 2);
    X2 = pts2(:, 1);
    Y2 = pts2(:, 2);

    A = [X1.*X2, X1.*Y2, X1, Y1.*X2, Y1.*Y2, Y1, X2, Y2, ones(m,1)];

    [~,~,EV1] = svd(A);

    EV = EV1(:,9);

    F = reshape(EV,3,3);

    [U,S,V] = svd(F);
    S(3,3) = 0;
    F = U*S*V';

    f = F;
    
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% Delete here when you run your code
    %f = eye(3);

end