tic
for k=0:999
    A=imread('grizzlypeakg.png');
    [m1,n1] = size( A );
    for i=1:m1
        for j=1:n1
            if A(i,j)<=10
                A(i,j) = 0;
            end
        end
    end
    %fprintf('%d try, method 1:',k+1);
    A=zeros(m1,n1);
end
fprintf('method 1:');
toc

tic
for k=0:999
    B=imread('grizzlypeakg.png');
    [m2,n2] = size( B );
    C = B <= 10;
    B(C) = 0;
    B=zeros(m2,n2);
end
fprintf('method 2:');
toc