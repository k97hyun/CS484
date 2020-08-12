i1=im2double(imread('RISDance.jpg'));
[s1,s2,s3] = size(i1);
size1 = s1*s2*s3;
sizegap = 262144/size1;
Time = zeros(7,32);
x=3:2:15;
y=0.25:0.25:8;
[X,Y]=meshgrid(y,x);
for a=1:7
    filter = fspecial('Gaussian', [2*a+1 2*a+1], 10);
    for b=1:32
        I = imresize(i1,sizegap*b,'bilinear');
        t1 = clock;
        for c = 1:20
            newone = imfilter(I,filter,'conv');
        end
%         newone = imfilter(I,filter,'conv');
        t2 = clock;
        Time(a,b) = etime(t2,t1);

    end
end

surf(X,Y,Time);

