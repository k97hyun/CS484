
A=imread('grizzlypeakg.png');
[m1,n1] = size( A );
fprintf('%d,%d\n',m1, n1);
tic
for i=1:m1
    for j=1:n1
        if A(i,j)<=10
            A(i,j) = 0;
        end
    end
end
toc
B=imread('grizzlypeakg.png');
[m2,n2] = size( B );

fprintf('%d,%d\n',m2, n2);
tic
C = B <= 10;
B(C) = 0;
toc
