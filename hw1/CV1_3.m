for k=0:9
    A=imread('grizzlypeak.jpg');
    [m1,n1] = size( A );
    tic
    for i=1:m1
        for j=1:n1
            if A(i,j)<=10
                A(i,j) = 0;
            end
        end
    end
    fprintf('%d try, method 1:',k+1);
    toc
    A=zeros(m1,n1);
    
    B=imread('grizzlypeak.jpg');
    [m2,n2] = size( B );
    tic
    C = B <= 10;
    B(C) = 0;
    fprintf('%d try, method 2:',k+1);
    toc
    B=zeros(m2,n2);
end
%imshow(B);