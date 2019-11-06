function [yout,gb] = Threshold(I)
%THRESHOLD Summary of this function goes here
%   Detailed explanation goes here
l=I(:,:,1);
a=I(:,:,2);
b=I(:,:,3);


T1 = graythresh(a);
T2 = graythresh(b);
T3 = graythresh(l);



for i=1:256
    for j=1:256
        if a(i,j)<T1
            l(i,j)=0;
            a(i,j)=0;
            b(i,j)=0;
        end
        if b(i,j)<T2
            l(i,j)=0;
            a(i,j)=0;
            b(i,j)=0;
        end
        if l(i,j)<T3
            l(i,j)=0;
            a(i,j)=0;
            b(i,j)=0;
        end
    end
end

I(:,:,1)=l;
I(:,:,2)=a;
I(:,:,3)=b;
yout = I;
gb = lab2rgb(I);
figure(2),
imshow(gb),title('Thresholded Image');
end

