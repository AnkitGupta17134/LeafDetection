function yout = MedianFilt(x)
%MEDIANFILT Summary of this function goes here
%   Detailed explanation goes here
yr=x(:,:,1);
yg=x(:,:,2);
yb=x(:,:,3);
 
yr=medfilt2(yr);
yg=medfilt2(yg);
yb=medfilt2(yb);
 
x(:,:,1)= yr;
x(:,:,2)=yg;
x(:,:,3)=yb;
yout = x;
figure,
imshow(x);
title('After Median Filter');

end

